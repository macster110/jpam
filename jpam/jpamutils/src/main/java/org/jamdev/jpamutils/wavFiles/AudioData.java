package org.jamdev.jpamutils.wavFiles;

import java.util.Arrays;

import org.jamdev.jpamutils.JamArr;

/**
 * Holds .wav file data. 
 *
 * @author Jamie Macaulay
 *
 */
public class AudioData {

	/**
	 * Interpolator for wav files. 
	 */
	public WavInterpolator wavInterpolator;

	/**
	 * Pre-emphasis filter. 
	 */
	public PreEmphasisFilter preEmphasisFilter;

	/**
	 * Samples in amplitude units u. 
	 */
	public int[] samples;

	/**
	 * Samples in amplitude units u.
	 */
	public double[] samples_double;

	/**
	 * The sample rate in samples per second
	 */
	public float sampleRate;

	/**
	 * The bit rate of samples
	 */
	public double bitRate = 16;

	/**
	 * Create an AudioData object.
	 * @param samples - the samples in amplitude units u.
	 * @param sampleRate - the sample rate in samples per second.
	 */
	public AudioData(int[] samples, float sampleRate){
		this.samples=samples;
		this.sampleRate = sampleRate;
		this.samples_double = this.getScaledSampleAmpliudes();
		preEmphasisFilter = new PreEmphasisFilter();
		wavInterpolator= new WavInterpolator();
	}

	/**
	 * Create an AudioData object.
	 * @param samples - the samples in amplitude units u.
	 * @param sampleRate - the sample rate in samples per second.
	 */
	public AudioData(short[] samples, float sampleRate){
		this(short2Int(samples), sampleRate);
	}

	/**
	 * Create an AudioData object.
	 * @param wavArray - the samples in linear amplitude units  - 1 to 1
	 * @param sampleRate - the sample rate in samples per second.
	 */
	public AudioData(double[] wavArray, float sampleRate){
		int[] samples = new int[wavArray.length];
		for (int i=0; i<wavArray.length; i++) {
			samples[i] = (int) (wavArray[i]*Math.pow(2, bitRate));
		}
		this.samples = samples;
		this.sampleRate = sampleRate;
		this.samples_double = this.getScaledSampleAmpliudes();
		preEmphasisFilter = new PreEmphasisFilter();
		wavInterpolator= new WavInterpolator();
	}

	/**
	 * Get the sample rate in samples per second.
	 * @return the sample rate in samples per second.
	 */
	public float getSampleRate() {
		return sampleRate;
	}

	/**
	 * Get the sample amplitudes in raw bits e.g. +/- 2^16 /2 for 16 bit files.
	 * @return the sample amplitudes
	 */
	public int[] getSampleAmplitudes() {
		return samples;
	}
	public double[] getDoubleSampleAmplitudes() {
		return this.samples_double;
	}

	/**
	 * Get the length in seconds.
	 * @return the length of the file in seconds
	 */
	public double getLengthInSeconds() {
		return samples.length / (double) sampleRate;
	}
	/**
	 * Get the length in seconds.
	 * @return the length of the file in seconds
	 */
	public double getDoubleLengthInSeconds() {
		return samples_double.length / (double) sampleRate;
	}

	/**
	 * Get the sample amplitudes as a double scaled between -1 and 1.
	 * @return the scaled amplitude samples.
	 */
	public double[] getScaledSampleAmpliudes() {
		//must divide the bitsize by because we are scaling between -1 and 1 i.e a range of 2.
		double bitSize = Math.pow(2, bitRate)/2;

		double[] wavArray = new double[samples.length];
		for (int i=0; i<wavArray.length; i++) {
			wavArray[i] = samples[i]/bitSize;
		}
		return wavArray;
	}

	/**
	 * Concatenate two arrays.
	 * From	https://stackoverflow.com/questions/80476/how-can-i-concatenate-two-arrays-in-java
	 * @param first first array to concatenate
	 * @param second second array to concatenate
	 * @return <T> concatenated array
	 *
	 */
	public static double[] concat(double[] first, double[] second) {
		double[] result = Arrays.copyOf(first, first.length + second.length);
		System.arraycopy(second, 0, result, first.length, second.length);
		return result;
	}

