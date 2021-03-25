package org.jamdev.jpamutils.spectrogram;

import java.util.Arrays;

import org.jamdev.jpamutils.JamArr;


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
	 * Normalise the current spectrogram by dividing by sum of the square of the sum of all rows. 
	 * @return reference to the normalised spectrogram
	 */
	public SpecTransform normaliseRowSum() {
		if (this.specData==null) this.specData = spectrgram.getAbsoluteSpectrogram(); 
		this.specData = normaliseRowSum(this.specData); 
		return this;
	}

	/**
	 * Reduce continuous tonal noise produced by e.g. ships and slowly varying
	 * background noise by subtracting from each row a running mean, computed
	 * according to the formula given in Baumgartner & Mussoline, Journal of the
	 * Acoustical Society of America 129, 2889 (2011); doi: 10.1121/1.3562166
	 * 
	 * @param input - a spectrogram image.
	 * @return timeConstLen - Time constant in number of samples, used for the
	 *         computation of the running mean.
	 */
	public SpecTransform  reduceTonalNoiseMean(int timeConstLen) {
		if (this.specData==null) this.specData = spectrgram.getAbsoluteSpectrogram(); 
		this.specData = reduceTonalNoiseMean(this.specData, timeConstLen); 
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
	 * Normalise a spectrogram by summing each row and squaring it then dividing the entire array by that value. 
	 * @param array - the absolute spectrogram array. 
	 * @return the normalised spectrogram. 
	 */
	public static double[][] normaliseRowSum(double[][] array) {
		double tot = 0; 
		for (int i = 0; i < array.length; i++) {
			tot+=JamArr.sum(JamArr.pow(array[i], 2)); 
		}
		tot=Math.sqrt(tot); 
		if (tot!=0) {
			return JamArr.divide(array, tot); 
		}
		return array; 
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

		//System.out.println("Min index: " +  minIndex + " max index: " + maxIndex + " FFT len: " + fftlen +  " f min Hz: " + fMin + " f max Hz: " + fMax + " sR: " + sR); 

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
	 * Reduce continuous tonal noise produced by e.g. ships and slowly varying
	 * background noise by subtracting from each row a running mean, computed
	 * according to the formula given in Baumgartner & Mussoline, Journal of the
	 * Acoustical Society of America 129, 2889 (2011); doi: 10.1121/1.3562166
	 * 
	 * @param input - a spectrogram image.
	 * @return timeConstLen - Time constant in number of samples, used for the
	 *         computation of the running mean.
	 */
	public static double[][] reduceTonalNoiseMean(double[][] input, double timeLenConst) {

		double eps = 1 - Math.exp((Math.log(0.15) * 1. / timeLenConst));

		double[] rMean = JamArr.mean(input, 0);

		double[][] imgNew = new double[input.length][];

		int nx = imgNew.length;

		for (int i = 0; i < nx; i++) {
			imgNew[i] = JamArr.subtract(input[i], rMean);
			// img_new[ix,:] = img[ix,:] - rmean // subtract running mean

			rMean = JamArr.add(JamArr.product(rMean, (1 - eps)), JamArr.product(input[i], eps));

			// rMean = (1 - eps) * rmean + eps * img[ix,:] # update running mean
		}

		return imgNew;
	}


	/**
	 * Subtracts from each row the median value of that row.
	 * @param input - a spectrogram image.
	 *
	 */
	public static double[][] reduceTonalNoiseMedian(double[][] img) {

		double[][] imgNew = new double[img.length][];

		double[] median = JamArr.median(imgNew, 0); 
	
		for (int i = 0; i < img.length; i++) {
			imgNew[i]= JamArr.subtract(img[i], median[i]); 
		}

		return imgNew;
	}
	
	/**
	 * Normalize the data array to specified mean and standard deviation.

            For the data array to be normalizable, it must have non-zero standard 
            deviation. If this is not the case, the array is unchanged by calling 
            this method.  
	 * @param img - the img to normalise
	 * @param mean -  Mean value of the normalized array. The default is 0.
	 * @param std -   Standard deviation of the normalized array. The default is 1.
	 * @return the normalised array
	 */
	public static double[][] normaliseStd(double[][] img, double mean, double std) {
		
        double std_orig =JamArr.std(img); 
        
        return JamArr.add(JamArr.product(JamArr.divide(JamArr.subtract(img, JamArr.mean(img)), std_orig), std ), mean); 
	}
	


	
	/**
	 * Discard pixels that are lower than the median threshold. 

        The resulting image will have 0s for pixels below the threshold and 1s for the pixels above the threshold.
	 * @param input - a spectrogram image.
	 *
	 */
	public static double[][] filterIsolatedSpots(double[][] img, int[][] struct) {

		//TODO
		
		return null;
	}
	
	/**
	 * Smooth the input image using a median or Gaussian blur filter.
        
        Note that the input image is recasted as np.float32.

        This is essentially a wrapper around the scipy.ndimage.median_filter 
        and scipy.ndimage.gaussian_filter methods. 

        For further details, see https://docs.scipy.org/doc/scipy/reference/ndimage.html
	 * @param img - image to be processed. 
	 * @param size -  Only used by the median filter. Describes the shape that is taken from the input array,
                at every element position, to define the input to the filter function.
	 * @param sigma -  Only used by the Gaussian filter. Standard deviation for Gaussian kernel. 
                for the axes to have different standard deviations.
	 * @param gaussian -   Switch between median and Gaussian (default) filter
	 * @return blurred image. 
	 */
	public static double[][] blurImage(double[][] img, int size, double sigma, boolean gaussian) {		
		return blurImage(img,  size, new double[] {sigma},  gaussian) ;
	}
	
	/**
	 * Smooth the input image using a median or Gaussian blur filter.
        
        Note that the input image is recasted as np.float32.

        This is essentially a wrapper around the scipy.ndimage.median_filter 
        and scipy.ndimage.gaussian_filter methods. 

        For further details, see https://docs.scipy.org/doc/scipy/reference/ndimage.html
	 * @param img - image to be processed. 
	 * @param size -  Only used by the median filter. Describes the shape that is taken from the input array,
                at every element position, to define the input to the filter function.
	 * @param sigma -  Only used by the Gaussian filter. Standard deviation for Gaussian kernel. May be given as a 
                single number, in which case all axes have the same standard deviation, or as an array, allowing 
                for the axes to have different standard deviations.
	 * @param gaussian -   Switch between median and Gaussian (default) filter
	 * @return blurred image. 
	 */
	public static double[][] blurImage(double[][] img, int size, double[] sigma, boolean gaussian) {

		//TODO
		
		return null;
	}
	
	/**
	 * Subtracts from each row the median value of that row.
	 * @param input - a spectrogram image.
	 *
	 */
	public static double[][] medianFilter(double[][] img1, double rowfactor, double colfactor) {
		
		/**
		 * Example:
            >>> from ketos.audio.utils.filter import apply_median_filter
            >>> img = np.array([[1,4,5],
            ...                 [3,5,1],
            ...                 [1,0,9]])
            >>> img_fil = apply_median_filter(img, row_factor=1, col_factor=1)
            >>> print(img_fil)
            [[0 0 0]
             [0 1 0]
             [0 0 1]]
		 */
		
		double[][] output = new double[img1.length][]; 


	    double[] col_median = JamArr.product(JamArr.median(img1, 0), colfactor);
	    double[] row_median = JamArr.product(JamArr.median(img1, 1), rowfactor);
	    
		double[] temp; 
		for (int i=0; i<img1.length; i++) {
			temp = new double[img1[i].length]; 
			for (int j=0; j<img1.length; j++) {
				if (img1[i][j]<=col_median[i]) {
					
				}
				else if (img1[i][j]<=row_median[i]) {
					
				}
				else temp[j] = img1[i][j]; 
				
				
				//clamp to one. 
				if (temp[j]> 0) temp[j]=1; 
			}
			output[i]=temp; 
		}
		
		
		return output;
	}


	/**
	 * Enhance the contrast between regions of high and low intensity, while
	 * preserving the range of pixel values.
	 * 
	 * Multiplies each pixel value by the factor,
	 * 
	 * .. math:: f(x) = ( e^{-(x - m_x - \sigma_m) / w} + 1)^{-1}
	 * 
	 * where :math:`x` is the pixel value, :math:`m_x` is the pixel value median of
	 * the image, and :math:`w = \sigma_x / \epsilon`, where :math:`\sigma_x` is the
	 * pixel value standard deviation of the image and :math:`\epsilon` is the
	 * enhancement parameter.
	 * 
	 * Some observations:
	 * 
	 * :math:`f(x)` is a smoothly increasing function from 0 to 1.
	 * :math:`f(m_x)=0.5`, i.e. the median :math:`m_x` demarks the transition from
	 * "low intensity" to "high intensity". The smaller the width, :math:`w`, the
	 * faster the transition from 0 to 1.
	 * 
	 * @param input - a spectrogram image.
	 * @param enhancement - Time constant in number of samples, used for the
	 *         computation of the running mean.
	 * @return - the enahnced image 
	 **/
	public static double[][] enhance(double[][] img, double enhancement) {


		if (enhancement>0) {
			double med = JamArr.median(img); 
			double std = JamArr.std(img); 
			double wid = (1. / enhancement) * std;

			// scaling = 1. / (np.exp(-(img - med - std) / wid) + 1.)

			//this is why python and matlab are nicer than Java...
			double[][] scaling = JamArr.divide(1, JamArr.exp(JamArr.add(JamArr.product(JamArr.divide(JamArr.subtract(img,  (med + std)),  wid), -1.), 1.))); 
			return JamArr.product(img, scaling); 
		}
		else {
			return img; 
		}

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
	 * Manually set the transformed data. 
	 * @param absoluteSpectrogram - the data to set. 
	 */
	public void setTransformedData(double[][] absoluteSpectrogram) {
		this.specData=absoluteSpectrogram; 
	}




}
