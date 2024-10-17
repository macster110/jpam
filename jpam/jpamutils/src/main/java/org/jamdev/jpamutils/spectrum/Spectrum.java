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
	
	public int getFftLength() {
		return fftLength;
	}


	public void setFftLength(int fftLength) {
		this.fftLength = fftLength;
	}


	public float getsR() {
		return sR;
	}


	public void setsR(float sR) {
		this.sR = sR;
	}

	private int fftLength;
	
	private float sR;
	
	/**
	 * The spectrum with c
	 */
	private ComplexArray spectrum;
	
	private ComplexArray complexSpectrogram;

	public Spectrum(AudioData wave, int fftLength) {
		this.sR = wave.getSampleRate();
		this.fftLength = fftLength;
		this.buildFFT(wave, fftLength);
	}
	
	/**
	 * 
	 * @param spectrum -the real part of the spectrum. 
	 * @param phase - the imaginary part of the specteum - i.e. the phase
	 * @param sR - the sampler rate in samples per second
	 */
	public Spectrum(double [] spectrum, double[] phase, float sR) {
		this.sR = sR;
		this.fftLength = spectrum.length;
		if (phase==null) {
			//phase is zero. 
			phase= new double[spectrum.length]; 
		}
		complexSpectrogram = new ComplexArray(spectrum, phase);
	}

	/**
	 * Create the FFT from audio data. 
	 * @param wave - audio data.
	 */
	private void buildFFT(AudioData wave, int fftLength ) {
		FastFFT fastFFT = new FastFFT();
		complexSpectrogram = fastFFT.rfftFull(wave.getScaledSampleAmplitudes(),fftLength);
	}


	/**
	 * Normalise the spectrum by dividing by it's sum. 
	 */
	public Spectrum normaliseSpectrumSum() {
		double[] norm = normaliseSpectrumSum(complexSpectrogram.getReal()); 		
		for (int i=0; i<complexSpectrogram.length(); i++) {
			complexSpectrogram.setReal(i, norm[i]);
		}
		return this;
	}
	
	/**
	 * Down sample a spectrum array. This is NOT decimating. 
	 * @param factor - down sample factor e.g. 3 indicates a spectrum one third of the size. 
	 */
	public Spectrum downSampleSpectrumMean(int factor) {
		double[] downspec = downSampleSpectrumMean(complexSpectrogram.getReal(), factor); 
		//lost the phase info. 
		complexSpectrogram = new ComplexArray(downspec, new double[downspec.length]);
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
	
	

}
