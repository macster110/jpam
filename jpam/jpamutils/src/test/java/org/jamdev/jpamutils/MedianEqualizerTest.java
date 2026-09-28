package org.jamdev.jpamutils;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Arrays;
import java.util.Random;

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

	/**
	 * Check the running median against a brute force implementation for random data
	 * and a range of window sizes. The brute force version sorts the whole window for
	 * every bin whereas SpecTransform uses a sliding Fenwick tree.
	 */
	@Test
	public void medianFilterRandomTest() {
		Random random = new Random(42);
		for (int nTime : new int[] { 1, 2, 7, 33, 128 }) {
			double[][] img = new double[nTime][3];
			for (int i = 0; i < nTime; i++) {
				for (int j = 0; j < 3; j++) {
					img[i][j] = Math.round(random.nextGaussian() * 100) / 10.;
				}
			}
			for (int window : new int[] { 1, 2, 3, 8, 15, 64, nTime, 2 * nTime + 1 }) {
				double[][] out = SpecTransform.medianFilterTime(img, window);
				double[][] expected = bruteForceMedian(img, window);
				for (int i = 0; i < nTime; i++) {
					assertArrayEquals(expected[i], out[i], 1e-12, "nTime " + nTime + " window " + window + " bin " + i);
				}
			}
		}
	}

	/**
	 * Brute force running median - sorts the window for every time bin.
	 */
	private static double[][] bruteForceMedian(double[][] img, int window) {
		int nTime = img.length;
		int nFreq = img[0].length;
		int offset = window / 2;
		double[][] median = new double[nTime][nFreq];
		for (int j = 0; j < nFreq; j++) {
			for (int i = 0; i < nTime; i++) {
				double[] vals = new double[window];
				for (int k = 0; k < window; k++) {
					int index = i - offset + k;
					// mirror the index into the array (d c b | a b c d | c b a)
					if (nTime == 1) {
						index = 0;
					}
					else {
						int period = 2 * (nTime - 1);
						index = index % period;
						if (index < 0) index += period;
						if (index >= nTime) index = period - index;
					}
					vals[k] = img[index][j];
				}
				Arrays.sort(vals);
				median[i][j] = vals[window / 2];
			}
		}
		return median;
	}

	@Test
	public void timeTrimTest() {
		double[][] img = transpose(X); // 7 time bins, 3 frequency bins
		double[][] out = SpecTransform.timeTrim(img, 2, 3);
		assertEquals(3, out.length);
		assertArrayEquals(new double[] { 5, 1, 9 }, out[0], 1e-12);
		assertArrayEquals(new double[] { 2, 9, 4 }, out[1], 1e-12);
		assertArrayEquals(new double[] { 8, 0, 4 }, out[2], 1e-12);
		// a trim which runs off the end of the spectrogram is clamped
		assertEquals(2, SpecTransform.timeTrim(img, 5, 10).length);
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
