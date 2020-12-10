package org.jamdev.jtorch4pam.spectrogram;

import java.util.Arrays;


/**
 * Transforms spectrogram data.
 * 
 * @author Jamie Macaulay 
 *
 */
public class SpecTransform {
	
	/**
	 * The transformed spectrgram data. 
	 */
	double[][] specData; 
	
	/**
	 * Reference to the original spectrgram. 
	 */
	private Spectrogram spectrgram; 
	
	public SpecTransform(Spectrogram spectrgram) {
		this.spectrgram=spectrgram; 
	}
	
	/**
	 * Convert the current spectrogram data to dB using 10*log10(linear) ; 
	 * @return reference to the spectrogram object.  
	 */
	public SpecTransform dBSpec() {
		if (this.specData==null) this.specData = spectrgram.getAbsoluteSpectrogram(); 
		this.specData = dBSpec(this.specData); 
		return this;
	}

	/**
	 * Normalise the current spectrogram between two reference values. 
	 * @param min_leveldB - the minimum dB level
	 * @param ref_level_dB - the reference dB level to normalise to 
	 * @return reference to the normalised spectrogram
	 */
	public SpecTransform normalise(double min_leveldB, double ref_level_dB) {
		if (this.specData==null) this.specData = spectrgram.getAbsoluteSpectrogram(); 
		this.specData = normalise(this.specData, min_leveldB, ref_level_dB); 
		return this;
	}

	/**
	 * Interpolate a spectrogram so that it has a specified number of frequency bins and sits 
	 * that sits between two frequency limits. 
	 *
	 * @param fMin - the minimum frequency (Hz)
	 * @param fMin - the minimum frequency (Hz)
	 * @param freqBins - the number of frequency bins to interpolate to. This is the number of bins between fMin and fMax 
	 * @return the interpolated spectrogram object. 
	 */
	public SpecTransform interpolate(double fMin, double fMax, int freqBins) {
		if (this.specData==null) this.specData = spectrgram.getAbsoluteSpectrogram(); 
		this.specData = interpolate(this.specData, fMin, fMax, freqBins, spectrgram.getSampleRate()); 
		return this;
	}

	/**
	 * Clamp the current spectrogram between two values.
	 * @param minVal - the minimum value to clamp between. 
	 * @param maxVal - the maximum value to clamp to. 
	 * @return reference the clamped spectrogram. 
	 */
	public SpecTransform clamp(double minVal, double maxVal) {
		if (this.specData==null) this.specData = spectrgram.getAbsoluteSpectrogram(); 
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
				//have to add a compensation factor here because of the the difference in fft calc
				normalizeSpec[i][j] = 2*(((array[i][j] - ref_level_dB - min_leveldB) / -min_leveldB))-1.1407; 
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

	/**
	 * 
	 * Interpolate a spectrogram so that it has a specified number of frequency bins and sits 
	 * that sits between two frequency limits. 
	 *
	 * @param array - the spectrogram array. This should be spectrogram covering it's full frequency range. 
	 * @param fMin - the minimum frequency (Hz)
	 * @param fMin - the minimum frequency (Hz)
	 * @param freqBins - the number of frequency bins to interpolate to. 
	 * @return interpolate spectrogram
	 */
	public static double[][] interpolate(double[][] array, double fMin, double fMax, int freqBins, float sR){
		//interpolate a spectrogram 
		int fftlen = array[0].length; 

		//find the minimum bin
		int minIndex = (int) Math.max(0, fftlen*(fMin/(sR/2))); 
		int maxIndex = (int) Math.min(fftlen-1, fftlen*(fMax/(sR/2))); 

		double[][] specInterp = new double[array.length][]; 
		double[] fftSliceInterp; 
		
		//System.out.println("Min index: " +  minIndex + " max index: " + maxIndex + " FFT len: " + fftlen +  " f min Hz: " + fMin + " f max Hz: " + fMax); 

		for (int i = 0; i < array.length; i++) 	{		
			fftSliceInterp = Arrays.copyOfRange(array[i], minIndex, maxIndex);
			specInterp[i] = fftSliceInterp; 
			fftSliceInterp = nearestNeighbourInterp(fftSliceInterp, freqBins); 
			specInterp[i] = fftSliceInterp; 
		} 

		return specInterp ; 
	}

	/**
	 * Perform a nearest neighbour interpolation of a 1D array of evenly spaced values. 
	 * @param inputArray - the array to interpolate. 
	 * @param w2 - the new length of array. 
	 * @return the interpolated array. 
	 */
	public static double[] nearestNeighbourInterp(double[] inputArray,int w2) {
		int w1 = inputArray.length;
		double[] temp = new double[w2] ;
		double x_ratio = w1/(double)w2 ;
		double px;
		
		for (int j=0;j<w2;j++) {
			px = Math.floor(j*x_ratio) ;
			temp[j] = inputArray[(int) (px)] ;
//			System.out.println("Old len: " +  w1 + "New len: " + w2 + "   " + x_ratio + " PX: " +px);
		}
	
		return temp;
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
	 * Get the raw spectrogram. This has no undergone any transformations. See getTransformedData for 
	 * the transformed spectrogram. 
	 * @return the original spectrogram data. 
	 */
	public Spectrogram getSpectrgram() {
		return this.spectrgram;
	}

	/**
	 * Manually set the transfromed data. 
	 * @param absoluteSpectrogram - the data to set. 
	 */
	public void setTransformedData(double[][] absoluteSpectrogram) {
		this.specData=absoluteSpectrogram; 
	}




}
