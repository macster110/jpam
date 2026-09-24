package org.jamdev.jdl4pam.deepAcoustics;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.jamdev.jdl4pam.deepAcoustics.Pred2BoxDJL3.DeepAcousticsNetwork;
import org.jamdev.jdl4pam.deepAcoustics.Pred2BoxDJL3.YoloPostProcessorResult;

/**
 * Decodes the outputs of a YOLO v4 object detector which has been trained in
 * MATLAB (e.g. a yolov4ObjectDetector or a DeepAcoustics model) into bounding
 * boxes, scores and class probabilities.
 * <p>
 * This follows the post processing in MATLAB's yolov4ObjectDetector detect
 * function:
 * <ul>
 * <li>x, y, objectness and class predictions are passed through a sigmoid and
 * the width and height through an exponential and are then scaled by the
 * anchor boxes.</li>
 * <li>The score of a box is the objectness multiplied by the maximum class
 * probability and boxes with a score below the threshold are discarded.</li>
 * <li>Optionally, boxes larger than the image are removed (the default MaxSize
 * in MATLAB's detect function), overlapping boxes of the same class are removed
 * using non maximum suppression (selectStrongestBboxMulticlass) and boxes are
 * clipped to the image.</li>
 * </ul>
 * The detection heads can be either channels last [batch, height, width,
 * channels] (e.g. TensorFlow models) or channels first [batch, channels, height,
 * width] (e.g. PyTorch models). The predictions for each anchor are [x, y, w, h,
 * objectness, class 1...class n] and the anchor boxes are [height, width] in
 * pixels.
 * <p>
 * This produces the same result as {@link Pred2BoxDJL3} (if non maximum
 * suppression and box clipping are disabled) but works on Java arrays and so is
 * much faster.
 *
 * @author Jamie Macaulay
 */
public class YoloV4Decoder {

	/**
	 * Decode the output of a YOLO v4 network for one image.
	 *
	 * @param headData   - the output data for each detection head flattened in
	 *                   row major order. This contains all images in a batch.
	 * @param headShapes - the shape of each detection head. [batch, height, width,
	 *                   channels] or [batch, channels, height, width] if the
	 *                   network is channels first.
	 * @param network    - the network information e.g. anchor boxes and input
	 *                   shape.
	 * @param thresh     - the minimum score for a detection.
	 * @param index      - the index of the image in the batch.
	 * @return the bounding boxes, scores and class probabilities.
	 */
	public static YoloPostProcessorResult decode(float[][] headData, long[][] headShapes, DeepAcousticsNetwork network,
			float thresh, int index) {

		double imHeight = network.getImageHeight();
		double imWidth = network.getImageWidth();

		List<double[]> boxes = new ArrayList<double[]>();
		List<Float> scores = new ArrayList<Float>();
		List<float[]> classProbs = new ArrayList<float[]>();
		List<Integer> labels = new ArrayList<Integer>();

		for (int idx = 0; idx < headData.length; idx++) {

			long[] shape = headShapes[idx];
			int h, w, nChannels;
			if (network.isChannelsFirst()) {
				nChannels = (int) shape[1];
				h = (int) shape[2];
				w = (int) shape[3];
			}
			else {
				h = (int) shape[1];
				w = (int) shape[2];
				nChannels = (int) shape[3];
			}

			double[][] anchors = network.getAnchorBoxes().get(idx);
			int nAnchors = anchors.length;
			int nElements = nChannels / nAnchors;
			int nClasses = nElements - 5;

			float[] data = headData[idx];
			int offset = index * nChannels * h * w;

			//strides to get to the value for a channel at a grid position.
			int channelStride = network.isChannelsFirst() ? h * w : 1;

			for (int row = 0; row < h; row++) {
				for (int col = 0; col < w; col++) {
					int cellIndex = network.isChannelsFirst() ? offset + row * w + col : offset + (row * w + col) * nChannels;

					for (int a = 0; a < nAnchors; a++) {
						int anchorIndex = cellIndex + a * nElements * channelStride;

						double obj = sigmoid(data[anchorIndex + 4 * channelStride]);

						float[] probs = new float[nClasses];
						int maxClass = 0;
						for (int k = 0; k < nClasses; k++) {
							probs[k] = (float) sigmoid(data[anchorIndex + (5 + k) * channelStride]);
							if (probs[k] > probs[maxClass]) maxClass = k;
						}

						float score = (float) (obj * (nClasses > 0 ? probs[maxClass] : 1));
						if (score < thresh) continue;

						double x = (col + sigmoid(data[anchorIndex])) / w;
						double y = (row + sigmoid(data[anchorIndex + channelStride])) / h;
						double bw = anchors[a][1] * Math.exp(data[anchorIndex + 2 * channelStride]) / imWidth;
						double bh = anchors[a][0] * Math.exp(data[anchorIndex + 3 * channelStride]) / imHeight;

						//convert from the centre to the top left and scale to image size.
						double[] box = new double[4];
						box[2] = bw * imWidth;
						box[3] = bh * imHeight;
						box[0] = x * imWidth - box[2] / 2.0 + 0.5;
						box[1] = y * imHeight - box[3] / 2.0 + 0.5;
						for (int j = 0; j < 4; j++) {
							if (box[j] < 1) box[j] = 1;
						}

						//MATLAB's detect function removes boxes larger than the image (the default MaxSize)
						if (network.isFilterLargeBoxes() && (box[2] > imWidth || box[3] > imHeight)) continue;

						boxes.add(box);
						scores.add(score);
						classProbs.add(probs);
						labels.add(maxClass);
					}
				}
			}
		}

		boolean[] keep = new boolean[boxes.size()];
		Arrays.fill(keep, true);

		if (network.getNmsOverlap() > 0) {
			keep = selectStrongestBboxMulticlass(boxes, scores, labels, network.getNmsOverlap());
		}

		int nKeep = 0;
		for (boolean k : keep) {
			if (k) nKeep++;
		}

		YoloPostProcessorResult result = new YoloPostProcessorResult();
		result.bboxes = new double[nKeep][];
		result.scores = new float[nKeep];
		result.classProbs = new float[nKeep][];

		int n = 0;
		for (int i = 0; i < boxes.size(); i++) {
			if (!keep[i]) continue;
			double[] box = boxes.get(i);
			if (network.isClipBoxes()) {
				//limit the boxes to the image as in MATLAB
				box[2] = Math.min(box[0] + box[2], imWidth) - box[0];
				box[3] = Math.min(box[1] + box[3], imHeight) - box[1];
				for (int j = 0; j < 4; j++) {
					if (box[j] < 1) box[j] = 1;
				}
			}
			result.bboxes[n] = box;
			result.scores[n] = scores.get(i);
			result.classProbs[n] = classProbs.get(i);
			n++;
		}

		return result;
	}

