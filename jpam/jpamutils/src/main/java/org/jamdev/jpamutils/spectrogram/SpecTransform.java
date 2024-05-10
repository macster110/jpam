package org.jamdev.jpamutils.spectrogram;

import java.util.Arrays;

import org.jamdev.jpamutils.JamArr;
import org.jamdev.jpamutils.clahe.Clahe;
import org.jamdev.jpamutils.clahe.FastBitmap;
import org.jamdev.jpamutils.interpolation.Bicubic;
import org.jamdev.jpamutils.interpolation.Bilinear;
import org.jamdev.jpamutils.interpolation.Interpolation;
import org.jamdev.jpamutils.interpolation.NearestNeighbor;

/**
 * Transforms spectrogram data.
 * 
 * @author Jamie Macaulay
 *
 */
public class SpecTransform {

	// If you want to clip values at -200 dB, put -200 for min_db
	private static final double DEFAULT_MIN_DB = -500;

	private Interpolation interpolation;

	/**
	 * The transformed spectrogram data.
	 */
	double[][] specData;

	/**
	 * Reference to the original spectrogram.
	 */
	private Spectrogram spectrgram;

	/**
	 * The magnitude and phase information.
	 */
	private ComplexArray[] complexData;

	/**
	 * A gaussian filter.
	 */
	// private GaussianFilter gaussianFilter;


	/**
	 * True to maintain the phase information after each transform. This will slow
	 * down calculations.
	 */
	private boolean maintainPhase = false;

	/**
	 * The sampleRate in samples per second.
	 */
	private float sampleRate;


	/**
	 * Constructor for the spectrogram transform.
	 * 
	 * @param spectrgram - the spectrogram
	 */
	public SpecTransform(Spectrogram spectrgram) {
		this.spectrgram = spectrgram;
		initialiseSpecData();
	}
	
	/**
	 * Constructor for the spectrogram transform. Only use for subclassing. 
	 * 
	 */
	public SpecTransform( ) {
	}

	/**
	 * Convert the current spectrogram data to dB using 10*log10(linear) ;
	 * 
	 * @return reference to the spectrogram object.
	 */
	public SpecTransform dBSpec() {
		return dBSpec(false, DEFAULT_MIN_DB);
	}

	/**
	 * Convert the current spectrogram data to dB using 10*log10(linear);
	 * 
	 * @param power -true for power 10*log(X) or false for amplitude 20*log10(X).
	 * @return reference to the spectrogram object.
	 */
	public SpecTransform dBSpec(boolean power) {
		return dBSpec(power, DEFAULT_MIN_DB);
	}

	/**
	 * Convert the current spectrogram data to dB using 10*log10(linear);
	 * 
	 * @param mindB - the minimum allowed mindB.
	 * @return reference to the spectrogram object.
	 */
	public SpecTransform dBSpec(Double mindB) {
		if (mindB == null)
			return dBSpec();
		else
			return dBSpec(false, mindB);
	}