	/**
	 * Concatenate two arrays.
	 * From	https://stackoverflow.com/questions/80476/how-can-i-concatenate-two-arrays-in-java
	 * @param first first array to concatenate
	 * @param rest other array to concatenate
	 * @return <T> concatenated array
	 *
	 */
	public static double[]  concatAll(double[]  first, double[]... rest) {
		int totalLength = first.length;
		for (double[]  array : rest) {
			totalLength += array.length;
		}
		double[]  result = Arrays.copyOf(first, totalLength);
		int offset = first.length;
		for (double[]  array : rest) {
			System.arraycopy(array, 0, result, offset, array.length);
			offset += array.length;
		}
		return result;
	}

	/**
	 * Reverse array. Adapted from org/jamdev/jpamutilsfx/utilsfx/ColourArray.java public void reverseArray()
	 * @param arr arrray to reverse
	 *
	 * @return <T> reversed array
	 */
	public static double[] reverseArray(double[] arr) {
		double[] reversed_arr = Arrays.copyOf(arr, arr.length);
		for (int i = 0; i < arr.length; i++) {
			reversed_arr[i] = arr[arr.length-1-i];
		}
		return reversed_arr;
	}

	/**
	 * Pad array with its own (inverted) reflection along
	 *         the first axis (0).
	 * @param x The data to be padded.
	 * @param pad_left Amount of padding on the left
	 * @param pad_right Amount of padding on the right
	 * @param invert Whether to invert the reflection. Default is False.
	 * @return Padded array
	 */
	public static double[] pad_reflect(double[] x, int pad_left, int pad_right, Boolean invert) {

		double[] x_padded;

		int pad_left_residual = 0;
		int pad_right_residual = 0;

		if (pad_left == 0 && pad_right == 0) {
			x_padded = x;
		}
		else{
			double[] x_padded_tmp = new double[x.length + pad_left + pad_right];

			if (pad_left > 0 && pad_right > 0){
				double[] x_pad_left = reverseArray(Arrays.copyOfRange(x, 1, pad_left + 1));
				double[] x_pad_right;
				if (x.length < pad_right) {
					x_pad_right = reverseArray(Arrays.copyOfRange(x, 0, x.length - 1));
					pad_right_residual = Math.max(0, pad_right - x_pad_right.length);
				} else {
					x_pad_right = reverseArray(Arrays.copyOfRange(x, x.length - pad_right - 1, x.length - 1));
				}
				x_padded_tmp = concatAll(x_pad_left, x, x_pad_right);
			}

			else {

				if (pad_left > 0) {
					// Python starts at 0 similarly to Java, 1 is really 1 here
					double[] x_pad = reverseArray(Arrays.copyOfRange(x, 1, pad_left + 1));

//				if (invert){
//					x_pad = 2 * x[0] - x_pad;
//				}

					pad_left_residual = Math.max(0, pad_left - x_pad.length);
					x_padded_tmp = concat(x_pad, x);
				}
				if (pad_right > 0) {
					// In Python but to thoroughly test
//				x_pad = np.flip(x[-pad_right - 1:-1],axis = 0)
					double[] x_pad;
					if (x.length < pad_right) {
						x_pad = reverseArray(Arrays.copyOfRange(x, 0, x.length - 1));
						pad_right_residual = Math.max(0, pad_right - x_pad.length);
					} else {
						x_pad = reverseArray(Arrays.copyOfRange(x, x.length - pad_right - 1, x.length - 1));
					}
//				if (invert) {
//					x_pad = 2 * x[-1] - x_pad
//				}
					x_padded_tmp = concat(x, x_pad);
				}
			}

			x_padded = new double[x_padded_tmp.length + pad_left + pad_right];

			if (pad_left_residual + pad_right_residual > 0) {
				double[] x_padded_zero = pad_zero(x_padded_tmp, pad_left_residual, pad_right_residual);
				x_padded = x_padded_zero;
			}
			else {
				x_padded = x_padded_tmp;
			}
		}

		return x_padded;
	}

	/**
	 * Pad array with zeros along the first axis (0).
	 *
	 * @param x
	 * @param pad_left
	 * @param pad_right
	 * @return
	 *     Padded array
	 */
	public static double[] pad_zero(double[] x, int pad_left, int pad_right) {
		double[] x_padded = x;

		if (pad_left == 0 && pad_right == 0) {
			x_padded = x;
		}
		else{
			int pad_shape = x.length;
			if (pad_left > 0){
				double[] x_pad = new double[pad_left];
				Arrays.fill(x_pad, 0);
				x_padded = concat(x_pad, x_padded);
			}

			if (pad_right > 0){
				double[] x_pad = new double[pad_right];
				Arrays.fill(x_pad, 0);
				x_padded = concat(x_padded, x_pad);
			}
		}

		return x_padded;
	}
	public void appendLeftRight(int num_pad_left, int num_pad_right) {
		this.samples_double = pad_reflect(this.samples_double, num_pad_left, num_pad_right, Boolean.FALSE);
	}


