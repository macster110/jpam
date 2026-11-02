package org.jamdev.jpamutils.spectrogram;

import com.github.psambit9791.jdsp.windows.Hamming;
import com.github.psambit9791.jdsp.windows.Hanning;
import com.github.psambit9791.jdsp.windows._Window;
import org.jamdev.jpamutils.wavFiles.AudioData;

/**
 * Class which converts raw wave data into a spectrgram and can perform some
 * basic transforms.
 * 
 * @author Jamie Macaulay
 *
 */
public class Spectrogram {

	/**
	 * The FFT length in samples.
	 */
	private int fftLength = 1024;

	/**
	 * The hop size in samples.
	 */
	private int fftHop = 512;
	
	/**
	 * The winow duration in seconds. 
	 */
	private double window_duration;

	/**
	 * The window function used by the Ketos spectrogram. Either WindowFunction.HAMMING or WindowFunction.HANNING.
	 */
	private int windowType = WindowFunction.HAMMING;

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
	 * 
	 * @param wave      - the clip of sound data
	 * @param fftLength - the FFT length in samples
	 * @param fftHop    - the spectrogram hop size to use in samples.
	 */
	public Spectrogram(AudioData wave, int fftLength, int fftHop) {
		this.sR = wave.getSampleRate();
		this.fftLength = fftLength;
		this.fftHop = fftHop;
		this.buildSpectrogram(wave);
	}
	
	/**
	 * Create a spectrogram which is compatible with Ketos models. 
	 * @param wave      - the clip of sound data
	 * @param fftLength - the FFT length in samples
	 * @param fftHop    - the spectrogram hop size to use in samples.
	 * @param window_duration - the duration of the sound window to use in seconds. 
	 */
	public Spectrogram(AudioData wave, int fftLength, int fftHop, double window_duration) {
		//System.out.println("FFTLength: " + fftLength + " FFTHop: " + fftHop + "  windowDuration " + window_duration); 
		this.sR = wave.getSampleRate();
		this.fftLength = fftLength;
		this.fftHop = fftHop;
		this.window_duration = window_duration;
		this.buildSpectrogramKetos(wave);
	}

	/**
	 * Create a spectrogram which is compatible with Ketos models using a specified window function.
	 * @param wave      - the clip of sound data
	 * @param fftLength - the FFT length in samples
	 * @param fftHop    - the spectrogram hop size to use in samples.
	 * @param window_duration - the duration of the sound window to use in seconds.
	 * @param windowType - the window function, WindowFunction.HAMMING or WindowFunction.HANNING. Both are symmetric
	 * i.e. the same as numpy.hamming and numpy.hanning.
	 */
	public Spectrogram(AudioData wave, int fftLength, int fftHop, double window_duration, int windowType) {
		this.sR = wave.getSampleRate();
		this.fftLength = fftLength;
		this.fftHop = fftHop;
		this.window_duration = window_duration;
		this.windowType = windowType;
		this.buildSpectrogramKetos(wave);
	}


	/**
	 * Create a new spectrogram with existing complex spectrogram data.
	 * 
	 * @param complexSpectrogram - the complex spectrogram data
	 * @param fftLength         - the FFT length in samples
	 * @param fftHop            - the spectrogram hop size to use in samples.
	 * @param sR                - the sample rate in samples per second.
	 */
	public Spectrogram(ComplexArray[] complexSpectrogram, int fftLength, int fftHop, float sR) {
		//System.out.println("FFTLength: " + fftLength + " FFTHop: " + fftHop + "  windowDuration " + window_duration); 
		this.sR = sR;
		this.fftLength = fftLength;
		this.fftHop = fftHop;
		this.complexSpectrogram = complexSpectrogram;
	}

	// /**
	// * Create a new spectrgram with new raw data.
	// * @param wave - the clip of sound data
	// * @param fftLength - the FFT length in samples
	// * @param fftHop - the spectrogram hop size to use in samples.
	// */
	// private Spectrogram(double[][] specData, Spectrogram spectrogram) {
	// this.sR=spectrogram.getSampleRate();
	// this.fftSampleSize=spectrogram.fftSampleSize;
	// this.overlapFactor=spectrogram.overlapFactor;
	// this.specData = specData;
	// }

