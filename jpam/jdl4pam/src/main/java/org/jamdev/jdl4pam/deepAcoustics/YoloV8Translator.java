package org.jamdev.jdl4pam.deepAcoustics;

import java.util.ArrayList;
import java.util.List;

import org.jamdev.jdl4pam.deepAcoustics.YoloV8Decoder.YoloV8Box;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jdl4pam.utils.InputShapeException;

import ai.djl.ndarray.NDArray;
import ai.djl.ndarray.NDList;
import ai.djl.ndarray.NDManager;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.Batchifier;
import ai.djl.translate.Translator;
import ai.djl.translate.TranslatorContext;

/**
 * Translator for anchor free Ultralytics YOLO models (YOLOv8, YOLO11 etc.)
 * exported without NMS, e.g. to TorchScript.
 * <p>
 * The input is a batch of images [batch][channel][height][width] with values
 * between 0 and 1. Each image is letterboxed to the model input size in the
 * same way as Ultralytics (see {@link YoloLetterbox}). The output is decoded
 * with {@link YoloV8Decoder} and the bounding boxes are mapped back to the
 * original image so that each {@link DeepAcousticsResult} is [x, y, width,
 * height] in pixels of the original image, where (x, y) is the top left corner
 * and the image spans 0 to width and 0 to height.
 *
 * @author Jamie Macaulay
 */
public class YoloV8Translator implements Translator<float[][][][], List<DeepAcousticResultArray>> {

	private static final String LETTERBOX_KEY = "yolo_letterbox";

	/**
	 * The model input shape [batch, channels, height, width].
	 */
	private final Shape inputShape;

	/**
	 * The minimum class score for a box.
	 */
	private float thresh = 0.25f;

	/**
	 * The IoU threshold for non maximum suppression (Ultralytics default 0.7).
	 */
	private double nmsOverlap = 0.7;

	/**
	 * True to run NMS over boxes of all classes.
	 */
	private boolean agnosticNMS = false;

	/**
	 * The maximum number of boxes per image.
	 */
	private int maxDet = 300;

	/**
	 * The value of the letterbox padding.
	 */
	private float padValue = YoloLetterbox.DEFAULT_PAD_VALUE;

	/**
	 * True to quantise images to 8 bits as Ultralytics does with image files.
	 */
	private boolean uint8 = false;

	/**
	 * Create a YOLOv8 translator.
	 *
	 * @param inputShape - the model input shape [batch, channels, height, width].
	 */
	public YoloV8Translator(Shape inputShape) {
		if (inputShape.dimension() != 4) {
			throw new IllegalArgumentException("YoloV8Translator: the input shape must be [batch, channels, height, width] not " + inputShape);
		}
		this.inputShape = inputShape;
	}

	@Override
	public NDList processInput(TranslatorContext ctx, float[][][][] data) {
		NDManager manager = ctx.getNDManager();

		int channels = (int) inputShape.get(1);
		int height = (int) inputShape.get(2);
		int width = (int) inputShape.get(3);

		YoloLetterbox[] letterboxes = new YoloLetterbox[data.length];
		float[][][][] input = new float[data.length][][][];
		for (int i = 0; i < data.length; i++) {
			if (data[i].length != channels) {
				throw new InputShapeException(String.format("YoloV8Translator: the image has %d channels but the model expects %d",
						data[i].length, channels));
			}
			letterboxes[i] = new YoloLetterbox(data[i][0].length, data[i][0][0].length, height, width);
			input[i] = letterboxes[i].letterbox(data[i], padValue, uint8);
		}
		ctx.setAttachment(LETTERBOX_KEY, letterboxes);

		Shape shape = new Shape(data.length, channels, height, width);
		NDArray array = manager.create(DLUtils.flattenDoubleArrayF(input), shape);
		return new NDList(array);
	}

	@Override
	public List<DeepAcousticResultArray> processOutput(TranslatorContext ctx, NDList list) {
		YoloLetterbox[] letterboxes = (YoloLetterbox[]) ctx.getAttachment(LETTERBOX_KEY);

		NDArray outArray = list.get(0);
		float[] output = outArray.toFloatArray();
		long[] shape = outArray.getShape().getShape();

		List<DeepAcousticResultArray> results = new ArrayList<DeepAcousticResultArray>();
		for (int i = 0; i < shape[0]; i++) {
			List<YoloV8Box> boxes = YoloV8Decoder.decode(output, shape, i, thresh, nmsOverlap, agnosticNMS, maxDet);

			YoloLetterbox letterbox = letterboxes[i];

			DeepAcousticResultArray boundingBoxes = new DeepAcousticResultArray();
			boundingBoxes.setImageHeight(letterbox.getSrcHeight());
			boundingBoxes.setImageWidth(letterbox.getSrcWidth());

			for (YoloV8Box box : boxes) {
				double[] src = letterbox.toSource(box.xyxy[0], box.xyxy[1], box.xyxy[2], box.xyxy[3]);
				double[] xywh = new double[] {src[0], src[1], src[2] - src[0], src[3] - src[1]};
				boundingBoxes.add(new DeepAcousticsResult(xywh, box.score, box.classScores));
			}
			results.add(boundingBoxes);
		}
		return results;
	}

	@Override
	public Batchifier getBatchifier() {
		//the input is already a batch
		return null;
	}

	/**
	 * Get the model input shape.
	 * @return the input shape [batch, channels, height, width].
	 */
	public Shape getInputShape() {
		return inputShape;
	}

	public float getThresh() {
		return thresh;
	}

	/**
	 * Set the minimum class score for a box.
	 * @param thresh - the minimum score between 0 and 1.
	 */
	public void setThresh(float thresh) {
		this.thresh = thresh;
	}

	public double getNmsOverlap() {
		return nmsOverlap;
	}

	/**
	 * Set the IoU threshold for non maximum suppression.
	 * @param nmsOverlap - boxes which overlap a higher scoring box by more than this are removed.
	 */
	public void setNmsOverlap(double nmsOverlap) {
		this.nmsOverlap = nmsOverlap;
	}

	public boolean isAgnosticNMS() {
		return agnosticNMS;
	}

	/**
	 * Set whether NMS is run over boxes of all classes (Ultralytics agnostic_nms).
	 * @param agnosticNMS - true for class agnostic NMS.
	 */
	public void setAgnosticNMS(boolean agnosticNMS) {
		this.agnosticNMS = agnosticNMS;
	}

	public int getMaxDet() {
		return maxDet;
	}

	public void setMaxDet(int maxDet) {
		this.maxDet = maxDet;
	}

	public float getPadValue() {
		return padValue;
	}

	/**
	 * Set the value of the letterbox padding.
	 * @param padValue - the padding value between 0 and 1. The Ultralytics default is 114/255.
	 */
	public void setPadValue(float padValue) {
		this.padValue = padValue;
	}

	public boolean isUint8() {
		return uint8;
	}

	/**
	 * Set whether images are quantised to 8 bits before and after the letterbox
	 * resize, as Ultralytics does with image files.
	 * @param uint8 - true to quantise images.
	 */
	public void setUint8(boolean uint8) {
		this.uint8 = uint8;
	}

}
