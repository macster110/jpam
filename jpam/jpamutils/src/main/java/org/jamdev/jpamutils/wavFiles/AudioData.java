package org.jamdev.jpamutils.wavFiles;

import java.util.Arrays;

import org.jamdev.jpamutils.JamArr;

import uk.me.berndporr.iirj.Butterworth;
import uk.me.berndporr.iirj.Cascade;
import uk.me.berndporr.iirj.ChebyshevII;
import uk.me.berndporr.iirj.DirectFormAbstract;

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
	 * Samples in amplitude units u e.g. +/- 2^16 /2 for 16 bit files. This is an
	 * integer view of the data which is kept for backwards compatibility - all
	 * processing uses the double precision samples. If this array is replaced, the
	 * double precision samples are recalculated from it; changing values in place
	 * is not detected, use {@link #setSampleAmplitudes(int[])} instead.
	 */
	public int[] samples;

	/**
	 * The samples at double precision, scaled so that full scale is +/-1. These are
	 * not quantised so low amplitude signals (e.g. clicks from a binary file) keep
	 * their full resolution through transforms. Values may exceed +/-1, e.g. after
	 * normalisation.
	 */
	private double[] scaledSamples;

	/**
	 * The integer array that scaledSamples was last synchronised with.
	 */
	private int[] syncedSamples;

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
		this.sampleRate = sampleRate;
		setSampleAmplitudes(samples);
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
		this.sampleRate = sampleRate;
		setScaledSamples(wavArray.clone());
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

	/**
	 * Set the sample amplitudes in raw bits e.g. +/- 2^16 /2 for 16 bit files.
	 * @return the sample amplitudes
	 */
	public void setSampleAmplitudes(int[] newValues) {
		this.samples = newValues;
		double bitSize = getBitSize();
		double[] scaled = new double[newValues.length];
		for (int i=0; i<scaled.length; i++) {
			scaled[i] = ((double) newValues[i])/bitSize;
		}
		this.scaledSamples = scaled;
		this.syncedSamples = newValues;
	}

	/**
	 * Set the double precision samples and update the integer view.
	 * @param scaled - samples scaled so that full scale is +/-1. The array is used directly, not copied.
	 */
	private void setScaledSamples(double[] scaled) {
		this.scaledSamples = scaled;
		this.samples = toIntSamples(scaled);
		this.syncedSamples = this.samples;
	}

	/**
	 * Get the double precision samples without copying, recalculating them if the
	 * public integer samples array has been replaced.
	 * @return samples scaled so that full scale is +/-1.
	 */
	private double[] scaled() {
		if (samples!=syncedSamples) {
			setSampleAmplitudes(samples);
		}
		return scaledSamples;
	}

	/**
	 * Convert scaled samples to integer amplitude units.
	 * @param scaled - samples scaled so that full scale is +/-1.
	 * @return the samples in amplitude units u.
	 */
	private int[] toIntSamples(double[] scaled) {
		double bitSize = getBitSize();
		int[] ints = new int[scaled.length];
		for (int i=0; i<scaled.length; i++) {
			if (scaled[i]==1.0) {
				//positive full scale is one bit less than negative full scale.
				ints[i] = (int) bitSize - 1;
			}
			else {
				ints[i] = (int) Math.floor(scaled[i] * bitSize);
			}
		}
		return ints;
	}

	/**
	 * The value of full scale in amplitude units u, i.e. 2^bitRate/2.
	 * @return full scale in amplitude units.
	 */
	private double getBitSize() {
		//must divide the bitsize by 2 because we are scaling between -1 and 1 i.e a range of 2.
		return Math.pow(2, bitRate)/2;
	}

	/**
	 * Get the length in seconds.
	 * @return the length of the file in seconds
	 */
	public double getLengthInSeconds() {
		return scaled().length / (double) sampleRate;
	}

	/**
	 * Get the sample amplitudes as a double scaled between -1 and 1.
	 * @return the scaled amplitude samples.
	 */
	public double[] getScaledSampleAmplitudes() {
		return scaled().clone();
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
		double[] wavArrayPadded = pad_reflect(scaled(), num_pad_left, num_pad_right, Boolean.FALSE);

		setScaledSamples(wavArrayPadded == scaledSamples ? wavArrayPadded.clone() : wavArrayPadded);

	}

	/**
	 * Multiply the audio data by a certain factor
	 * @param factor - the factor to multiply by
	 * @return the multipled audio data
	 */
	public AudioData multiply(double factor) {
		//note this also changes this object's data
		setScaledSamples(JamArr.product(scaled(), factor));
		return new AudioData(scaledSamples, sampleRate);
	}

	/**
	 * Trim the audio data between two sample indexes.
	 * @param sampleStart - the sample start.
	 * @param samplEnd - the sample end.
	 * @return AudioData object with trimmed data.
	 */
	public AudioData trim(int sampleStart, int samplEnd) {
		double[] data = scaled();
		if (data.length <= samplEnd){
			return new AudioData(Arrays.copyOfRange(data, sampleStart, data.length), sampleRate);
		}
		else {
			return new AudioData(Arrays.copyOfRange(data, sampleStart, samplEnd), sampleRate);
		}
	}


	/**
	 * Interpolate the audio data (e..g up sample or down sample)
	 * @param interpSr - the new sample rate.
	 * @return AudioData object containing interpolated data and sample rate.
	 */
	public AudioData interpolate(float interpSr) {

		if (interpSr==this.sampleRate) return this;

		double[] intperarr = wavInterpolator.interpolate(scaled(), this.sampleRate, interpSr);
		
//		if (interpSr>this.sampleRate) {
//			//low pass filter at previous samplerate
//			Cascade filter = createLowPassFilter( BUTTERWORTH,  4,   sampleRate/2); 
//			double[] ampsFilt = new double[intperarr.length];
//			for (int i=0; i<intperarr.length; i++) {
//				ampsFilt[i]=filter.filter(intperarr[i]);
//			}		
//			intperarr = ampsFilt;
//		}

		//the interpolated data have always been doubled in amplitude (they were scaled by 2^bitRate
		//rather than 2^bitRate/2). Keep this so existing models see the same input. 
		AudioData soundTmp =  new AudioData(JamArr.product(intperarr, 2.0), interpSr);

		if (interpSr>this.sampleRate) {
			soundTmp = soundTmp.filter(BUTTERWORTH, LOWPASS, 4, 0, this.sampleRate/2); 
		}
		
		return soundTmp;
	}

	/**
	 * Interpolate the audio data (e.g. up sample or down sample) using FFT similarly to scipy
	 * @param target_sr - the new sample rate.
	 * @return AudioData object containing interpolated data and sample rate.
	 */
	public AudioData interpolate_scipy(float target_sr) {

		if (target_sr==this.sampleRate) return this;

		double[] wavArray = scaled();
		double ratio = target_sr / this.sampleRate;
		
		int n_samples = (int) Math.ceil(wavArray.length * ratio);

		double[] wavArrayResampled = wavInterpolator.fourierResample(wavArray, n_samples);
		
//		if (target_sr>this.sampleRate) {
//			//low pass filter at previous samplerate
//			Cascade filter = createLowPassFilter( BUTTERWORTH,  4,   sampleRate/2); 
//			double[] ampsFilt = new double[wavArrayResampled.length];
//			for (int i=0; i<wavArrayResampled.length; i++) {
//				ampsFilt[i]=filter.filter(wavArrayResampled[i]);
//			}		
//			wavArrayResampled = ampsFilt;
//		}

		//System.out.println("Audio samples: " + wavArray.length + " "  +wavArrayResampled.length); 

		AudioData soundTmp = new AudioData(wavArrayResampled, target_sr);
		
		if (target_sr>this.sampleRate) {
			soundTmp = soundTmp.filter(BUTTERWORTH, LOWPASS, 4, 0, this.sampleRate/2); 
		}

		return soundTmp;
	}

	/**
	 * Selects the largest value in the waveform and use that to hunt for the peak. 
	 */
	public final static int PEAK_MAX = 0; 

	/**
	 * Cuts or pads a waveform to match the target length while centring the maximum positive value.
	 *
	 * @param waveform The input waveform as a double array.
	 * @param targetLength The desired length of the output waveform.
	 * @return The cut or padded waveform as a double array.
	 */
	private static double[] cutOrPadWaveform(double[] waveform, int targetLength) {
		int currentLength = waveform.length;

		if (currentLength > targetLength) {
			int maxIndex = JamArr.maxIndex(waveform);
			int start = Math.max(0, maxIndex - targetLength / 2);
			int end = Math.min(currentLength, start + targetLength);
			
			double[] trimmedArr =Arrays.copyOfRange(waveform, start, end);
			if ((end-start)>targetLength) {
				return trimmedArr;
			}
			else {
				//System.out.println(trimmedArr.length + " start " + start + " end " + end);
				return padArray(trimmedArr, 0, targetLength-trimmedArr.length);
			}
		} else if (currentLength < targetLength) {
			int maxIndex = JamArr.maxIndex(waveform);
			int padBefore = Math.max(0, targetLength / 2 - maxIndex);
			int padAfter = targetLength - (currentLength + padBefore);
			if (padAfter < 0) {
				padBefore += padAfter;
				padAfter = 0;
			}
			return padArray(waveform, padBefore, padAfter);
		} else {
			return waveform.clone();
		}
	}

	/**
	 * Finds the index of the maximum value in a given array.
	 *
	 * @param array The input array.
	 * @return The index of the maximum value.
	 */
	private static double[] padArray(double[] array, int padBefore, int padAfter) {
		double[] paddedArray = new double[array.length + padBefore + padAfter];
		System.arraycopy(array, 0, paddedArray, padBefore, array.length);
		return paddedArray;
	}

	/**
	 * Select  a peak and pad it. 
	 * @param targetLen - the number of samples to pad with. i.e. if padding is 128 then 64 bins before the peak and 64 bins after the peak are selected. Must be even.
	 * @param type - the type of peak finding to use e.g. PEAK_MAX
	 * @return AudioData object containing interpolated data and sample rate.
	 */
	public AudioData selectPeak(int targetLen, int type) {

		switch (type) {
		case (PEAK_MAX): default:

			double[] trimSamples = cutOrPadWaveform(scaled(),  targetLen);

			AudioData soundTmp = new AudioData(trimSamples, this.getSampleRate());

			return soundTmp;
		}

	}

	private void setSampleRate(float targetSr) {
		this.sampleRate = targetSr;
	}

	/**
	 * Pre-emphasise the audio data so that lower frequencies are attenuated
	 * @param factor - the pre-emphasis factor
	 * @return AudioData object with pre emphasised data.
	 */
	public AudioData preEmphasis(double factor) {
		return new AudioData(preEmphasisFilter.preEmphasis(scaled(), factor) , sampleRate);
	}


	public final static int PGNORM = 0;

	/**
	 * Subtract the mean and then divide by the target mean and multiply target standard deviation. 
	 */
	public final static int KETOSNORM = 1;

	/**
	 * Subtract the mean and divide by absolute value. Ignores target mean and std values
	 */
	public final static int MEANNORM = 2;


	/**
	 * Transform  waveform data such that the mean value becomes zero and the standard deviation becomes one
	 */
	public final static int ZSCORE = 3;


	//	/**
	//	 * Normalise the audio data.
	//	 * @param mean - the target mean for the normalised data
	//	 * @param std - the target standard deviation for the normalised audio data
	//	 * @param - the transform type 
	//	 * @return AudioData object containing normalised data.
	//	 */
	//	public AudioData normalise(double mean, double std, int type) {
	//
	//		// self.data = std * (self.data - np.mean(self.data)) / std_orig + mean
	//
	//		double meanSamples = JamArr.mean(this.samples);
	//		double stdSamples = JamArr.std(this.samples);
	//
	//		int[] samplesNorm = new int[samples.length];
	//		if (type == KETOSNORM){
	//			for (int i = 0; i < samples.length; i++) {
	//				// Ketos version of normalising
	//				samplesNorm[i] = (int) (std * (this.samples[i] - meanSamples) / stdSamples + mean);
	//			}
	//		}
	//		else if (type==PGNORM) {
	//			for (int i = 0; i < samples.length; i++) {
	//				// PAMGuard version
	//				samplesNorm[i] = (int) (stdSamples*(samples[i] - meanSamples) / (std+mean));
	//			}
	//		}
	//		else {
	//			for (int i = 0; i < samples.length; i++) {
	//				// PAMGuard version
	//				samplesNorm[i] = (int) (samples[i] - meanSamples);
	//
	//			}
	////			System.out.println("Max: " + JamArr.max(samplesNorm));
	//			double[] samplesNormD =  JamArr.divide(samplesNorm, JamArr.max(samplesNorm)); 
	//			return new AudioData(samplesNormD, this.sampleRate);
	//		}
	//
	//		return new AudioData(samplesNorm, this.sampleRate);
	//	}


	/**
	 * Normalise the audio data.
	 * @param mean - the target mean for the normalised data
	 * @param std - the target standard deviation for the normalised audio data
	 * @param - the transform type 
	 * @return AudioData object containing normalised data.
	 */
	public AudioData normalise(double mean, double std, int type) {

		// self.data = std * (self.data - np.mean(self.data)) / std_orig + mean

		if (type==ZSCORE) {
			// standardisation or Z-score normalisation. Uses the double precision samples
			// and the population standard deviation (the same as numpy's default).
			double[] data = scaled(); 
			double meanSamples = JamArr.mean(data);
			double stdSamples = JamArr.std(data);
			double[] samplesNormD = new double[data.length];
			for (int i = 0; i < data.length; i++) {
				samplesNormD[i] = (data[i] - meanSamples)/stdSamples;
			}
			return new AudioData(samplesNormD, this.sampleRate);
		}
		else if (type!=KETOSNORM && type!=PGNORM) {
			// subtract the mean and divide by the maximum value.
			double[] data = scaled(); 
			double meanSamples = JamArr.mean(data);
			double[] samplesNormD = new double[data.length];
			for (int i = 0; i < data.length; i++) {
				samplesNormD[i] =  data[i] - meanSamples;
			}
			samplesNormD =  JamArr.divide(samplesNormD, JamArr.max(samplesNormD)); 
			return new AudioData(samplesNormD, this.sampleRate);
		}

		// KETOSNORM and PGNORM work on the integer samples and are left exactly as they
		// were so that existing models get identical inputs.
		int[] samples = getSampleAmplitudes(); 
		double meanSamples = JamArr.mean(samples);
		double stdSamples = JamArr.std(samples);

		int[] samplesNorm = new int[samples.length];
		if (type == KETOSNORM){
			for (int i = 0; i < samples.length; i++) {
				// Ketos version of normalising - do not mess with this
				samplesNorm[i] = (int) (std * (this.samples[i] - meanSamples) / stdSamples + mean);
			}
		}
		else {
			for (int i = 0; i < samples.length; i++) {
				// PAMGuard version
				samplesNorm[i] = (int) (stdSamples*(samples[i] - meanSamples) / (std+mean));
			}
		}

		return new AudioData(samplesNorm, this.sampleRate);
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

	/**
	 * Filter audio data using a Butterworth or Chebyshev filter. 
	 * @param params - filter params object holding paratmers for filter. 
	 * @return filtered audio data. 
	 */
	public AudioData filter(FilterParams params) {
		return filter(params.filterMethod, params.filterType, params.order, params.lowCut, params.highCut); 
	}

	/**
	 * Filter audio data using a Butterworth or Chebyshev filter. 
	 * @param filterMethod - the type if filter e.g. AudioData.BUTTERWORTH
	 * @param filterType - the pass type e.g. AudioData.LOWPASS
	 * @param order - the filter order. 
	 * @param lowCut - the low cut frequency in Hz (not used for LOWPASS).
	 * @param highCut - the high cut frequency in Hz (not used for HIGHPASS). 
	 * @return filtered audio data. 
	 */
	public AudioData filter(int filterMethod, int filterType, int order, double lowCut, double highCut) {

		//		System.out.println("Create filter: type: " + type + " passType: " + passType + " order: " +  order + " lowCut: " + lowCut + " highCut: " + highCut + " sr " + this.sampleRate); 

		Cascade filter = null;
		switch (filterType) {
		case LOWPASS: 
			filter = createLowPassFilter( filterMethod,  order,   highCut); 
			break;
		case HIGHPASS: 
			filter = createHighPassFilter( filterMethod,  order,   lowCut); 
			break;
		case BANDPASS: 
			filter = createBandPassFilter( filterMethod,  order,   lowCut, highCut); 
			break;
		}

		double[] amps = scaled();
		double[] ampsFilt = new double[amps.length];
		for (int i=0; i<amps.length; i++) {
			ampsFilt[i]=filter.filter(amps[i]);
		}		
		//		System.out.println("New audio data: " + ampsFilt.length);
		return new AudioData(ampsFilt, this.sampleRate);

	}

	/**
	 * Flag for a Butterworth filter
	 */
	public static final int BUTTERWORTH = 0; 

	/**
	 * Flag for a Chebyshev filter
	 */
	public static final int CHEBYSHEV = 1; 

	/**
	 * Flag for a low pass filter
	 */
	public static final int LOWPASS = 0; 

	/**
	 * Flag for a high pass filter
	 */
	public static final int HIGHPASS = 1; 

	/**
	 * Flag for a band pass filter
	 */
	public static final int BANDPASS = 2; 


	/**
	 * Create a low pass filter. 
	 * @param filterMethod - the filter type e.g. AudioData.BUTTERWORTH
	 * @param order - the filter order.
	 * @param highCut - the high cut frequency in Hz.
	 * @return a filter object. 
	 */
	private Cascade createLowPassFilter(int filterMethod, int order,  double highCut) {

		Cascade filter = null;
		switch (filterMethod) {

		case CHEBYSHEV:
			ChebyshevII filterC = new ChebyshevII(); 
			filterC.lowPass(order, this.sampleRate, highCut,  10);
			filter=filterC;
			break;

		case BUTTERWORTH:
			Butterworth filterB = new Butterworth(); 
			filterB.lowPass(order, this.sampleRate, highCut, DirectFormAbstract.DIRECT_FORM_I);
			filter=filterB;
			break;
		}

		return filter;
	}

	/**
	 * Create a high pass filter. 
	 * @param filterMethod - the filter type e.g. AudioData.BUTTERWORTH
	 * @param order - the filter order.
	 * @param lowCut - the low cut frequency in Hz.
	 * @return a filter object. 
	 */
	private Cascade createHighPassFilter(int filterMethod, int order, double lowCut) {

		Cascade filter = null;
		switch (filterMethod) {

		case CHEBYSHEV:
			ChebyshevII filterC = new ChebyshevII(); 
			filterC.highPass(order, this.sampleRate, lowCut, 10);
			filter=filterC;
			break;

		case BUTTERWORTH:
			Butterworth filterB = new Butterworth(); 
			filterB.highPass(order, this.sampleRate, lowCut, DirectFormAbstract.DIRECT_FORM_I);
			filter=filterB;
			break;
		}

		return filter;
	}

	/**
	 * Create a band pass filter. 
	 * @param filterMethod - the filter type e.g. AudioData.BUTTERWORTH
	 * @param order - the filter order.
	 * @param lowCut - the low cut frequency in Hz.
	 * @param highCut - the low cut frequency in Hz.
	 * @return a filter object. 
	 */
	private Cascade createBandPassFilter(int filterMethod, int order, double lowCut, double highCut) {
		Cascade filter = null;

		double width = (highCut-lowCut);
		double center = (highCut+lowCut)/2;

		switch (filterMethod) {

		case CHEBYSHEV:
			ChebyshevII filterC = new ChebyshevII(); 
			filterC.bandPass(order, this.sampleRate, center, width, 10);
			filter=filterC;
			break;

		case BUTTERWORTH:
			Butterworth filterB = new Butterworth(); 
			filterB.bandPass(order, this.sampleRate, center, width, DirectFormAbstract.DIRECT_FORM_I);
			filter=filterB;
			break;
		}

		return filter;
	}

	public static void main(String[] args) {
		double[] waveform = new double[50]; 
		waveform[3] = 3;
		
		double[] results  = AudioData.cutOrPadWaveform(waveform, 64) ;
			
		System.out.println("Reesulting len: " + results.length);
	}


}