	/**
	 * Calculates the absolute spectrogram. Note this is not saved within the
	 * Spectrogram object and so is recalculated every time this function is called.
	 * 
	 * @return the absolute spectrogram
	 */
	public double[][] getAbsoluteSpectrogram() {
		return buildAbsoluteSpectram(complexSpectrogram);
	}

	/**
	 * Convert time interval to number of samples. Same in DLUtils.java to avoid circular dependency.
	 *
	 *         If the time corresponds to a non-integer number of samples,
	 *         round to the nearest larger integer value.
	 *             time: float
	 * @param time: float Timer interval in seconds
	 * @param rate: float Sampling rate in Hz
	 * @param even: Boolean Convert to nearest larger even integer.
	 * @return n: int Number of samples
	 */
	public static int numSamplesKetos(double time, double rate, Boolean even){

		double e = Math.ulp(1.0); //machine precision
		double f = time * rate;
		int n = (int) f;

		if (f - n > e) {
			n = (int) Math.ceil(f);
		}

		if ((even) && (n%2 == 1)){
			n += 1;
		}

		return n;
	}

	/**
	 * Construct the spectrogram form the raw wave data.
	 */
	private void buildSpectrogram(AudioData wave) {

		double[] amplitudes = wave.getScaledSampleAmplitudes();	
		int pointer = 0;

		// System.out.println("Build spectrogram: sR: " + wave.sampleRate + " FFTHop: "
		// + this.fftHop + " for " + amplitudes.length + " samples") ;

		// overlapping

		/**
		 * f This is a little complicated. The FFT hop is the number of samples the the
		 * window moves each iteration in the spectrogram. the hop moves as long as the
		 * current window position + FFT length is no greater than the total number of
		 * samples. once that limit is reached then the spectrogram stops calculating
		 * samples. Surprisingly complicate to deal all the all the cases where the fft
		 * hop and length are not direct divisors of the samples etc.
		 */

		int numHops = (int) Math.ceil((amplitudes.length) / (double) fftHop);
		int numOverlappedSamples = (int) (fftLength * numHops);
		double[] overlapAmp = new double[numOverlappedSamples];

		int numSamples = amplitudes.length+fftLength-fftHop;

		//System.out.println("numSamples: " + numSamples + " numOverlappedSamples: " + numOverlappedSamples + "  " + numHops);

		int nn = 0;
		for (int i = 0; i < numSamples; i++) {
			// "i" might go over the samples at the tail end where were the fft length is
			// greater than the end of the sound
			// need to fill these areas with zeros.
			if (i < amplitudes.length)
				overlapAmp[pointer++] = amplitudes[i];
			else {
				overlapAmp[pointer++] = 0;
			}
			if (pointer % fftLength == 0 && nn <= numHops) {
				//System.out.println("Pointer: " + pointer + " i: " + i + " new i: " + (nn+1)*fftHop);
				// overlap
				nn++;
				i = nn * fftHop;
//				System.out.println("New i: " + i + " of " +  amplitudes.length); 
			}
		}

		// System.out.println("Pointer: " + pointer + " Num overlap samples: " +
		// overlapAmp.length + " numsamples: " + numSamples + " numHops: " + numHops);
		numSamples = numOverlappedSamples;
		amplitudes = overlapAmp;

		numFrames = numSamples / fftLength;
		framesPerSecond = (int) (numFrames / wave.getLengthInSeconds());

//		System.out.println("Pointer: " + pointer + " Num overlap samples: " + overlapAmp.length + " numsamples: "
//				+ numSamples + " numHops: " + numHops);

		// set signals for fft
		WindowFunction window = new WindowFunction();
		window.setWindowType(WindowFunction.HAMMING);
		double[] win = window.generate(fftLength);

		double[][] signals = new double[numFrames][];
		for (int f = 0; f < numFrames; f++) {
			signals[f] = new double[fftLength];
			int startSample = f * fftLength;

			for (int n = 0; n < fftLength; n++) {
				signals[f][n] = amplitudes[startSample + n] * win[n];
			}
		}

		// for each frame in signals, do fft on it
		//original way but could not handle FFT lengths not a power of 2. 
		//FastFourierTransformer fft = new FastFourierTransformer(DftNormalization.STANDARD);
		complexSpectrogram = new ComplexArray[numFrames];
		
		FastFFT fastFFT = new FastFFT();

		//Complex[] specData;
		for (int i = 0; i < numFrames; i++) {
			//original way but could not handle FFT lengths not a power of 2. 
			//specData = fft.transform(signals[i], TransformType.FORWARD);
			//complexSpectrogram[i] = new ComplexArray(specData);
			//System.out.println("Len1 " + complexSpectrogram[i].length()+ "  " + specData.length);

			complexSpectrogram[i] = fastFFT.rfftFull(signals[i], signals[i].length);
			//System.out.println("Len2 " + complexSpectrogram[i].length() + "  " + signals[i].length);
		}

		/**
		 * Set some extra parameters
		 */
		numFrequencyUnit = complexSpectrogram[0].length() / 2;
		frequencyBinSize = (double) wave.getSampleRate() / 2 / numFrequencyUnit; // frequency is half of

		//System.out.println("Build spectrogram: specData: " + complexSpectrogram.length);

	}

