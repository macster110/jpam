package org.jamdev.jpamutils.interpolation;

/**
 * Resizes a 2D image in exactly the same way as MATLAB's <code>imresize</code>
 * function with the default bicubic method.
 * <p>
 * The image is resized separately along each dimension using weights from a
 * cubic convolution kernel (a = -0.5). As in MATLAB, antialiasing is applied
 * when an image is shrunk (the kernel is stretched), out of range indices are
 * mirrored at the image edges and the dimension with the smallest scale factor
 * is resized first.
 *
 * @author Jamie Macaulay
 */
public class ImResize {

	/**
	 * The width of the cubic kernel.
	 */
	private static final double CUBIC_KERNEL_WIDTH = 4.0;

	/**
	 * Resize an image using MATLAB's bicubic interpolation with antialiasing.
	 *
	 * @param image - the image to resize [dim0][dim1].
	 * @param len0  - the new length of the first dimension.
	 * @param len1  - the new length of the second dimension.
	 * @return the resized image [len0][len1].
	 */
	public static double[][] imresizeBicubic(double[][] image, int len0, int len1) {
		return imresizeBicubic(image, len0, len1, true);
	}

	/**
	 * Resize an image using MATLAB's bicubic interpolation.
	 *
	 * @param image        - the image to resize [dim0][dim1].
	 * @param len0         - the new length of the first dimension.
	 * @param len1         - the new length of the second dimension.
	 * @param antialiasing - true to use antialiasing when shrinking the image
	 *                     (MATLAB default).
	 * @return the resized image [len0][len1].
	 */
	public static double[][] imresizeBicubic(double[][] image, int len0, int len1, boolean antialiasing) {

		int in0 = image.length;
		int in1 = image[0].length;

		double scale0 = len0 / (double) in0;
		double scale1 = len1 / (double) in1;

		Contributions c0 = contributions(in0, len0, scale0, antialiasing);
		Contributions c1 = contributions(in1, len1, scale1, antialiasing);

		//MATLAB resizes the dimension with the smallest scale first.
		if (scale0 <= scale1) {
			return resizeDim1(resizeDim0(image, c0), c1);
		}
		else {
			return resizeDim0(resizeDim1(image, c1), c0);
		}
	}

	/**
	 * Resize along the first dimension of an image.
	 */
	private static double[][] resizeDim0(double[][] image, Contributions c) {
		int n1 = image[0].length;
		double[][] out = new double[c.weights.length][n1];
		for (int i = 0; i < c.weights.length; i++) {
			for (int k = 0; k < c.weights[i].length; k++) {
				double w = c.weights[i][k];
				double[] row = image[c.indices[i][k]];
				for (int j = 0; j < n1; j++) {
					out[i][j] += w * row[j];
				}
			}
		}
		return out;
	}

	/**
	 * Resize along the second dimension of an image.
	 */
	private static double[][] resizeDim1(double[][] image, Contributions c) {
		double[][] out = new double[image.length][c.weights.length];
		for (int i = 0; i < image.length; i++) {
			double[] row = image[i];
			for (int j = 0; j < c.weights.length; j++) {
				double sum = 0;
				for (int k = 0; k < c.weights[j].length; k++) {
					sum += c.weights[j][k] * row[c.indices[j][k]];
				}
				out[i][j] = sum;
			}
		}
		return out;
	}

	/**
	 * The weights and (zero based) input indices for each output pixel along one
	 * dimension.
	 */
	private static class Contributions {
		double[][] weights;
		int[][] indices;
	}

	/**
	 * Calculate the interpolation weights and indices along one dimension. This is
	 * a direct port of MATLAB's contributions.m
	 *
	 * @param inLength     - the input length.
	 * @param outLength    - the output length.
	 * @param scale        - the scale factor.
	 * @param antialiasing - true to use antialiasing when scale < 1.
	 * @return the weights and indices for each output pixel.
	 */
	private static Contributions contributions(int inLength, int outLength, double scale, boolean antialiasing) {

		double kernelWidth = CUBIC_KERNEL_WIDTH;
		boolean stretch = scale < 1 && antialiasing;
		if (stretch) {
			kernelWidth = kernelWidth / scale;
		}

		int nTaps = (int) Math.ceil(kernelWidth) + 2;

		double[][] weights = new double[outLength][nTaps];
		int[][] indices = new int[outLength][nTaps];

		//columns which have a zero weight for every output pixel are removed (as in MATLAB)
		boolean[] anyWeight = new boolean[nTaps];

		for (int i = 0; i < outLength; i++) {
			//one based pixel position in the input image
			double u = (i + 1) / scale + 0.5 * (1 - 1 / scale);
			double left = Math.floor(u - kernelWidth / 2);

			double sum = 0;
			for (int k = 0; k < nTaps; k++) {
				double index = left + k;
				double w = stretch ? scale * cubic(scale * (u - index)) : cubic(u - index);
				weights[i][k] = w;
				indices[i][k] = mirrorIndex((int) index, inLength);
				sum += w;
			}
			for (int k = 0; k < nTaps; k++) {
				weights[i][k] = weights[i][k] / sum;
				if (weights[i][k] != 0) anyWeight[k] = true;
			}
		}

		int nKeep = 0;
		for (int k = 0; k < nTaps; k++) {
			if (anyWeight[k]) nKeep++;
		}

		Contributions c = new Contributions();
		c.weights = new double[outLength][nKeep];
		c.indices = new int[outLength][nKeep];
		for (int i = 0; i < outLength; i++) {
			int n = 0;
			for (int k = 0; k < nTaps; k++) {
				if (!anyWeight[k]) continue;
				c.weights[i][n] = weights[i][k];
				c.indices[i][n] = indices[i][k];
				n++;
			}
		}
		return c;
	}

	/**
	 * Convert a one based index which may be outside the image into a zero based
	 * index inside the image by mirroring at the edges (MATLAB's
	 * <code>aux = [1:in_length, in_length:-1:1]</code>).
	 *
	 * @param index    - the one based index.
	 * @param inLength - the length of the image.
	 * @return the zero based index.
	 */
	private static int mirrorIndex(int index, int inLength) {
		int period = 2 * inLength;
		int m = Math.floorMod(index - 1, period);
		return m < inLength ? m : period - 1 - m;
	}

	/**
	 * The cubic convolution kernel used by MATLAB (a = -0.5).
	 *
	 * @param x - the distance from the pixel.
	 * @return the kernel weight.
	 */
	private static double cubic(double x) {
		double absx = Math.abs(x);
		double absx2 = absx * absx;
		double absx3 = absx2 * absx;
		if (absx <= 1) {
			return 1.5 * absx3 - 2.5 * absx2 + 1;
		}
		else if (absx <= 2) {
			return -0.5 * absx3 + 2.5 * absx2 - 4 * absx + 2;
		}
		return 0;
	}

}
