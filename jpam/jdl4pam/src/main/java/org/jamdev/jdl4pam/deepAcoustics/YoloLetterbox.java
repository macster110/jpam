package org.jamdev.jdl4pam.deepAcoustics;

/**
 * Letterboxing of images in the same way as Ultralytics YOLO (YOLOv8, YOLO11
 * etc.). The image is resized, keeping its aspect ratio, so that it fits inside
 * the model input and is then padded to the model input size. Bounding boxes
 * from the model can then be mapped back to the original image.
 * <p>
 * The resize is bilinear with pixel centres at half pixels (the same as
 * OpenCV's INTER_LINEAR) and the padding is grey (114 out of 255). Ultralytics
 * models are trained on 8 bit images so the image can optionally be quantised
 * to 8 bits before and after resizing, as OpenCV does with uint8 images.
 *
 * @author Jamie Macaulay
 */
public class YoloLetterbox {

	/**
	 * The default padding value used by Ultralytics (114/255).
	 */
	public static final float DEFAULT_PAD_VALUE = 114f / 255f;

	/**
	 * The height of the original image in pixels.
	 */
	private final int srcHeight;

	/**
	 * The width of the original image in pixels.
	 */
	private final int srcWidth;

	/**
	 * The height of the model input in pixels.
	 */
	private final int dstHeight;

	/**
	 * The width of the model input in pixels.
	 */
	private final int dstWidth;

	/**
	 * The scale factor between the original image and the resized image.
	 */
	private final double gain;

	/**
	 * The width and height of the resized image (before padding).
	 */
	private final int newWidth, newHeight;

	/**
	 * The padding at the top and left of the image.
	 */
	private final int padTop, padLeft;

	/**
	 * Create a letterbox which maps an image to a model input.
	 *
	 * @param srcHeight - the height of the original image.
	 * @param srcWidth  - the width of the original image.
	 * @param dstHeight - the height of the model input.
	 * @param dstWidth  - the width of the model input.
	 */
	public YoloLetterbox(int srcHeight, int srcWidth, int dstHeight, int dstWidth) {
		this.srcHeight = srcHeight;
		this.srcWidth = srcWidth;
		this.dstHeight = dstHeight;
		this.dstWidth = dstWidth;

		//Ultralytics LetterBox - Python's round is round half to even i.e. Math.rint.
		gain = Math.min(dstHeight / (double) srcHeight, dstWidth / (double) srcWidth);
		newWidth = (int) Math.rint(srcWidth * gain);
		newHeight = (int) Math.rint(srcHeight * gain);

		double dw = (dstWidth - newWidth) / 2.0;
		double dh = (dstHeight - newHeight) / 2.0;
		padTop = (int) Math.rint(dh - 0.1);
		padLeft = (int) Math.rint(dw - 0.1);
	}

	/**
	 * Letterbox a multi channel image.
	 *
	 * @param image    - the image [channel][height][width].
	 * @param padValue - the value of the padding.
	 * @param uint8    - true to quantise the image to 8 bits (values 0-1 are
	 *                 converted to 0-255) before and after resizing as Ultralytics
	 *                 does with 8 bit images.
	 * @return the letterboxed image [channel][dstHeight][dstWidth].
	 */
	public float[][][] letterbox(float[][][] image, float padValue, boolean uint8) {
		float[][][] out = new float[image.length][dstHeight][dstWidth];
		boolean resize = newWidth != srcWidth || newHeight != srcHeight;
		for (int c = 0; c < image.length; c++) {
			float[][] resized;
			if (uint8) {
				//numpy conversion to uint8 truncates
				int[][] src8 = new int[srcHeight][srcWidth];
				for (int i = 0; i < srcHeight; i++) {
					for (int j = 0; j < srcWidth; j++) {
						src8[i][j] = (int) Math.floor(clamp(image[c][i][j], 0, 1) * 255);
					}
				}
				int[][] resized8 = resize ? resizeBilinearUint8(src8, newHeight, newWidth) : src8;
				resized = new float[newHeight][newWidth];
				for (int i = 0; i < newHeight; i++) {
					for (int j = 0; j < newWidth; j++) {
						resized[i][j] = resized8[i][j] / 255f;
					}
				}
			}
			else {
				resized = resize ? resizeBilinear(image[c], newHeight, newWidth) : image[c];
			}

			for (int i = 0; i < dstHeight; i++) {
				for (int j = 0; j < dstWidth; j++) {
					int si = i - padTop;
					int sj = j - padLeft;
					if (si < 0 || sj < 0 || si >= newHeight || sj >= newWidth) {
						out[c][i][j] = padValue;
					}
					else {
						out[c][i][j] = resized[si][sj];
					}
				}
			}
		}
		return out;
	}