	/**
	 * Construct the spectrogram form the raw wave data.
	 */
	private void buildSpectrogramKetos(AudioData wave) {

		double[] amplitudes = wave.getScaledSampleAmplitudes();
		
		//note that w=the window duration here is the true segment length. i.e. it is NOT the "duration" parameter
		//in the ketos JSON file but the calculated segment length. See KetosParams for more info. 

		numFrames = numSamplesKetos(window_duration - ((double) fftLength)/sR, (double) sR/fftHop, Boolean.FALSE);
		framesPerSecond = (int) (numFrames / wave.getLengthInSeconds());

		_Window w1 = windowType == WindowFunction.HANNING ? new Hanning(fftLength) : new Hamming(fftLength);
		double[] win = w1.getWindow();

		double[][] signals = new double[numFrames][];
		
		//System.out.println("Number of samples: " + amplitudes.length);
				
		int startSample;
		for (int f = 0; f < numFrames; f++) {
			signals[f] = new double[fftLength];
			startSample = f * fftHop;

			for (int n = 0; n < fftLength; n++) {
				signals[f][n] = (startSample + n) < amplitudes.length ? amplitudes[startSample + n] * win[n] : 0;
			}
		}
		
		//System.out.println("Number of spec samples: " + ((numFrames * fftHop) + fftLength) + " num Frames: " + numFrames + " window_duration: " + window_duration);


		// for each frame in signals, do fft on it
		//original way but could not handle FFT lengths not a power of 2.
		//FastFourierTransformer fft = new FastFourierTransformer(DftNormalization.STANDARD);
		complexSpectrogram = new ComplexArray[numFrames];

		FastFFT fastFFT = new FastFFT();

		//Complex[] specData;
		for (int i = 0; i < numFrames; i++) {
			complexSpectrogram[i] = fastFFT.rfftFull(signals[i], signals[i].length);
		}

		/**
		 * Set some extra parameters
		 */
		numFrequencyUnit = complexSpectrogram[0].length() / 2;
		frequencyBinSize = (double) wave.getSampleRate() / 2 / numFrequencyUnit; // frequency is half of

		//System.out.println("Build spectrogram: specData: " + complexSpectrogram.length);

	}


	/**
	 * Create a spectrogram in the same way as scipy.signal.spectrogram with
	 * detrend=False. Frames are not padded so the number of frames is (nSamples -
	 * winLen) / hop + 1. Each frame is windowed and zero padded to the FFT length.
	 * Use {@link #scipyMagnitude(Spectrogram, int, int)} to get the magnitude
	 * spectrogram.
	 *
	 * @param wave       - the clip of sound data.
	 * @param winLen     - the window length in samples (scipy nperseg).
	 * @param hop        - the hop size in samples (scipy nperseg - noverlap).
	 * @param nfft       - the FFT length in samples (scipy nfft).
	 * @param windowType - the window, WindowFunction.HANNING or
	 *                   WindowFunction.HAMMING. The window is periodic, the same
	 *                   as scipy.signal.get_window.
	 * @return the spectrogram. The FFT length of the spectrogram is nfft.
	 */
	public static Spectrogram scipySpectrogram(AudioData wave, int winLen, int hop, int nfft, int windowType) {
		if (nfft < winLen) {
			throw new IllegalArgumentException("Spectrogram: the FFT length " + nfft + " must be at least the window length " + winLen);
		}

		double[] amplitudes = wave.getScaledSampleAmplitudes();
		double[] win = periodicWindow(winLen, windowType);

		int numFrames = amplitudes.length < winLen ? 0 : (amplitudes.length - winLen) / hop + 1;

		ComplexArray[] complexSpectrogram = new ComplexArray[numFrames];
		FastFFT fastFFT = new FastFFT();
		double[] frame = new double[winLen];
		for (int f = 0; f < numFrames; f++) {
			int startSample = f * hop;
			for (int n = 0; n < winLen; n++) {
				frame[n] = amplitudes[startSample + n] * win[n];
			}
			complexSpectrogram[f] = fastFFT.rfftFull(frame, nfft);
		}

		Spectrogram spectrogram = new Spectrogram(complexSpectrogram, nfft, hop, wave.getSampleRate());
		spectrogram.numFrames = numFrames;
		spectrogram.numFrequencyUnit = nfft / 2 + 1;
		spectrogram.frequencyBinSize = wave.getSampleRate() / (double) nfft;
		spectrogram.framesPerSecond = (int) (numFrames / wave.getLengthInSeconds());
		return spectrogram;
	}