	/**
	 * Non maximum suppression which follows MATLAB's selectStrongestBboxMulticlass
	 * function with a 'Union' ratio type. Boxes are processed in order of
	 * decreasing score and any box of the same class which overlaps a kept box
	 * with an intersection over union greater than the overlap threshold is
	 * removed.
	 *
	 * @param boxes            - the bounding boxes [x, y, width, height].
	 * @param scores           - the score for each box.
	 * @param labels           - the class label for each box.
	 * @param overlapThreshold - the overlap threshold.
	 * @return true for each box which is kept.
	 */
	public static boolean[] selectStrongestBboxMulticlass(List<double[]> boxes, List<Float> scores,
			List<Integer> labels, double overlapThreshold) {

		int n = boxes.size();

		//sort by descending score - the sort is stable, as in MATLAB.
		Integer[] order = new Integer[n];
		for (int i = 0; i < n; i++) order[i] = i;
		Arrays.sort(order, (a, b) -> Float.compare(scores.get(b), scores.get(a)));

		boolean[] keep = new boolean[n];
		Arrays.fill(keep, true);

		for (int i = 0; i < n; i++) {
			int bi = order[i];
			if (!keep[bi]) continue;
			double[] boxI = boxes.get(bi);
			double areaI = boxI[2] * boxI[3];

			for (int j = i + 1; j < n; j++) {
				int bj = order[j];
				if (!keep[bj] || !labels.get(bj).equals(labels.get(bi))) continue;

				double[] boxJ = boxes.get(bj);
				double width = Math.min(boxI[0] + boxI[2], boxJ[0] + boxJ[2]) - Math.max(boxI[0], boxJ[0]);
				if (width <= 0) continue;
				double height = Math.min(boxI[1] + boxI[3], boxJ[1] + boxJ[3]) - Math.max(boxI[1], boxJ[1]);
				if (height <= 0) continue;

				double intersect = width * height;
				double overlap = intersect / (areaI + boxJ[2] * boxJ[3] - intersect);
				if (overlap > overlapThreshold) {
					keep[bj] = false;
				}
			}
		}
		return keep;
	}

	private static double sigmoid(double x) {
		return 1.0 / (1.0 + Math.exp(-x));
	}

}