	/**
	 * Map a bounding box from model input pixels to original image pixels. The box
	 * is clipped to the original image.
	 *
	 * @param x1 - the left of the box in model input pixels.
	 * @param y1 - the top of the box in model input pixels.
	 * @param x2 - the right of the box in model input pixels.
	 * @param y2 - the bottom of the box in model input pixels.
	 * @return the box [x1, y1, x2, y2] in original image pixels.
	 */
	public double[] toSource(double x1, double y1, double x2, double y2) {
		//Ultralytics scale_boxes
		double padX = Math.rint((dstWidth - Math.rint(srcWidth * gain)) / 2 - 0.1);
		double padY = Math.rint((dstHeight - Math.rint(srcHeight * gain)) / 2 - 0.1);

		return new double[] {
				clamp((x1 - padX) / gain, 0, srcWidth),
				clamp((y1 - padY) / gain, 0, srcHeight),
				clamp((x2 - padX) / gain, 0, srcWidth),
				clamp((y2 - padY) / gain, 0, srcHeight)};
	}

	/**
	 * Resize an image using bilinear interpolation with pixel centres at half
	 * pixels and edge pixels replicated (the same as OpenCV's INTER_LINEAR).
	 *
	 * @param src       - the image [height][width].
	 * @param newHeight - the new height.
	 * @param newWidth  - the new width.
	 * @return the resized image [newHeight][newWidth].
	 */
	public static float[][] resizeBilinear(float[][] src, int newHeight, int newWidth) {
		int h = src.length;
		int w = src[0].length;

		double scaleY = h / (double) newHeight;
		double scaleX = w / (double) newWidth;

		int[] x0 = new int[newWidth];
		int[] x1 = new int[newWidth];
		double[] fx = new double[newWidth];
		for (int j = 0; j < newWidth; j++) {
			double sx = (j + 0.5) * scaleX - 0.5;
			int ix = (int) Math.floor(sx);
			double f = sx - ix;
			if (ix < 0) {
				ix = 0;
				f = 0;
			}
			if (ix >= w - 1) {
				ix = w - 1;
				f = 0;
			}
			x0[j] = ix;
			x1[j] = Math.min(ix + 1, w - 1);
			fx[j] = f;
		}

		float[][] out = new float[newHeight][newWidth];
		for (int i = 0; i < newHeight; i++) {
			double sy = (i + 0.5) * scaleY - 0.5;
			int iy = (int) Math.floor(sy);
			double fy = sy - iy;
			if (iy < 0) {
				iy = 0;
				fy = 0;
			}
			if (iy >= h - 1) {
				iy = h - 1;
				fy = 0;
			}
			int iy1 = Math.min(iy + 1, h - 1);
			for (int j = 0; j < newWidth; j++) {
				double top = src[iy][x0[j]] * (1 - fx[j]) + src[iy][x1[j]] * fx[j];
				double bottom = src[iy1][x0[j]] * (1 - fx[j]) + src[iy1][x1[j]] * fx[j];
				out[i][j] = (float) (top * (1 - fy) + bottom * fy);
			}
		}
		return out;
	}

