package org.jamdev.jpamutils.wavFiles;

import java.util.Arrays;

import org.apache.commons.math3.analysis.UnivariateFunction;
import org.apache.commons.math3.analysis.interpolation.LinearInterpolator;
import org.apache.commons.math3.analysis.interpolation.SplineInterpolator;
import org.apache.commons.math3.analysis.interpolation.UnivariateInterpolator;
import edu.emory.mathcs.jtransforms.fft.DoubleFFT_1D;
import org.jamdev.jpamutils.spectrogram.FastFFT;
import uk.me.berndporr.iirj.Butterworth;

/**
 * Decimates or interpolates sound files
 * @author Jamie Macaulay 
 *
 */
public class WavInterpolator {

	private UnivariateFunction interp;
	
	/**
	 * Create a new WavInterpolator 
	 *
	 */ 
	public WavInterpolator() {

	} 
	
	/**
	 * Interpolate wave data either by decimating or up-sampling depending on the new sample rate. 
	 * @param wavArray - the wave data to interpolate. 
	 * @param sR - the sample rate of wavArray. 
	 * @param interpSr - the sample rate to interpolate to.  
	 * @return the interpolated wave data.
	 */
	public double[] interpolate(double[] wavArray, float sR, float interpSr) {
		if (sR == interpSr) {
			//do nothing but copy the array
			return Arrays.copyOf(wavArray, wavArray.length); 
		}
		if (interpSr<sR) {
			return decimate(wavArray,  sR, interpSr);
		}
		if (interpSr>sR) {
			return upSample(wavArray,  sR, interpSr);
		} 
		return null; //should never return
	}

	
	/**
	 * Up sample wave data. 
	 * @param sR - the current sample rate
	 * @param interpSr - the samplerate to up-sample to in samples per second
	 * @return the up sampled data. 
	 */
	public double[] upSample(double[] wavArray, float sR, float interpSr) {
		//work out the desired length of the array
		int arraySize = (int) (wavArray.length*(interpSr/((double) sR)));
		//interpolate the samples. 
		return getScaled(wavArray, arraySize); 
	}


	/**
	 * Decimate wave data including anti alisaing filter.
	 * @param decimatorSr - the new lower samnple rate
	 * @return the decimated data. 
	 */
	public double[] decimate(double[] wavArray, float sR, float decimatorSr) {

		//first have to filter the data
		Butterworth butterworth = new Butterworth();
		butterworth.lowPass(4, sR, decimatorSr/2);

		double[] wavArray2 = new double[wavArray.length]; 
		for (int i=0; i<wavArray.length; i++) {
			wavArray2[i] = butterworth.filter(wavArray[i]);
		}

		//work out the desired length of the array
		int arraySize = (int) (wavArray2.length*(decimatorSr/((double) sR)));
		
		
		//interpolate the samples. 
		return getScaled(wavArray2, arraySize); 

	}


	/*
	 * Resample an input signal to new number of samples using the Fourier method
	 * Based on implementation from scipy.signal
	 * https://github.com/scipy/scipy/blob/v1.3.0/scipy/signal/signaltools.py#L2162-L2290
	 * From https://gist.github.com/lichard49/a46b4afc9236ef7295425aba1a70774f
	 */
	public double[] fourierResample(double[] input, int targetNumSamples) {

		// copy input signal because FFT is in-place
		double[] inputCopy = new double[2*input.length];
		System.arraycopy(input, 0, inputCopy, 0, input.length);

		// perform FFT
		DoubleFFT_1D fft = new DoubleFFT_1D(input.length);
		fft.realForwardFull(inputCopy);

		// Compute number of samples to take if even or odd
		int n = Math.min(input.length, targetNumSamples);
		double[] output = new double[2*targetNumSamples];
		if (n%2 == 0){
			System.arraycopy(inputCopy, 0, output, 0, n);
			System.arraycopy(inputCopy, inputCopy.length - n, output, output.length - n, n);
		}
		else {
			int nyq = n / 2 + 1;
			System.arraycopy(inputCopy, 0, output, 0, n + 1);
			System.arraycopy(inputCopy, inputCopy.length - 2 * nyq + 2, output, output.length - 2 * nyq + 2, n - 1);
		}

		if (n % 2 == 0) {
			// special treatment if low number of points is even. So far we have set Y[-N/2]=X[-N/2]
			if (n < input.length) {
				// if downsampling
				output[n] += inputCopy[n]; // select the component at frequency N/2
				output[n + 1] += inputCopy[n + 1]; // add the component of X at N/2
			} else if (n < targetNumSamples) {
				// if upsampling
				output[targetNumSamples - n] /= 2; // halve the component at frequency N/2
				output[targetNumSamples - n + 1] /= 2;
				output[n] = output[targetNumSamples - n]; // set the component at -N/2 equal to the component at N/2
				output[n + 1] = output[targetNumSamples - n + 1];
			}
		}

		fft = new DoubleFFT_1D(output.length / 2);
		fft.complexInverse(output, true);

		double[] realOutput = new double[output.length / 2];
		double realMultiplier = (double) targetNumSamples / input.length;
//        System.out.println(realMultiplier);
		for (int i = 0; i < realOutput.length; i++) {
			realOutput[i] = output[i * 2] * realMultiplier;
		}

		return realOutput;
	}


	/**
	 * Interpolate to create a new scaled vector of length l 
	 *  
	 * @param l 
	 *          the desired vector length 
	 * @return a new vector of length l created by interpolating x 
	 */ 
	public double[] getScaled(double[] x, int l) { 
		double[] indices = new double[x.length]; 

		for (int i = 0; i < indices.length; i++) { 
			indices[i] = ((double) i) / (x.length - 1); 
		} 

		UnivariateInterpolator interpolator = new SplineInterpolator(); 
		
		if (l > x.length) {
			//if up sampling then us linear interpolation
			interpolator = new LinearInterpolator();
		}
		
		interp = interpolator.interpolate(indices, x); 

		double[] stretched = new double[l]; 
		for (int i = 0; i < l; i++) { 
			stretched[i] = interp.value(((double) i) / l); 
		} 
		return stretched; 
	} 
}