	/**
	 * Get the magnitude spectrogram in the same way as scipy.signal.spectrogram
	 * with mode='magnitude' and scaling='density', i.e. the absolute value of
	 * the one sided FFT (including the Nyquist frequency) multiplied by
	 * sqrt(1/(fs*sum(window^2))).
	 *
	 * @param spectrogram - a spectrogram created by
	 *                    {@link #scipySpectrogram(AudioData, int, int, int, int)}.
	 * @param winLen      - the window length in samples.
	 * @param windowType  - the window type.
	 * @return the magnitude spectrogram [time][frequency] with nfft/2 + 1
	 *         frequency bins.
	 */
	public static double[][] scipyMagnitude(Spectrogram spectrogram, int winLen, int windowType) {
		double[] win = periodicWindow(winLen, windowType);
		double winSumSq = 0;
		for (double w : win) {
			winSumSq += w * w;
		}
		double scale = Math.sqrt(1.0 / (spectrogram.getSampleRate() * winSumSq));

		ComplexArray[] complexSpectrogram = spectrogram.getComplexSpectrogram();
		int nBins = spectrogram.getFFTLength() / 2 + 1;
		double[][] magnitude = new double[complexSpectrogram.length][nBins];
		for (int i = 0; i < complexSpectrogram.length; i++) {
			for (int j = 0; j < nBins; j++) {
				double re = complexSpectrogram[i].getReal(j);
				double im = complexSpectrogram[i].getImag(j);
				magnitude[i][j] = Math.sqrt(re * re + im * im) * scale;
			}
		}
		return magnitude;
	}

	/**
	 * Create a periodic window, the same as scipy.signal.get_window (i.e. a
	 * symmetric window of length n+1 with the last point removed).
	 *
	 * @param n          - the window length.
	 * @param windowType - WindowFunction.HANNING or WindowFunction.HAMMING.
	 * @return the window.
	 */
	public static double[] periodicWindow(int n, int windowType) {
		double a = windowType == WindowFunction.HAMMING ? 0.54 : 0.5;
		double[] win = new double[n];
		for (int i = 0; i < n; i++) {
			win[i] = a - (1 - a) * Math.cos(2 * Math.PI * i / n);
		}
		return win;
	}

	/**
	 * Builds the absolute spectrogram from the complex array
	 * 
	 * @return the absolute spectrogram.
	 */
	public static double[][] buildAbsoluteSpectram(ComplexArray[] complexSpectrogram) {
		double[][] absoluteSpectrogram = new double[complexSpectrogram.length][];
		int npts = 0;
		// Assume each segment have the same FFT length
		if ((complexSpectrogram[0].length() / 2)%2 == 1){
			npts = complexSpectrogram[0].length() / 2 + 1;
		}
		else {
			npts = complexSpectrogram[0].length() / 2;
		}

		for (int i = 0; i < complexSpectrogram.length; i++) {
			absoluteSpectrogram[i] = new double[npts];

			for (int j = 0; j < absoluteSpectrogram[i].length; j++) {
				absoluteSpectrogram[i][j] = Math
						.sqrt(complexSpectrogram[i].getReal(j) * complexSpectrogram[i].getReal(j)
								+ complexSpectrogram[i].getImag(j) * complexSpectrogram[i].getImag(j));
			}
		}
		return absoluteSpectrogram;
	}

