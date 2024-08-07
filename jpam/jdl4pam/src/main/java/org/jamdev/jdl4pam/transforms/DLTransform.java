package org.jamdev.jdl4pam.transforms;

/**
 * Any transform of data.
 * 
 * @author Jamie Macaulay
 *
 */
public interface DLTransform {

	/**
	 * Type of waveform transform that are available. {@link #PREEMPHSIS}
	 * {@link #DECIMATE} {@link #TRIM}
	 * 
	 * Type of frequency transform that are available. {@link #SPECTROGRAM}
	 * {@link #SPECCROPINTERP} {@link #SPECNORMALISE} {@link #SPECNORMALISEROWSUM}
	 * {@link #SPEC2DB}
	 * 
	 * Note when adding a new transform also add required implementation to transforms.jsonfile.DLTransformParser2;
	 * 
	 * @author Jamie Macaulay
	 *
	 */
	public enum DLTransformType {

		/**
		 * Basic filter which reduces lower frequencies.
		 * <p>
		 * One associated parameter- the pre-emphasis factor between 0 and 1 which
		 * defines the degree of filtering.
		 */
		PREEMPHSIS("Pre-emphasis", "pre_emph"),
		
		/**
		 * Decimates the signal to a high or lower amplitude including anti-aliasing
		 * filters. Note this uses a method of decimation similar to scipy. 
		 * <p>
		 * One associated parameter- the sample-rate in samples per second to decimate
		 * or interpolate to.
		 */
		DECIMATE_SCIPY("Decimate wave scipy", "load_audio_scipy"),

		/**
		 * Decimates the signal to a high or lower amplitude including anti-aliasing
		 * filters.
		 * <p>
		 * One associated parameter- the sample-rate in samples per second to decimate
		 * or interpolate to.
		 */
		DECIMATE("Decimate wave", "load_audio"),

		/**
		 * Trims the acoustic data to new length.
		 * <p>
		 * Two associated parameters- the start and end sample to keep
		 * 
		 */
		TRIM("Trim wave", "trim"),
		
		/**
		 * Trims the acoustic data to new length around the peak of the waveform
		 * <p>
		 * Two associated parameters- padding and peak search type. Padding is the
		 * number of samples to trim to. So for example 128 samples keeps 64 samples
		 * before the peak and 64 samples after. The second parameter is an int flag for
		 * the type of peak search. Peak search types are 1 - max peak - select the max
		 * value in the waveform as a peak.
		 * 
		 */
		PEAK_TRIM("Peak trim", "peak_trim"),

		/**
		 * Converts a waveform to a spectrogram
		 * <p>
		 * Two associated parameters - the FFT length and FFT hop size in samples. The
		 * hop is the number of samples from the start of the last FFT window to move.
		 * 
		 */
		SPECTROGRAM("Spectrogram", "spectrogram"),

		/**
		 * Converts a waveform to a spectrogram in exactly the same as the Ketos library
		 * <p>
		 * Two associated parameters - the FFT length and FFT hop size in samples. The
		 * hop is the number of samples from the start of the last FFT window to move.
		 * The third parameter is window size which is in seconds. 
		 * 
		 */
		SPECTROGRAMKETOS("Spectrogramketos", "spectrogramketos"),

		/**
		 * Crops a spectrogram image between two frequency values and interpolates the
		 * image to be a specified pixel size.
		 * <p>
		 * Three associated parameters;
		 * <li>Minimum frequency in Hz
		 * <li>Maximum frequency in Hz
		 * <li>The number of bins between to the minimum and maximum frequency. Integer
		 * number
		 */
		SPECCROPINTERP("Interp. Spectrogram", "freq_compression"),

		/**
		 * Normalises the spectrogram
		 */
		SPECNORMALISE("Normalise Spectrogram", "normalize"),
		
		
		/**
		 * Normalises the spectrogram using a min max normalisation. 
		 * <p> No associated paramters. 
		 */
		SPECNORMALISE_MINIMAX("Normalise Spectrogram Min. Max.", "normalize_min_max"),

		/**
		 * Normalises the spectrogram by summing squared rows and dividing by the square
		 * root of the sum. There are no associated parameters.
		 */
		SPECNORMALISEROWSUM("Normalise Spectrogram Sum", "norm_row_sum"),

		/**
		 * Converts a spectrogram from linear to log10 units. No associated parameters.
		 */
		SPEC2DB("Spectrogram to dB", "amplitude_to_decibel"),

		/**
		 * Clamps the spectrogram between two values. Only values between the clamp
		 * values are kept. Values outside the clamp values are set to the minimum and
		 * maximum of the clamp depending on whether they are above the maximum or below
		 * the minimum clamp values respectively.
		 * <p>
		 * Two associated parameters - the minimum and maximum clamp values.
		 */
		SPECCLAMP("Clamp Spectrogram", "clamp"),

		/**
		 * Normalize the data array to specified mean and standard deviation.
		 * 
		 * For the data array to be normalizable, it must have non-zero standard
		 * deviation. If this is not the case, the array is unchanged by calling this
		 * method.
		 * <p>
		 * Two associated parameters - the mean and std of the normalized array.
		 * Defaults are 0 and 1 respecetively
		 * 
		 * @param mean - Mean value of the normalized array. The default is 0.
		 * @param std  - Standard deviation of the normalized array. The default is 1.
		 * @return the normalised array
		 */
		SPECNORMALISESTD("Normalise std", "normalisestd"),

		/**
		 * Subtracts from each row the median value of that row.
		 * <p>
		 * No associated parameters.
		 */
		REDUCETONALNOISE_MEDIAN("Reduce Tonal Noise (Median)", "reduce_tonal_noise_median"),