	/**
	 * Resize an 8 bit image in exactly the same way as OpenCV's INTER_LINEAR
	 * resize of a uint8 image. OpenCV uses fixed point arithmetic with 11 bit
	 * interpolation coefficients and so results can differ by one grey level from
	 * a floating point bilinear resize.
	 *
	 * @param src       - the image [height][width] with values 0-255.
	 * @param newHeight - the new height.
	 * @param newWidth  - the new width.
	 * @return the resized image [newHeight][newWidth] with values 0-255.
	 */
	public static int[][] resizeBilinearUint8(int[][] src, int newHeight, int newWidth) {
		final int coefScale = 2048; //INTER_RESIZE_COEF_SCALE
		int h = src.length;
		int w = src[0].length;

		int[] xofs = new int[newWidth];
		short[] alpha = new short[2 * newWidth];
		computeCoefficients(w, newWidth, coefScale, xofs, alpha);

		int[] yofs = new int[newHeight];
		short[] beta = new short[2 * newHeight];
		computeCoefficients(h, newHeight, coefScale, yofs, beta);

		//horizontal pass for every source row
		int[][] rows = new int[h][newWidth];
		for (int i = 0; i < h; i++) {
			for (int j = 0; j < newWidth; j++) {
				int sx = xofs[j];
				int sx1 = Math.min(sx + 1, w - 1);
				rows[i][j] = src[i][sx] * alpha[2 * j] + src[i][sx1] * alpha[2 * j + 1];
			}
		}

		//vertical pass - the same fixed point arithmetic as OpenCV's VResizeLinearVec_32s8u
		int[][] out = new int[newHeight][newWidth];
		for (int i = 0; i < newHeight; i++) {
			int[] s0 = rows[yofs[i]];
			int[] s1 = rows[Math.min(yofs[i] + 1, h - 1)];
			int b0 = beta[2 * i];
			int b1 = beta[2 * i + 1];
			for (int j = 0; j < newWidth; j++) {
				int val = (((b0 * (s0[j] >> 4)) >> 16) + ((b1 * (s1[j] >> 4)) >> 16) + 2) >> 2;
				out[i][j] = Math.max(0, Math.min(255, val));
			}
		}
		return out;
	}

	/**
	 * Calculate the source indices and fixed point interpolation coefficients for
	 * one axis in the same way as OpenCV's linear resize.
	 */
	private static void computeCoefficients(int srcSize, int dstSize, int coefScale, int[] ofs, short[] coef) {
		double scale = 1. / ((double) dstSize / srcSize);
		for (int d = 0; d < dstSize; d++) {
			float f = (float) ((d + 0.5) * scale - 0.5);
			int s = (int) Math.floor(f);
			f -= s;
			if (s < 0) {
				f = 0;
				s = 0;
			}
			if (s >= srcSize - 1) {
				f = 0;
				s = srcSize - 1;
			}
			ofs[d] = s;
			coef[2 * d] = (short) Math.rint((1.f - f) * coefScale);
			coef[2 * d + 1] = (short) Math.rint(f * coefScale);
		}
	}

	private static double clamp(double val, double min, double max) {
		return Math.max(min, Math.min(max, val));
	}

	/**
	 * Get the scale factor between the original image and the resized image.
	 * @return the scale factor.
	 */
	public double getGain() {
		return gain;
	}

	/**
	 * Get the padding at the top of the image.
	 * @return the top padding in pixels.
	 */
	public int getPadTop() {
		return padTop;
	}

	/**
	 * Get the height of the original image.
	 * @return the height in pixels.
	 */
	public int getSrcHeight() {
		return srcHeight;
	}

	/**
	 * Get the width of the original image.
	 * @return the width in pixels.
	 */
	public int getSrcWidth() {
		return srcWidth;
	}

	/**
	 * Get the padding at the left of the image.
	 * @return the left padding in pixels.
	 */
	public int getPadLeft() {
		return padLeft;
	}

}
