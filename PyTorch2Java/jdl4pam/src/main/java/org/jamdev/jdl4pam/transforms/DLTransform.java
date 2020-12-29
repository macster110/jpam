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
	 * {@link #SPECCROPINTERP} {@link #SPECNORMALISE} {@link #SPEC2DB}
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
		PREEMPHSIS("Pre-emphasis"),

		/**
		 * Decimates the signal to a high or lower amplitude including anti-aliasing
		 * filters.
		 * <p>
		 * One associated parameter- the sample-rate in samples per second to decimate
		 * or interpolate to.
		 */
		DECIMATE("Decimate wave"),

		/**
		 * Trims the acoustic data to new length.
		 * <p>
		 * Two associated parameters- the start and end sample to keep
		 * 
		 */
		TRIM("Trim wave"),

		/**
		 * Converts a waveform to a spectrogram
		 * <p>
		 * Two associated parameters - the FFT length and FFT hop size in samples. The
		 * hop is the number of samples from the start of the last FFT window to move.
		 * 
		 */
		SPECTROGRAM("Spectrogram"),

		/**
		 * Crops a spectrogram image between two frequency values and interpolates the
		 * image to be a specified pixel size.
		 * <p>
		 * Three associated parameters;
		 * <li>Minimum frequency in Hz
		 * <li>Maximum frequency in Hz
		 * <li>The number of bins between to the minimum and maximum frequency. Integer number
		 */
		SPECCROPINTERP("Interp. Spectrogram"),

		/**
		 * Normalises the spectrogram
		 */
		SPECNORMALISE("Normalise Spectrogram"),

		/**
		 * Converts a spectrogram from linear to log10 units. No associated parameters.
		 */
		SPEC2DB("Spectrogram to dB"),

		/**
		 * Clamps the spectrogram between two values. Only values between the clamp
		 * values are kept. Values outside the clamp values are set to the minimum and
		 * maximum of the clamp depending on whether they are above the maximum or below
		 * the minimum clamp values respectively.
		 * <p>
		 * Two associated parameters - the minimum and maximum clamp values.
		 */
		SPECCLAMP("Clamp Spectrogram");

		private final String text;

		/**
		 * @param text
		 */
		DLTransformType(final String text) {
			this.text = text;
		}

		/*
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