	/**
	 * Trim the audio data between two sample indexes.
	 * @param sampleStart - the sample start.
	 * @param samplEnd - the sample end.
	 * @return AudioData object with trimmed data.
	 */
	public AudioData trim(int sampleStart, int samplEnd) {
		if (samples.length <= samplEnd){
			return new AudioData(Arrays.copyOfRange(samples, sampleStart, samples.length), sampleRate);
		}
		else {
			return new AudioData(Arrays.copyOfRange(samples, sampleStart, samplEnd), sampleRate);
		}
	}

	public void setSamplesDouble(double[] arr) {
		this.samples_double = arr;
	}

	public void setSampleRate(float sr) {
		this.sampleRate = sr;
	}

	/**
	 * Interpolate the audio data (e..g up sample or down sample)
	 * @param interpSr - the new sample rate.
	 * @return AudioData object containing interpolated data and sample rate.
	 */
	public AudioData interpolate(float interpSr) {
		double[] wavArray = getScaledSampleAmpliudes();

		double[] intperarr = wavInterpolator.interpolate(wavArray, this.sampleRate, interpSr);

		int[] samplesDecimated = new int[intperarr.length];

		double bitSize = Math.pow(2, bitRate);
		for (int i=0; i<intperarr.length; i++) {
			samplesDecimated[i]=(int) (bitSize*intperarr[i]);
		}

		return new AudioData(samplesDecimated, interpSr);
	}

	/**
	 * Interpolate the audio data (e..g up sample or down sample) using FFT similarly to scipy
	 * @param target_sr - the new sample rate.
	 * @return AudioData object containing interpolated data and sample rate.
	 */
	public AudioData interpolate_scipy(float target_sr) {

		double[] wavArray = getScaledSampleAmpliudes();
		double ratio = target_sr / this.sampleRate;
		int n_samples = (int) Math.ceil(wavArray.length * ratio);

		double[] wavArray_resampled = wavInterpolator.fourierResample(wavArray, n_samples);

		this.setSamplesDouble(null);
		this.setSamplesDouble(wavArray_resampled);
		this.setSampleRate(target_sr);

		return this;
	}


	/**
	 * Pre-emphasise the audio data so that lower frequencies are attenuated
	 * @param factor - the pre-emphasis factor
	 * @return AudioData object with pre emphasised data.
	 */
	public AudioData preEmphasis(double factor) {
		return new AudioData(preEmphasisFilter.preEmphasis(this.samples, factor) , sampleRate);
	}


	/**
	 * Normalise the audio data.
	 * @param mean - the target mean for the normalised data
	 * @param std = the target standard deviation for the normalised audio data
	 * @return AudioData object containing normalised data.
	 */
	public AudioData normalise(double mean, double std) {

		// self.data = std * (self.data - np.mean(self.data)) / std_orig + mean

		double meanSamples = JamArr.mean(this.samples);
		double stdSamples = JamArr.std(this.samples);

		int[] samplesNorm = new int[samples.length];

		for (int i=0; i<samples.length; i++) {
			samplesNorm[i] = (int) (stdSamples*(samples[i] - meanSamples) / (std+mean));
		}

		return new AudioData(samplesNorm, this.sampleRate);
	}

	public AudioData normalise_double(double mean, double std) {

		double meanSamples = JamArr.mean(this.samples_double);
		double stdSamples = JamArr.std(this.samples_double);

		if (stdSamples > 0){
			double[] samplesNorm = new double[this.samples_double.length];
	//		int[] samplesNorm_int = new int[this.samples.length];

			for (int i=0; i<this.samples_double.length; i++) {
//				self.data = std * (self.data - np.mean(self.data)) / std_orig + mean
				samplesNorm[i] = std * (this.samples_double[i] - meanSamples) / stdSamples + mean;
	//			samplesNorm_int[i] = (int) (stdSamples*(this.samples[i] - meanSamples) / (std+mean));
			}
			this.setSamplesDouble(samplesNorm);
		}

		return this;
	}
	/**
	 * Convert a short[] array to int[].
	 * @param samples - the short samples
	 * @return the integer array containing the same data.
	 */
	public static int[] short2Int(short[] samples) {
		int[] arr = new int[samples.length];
		for (int i=0; i<samples.length; i++) {
			arr[i]=samples[i];
		}
		return arr;
	}

}