	// /**
	// * Build the normalised spectrogram.
	// * @return the normalised spectrogram.
	// */
	// public static double[][] buildNormalizedSpectram(ComplexArray[]
	// complexSpectrogram) {
	// double[][] absoluteSpectrogram = buildAbsoluteSpectram(complexSpectrogram);
	//
	// if (absoluteSpectrogram!=null && absoluteSpectrogram.length > 0) {
	//
	// int numFrequencyUnit = absoluteSpectrogram[0].length;
	// // double frequencyBinSize = (double) sR / 2.0 / numFrequencyUnit; //
	// frequency is half of
	//
	// // normalization of absoultSpectrogram
	// double[][] spectrogram = new
	// double[complexSpectrogram.length][numFrequencyUnit];
	//
	// // set max and min amplitudes
	// double maxAmp = Double.MIN_VALUE;
	// double minAmp = Double.MAX_VALUE;
	// for (int i = 0; i < complexSpectrogram.length; i++) {
	// for (int j = 0; j < numFrequencyUnit; j++) {
	// if (absoluteSpectrogram[i][j] > maxAmp) {
	// maxAmp = absoluteSpectrogram[i][j];
	// }
	// else if (absoluteSpectrogram[i][j] < minAmp) {
	// minAmp = absoluteSpectrogram[i][j];
	// }
	// }
	// }
	//
	// // normalization
	// // avoiding divided by zero
	// double minValidAmp = 0.00000000001F;
	// if (minAmp == 0) {
	// minAmp = minValidAmp;
	// }
	//
	// double diff = Math.log10(maxAmp / minAmp); // perceptual difference
	// for (int i = 0; i < complexSpectrogram.length; i++) {
	// for (int j = 0; j < numFrequencyUnit; j++) {
	// if (absoluteSpectrogram[i][j] < minValidAmp) {
	// spectrogram[i][j] = 0;
	// }
	// else {
	// spectrogram[i][j] = (Math.log10(absoluteSpectrogram[i][j] / minAmp)) / diff;
	// // System.out.println(spectrogram[i][j]);
	// }
	// }
	// }
	// return spectrogram;
	// }
	// else return null;
	// }

	// /**
	// * Calculates the normalized spectrogram. Note this is not saved within the
	// Spectrogram
	// * object and so is recalculated every time this function is called.
	// * @return the normalized spectrogram.
	// */
	// public double[][] getNormalisedSpectrogram() {
	// return buildNormalizedSpectram(complexSpectrogram);
	// }

	/**
	 * Get the total number of FFT bins
	 * 
	 * @return the number of FFT bins
	 */
	public int getNumFrames() {
		return numFrames;
	}

	/**
	 * Get the number of FFT units per second
	 * 
	 * @return the number of FFT units per second
	 */
	public int getFramesPerSecond() {
		return framesPerSecond;
	}

	/**
	 * Get the frequency width of frequency bins
	 * 
	 * @return the bin size in Hz
	 */
	public double getFrequencyBinSize() {
		return frequencyBinSize;
	}

	/**
	 * Get the raw spectrogram data. This is a complex array containing both the
	 * phase and amplitude information
	 * 
	 * @return complex array with each array one FFT slice of the spectrogram.
	 */
	public ComplexArray[] getFFTData() {
		return this.complexSpectrogram;
	}

	/**
	 * Get the sample rate in samples per second.
	 * 
	 * @return the sample rate.
	 */
	public float getSampleRate() {
		return this.sR;
	}

	/**
	 * Get the FFT length in samples.
	 * 
	 * @return the FFT length in samples
	 */
	public int getFFTLength() {
		return fftLength;
	}

	/**
	 * Get the FFT hop in samples.
	 * 
	 * @return the FFT hop in samples.
	 */
	public int getFFTHop() {
		return fftHop;
	}
	
	/**
	 * Get the spectrogram with both magnitude and phase information. 
	 * @return array of ComplaxArray where each ComplexArray is an FFT. 
	 */
	public ComplexArray[] getComplexSpectrogram() {
		return complexSpectrogram;
	}

	/**
	 * Set the spectrogram with both magnitude and phase information. 
	 * @param array of ComplaxArray where each ComplexArray is an FFT. 
	 */
	public void setComplexSpectrogram(ComplexArray[] complexSpectrogram) {
		this.complexSpectrogram = complexSpectrogram;
	}

}