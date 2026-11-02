package org.jamdev.jdl4pam.deepAcoustics;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Decodes the output of an anchor free Ultralytics YOLO model (YOLOv8, YOLO11
 * etc.) exported without non maximum suppression, e.g. to TorchScript or ONNX.
 * <p>
 * The output of these models is a single tensor of shape [batch, 4 + nClasses,
 * nAnchors]. The first four rows are the centre x, centre y, width and height
 * of each box in model input pixels and the remaining rows are the score for
 * each class (sigmoid already applied). Decoding is the same as Ultralytics'
 * non_max_suppression function, i.e. boxes with a maximum class score above the
 * threshold are kept and then non maximum suppression removes boxes which
 * overlap a higher scoring box.
 *
 * @author Jamie Macaulay
 */
public class YoloV8Decoder {

	/**
	 * Offset added to boxes of different classes so that per class NMS can be run
	 * in one pass (Ultralytics max_wh).
	 */
	private static final double MAX_WH = 7680;

	/**
	 * The maximum number of boxes passed to NMS (Ultralytics max_nms).
	 */
	private static final int MAX_NMS = 30000;

	/**
	 * A decoded bounding box.
	 */
	public static class YoloV8Box {

		/**
		 * The box corners [x1, y1, x2, y2] in model input pixels.
		 */
		public double[] xyxy;

		/**
		 * The maximum class score.
		 */
		public float score;

		/**
		 * The index of the class with the maximum score.
		 */
		public int classIndex;

		/**
		 * The scores for all classes.
		 */
		public float[] classScores;

		public YoloV8Box(double[] xyxy, float score, int classIndex, float[] classScores) {
			this.xyxy = xyxy;
			this.score = score;
			this.classIndex = classIndex;
			this.classScores = classScores;
		}
	}

	/**
	 * Decode the boxes for one image.
	 *
	 * @param output      - the flattened model output.
	 * @param shape       - the shape of the output. Either [batch, 4 + nClasses,
	 *                    nAnchors] (the default for Ultralytics exports) or [batch,
	 *                    nAnchors, 4 + nClasses]. The layout is decided by which
	 *                    dimension is smaller.
	 * @param batchIndex  - the image in the batch.
	 * @param confThresh  - the minimum class score for a box.
	 * @param iouThresh   - boxes which overlap a higher scoring box by more than
	 *                    this intersection over union are removed.
	 * @param agnosticNMS - true to run NMS over all boxes, false to run NMS only
	 *                    between boxes of the same class.
	 * @param maxDet      - the maximum number of boxes to return.
	 * @return the boxes, sorted by descending score.
	 */
	public static List<YoloV8Box> decode(float[] output, long[] shape, int batchIndex, float confThresh,
			double iouThresh, boolean agnosticNMS, int maxDet) {

		boolean channelsFirst = shape[1] <= shape[2];
		int nChannels = (int) (channelsFirst ? shape[1] : shape[2]);
		int nAnchors = (int) (channelsFirst ? shape[2] : shape[1]);
		int nClasses = nChannels - 4;

		if (nClasses < 1) {
			throw new IllegalArgumentException("YoloV8Decoder: the output shape " + Arrays.toString(shape)
					+ " does not have 4 box coordinates and at least one class");
		}

		int offset = batchIndex * nChannels * nAnchors;

		List<YoloV8Box> candidates = new ArrayList<YoloV8Box>();
		for (int a = 0; a < nAnchors; a++) {
			float[] scores = new float[nClasses];
			float maxScore = Float.NEGATIVE_INFINITY;
			int maxClass = 0;
			for (int c = 0; c < nClasses; c++) {
				scores[c] = output[index(offset, 4 + c, a, nChannels, nAnchors, channelsFirst)];
				if (scores[c] > maxScore) {
					maxScore = scores[c];
					maxClass = c;
				}
			}
			if (!(maxScore > confThresh)) continue;

			double x = output[index(offset, 0, a, nChannels, nAnchors, channelsFirst)];
			double y = output[index(offset, 1, a, nChannels, nAnchors, channelsFirst)];
			double w = output[index(offset, 2, a, nChannels, nAnchors, channelsFirst)];
			double h = output[index(offset, 3, a, nChannels, nAnchors, channelsFirst)];

			double[] xyxy = new double[] {x - w / 2, y - h / 2, x + w / 2, y + h / 2};
			candidates.add(new YoloV8Box(xyxy, maxScore, maxClass, scores));
		}

		//sort by descending score (stable so that equal scores keep the anchor order)
		candidates.sort((b1, b2) -> Float.compare(b2.score, b1.score));
		if (candidates.size() > MAX_NMS) {
			candidates = new ArrayList<YoloV8Box>(candidates.subList(0, MAX_NMS));
		}

		return nms(candidates, iouThresh, agnosticNMS, maxDet);
	}

	/**
	 * Greedy non maximum suppression (the same as torchvision.ops.nms).
	 *
	 * @param boxes       - the boxes sorted by descending score.
	 * @param iouThresh   - boxes with an IoU greater than this with a kept box are
	 *                    removed.
	 * @param agnosticNMS - true to suppress boxes of any class, false to only
	 *                    suppress boxes of the same class.
	 * @param maxDet      - the maximum number of boxes to keep.
	 * @return the kept boxes.
	 */
	public static List<YoloV8Box> nms(List<YoloV8Box> boxes, double iouThresh, boolean agnosticNMS, int maxDet) {
		List<YoloV8Box> kept = new ArrayList<YoloV8Box>();
		boolean[] removed = new boolean[boxes.size()];
		for (int i = 0; i < boxes.size(); i++) {
			if (removed[i]) continue;
			YoloV8Box box = boxes.get(i);
			kept.add(box);
			if (kept.size() >= maxDet) break;
			for (int j = i + 1; j < boxes.size(); j++) {
				if (removed[j]) continue;
				YoloV8Box other = boxes.get(j);
				if (!agnosticNMS && other.classIndex != box.classIndex) continue;
				if (iou(box.xyxy, other.xyxy) > iouThresh) {
					removed[j] = true;
				}
			}
		}
		return kept;
	}

	/**
	 * The intersection over union of two boxes.
	 *
	 * @param a - box [x1, y1, x2, y2].
	 * @param b - box [x1, y1, x2, y2].
	 * @return the intersection over union.
	 */
	public static double iou(double[] a, double[] b) {
		double iw = Math.max(0, Math.min(a[2], b[2]) - Math.max(a[0], b[0]));
		double ih = Math.max(0, Math.min(a[3], b[3]) - Math.max(a[1], b[1]));
		double inter = iw * ih;
		double union = (a[2] - a[0]) * (a[3] - a[1]) + (b[2] - b[0]) * (b[3] - b[1]) - inter;
		return union <= 0 ? 0 : inter / union;
	}

	private static int index(int offset, int channel, int anchor, int nChannels, int nAnchors, boolean channelsFirst) {
		return channelsFirst ? offset + channel * nAnchors + anchor : offset + anchor * nChannels + channel;
	}

}
