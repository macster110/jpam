package spectrogram;

import org.apache.commons.math3.complex.Complex;
import org.apache.commons.math3.transform.DftNormalization;
import org.apache.commons.math3.transform.FastFourierTransformer;
import org.apache.commons.math3.transform.TransformType;

import wavFiles.AudioData;


/**
 * Class which converts raw wave data into a spectrgram and can perform some basic transforms. 
 * 
 * @author Jamie Macaulay
 *
 */
public class Spectrogram {

	/**
	 * The wave to calculate a spectrogram for. 
	 */
	private AudioData wave;

	/**
	 * The FFT length in samples. 
	 */
	private int fftSampleSize =1024; 

	/**
	 * The hop size in samples. 
	 */
	private int overlapFactor = 512;

	/**
	 * The total number of fft windows. 
	 */
	private int numFrames;

	/**
	 * The total number of frequency bins 
	 */
	private int numFrequencyUnit;

	/**
	 * Holds the complex data of the spectrogram for further analysis. 
	 */
	private ComplexArray[] complexSpectrogram;

	/**
	 * The current spectrogram data. 
	 */
	private double[][] specData; 

	/**
	 * The number of fft bins per second
	 */
	private int framesPerSecond;

	/**
	 * The size of each FFT bin in Hz. 
	 */
	private double frequencyBinSize;

	/**
	 * The sample rate in samples per second.
	 */
	private float sR; 

	/**
	 * Create the spectrogram from a clip of sound data 
	 * @param wave - the clip of sound data
	 * @param fftLength - the FFT length in samples
	 * @param fftHop - the spectrogram hop size to use in samples. 
	 */
	public Spectrogram(AudioData wave, int fftLength, int fftHop) {
		this.sR=wave.getSampleRate(); 
		this.fftSampleSize=fftLength;
		this.overlapFactor=fftHop; 
		this.buildSpectrogram(wave);
	}


//	/**
//	 * Create a new spectrgram with new raw data. 
//	 * @param wave - the clip of sound data
//	 * @param fftLength - the FFT length in samples
//	 * @param fftHop - the spectrogram hop size to use in samples. 
//	 */
//	private Spectrogram(double[][] specData, Spectrogram spectrogram) {
//		this.sR=spectrogram.getSampleRate();
//		this.fftSampleSize=spectrogram.fftSampleSize;
//		this.overlapFactor=spectrogram.overlapFactor;
//		this.specData = specData; 
//	}

	/**
	 * Calculates the absolute spectrogram. Note this is not saved within the Spectrogram 
	 * object and so is recalculated every time this function is called. 
	 * @return the absolute spectrogram
	 */
	private double[][] getAbsoluteSpectrogram() {
		return buildAbsoluteSpectram(complexSpectrogram); 
	}

	
	/**
	 * Construct the spectrogram form the raw wave data. 
	 */
	private void buildSpectrogram(AudioData wave) {

		int[] amplitudes = wave.getSampleAmplitudes();
		int numSamples = amplitudes.length;

		int pointer = 0;

		// overlapping
		if (overlapFactor > 1) {

			int numOverlappedSamples = numSamples * overlapFactor;
			int backSamples = fftSampleSize * (overlapFactor - 1) / overlapFactor;
			int fftSampleSize_1 = fftSampleSize - 1;
			int[] overlapAmp = new int[numOverlappedSamples];
			pointer = 0;
			for (int i = 0; i < amplitudes.length; i++) {
				overlapAmp[pointer++] = amplitudes[i];
				if (pointer % fftSampleSize == fftSampleSize_1) {
					// overlap
					i -= backSamples;
				}
			}
			numSamples = numOverlappedSamples;
			amplitudes = overlapAmp;
		}

		numFrames = numSamples / fftSampleSize;
		framesPerSecond = (int) (numFrames / wave.getLengthInSeconds());

		// set signals for fft
		WindowFunction window = new WindowFunction();
		window.setWindowType(WindowFunction.HAMMING);
		double[] win = window.generate(fftSampleSize);

		double[][] signals = new double[numFrames][];
		for (int f = 0; f < numFrames; f++) {
			signals[f] = new double[fftSampleSize];
			int startSample = f * fftSampleSize;
			for (int n = 0; n < fftSampleSize; n++) {
				signals[f][n] = amplitudes[startSample + n] * win[n];
			}
		}

		// for each frame in signals, do fft on it
		FastFourierTransformer fft = new FastFourierTransformer(DftNormalization.STANDARD);

		complexSpectrogram = new ComplexArray[numFrames]; 



		Complex[] specData; 
		for (int i = 0; i < numFrames; i++) {
			specData = fft.transform(signals[i], TransformType.FORWARD); 
			complexSpectrogram[i] = new ComplexArray(specData); 
		}

		/**
		 * Set some extra parameters
		 */
		numFrequencyUnit = complexSpectrogram[0].length()/2; 
		frequencyBinSize = (double) wave.getSampleRate() / 2 / numFrequencyUnit; // frequency is half of
	}