		/**
		 * Reduce continuous tonal noise produced by e.g. ships and slowly varying
		 * background noise by subtracting from each row a running mean, computed
		 * according to the formula given in Baumgartner & Mussoline, Journal of the
		 * Acoustical Society of America 129, 2889 (2011); doi: 10.1121/1.3562166
		 * <p>
		 * One associated parameter - timeConstLen - Time constant in number of samples,
		 * used for the computation of the running mean.
		 */
		REDUCETONALNOISE_MEAN("Reduce Tonal Noise (Mean)", "reduce_tonal_noise_mean"),

		/**
		 * Discard pixels that are lower than the median threshold.
		 * 
		 * The resulting image will have 0s for pixels below the threshold and 1s for
		 * the pixels above the threshold.
		 * 
		 * Note: Code adapted from Kahl et al. (2017) Paper:
		 * http://ceur-ws.org/Vol-1866/paper_143.pdf Code:
		 * https://github.com/kahst/BirdCLEF2017/blob/master/birdCLEF_spec.py
		 * <p>
		 * Two associated parameters. rowfactor - Factor by which the row-wise median
		 * pixel value will be multiplied in other to define the threshold.
		 * <p>
		 * colfactor - Factor by which the col-wise median pixel value will be
		 * multiplied in orther to define the threshold.
		 */
		MEDIANFILTER("Median Filter", "medianfilter"),

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
		 * <p>
		 * One associated parameter - enhancement - Time constant in number of samples,
		 * used for the computation of the running mean.
		 **/
		ENHANCE("Enhance", "enhance_signal"),

		/**
		 * 
		 * Smooth the image using a Gaussian smoothing image.
		 * <p>
		 * One associated parameter. Standard deviation for Gaussian kernel. May be given
		 * as a single number, in which case all axes have the same standard deviation,
		 * or as an array, allowing for the axes to have different standard deviations.
		 */
		GAUSSIAN_FILTER("Gaussion Filter", "guassian_filter"),

		/**
		 * Remove isolated spots from the image.
		 * 
		 * <p>
		 * One associated paramter. An int[][] array containing a structuring pattern
		 * that defines feature connections. Must be symmetric.
		 */
		FILTER_ISOLATED_SPOTS("Filter Isolated Spots", "filter_isolated_spots"), 
		
		
		/**
		 * Normalises the waveform to zero mean and standard deviation of 1.
		 * 
		 * <p>
		 * Three associated parameters - the target mean and std for the nomralization e.g. 0 and 1 are often used. 
		 * Parameter 3 is an integer which defines which type of normalisation to use. 
		 * KETOSNORM is the ketos method.
		 * PGNORM is the PAMGuard method.
		 * MEANNORM is a standard subtract the mean and divide by absolute value. 
		 */
		NORMALISE_WAV("Normalise Waveform", "normalize_wav"), 
		
		/**
		 * Filter a waveform. 
		 * 
		 * <p>
		 * Five associated parameters 
		 *  <ul>
			  <li>Filter type (int) - low pass = 0, high pass = 1, band pass = 2  </li>
			  <li>Filter order(int) - the filter order.	</li>
			  <li>Filter method (int) - Butterworth = 0, Chebyshev = 1</li>
			  <li>Low cut frequency - ignored when using low pass</li>
			  <li>High cut frequency - ignored when using high pass</li>
			</ul> 
		 * 
		 */
		FILTER("Filter", "filter_wav"), 

		/**
		 * Resize the spectrgram so that the frequency and time axis are a certian
		 * number of bins
		 * <p>
		 * Two associated parameters. *
		 * <ul>
		 * <li>time bins - the number of bins to resize the time axis to</li>
		 * <li>frequency bins - the number of bins to resize the frequency axis to</li>
		 * </ul>
		 * 
		 */
		SPECRESIZE("Resize Spectrogram", "spec_resize"), 
		
		/**
		 * Flip the spectrogram on the frequency axis. 
		 */
		SPECFLIP("Flip Spectrogram", "spec_flip"), 
		
		/**
		 * Contrast Limited Adaptive Histogram Equalization.
		 * 
		 * <br>
		 * References:
		 * http://en.wikipedia.org/wiki/Adaptive_histogram_equalization#Contrast_Limited_AHE
		 * 
		 * Three associated parameters.
		 * <ul>
		 * <li>block radius - Integer - The size of the local region around a pixel for
		 * which the histogram is equalized. This size should be larger than the size of
		 * features to be preserved.</li>
		 * <li>bins - the number of histogram bins used for histogram equalization.</li>
		 * <li>slope - Float - Limits the contrast stretch in the intensity transfer
		 * function. Very large values will let the histogram equalization do whatever
		 * it wants to do, that is result in maximal local contrast. The value 1 will
		 * result in the original image.</li>
		 * </ul>
		 */
		CLAHE("CLAHE Spectrogram", "clahe");

		
		
		/**
		 * Then name of the transform.
		 */
		private final String text;

		/**
		 * The json text for the transform.
		 */
		private String jsonText;

		/**
		 * @param text
		 */
		DLTransformType(final String text, final String jsonText) {
			this.text = text;
			this.jsonText = jsonText;
		}

		/**
		 * The JSON string
		 * 
		 * @return the JSON string.
		 */
		public String getJSONString() {
			return jsonText;
		}

		/**
		 * (non-Javadoc)
		 * 
		 * @see java.lang.Enum#toString()
		 */
		@Override
		public String toString() {
			return text;
		}
	}

	/**
	 * Transform the data to transform the data it holds. The data returns a
	 * reference to itself (which will now contains the transformed data)
	 */
	public DLTransform transformData(DLTransform transfrom);

	/**
	 * Get the type of transform
	 * 
	 * @return
	 */
	public DLTransformType getDLTransformType();

}