	/**
	 * Convert the current spectrogram data to dB using 10*log10(linear);
	 * 
	 * @param power -true for power 10*log(X) or false for amplitude 20*log10(X).
	 * @param mindB - the minimum allowed mindB.
	 * @return reference to the spectrogram object.
	 */
	public SpecTransform dBSpec(boolean power, double mindB) {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = dBSpec(this.specData, power, mindB);
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Normalise the current spectrogram between two reference values.
	 * 
	 * @param min_leveldB  - the minimum dB level
	 * @param ref_level_dB - the reference dB level to normalise to
	 * @return reference to the normalised spectrogram
	 */
	public SpecTransform normalise(double min_leveldB, double ref_level_dB) {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = normalise(this.specData, min_leveldB, ref_level_dB);
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Normalise the current spectrogram between the minimum and maximum of the
	 * array
	 * 
	 * @return reference to the normalised spectrogram
	 */
	public SpecTransform normaliseMinMax() {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = normaliseMinMax(this.specData);
//		System.out.println("Min max: 2" + JamArr.min(specData)); 
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Normalise the current spectrogram by dividing by sum of the square of the sum
	 * of all rows.
	 * 
	 * @return reference to the normalised spectrogram
	 */
	public SpecTransform normaliseRowSum() {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = normaliseRowSum(this.specData);
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Normalize the data array to specified mean and standard deviation.
	 * 
	 * For the data array to be normalizable, it must have non-zero standard
	 * deviation. If this is not the case, the array is unchanged by calling this
	 * method.
	 * <p>
	 * From Ketos (Meridian).
	 * 
	 * @param img  - the img to normalise
	 * @param mean - Mean value of the normalized array. The default is 0.
	 * @param std  - Standard deviation of the normalized array. The default is 1.
	 * @return the normalised array
	 */
	public SpecTransform normaliseStd(double mean, double std) {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = normaliseStd(this.specData, mean, std);
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Reduce continuous tonal noise produced by e.g. ships and slowly varying
	 * background noise by subtracting from each row a running mean, computed
	 * according to the formula given in Baumgartner & Mussoline, Journal of the
	 * Acoustical Society of America 129, 2889 (2011); doi: 10.1121/1.3562166
	 * <p>
	 * From Ketos (Meridian).
	 * 
	 * @param input - a spectrogram image.
	 * @return timeConstLen - Time constant in number of samples, used for the
	 *         computation of the running mean.
	 */
	public SpecTransform reduceTonalNoiseMean(int timeConstLen) {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = reduceTonalNoiseMean(this.specData, timeConstLen);
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Subtracts from each row the median value of that row.
	 * 
	 * @param input - a spectrogram image.
	 * @return corrected array.
	 */
	public SpecTransform reduceTonalNoiseMedian() {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = reduceTonalNoiseMedian(this.specData);
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Discard pixels that are lower than the median threshold.
	 * 
	 * The resulting image will have 0s for pixels below the threshold and 1s for
	 * the pixels above the threshold.
	 * 
	 * Note: Code adapted from Kahl et al. (2017) Paper:
	 * http://ceur-ws.org/Vol-1866/paper_143.pdf Code:
	 * https://github.com/kahst/BirdCLEF2017/blob/master/birdCLEF_spec.py
	 * <p>
	 * From Ketos (Meridian).
	 * 
	 * @param rowfactor - Factor by which the row-wise median pixel value will be
	 *                  multiplied in orther to define the threshold.
	 * @param colfactor - Factor by which the col-wise median pixel value will be
	 *                  multiplied in orther to define the threshold.
	 * @return the fitlered median.
	 */
	public SpecTransform medianFilter(double rowfactor, double colfactor) {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = medianFilter(this.specData, rowfactor, colfactor);
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Enhance the contrast between regions of high and low intensity, while
	 * preserving the range of pixel values.
	 * 
	 * Multiplies each pixel value by the factor,
	 * 
	 * .. math:: f(x) = ( e^{-(x - m_x - \sigma_m) / w} + 1)^{-1}
	 * 
	 * where :math:`x` is the pixel value, :math:`m_x` is the pixel value median of
	 * the image, and :math:`w = \sigma_x / \epsilon`, where :math:`\sigma_x` is the
	 * pixel value standard deviation of the image and :math:`\epsilon` is the
	 * enhancement parameter.
	 * 
	 * Some observations:
	 * 
	 * :math:`f(x)` is a smoothly increasing function from 0 to 1.
	 * :math:`f(m_x)=0.5`, i.e. the median :math:`m_x` demarks the transition from
	 * "low intensity" to "high intensity". The smaller the width, :math:`w`, the
	 * faster the transition from 0 to 1. *
	 * <p>
	 * From Ketos (Meridian).
	 * 
	 * @param enhancement - Time constant in number of samples, used for the
	 *                    computation of the running mean.
	 * @return - the enahnced transform
	 **/
	public SpecTransform enhance(double enhanceFactor) {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = enhance(specData, enhanceFactor);
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Interpolate a spectrogram so that it has a specified number of frequency bins
	 * and sits that sits between two frequency limits.
	 *
	 * @param fMin     - the minimum frequency (Hz)
	 * @param fMin     - the minimum frequency (Hz)
	 * @param freqBins - the number of frequency bins to interpolate to. This is the
	 *                 number of bins between fMin and fMax
	 * @return the interpolated spectrogram object.
	 */
	public SpecTransform interpolate(double fMin, double fMax, int freqBins) {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = interpolate(this.specData, fMin, fMax, freqBins, sampleRate);

		// this is a little crazy for complex arrays...
		if (maintainPhase) {
			// TODO
		}
		return this;
	}

	/**
	 * Clamp the current spectrogram between two values.
	 * 
	 * @param minVal - the minimum value to clamp between.
	 * @param maxVal - the maximum value to clamp to.
	 * @return reference the clamped spectrogram.
	 */
	public SpecTransform clamp(double minVal, double maxVal) {
		if (this.specData == null)
			initialiseSpecData();
		this.specData = clamp(this.specData, minVal, maxVal);
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Clamp the current spectrogram between two values.
	 * 
	 * @param - sigma - the default value is 5.0;
	 * @return reference to the clamped spectrogram.
	 */
	public SpecTransform gaussianFilter(double sigma) {

		if (specData == null)
			initialiseSpecData();
		// if (gaussianFilter==null) gaussianFilter = new GaussianFilter();
		// this.complexData = gaussianFilter.runFilter(complexData);
		// this.specData = Spectrogram.buildAbsoluteSpectram(complexData);
		this.specData = blurImage(this.specData, sigma);
		if (maintainPhase)
			absSpec2Complex(); // set the new data in the complex spectrogram
		return this;
	}

	/**
	 * Use a bilinear interpolation.
	 */
	public final static int RESIZE_BILINEAR = 0; 
	

	/**
	 * Use a nearest neighbour interpolation.
	 */
	public final static int RESIZE_NEAREST = 1; 
	

	/**
	 * Use a bicubic interpolation.
	 */
	public final static int RESIZE_BICUBIC = 2; 
	/**
	 * Resize the spectrogram using bilinear interpolation.
	 * 
	 * @param array    - the spectrogram array. This should be spectrogram covering
	 *                 it's full frequency range.
	 * @param timebins - the number of time bins to interpolate to.
	 * @param resizeType - an int flag for the resize type. e.g SpecTransForm.RESIZE_BILINEAR.
	 * @return reference to the interpolated spectrogram.
	 */
	public SpecTransform resize(int timebins, int freqbins, int resizeType) {
		if (specData == null)
			initialiseSpecData();

		this.specData = resize(this.specData, timebins, freqbins, resizeType);

		return this;
	}
	
	/**
	 * Flip the spectrogram along the frequency axis. 
	 * @return the fliped spectrogram. 
	 */
	public SpecTransform flip() {
		if (specData == null)
			initialiseSpecData();

		this.specData = flip(this.specData);

		return this;
	}

	/**
	 * Contrast Limited Adaptive Histogram Equalization.
	 * 
	 * <br>
	 * References:
	 * http://en.wikipedia.org/wiki/Adaptive_histogram_equalization#Contrast_Limited_AHE
	 * 
	 * Three associated parameters.
	 * @param blockRadius - Integer - The size of the local region around a pixel for
	 * which the histogram is equalized. This size should be larger than the size of
	 * features to be preserved.
	 * @param bins - the number of histogram bins used for histogram equalization.
	 * @param slope - Float - Limits the contrast stretch in the intensity transfer
	 * function. Very large values will let the histogram equalization do whatever
	 * it wants to do, that is result in maximal local contrast. The value 1 will
	 * result in the original image.
	 * @return the histogram equalized spectrgram. 
	 */
	public SpecTransform clahe(int blockRadius, int bins, float slope) {
		if (specData == null)
			initialiseSpecData();

		this.specData = clahe(this.specData, blockRadius, bins, slope);

		return this;
	}

	/**
	 * Convert a spectrogram to dB.
	 * 
	 * @param array - the absolute spectrogram array.
	 * @param power -true for power 10*log(X) or false for amplitude 20*log10(X).
	 * @param mindB - the minimum dB i.e. if the 10/20*log10(value) in array is
	 *              below this value, the value is set to mindB. Be careful about
	 *              the sign when you set mindB
	 * @return the normalised spectrogram.
	 */
	public static double[][] dBSpec(double[][] array, boolean power, double mindB) {

		double eps = 1.4210854715202004e-14;
		double coeff = 20;
		if (power) {
			coeff = 10;
		}

		double[][] logSpectrgram = new double[array.length][array[0].length];

		for (int i = 0; i < array.length; i++) {
			for (int j = 0; j < array[i].length; j++) {
				if (array[i][j] <= 0) {
					logSpectrgram[i][j] = coeff * Math.log10(eps);
				} else {
					logSpectrgram[i][j] = coeff * Math.log10(array[i][j]);
				}
				if (logSpectrgram[i][j] < mindB) {
					logSpectrgram[i][j] = mindB;
				}
			}
		}

		return logSpectrgram;
	}

	/**
	 * Normalise a spectrogram.
	 * 
	 * @param array - the absolute spectrogram array.
	 * @return the normalised spectrogram.
	 */
	public static double[][] normalise(double[][] array, double min_leveldB, double ref_level_dB) {

		double[][] normalizeSpec = new double[array.length][array[0].length];

		for (int i = 0; i < array.length; i++) {
			for (int j = 0; j < array[i].length; j++) {
				// have to add a compensation factor here because of the the difference in fft
				// calc
				normalizeSpec[i][j] = 2 * (((array[i][j] - ref_level_dB - min_leveldB) / -min_leveldB)) - 1.1407;
			}
		}
		return normalizeSpec;
	}

	/**
	 * A minimum/maximum spectrogram normalisation.
	 * 
	 * @param img - the absolute spectrogram array.
	 * @return the normalised spectrogram.
	 */
	public static double[][] normaliseMinMax(double[][] img) {

		double[][] array = copyArr(img);

		double min = JamArr.min(array);

		double max = JamArr.max(array);

		array = JamArr.subtract(array, min);

		array = JamArr.divide(array, max - min);

		return array;
	}

	/**
	 * Hard copy of an array.
	 * 
	 * @param array
	 * @return
	 */
	public static double[][] copyArr(double[][] array) {

		double[][] arrCopy = new double[array.length][array[0].length];

		for (int i = 0; i < array.length; i++) {
			System.arraycopy(array[i], 0, arrCopy[i], 0, array[i].length);
		}

		return arrCopy;
	}
	
	

	/**
	 * Flip an array along it's y axis. 
	 * 
	 * @param array - the array to flip
	 * @return the flipped array
	 */
	public static double[][] flip(double[][] array) {
		
		double[][] arrCopy = new double[array.length][array[0].length];

		double[] arr;
		for (int i = 0; i < array.length; i++) {
			
			arr = new double[array[i].length];
			
			for (int j=0; j<arr.length; j++) {
				arr[arr.length-j-1] = array[i][j];
			}
			arrCopy[i]=arr;
		}

		return arrCopy;
	}

	/**
	 * Normalise a spectrogram by summing each row and squaring it then dividing the
	 * entire array by that value.
	 * 
	 * @param array - the absolute spectrogram array.
	 * @return the normalised spectrogram.
	 */
	public static double[][] normaliseRowSum(double[][] img) {

		double[][] array = copyArr(img);

		double tot = 0;
		for (int i = 0; i < array.length; i++) {
			tot += JamArr.sum(JamArr.pow(array[i], 2));
		}
		tot = Math.sqrt(tot);
		if (tot != 0) {
			return JamArr.divide(array, tot);
		}
		return array;
	}

	/**
	 * Clamp a spectrogram between two values.
	 * 
	 * @param array - the spectrogram array.
	 * @return the clamped spectrogram.
	 */
	public static double[][] clamp(double[][] array, double minVal, double maxVal) {
		double[][] clampedSpec = new double[array.length][array[0].length];

		for (int i = 0; i < array.length; i++) {
			for (int j = 0; j < array[i].length; j++) {
				if (array[i][j] < minVal) {
					clampedSpec[i][j] = minVal;
				} else if (array[i][j] > maxVal) {
					clampedSpec[i][j] = maxVal;
				} else {
					clampedSpec[i][j] = array[i][j];
				}
			}
		}

		return clampedSpec;
	}

	/**
	 * 
	 * Interpolate a spectrogram so that it has a specified number of frequency bins
	 * and sits that sits between two frequency limits.
	 *
	 * @param array    - the spectrogram array. This should be spectrogram covering
	 *                 it's full frequency range.
	 * @param fMin     - the minimum frequency (Hz)
	 * @param fMin     - the minimum frequency (Hz)
	 * @param freqBins - the number of frequency bins to interpolate to.
	 * @return interpolate spectrogram
	 */
	// TODO - use inteprolation function for this
	public static double[][] interpolate(double[][] array, double fMin, double fMax, int freqBins, float sR) {
		// interpolate a spectrogram
		int fftlen = array[0].length;

		// find the minimum bin
		int minIndex = (int) Math.max(0, fftlen * (fMin / (sR / 2)));
		int maxIndex = (int) Math.min(fftlen, fftlen * (fMax / (sR / 2)));

		double[][] specInterp = new double[array.length][];
		double[] fftSliceInterp;

		// System.out.println("Min index: " + minIndex + " max index: " + maxIndex + "
		// FFT len: " + fftlen + " f min Hz: " + fMin + " f max Hz: " + fMax + " sR: " +
		// sR);
		if (freqBins == fftlen) {
			// Crop only if same number of pts in the new freqBins
			for (int i = 0; i < array.length; i++) {
				fftSliceInterp = Arrays.copyOfRange(array[i], minIndex, maxIndex);
				specInterp[i] = fftSliceInterp;
			}
		} else {
			for (int i = 0; i < array.length; i++) {
				fftSliceInterp = Arrays.copyOfRange(array[i], minIndex, maxIndex);
				specInterp[i] = fftSliceInterp;
				fftSliceInterp = nearestNeighbourInterp(fftSliceInterp, freqBins);
				specInterp[i] = fftSliceInterp;
			}
		}

		return specInterp;
	}

	/**
	 * 
	 * Interpolate a spectrogram so that it has a specified number of time bins
	 * 
	 * @param array    - the spectrogram array. This should be spectrogram covering
	 *                 it's full frequency range.
	 * @param timebins - the number of time bins to interpolate to.
	 * @param resizeType - an int flag for the resize type. e.g SpecTransForm.RESIZE_BILINEAR.
	 * @return interpolated spectrogram
	 */
	public double[][] resize(double[][] array, int timeBins, int freqbins, int resizeType) {

		switch (resizeType) {
		case RESIZE_BILINEAR:
			interpolation = new Bilinear(JamArr.doubleToFloat(array));
			break;
		case RESIZE_NEAREST:
			interpolation = new NearestNeighbor(JamArr.doubleToFloat(array));
			break;
		case RESIZE_BICUBIC:
			interpolation = new Bicubic(JamArr.doubleToFloat(array));
			break;
		}

		float[][] resizeArr = interpolation.resize(timeBins, freqbins);

		return JamArr.floatToDouble(resizeArr);
	}
	
	
	

	/**
	 * Perform a nearest neighbour interpolation of a 1D array of evenly spaced
	 * values.
	 * 
	 * @param inputArray - the array to interpolate.
	 * @param w2         - the new length of array.
	 * @return the interpolated array.
	 */
	public static double[] nearestNeighbourInterp(double[] inputArray, int w2) {
		int w1 = inputArray.length;
		double[] temp = new double[w2];
		double x_ratio = w1 / (double) w2;
		double px;

		for (int j = 0; j < w2; j++) {
			px = Math.floor(j * x_ratio);
			temp[j] = inputArray[(int) (px)];
			// System.out.println("Old len: " + w1 + "New len: " + w2 + " " + x_ratio + "
			// PX: " +px);
		}

		return temp;
	}

	/**
	 * Reduce continuous tonal noise produced by e.g. ships and slowly varying
	 * background noise by subtracting from each row a running mean, computed
	 * according to the formula given in Baumgartner & Mussoline, Journal of the
	 * Acoustical Society of America 129, 2889 (2011); doi: 10.1121/1.3562166
	 * <p>
	 * From Ketos (Meridian).
	 * 
	 * @param input - a spectrogram image.
	 * @return timeConstLen - Time constant in number of samples, used for the
	 *         computation of the running mean.
	 */
	public static double[][] reduceTonalNoiseMean(double[][] input, double timeLenConst) {

		double eps = 1 - Math.exp((Math.log(0.15) * 1. / timeLenConst));

		double[] rMean = JamArr.mean(input, 0);

		double[][] imgNew = new double[input.length][];

		int nx = imgNew.length;

		for (int i = 0; i < nx; i++) {
			imgNew[i] = JamArr.subtract(input[i], rMean);
			// img_new[ix,:] = img[ix,:] - rmean // subtract running mean

			rMean = JamArr.add(JamArr.product(rMean, (1 - eps)), JamArr.product(input[i], eps));

			// rMean = (1 - eps) * rmean + eps * img[ix,:] # update running mean
		}

		return imgNew;
	}

	/**
	 * Subtracts from each row the median value of that row.
	 * 
	 * @param input - a spectrogram image.
	 *              <p>
	 *              From Ketos (Meridian).
	 * @return corrected array.
	 *
	 */
	public static double[][] reduceTonalNoiseMedian(double[][] img) {

		double[][] imgNew = new double[img.length][img[0].length];

		double[] median = JamArr.median(img, 1);

		// each double is an fft.
		// System.out.println("specMatrix: " + median.length);

		for (int i = 0; i < img[0].length; i++) {
			for (int j = 0; j < img.length; j++) {
				// System.out.println("Median: " + median[i]);
				imgNew[j][i] = img[j][i] - median[i];
			}
		}

		return imgNew;
	}

	/**
	 * Normalize the data array to specified mean and standard deviation.
	 * 
	 * For the data array to be normalizable, it must have non-zero standard
	 * deviation. If this is not the case, the array is unchanged by calling this
	 * method.
	 * <p>
	 * From Ketos (Meridian).
	 * 
	 * @param img  - the img to normalise
	 * @param mean - Mean value of the normalized array. The default is 0.
	 * @param std  - Standard deviation of the normalized array. The default is 1.
	 * @return the normalised array
	 */
	public static double[][] normaliseStd(double[][] img, double mean, double std) {

//		System.out.println("Normalise Std: " + mean + "  " + std + "  " + JamArr.max(img));

		double std_orig = JamArr.std(img);

		return JamArr.add(JamArr.product(JamArr.divide(JamArr.subtract(img, JamArr.mean(img)), std_orig), std), mean);
	}

	/**
	 * Discard pixels that are lower than the median threshold.
	 * 
	 * The resulting image will have 0s for pixels below the threshold and 1s for
	 * the pixels above the threshold.
	 * 
	 * @param input - a spectrogram image.
	 *
	 */
	public static double[][] filterIsolatedSpots(double[][] img, int[][] struct) {

		// TODO

		return null;
	}

	// /**
	// * Smooth the input image using a median or Gaussian blur filter.
	// *
	// *
	// * For further details, see
	// * https://docs.scipy.org/doc/scipy/reference/ndimage.html
	// * <p>
	// * From Ketos Meridian.
	// *
	// * @param img - image to be processed.
	// * @param size - Only used by the median filter. Describes the shape that is
	// * taken from the input array, at every element position, to
	// * define the input to the filter function.
	// * @param sigma - Only used by the Gaussian filter. Standard deviation for
	// * Gaussian kernel. for the axes to have different standard
	// * deviations.
	// * @param gaussian - Switch between median and Gaussian (default) filter
	// * @return blurred image.
	// */
	// public static double[][] blurImage(double[][] img, int size, double sigma,
	// boolean gaussian) {
	// return blurImage(img, size, new double[] {sigma}, gaussian) ;
	// }

	/**
	 * Smooth the input image using a median or Gaussian blur filter.
	 * 
	 * Note that the input image is recasted as np.float32.
	 * 
	 * This is essentially a wrapper around the scipy.ndimage.median_filter and
	 * scipy.ndimage.gaussian_filter methods.
	 * 
	 * For further details, see
	 * https://docs.scipy.org/doc/scipy/reference/ndimage.html
	 * <p>
	 * From Ketos (Meridian).
	 * 
	 * @param img      - image to be processed.
	 * @param size     - Only used by the median filter. Describes the shape that is
	 *                 taken from the input array, at every element position, to
	 *                 define the input to the filter function.
	 * @param sigma    - Only used by the Gaussian filter. Standard deviation for
	 *                 Gaussian kernel. May be given as a single number, in which
	 *                 case all axes have the same standard deviation, or as an
	 *                 array, allowing for the axes to have different standard
	 *                 deviations.
	 * @param gaussian - Switch between median and Gaussian (default) filter
	 * @return blurred image.
	 */
	public static double[][] blurImage(double[][] img, double sigma) {

		double[][] kernel = generateKernal(sigma);

		int inputWidth = img.length;
		int inputHeight = img[0].length;
		int kernelWidth = kernel.length;
		int kernelHeight = kernel[0].length;
		if ((kernelWidth <= 0) || ((kernelWidth & 1) != 1))
			throw new IllegalArgumentException("Kernel must have odd width");
		if ((kernelHeight <= 0) || ((kernelHeight & 1) != 1))
			throw new IllegalArgumentException("Kernel must have odd height");
		int kernelWidthRadius = kernelWidth >>> 1;
		int kernelHeightRadius = kernelHeight >>> 1;

		double[][] outputData = new double[inputWidth][inputHeight];
		for (int i = inputWidth - 1; i >= 0; i--) {
			for (int j = inputHeight - 1; j >= 0; j--) {
				double newValue = 0.0;
				for (int kw = kernelWidth - 1; kw >= 0; kw--)
					for (int kh = kernelHeight - 1; kh >= 0; kh--)
						newValue += kernel[kw][kh]
								* img[bound(i + kw - kernelWidthRadius, inputWidth)][bound(j + kh - kernelHeightRadius,
										inputHeight)];
				outputData[i][j] = newValue;
			}
		}
		return outputData;

	}

	private static int bound(int value, int endIndex) {
		if (value < 0)
			return 0;
		if (value < endIndex)
			return value;
		return endIndex - 1;
	}

	/**
	 * Generate the Kernel for a sigma value
	 * 
	 * @param sigma
	 * @return
	 */
	public static double[][] generateKernal(double sigma) {
		int W = 5;
		double[][] kernel = new double[W][W];
		double mean = W / 2;
		double sum = 0.0; // For accumulating the kernel values
		for (int x = 0; x < W; ++x)
			for (int y = 0; y < W; ++y) {
				kernel[x][y] = Math.exp(-0.5 * (Math.pow((x - mean) / sigma, 2.0) + Math.pow((y - mean) / sigma, 2.0)))
						/ (2 * Math.PI * sigma * sigma);

				// Accumulate the kernel values
				sum += kernel[x][y];
			}
		//
		// Normalize the kernel
		for (int x = 0; x < W; ++x)
			for (int y = 0; y < W; ++y)
				kernel[x][y] /= sum;

		return kernel;

	}

	/**
	 * Discard pixels that are lower than the median threshold.
	 * 
	 * The resulting image will have 0s for pixels below the threshold and 1s for
	 * the pixels above the threshold.
	 * 
	 * Note: Code adapted from Kahl et al. (2017) Paper:
	 * http://ceur-ws.org/Vol-1866/paper_143.pdf Code:
	 * https://github.com/kahst/BirdCLEF2017/blob/master/birdCLEF_spec.py
	 * <p>
	 * From Ketos (Meridian).
	 * 
	 * @param img1      - Array containing the img to be filtered.
	 * @param rowfactor - Factor by which the row-wise median pixel value will be
	 *                  multiplied in orther to define the threshold.
	 * @param colfactor - Factor by which the col-wise median pixel value will be
	 *                  multiplied in orther to define the threshold.
	 * @return numpy array The filtered image with 0s and 1s.
	 */
	public static double[][] medianFilter(double[][] img1, double rowfactor, double colfactor) {

		/**
		 * Example: >>> from ketos.audio.utils.filter import apply_median_filter >>> img
		 * = np.array([[1,4,5], ... [3,5,1], ... [1,0,9]]) >>> img_fil =
		 * apply_median_filter(img, row_factor=1, col_factor=1) >>> print(img_fil) [[0 0
		 * 0] [0 1 0] [0 0 1]]
		 */

		double[][] output = new double[img1.length][];

		double[] col_median = JamArr.product(JamArr.median(img1, 0), colfactor);
		double[] row_median = JamArr.product(JamArr.median(img1, 1), rowfactor);

		double[] temp;
		for (int i = 0; i < img1.length; i++) {
			temp = new double[img1[i].length];
			for (int j = 0; j < img1.length; j++) {
				if (img1[i][j] <= col_median[i]) {

				} else if (img1[i][j] <= row_median[i]) {

				} else
					temp[j] = img1[i][j];

				// clamp to one.
				if (temp[j] > 0)
					temp[j] = 1;
			}
			output[i] = temp;
		}

		return output;
	}

	/**
	 * Enhance the contrast between regions of high and low intensity, while
	 * preserving the range of pixel values.
	 * 
	 * Multiplies each pixel value by the factor,
	 * 
	 * .. math:: f(x) = ( e^{-(x - m_x - \sigma_m) / w} + 1)^{-1}
	 * 
	 * where :math:`x` is the pixel value, :math:`m_x` is the pixel value median of
	 * the image, and :math:`w = \sigma_x / \epsilon`, where :math:`\sigma_x` is the
	 * pixel value standard deviation of the image and :math:`\epsilon` is the
	 * enhancement parameter.
	 * 
	 * Some observations:
	 * 
	 * :math:`f(x)` is a smoothly increasing function from 0 to 1.
	 * :math:`f(m_x)=0.5`, i.e. the median :math:`m_x` demarks the transition from
	 * "low intensity" to "high intensity". The smaller the width, :math:`w`, the
	 * faster the transition from 0 to 1.
	 * <p>
	 * From Ketos (Meridian).
	 * 
	 * @param input       - a spectrogram image.
	 * @param enhancement - Time constant in number of samples, used for the
	 *                    computation of the running mean.
	 * @return - the enahnced image
	 **/
	public static double[][] enhance(double[][] img, double enhancement) {

		if (enhancement > 0) {
			double med = JamArr.median(img);
			double std = JamArr.std(img);
			double wid = (1. / enhancement) * std;

			// scaling = 1. / (np.exp(-(img - med - std) / wid) + 1.)

			// System.out.println(" Enhance: med: " + med + " std: " + std + " wid: " +
			// wid);

			// this is why Python and MATLAB are nicer than Java...
			double[][] scaling = JamArr.divide(1., JamArr
					.add(JamArr.exp(JamArr.product(JamArr.divide(JamArr.subtract(img, (med + std)), wid), -1.)), 1.));

			return JamArr.product(img, scaling);
		} else {
			return img;
		}

	}

	/**
	 * Initialise the spectrogram data.
	 */
	private void initialiseSpecData() {
		this.specData = spectrgram.getAbsoluteSpectrogram();
		this.complexData = spectrgram.getComplexSpectrogram();
		this.sampleRate = spectrgram.getSampleRate(); 
	}

	/**
	 * Get the real data from the transformed spectrogram.
	 * 
	 * @return the real data from the spectrogram transform.
	 */
	public double[][] getReal() {

		double[][] real = new double[complexData.length][complexData[0].length()];

		for (int i = 0; i < complexData.length; i++) {
			for (int j = 0; j < complexData[i].length(); j++) {
				real[i][j] = complexData[i].getReal(j);
			}
		}

		return real;

	}

	/**
	 * Get the imaginary data from the transformed spectrogram.
	 * 
	 * @return the real data from the spectrogram transform.
	 */
	public double[][] getImag() {

		double[][] imag = new double[complexData.length][complexData[0].length()];

		for (int i = 0; i < complexData.length; i++) {
			for (int j = 0; j < complexData[i].length(); j++) {
				imag[i][j] = complexData[i].getImag(j);
			}
		}

		return imag;
	}

	/**
	 * Apply the transformed data from an absolute spectrogram to the
	 */
	private void absSpec2Complex() {

		double newReal;
		int n;
		for (int i = 0; i < complexData.length; i++) {
			for (int j = 0; j < complexData[i].length(); j++) {

				if (j > specData[i].length - 1) {
					n = 2 * specData[i].length - j - 1;
				} else {
					n = j;
				}

				// System.out.println("absSpec2Complex: " + specData[i].length + " " +
				// complexData[i].length() + " j: " + j +" n: " + n);

				newReal = Math.sqrt(Math.pow(specData[i][n], 2) - Math.pow(complexData[i].getImag(j), 2));
				complexData[i].set(j, newReal, complexData[i].getImag(j));
			}
		}
	}

	/**
	 * Get the transformed spectrgram data.
	 *
	 * @return the transformed spectrgram data.
	 */
	public double[][] getTransformedData() {
		return this.specData;
	}

	/**
	 * Get the raw spectrogram. This has no undergone any transformations. See
	 * getTransformedData for the transformed spectrogram.
	 * 
	 * @return the original spectrogram data.
	 */
	public Spectrogram getSpectrgram() {
		return this.spectrgram;
	}

	/**
	 * Manually set the transformed data.
	 * 
	 * @param absoluteSpectrogram - the data to set.
	 */
	public void setTransformedData(double[][] absoluteSpectrogram) {
		this.specData = absoluteSpectrogram;
	}

	/**
	 * Contrast Limited Adaptive Histogram Equalization.
	 * 
	 * <br>
	 * References:
	 * http://en.wikipedia.org/wiki/Adaptive_histogram_equalization#Contrast_Limited_AHE
	 * 
	 * Three associated parameters.
	 * @param blockRadius - Integer - The size of the local region around a pixel for
	 * which the histogram is equalized. This size should be larger than the size of
	 * features to be preserved.
	 * @param bins - the number of histogram bins used for histogram equalization.
	 * @param slope - Float - Limits the contrast stretch in the intensity transfer
	 * function. Very large values will let the histogram equalization do whatever
	 * it wants to do, that is result in maximal local contrast. The value 1 will
	 * result in the original image.
	 * @return histogram equalized image. 
	 */
	public static double[][] clahe(double[][] dataF, int bloackRadius, int bins, float slope) {
		
		FastBitmap fastBitMap = new FastBitmap(dataF[0].length, dataF.length); 

		for (int i=0; i<dataF.length; i++) {
			for (int j=0; j<dataF[0].length; j++) {
				fastBitMap.setGray(i, j, (int) (255.*dataF[i][j]));
			}
		}
		
		Clahe clahe = new  Clahe(bloackRadius, bins, slope); 
		
		
		clahe.applyInPlace(fastBitMap);
		
		double[][] dataClahe = new double[dataF.length][dataF[0].length];
		for (int i=0; i<dataF.length; i++) {
			for (int j=0; j<dataF[0].length; j++) {
				dataClahe[i][j] = fastBitMap.getGray(i, j)/255.;
			}
		}
		
		return dataClahe;
	}


	/**
	 * Get the spectrogram image data. This is the absolute data from the spectrogram. 
	 * Each row is a the absolute value of a single FFT. 
	 * @return the absolute from the spectrogram.. 
	 */
	public double[][] getSpecData() {
		return specData;
	}

	/**
	 * Set the spectrogram image data. This is the absolute data from the spectrogram. 
	 * @param specData - the absolute data from the spectrogram. 
	 */
	public void setSpecData(double[][] specData) {
		this.specData = specData;
	}

	/**
	 * Get the phase data from the spectrogram (complex data). 
	 * @return the phase data from each FFT bin in the spectrogram. 
	 */
	public ComplexArray[] getComplexData() {
		return complexData;
	}

	/**
	 * Set the phase data from the spectrogram (complex data). 
	 * @param the phase data from each FFT bin in the spectrogram. 
	 */
	public void setComplexData(ComplexArray[] complexData) {
		this.complexData = complexData;
	}
	

	/**
	 * Get the sample rate of the spectrogram in samples per second. 
	 * @return samples in samples per second. 
	 */
	public float getSampleRate() {
		return sampleRate;
	}

	/**
	 * Set the sample rate of the spectrogram in samples per second. 
	 * @param samples in samples per second. 
	 */
	public void setSampleRate(float sampleRate) {
		this.sampleRate = sampleRate;
	}



}