	/**
	 * Builds the absolute spectrogram from the complex array
	 * @return the absolute spectrogram. 
	 */
	public static double[][] buildAbsoluteSpectram(ComplexArray[] complexSpectrogram) {
		double[][] absoluteSpectrogram = new double[complexSpectrogram.length][];

		for (int i = 0; i < complexSpectrogram.length; i++) {
			absoluteSpectrogram[i] = new double[complexSpectrogram[i].length()/2];
			for (int j = 0; j < absoluteSpectrogram[i].length; j++) {
				absoluteSpectrogram[i][j] = Math.sqrt(complexSpectrogram[i].getReal(j) * complexSpectrogram[i].getReal(j) 
						+ complexSpectrogram[i].getImag(j) * complexSpectrogram[i].getImag(j));
			}
		}
		return absoluteSpectrogram; 
	}
	
	/**
	 * Convert the current spectrogram data to dB using 10*log10(linear) ; 
	 * @return reference to the spectrogram object.  
	 */
	public Spectrogram dBSpec() {
		if (this.specData==null) this.specData = this.getAbsoluteSpectrogram(); 
		this.specData = dBSpec(this.specData); 
		return this;
	}
	
	/**
	 * Normalise the current spectrogram between two reference values. 
	 * @param min_leveldB - the minimum dB level
	 * @param ref_level_dB - the reference dB level to normalise to 
	 * @return reference to the normalised spectrogram
	 */
	public Spectrogram normalise(double min_leveldB, double ref_level_dB) {
		if (this.specData==null) this.specData = this.getAbsoluteSpectrogram(); 
		this.specData = normalise(this.specData, min_leveldB, ref_level_dB); 
		return this;
	}
	
	/**
	 * Clamp the current spectrogram between two values.
	 * @param minVal - the minimum value to clamp between. 
	 * @param maxVal - the maximum value to clamp to. 
	 * @return reference the clamped spectrogram. 
	 */
	public Spectrogram clamp(double minVal, double maxVal) {
		if (this.specData==null) this.specData = this.getAbsoluteSpectrogram(); 
		this.specData = clamp(this.specData, minVal, maxVal); 
		return this;
	}

	/**
	 * Convert a spectrogram to dB. 
	 * @param array - the absolute spectrogram array. 
	 * @return the normalised spectrogram. 
	 */
	public static double[][] dBSpec(double[][] array) {
		double[][] logSpectrgram = new double[array.length][array[0].length];

		for (int i = 0; i < array.length; i++) {
			for (int j = 0; j < array[i].length; j++) {
				logSpectrgram[i][j] = 10*Math.log10(array[i][j]); 
			}
		}

		return logSpectrgram; 	
	}


	/**
	 * Normalise a spectrogram.
	 * @param array - the absolute spectrogram array. 
	 * @return the normalised spectrogram. 
	 */
	public static double[][] normalise(double[][] array, double min_leveldB, double ref_level_dB) {

		double[][] normalizeSpec = new double[array.length][array[0].length];

		for (int i = 0; i < array.length; i++) {
			for (int j = 0; j < array[i].length; j++) {
				normalizeSpec[i][j] = (array[i][j] - ref_level_dB- min_leveldB) / -min_leveldB; 
			}
		}
		return normalizeSpec; 
	}


