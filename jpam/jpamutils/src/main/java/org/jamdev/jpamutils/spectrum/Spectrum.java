package org.jamdev.jpamutils.spectrum;

import java.util.Arrays;

import org.jamdev.jpamutils.JamArr;
import org.jamdev.jpamutils.spectrogram.ComplexArray;
import org.jamdev.jpamutils.spectrogram.FastFFT;
import org.jamdev.jpamutils.wavFiles.AudioData;


/**
 * Holds data on a spectrum and has function for transforming a spectrum
 * 
 * @author Jamie Macaulay
 */
public class Spectrum {

	/**
	 * The minimum frequency of the spectrum in Hz. 
	 * <p>
	 * Having a min. and max. frequency his is more robust then having the FFT length and sample rates
	 * as transforms may trim the spectrum.
	 */
	private float minFreq;
	
	/**
	 * The maximum frequency of the spectrum in Hz. 
	 * <p>
	 * Having a min. and max. frequency his is more robust then having the FFT length and sample rates
	 * as transforms may trim the spectrum.
	 */
	private float maxFreq;
		
	private ComplexArray complexSpectrum;

	public Spectrum(AudioData wave, int fftLength) {
		this.minFreq = 0;
		this.maxFreq = wave.getSampleRate()/2;
		this.buildFFT(wave, fftLength);
	}
	
	/**
	 * 
	 * @param spectrum -the real part of the spectrum. 
	 * @param phase - the imaginary part of the specteum - i.e. the phase
	 * @param sR - the sampler rate in samples per second
	 */
	public Spectrum(double [] spectrum, double[] phase, float sR) {
		this.minFreq = 0;
		this.maxFreq = sR/2;
		if (phase==null) {
			//phase is zero. 
			phase= new double[spectrum.length]; 
		}
		complexSpectrum = new ComplexArray(spectrum, phase);
	}
	
	/**
	 * Get the length of the spectrum in bins. 
	 * @return the lengthmin bins. 
	 */
	public int length() {
		return complexSpectrum.getReal().length;
	}

	/**
	 * Create the FFT from audio data. 
	 * @param wave - audio data.
	 */
	private void buildFFT(AudioData wave, int fftLength ) {
		FastFFT fastFFT = new FastFFT();
		complexSpectrum = fastFFT.rfftFull(wave.getScaledSampleAmplitudes(),fftLength);
	}


	/**
	 * Normalise the spectrum by dividing by it's sum. 
	 */
	public Spectrum normaliseSpectrumSum() {
		double[] norm = normaliseSpectrumSum(complexSpectrum.getReal()); 		
		for (int i=0; i<complexSpectrum.length(); i++) {
			complexSpectrum.setReal(i, norm[i]);
		}
		return this;
	}
	
	/**
	 * Trim a spectrum between an upper and lower frequency

	 * @param newFreqLims - the new frequency limits in Hz. 
	 * @return the trimmed spectrum. 
	 */
	public Spectrum trimSpectrum(double[] newFreqLims) {
		double[] trimmed = trim(complexSpectrum.getReal(), new double[] {minFreq, maxFreq}, newFreqLims); 
		double[] trimmedPhase = trim(complexSpectrum.getImag(), new double[] {minFreq, maxFreq}, newFreqLims); 
		
		complexSpectrum = new ComplexArray(trimmed, trimmedPhase);
		
		this.minFreq = (float) newFreqLims[0];
		this.maxFreq = (float) newFreqLims[1];

		return this;
	}
	
	/**
	 * Down sample a spectrum array. This is NOT decimating. 
	 * @param factor - down sample factor e.g. 3 indicates a spectrum one third of the size. 
	 */
	public Spectrum downSampleSpectrumMean(int factor) {
		double[] downspec = downSampleSpectrumMean(complexSpectrum.getReal(), factor); 
		//lost the phase info. 
		complexSpectrum = new ComplexArray(downspec, new double[downspec.length]);
		return this;
	}
	
	
	/**
	 * Smooth the spectrum by a moving average filter. 
	 * @param - the window size of the moving average. 
	 */
	public Spectrum smoothSpectrum(int windowSizw) {
		double[] smoth = smooth(complexSpectrum.getReal(), windowSizw); 		
		for (int i=0; i<complexSpectrum.length(); i++) {
			complexSpectrum.setReal(i, smoth[i]);
		}
		return this;
	}
	
	
	/**
	 * Convert the spectrum to dB. 
	 * @param - subtractMin - true to minus the min dB so the min. dB start at 0. 
	 */
	public Spectrum spectrumdB(boolean subtractMin) {
		double[] spectrumdB = spectrumdB(complexSpectrum.getReal()); 		
		
		if (subtractMin) {
			spectrumdB = JamArr.subtract(spectrumdB, JamArr.min(spectrumdB)); 
		}
		
		complexSpectrum = new ComplexArray(spectrumdB, complexSpectrum.getImag());


		return this;
	}
	
