package org.jamdev.jpamutils.spectrum;

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
	 * Normalise the spectrum by dividing by it's sum. 
	 * @param spectrum - the spectrum to normalise. 
	 * @return the normalised spectrum. 
	 */
	public static double[] normaliseSpectrumSum(double[] spectrum) {
		double[] normSpectrum = JamArr.divide(spectrum, JamArr.sum(spectrum));
		return normSpectrum;
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
	

}