	/**
	 * Clamp a spectrogram between two values. 
	 * @param array - the spectrogram array. 
	 * @return the clamped spectrogram. 
	 */
	public static double[][] clamp(double[][] array, double minVal, double maxVal) {
		double[][] clampedSpec = new double[array.length][array[0].length];

		for (int i = 0; i < array.length; i++) {
			for (int j = 0; j < array[i].length; j++) {
				if (array[i][j]<minVal) {
					clampedSpec[i][j] = minVal;
				}
				else if (array[i][j]>maxVal){
					clampedSpec[i][j] = maxVal;
				}
				else {
					clampedSpec[i][j] = array[i][j]; 
				}
			}
		}
		
		return clampedSpec; 
	}





//	/**
//	 * Build the normalised spectrogram. 
//	 * @return the normalised spectrogram. 
//	 */
//	public static double[][] buildNormalizedSpectram(ComplexArray[] complexSpectrogram) {
//		double[][] absoluteSpectrogram = buildAbsoluteSpectram(complexSpectrogram);
//
//		if (absoluteSpectrogram!=null && absoluteSpectrogram.length > 0) {
//
//			int numFrequencyUnit = absoluteSpectrogram[0].length;
//			//			double frequencyBinSize = (double) sR / 2.0 / numFrequencyUnit; // frequency is half of
//
//			// normalization of absoultSpectrogram
//			double[][]  spectrogram = new double[complexSpectrogram.length][numFrequencyUnit];
//
//			// set max and min amplitudes
//			double maxAmp = Double.MIN_VALUE;
//			double minAmp = Double.MAX_VALUE;
//			for (int i = 0; i < complexSpectrogram.length; i++) {
//				for (int j = 0; j < numFrequencyUnit; j++) {
//					if (absoluteSpectrogram[i][j] > maxAmp) {
//						maxAmp = absoluteSpectrogram[i][j];
//					}
//					else if (absoluteSpectrogram[i][j] < minAmp) {
//						minAmp = absoluteSpectrogram[i][j];
//					}
//				}
//			}
//
//			// normalization
//			// avoiding divided by zero
//			double minValidAmp = 0.00000000001F;
//			if (minAmp == 0) {
//				minAmp = minValidAmp;
//			}
//
//			double diff = Math.log10(maxAmp / minAmp); // perceptual difference
//			for (int i = 0; i < complexSpectrogram.length; i++) {
//				for (int j = 0; j < numFrequencyUnit; j++) {
//					if (absoluteSpectrogram[i][j] < minValidAmp) {
//						spectrogram[i][j] = 0;
//					}
//					else {
//						spectrogram[i][j] = (Math.log10(absoluteSpectrogram[i][j] / minAmp)) / diff;
//						// System.out.println(spectrogram[i][j]);
//					}
//				}
//			}
//			return spectrogram;  
//		}
//		else return null; 	
//	}
	
//	/**
//	 * Calculates the normalized spectrogram. Note this is not saved within the Spectrogram 
//	 * object and so is recalculated every time this function is called. 
//	 * @return the normalized spectrogram. 
//	 */
//	public double[][] getNormalisedSpectrogram() {
//		return buildNormalizedSpectram(complexSpectrogram);		
//	}
	


	/**
	 * Get the total number of FFT bins
	 * @return the number of FFT bins
	 */
	public int getNumFrames() {
		return numFrames;
	}

	/**
	 * Get the number of FFT units per second
	 * @return the number of FFT units per second
	 */
	public int getFramesPerSecond() {
		return framesPerSecond;
	}

	/**
	 * Get the frequency width of frequency bins
	 * @return the bin size in Hz
	 */
	public double getFrequencyBinSize() {
		return frequencyBinSize;
	}

	/**
	 * Get the raw spectrogram data. This is a complex array containing both the phase and amplitude information 
	 * @return complex array with each array one FFT slice of the spectrogram. 
	 */
	public ComplexArray[] getFFTData() {
		return this.complexSpectrogram;
	}

	/**
	 * Get the sample rate in samples per second. 
	 * @return the sample rate. 
	 */
	public float getSampleRate() {
		return this.sR;
	}


	/**
	 * Get the spectrgram array as a doubles. Note that this includes any transfroms the spectrgram has undergone. 
	 * @return the spectrgram array 
	 */
	public double[][] getSpectrogramArray() {
		return this.specData;
	}



}