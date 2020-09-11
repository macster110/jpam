package wavFiles;

import java.util.Arrays;

import org.apache.commons.math3.analysis.UnivariateFunction;
import org.apache.commons.math3.analysis.interpolation.SplineInterpolator;
import org.apache.commons.math3.analysis.interpolation.UnivariateInterpolator;

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
		interp = interpolator.interpolate(indices, x); 

		double[] stretched = new double[l]; 
		for (int i = 0; i < l; i++) { 
			stretched[i] = interp.value(((double) i) / l); 
		} 
		return stretched; 
	} 
}