	/**
	 * Normalise the spectrum by dividing by it's sum. 
	 * @param spectrum - the spectrum to normalise. 
	 * @return the normalised spectrum. 
	 */
	public static double[] normaliseSpectrumSum(double[] spectrum) {
		double[] normSpectrum = JamArr.divide(spectrum, JamArr.sum(spectrum));
		return normSpectrum;
	}
	
	
	/**
	 * Smooth using a moving average filter. 
	 * @param spectrum - the spectrum to smooh
	 * @param windowSize - the window size. 
	 * @return the smoothed spectrum
	 */
	public static double[] smooth(double[] spectrum, int windowSize) {

		MovingAverageByCircularBuffer movingAv = new MovingAverageByCircularBuffer(windowSize); 
		
		double[] spectrumSmooth = new double[spectrum.length];
		
		for (int i=0; i<spectrum.length; i++) {
			movingAv.add(i);
			spectrumSmooth[i] = movingAv.getMovingAverage();
		}
		
		return spectrumSmooth;
	}
	
	
	/**
	 * Trim a spectrum between an upper and lower frequency
	 * 
	 * @param spectrum    - the spectrum to trim.
	 * @param freqLims    - the current frequency limits of the spectrum in Hz with
	 *                    the first element the lower frequency and the second
	 *                    element the upper frequency.
	 * @param newFreqLims - the new frequency limits
	 * @return the trimmed spectrum.
	 */
	public static double[] trim(double[] spectrum, double[] freqLims, double[] newFreqLims) {

		double freqRange =freqLims[1] - freqLims[0];

		//find the index to trim between. 
		int indexlow = (int) (((newFreqLims[0]-freqLims[0])/freqRange)*spectrum.length); 
		int indexhigh = (int) (((newFreqLims[1]-freqLims[0])/freqRange)*spectrum.length); 

		if (indexlow >= 0 && indexhigh < spectrum.length && indexhigh!=indexlow) {

			double[] trimmedSpectrum = Arrays.copyOfRange(spectrum, indexlow, indexhigh);

			return trimmedSpectrum; 
		}
		else {
			System.out.println("Spectrum: trim: Invalid position: indexlow: " + indexhigh + " indexhigh: " + indexhigh);
			return null;
		}
	}
	
	
	
	/**
	 * Down sample a spectrum array. This is NOT decimating. 
	 * @param spectrum - down sample a spectrum arra by a factor of 2 
	 * @return the down sampled array. 
	 */
	public static double[] downSampleSpectrumMean(double[] spectrum, int factor) {
		
		int newlen = (int) Math.floor(((double) spectrum.length)/factor); 
		
		double[] downSample = new double[newlen]; 
		
		int n=0; 
		double mean =0; 
		for (int i=0; i<spectrum.length; i+=factor) {
			
			mean=0;
			for (int j=0; j<factor; j++) {
				mean += spectrum[i+j]; 
			}
			mean =mean/factor; 
			
			downSample[n]=mean;
			n++; 
		}
		
		return downSample; 
	}
	
	
	/**
	 * Convert a spectrum to decibels
	 * @param spectrum - the spectrum to convert
	 * @return the new spectrum in decibels. 
	 */
	public static double[] spectrumdB(double[] spectrum) {
		
		
		double[] spectrumdB = new double[spectrum.length]; 
		
		for (int i=0; i<spectrum.length; i++) {
			spectrumdB[i] = 20*Math.log10(spectrum[i]);
		}
		
		return spectrumdB; 
	}
	
	/**
	 * Get the minimum frequency of the spectrum in Hz
	 * @return the minimum frequency of the spectrum in Hz. 
	 */
	public float getMinFreq() {
		return minFreq;
	}

	/**
	 * Set the minimum frequency of the spectrum in Hz
	 * @param the minimum frequency of the spectrum in Hz. 
	 */
	public void setMinFreq(float minFreq) {
		this.minFreq = minFreq;
	}

	/**
	 * Get the maximum frequency of the spectrum in Hz
	 * @return the maximum frequency of the spectrum in Hz. 
	 */
	public float getMaxFreq() {
		return maxFreq;
	}

	/**
	 * Set the maximum frequency of the spectrum in Hz
	 * @param the maximum frequency of the spectrum in Hz. 
	 */
	public void setMaxFreq(float maxFreq) {
		this.maxFreq = maxFreq;
	}
	
	/**
	 * Get the spectrum. This includes amplitude (real) and phase (imaginary) info.
	 * @return the spectrum
	 */
	public ComplexArray getSpectrum() {
		return complexSpectrum;
	}

	/**
	 * Set the spectrum. This should include the amplitude (real) and phase (imaginary) info packaged into a Complex Array object.
	 * @param the spectrum.
	 */
	public void setSpectrum(ComplexArray complexSpectrogram) {
		this.complexSpectrum = complexSpectrogram;
	}


	/**
	 * Get the real part of the spectrum i.e. the frequency versus amplitude
	 * @return - the amplitude for each frequency bin.
	 */
	public double[] getRealSpectrum() {
		return complexSpectrum.getReal();
	}
	
	
	public static class MovingAverageByCircularBuffer {

	    private final double[] buffer;
	    private int head;
	    private int count;

	    public MovingAverageByCircularBuffer(int windowSize) {
	        this.buffer = new double[windowSize];
	    }

	    public void add(double value) {
	        buffer[head] = value;
	        head = (head + 1) % buffer.length;
	        if (count < buffer.length) {
	            count++;
	        }
	    }

	    public double getMovingAverage() {
	        if (count == 0) {
	            return Double.NaN;
	        }
	        double sum = 0;
	        for (int i = 0; i < count; i++) {
	            sum += buffer[i];
	        }
	        return sum / count;
	    }
	}
	
	public static void main(String[] args) {
		double[] freqLimits = new double[] {10000., 40000.};

		 double[] result =  trim(new double[512], new double[] {0., 48000.}, new double[] {10000., 40000.}); 
		 
		 System.out.println("Trimmed array: " + result); 
	}

}
