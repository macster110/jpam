package org.jamdev.jpamutils;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;

import org.jamdev.jpamutils.spectrogram.SpecTransform;
import org.junit.jupiter.api.Test;

/**
 * Test the running median and median equalizer against
 * scipy.ndimage.median_filter(x, size=(1, window), mode="mirror").
 *
 * @author Jamie Macaulay
 *
 */
public class MedianEqualizerTest {

	/**
	 * Test image - rows are frequency bins and columns are time bins i.e. the same
	 * orientation as the python array.
	 */
	private static final double[][] X = {
			{ 1, 4, 5, 2, 8, 3, 7 },
			{ 3, 5, 1, 9, 0, 6, 2 },
			{ 1, 0, 9, 4, 4, 7, 5 } };

	@Test
	public void medianFilterTimeTest() {
		// window length and the expected output from scipy.
		checkMedian(X, 1, X);
		checkMedian(X, 2, new double[][] { { 4, 4, 5, 5, 8, 8, 7 }, { 5, 5, 5, 9, 9, 6, 6 }, { 1, 1, 9, 9, 4, 7, 7 } });
		checkMedian(X, 3, new double[][] { { 4, 4, 4, 5, 3, 7, 3 }, { 5, 3, 5, 1, 6, 2, 6 }, { 0, 1, 4, 4, 4, 5, 7 } });
		checkMedian(X, 4, new double[][] { { 4, 4, 4, 5, 5, 7, 7 }, { 5, 5, 5, 5, 6, 6, 6 }, { 1, 1, 4, 4, 7, 5, 7 } });
		checkMedian(X, 5, new double[][] { { 4, 4, 4, 4, 5, 3, 7 }, { 3, 5, 3, 5, 2, 6, 2 }, { 1, 1, 4, 4, 5, 5, 5 } });
		// window longer than the data
		checkMedian(X, 20, new double[][] { { 4, 4, 4, 4, 4, 4, 4 }, { 5, 5, 5, 5, 5, 5, 5 }, { 4, 4, 4, 4, 4, 4, 4 } });

		checkMedian(new double[][] { { 2, 1 } }, 3, new double[][] { { 1, 2 } });
		checkMedian(new double[][] { { 2, 1 } }, 4, new double[][] { { 2, 2 } });
		checkMedian(new double[][] { { 2, 1 } }, 10, new double[][] { { 2, 2 } });
		checkMedian(new double[][] { { 5 } }, 4, new double[][] { { 5 } });
	}

	@Test
	public void medianEqualizerTest() {
		double[][] expected = { { 0, 0, 1, 0, 3, 0, 0 }, { 0, 0, 0, 4, 0, 0, 0 }, { 0, 0, 5, 0, 0, 2, 0 } };
		double[][] out = SpecTransform.medianEqualizer(transpose(X), 5);
		double[][] exp = transpose(expected);
		for (int i = 0; i < exp.length; i++) {
			assertArrayEquals(exp[i], out[i], 1e-12);
		}
	}

	private static void checkMedian(double[][] x, int window, double[][] expected) {
		double[][] out = SpecTransform.medianFilterTime(transpose(x), window);
		double[][] exp = transpose(expected);
		for (int i = 0; i < exp.length; i++) {
			assertArrayEquals(exp[i], out[i], 1e-12, "window " + window + " time bin " + i);
		}
	}

	/**
	 * Transpose from python orientation (frequency, time) to jpam orientation (time, frequency).
	 */
	private static double[][] transpose(double[][] x) {
		double[][] out = new double[x[0].length][x.length];
		for (int i = 0; i < x.length; i++) {
			for (int j = 0; j < x[0].length; j++) {
				out[j][i] = x[i][j];
			}
		}
		return out;
	}

}
