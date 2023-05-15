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
		 * Converts a waveform to a spectrogram
		 * <p>
		 * Two associated parameters - the FFT length and FFT hop size in samples. The
		 * hop is the number of samples from the start of the last FFT window to move.
		 * 
		 */
		SPECTROGRAM("Spectrogram", "spectrogram"),

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
		 * No parameters. 
		 */
		NORMALISE_WAV("Normalise Waveform", "normlize_wav");

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
