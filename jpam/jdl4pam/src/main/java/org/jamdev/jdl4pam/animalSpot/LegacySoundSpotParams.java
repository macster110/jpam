package org.jamdev.jdl4pam.animalSpot;

/**
 * Old sound spot params. More readable though. 
 * @author Jamie Macaulay 
 *
 */
public class LegacySoundSpotParams {

	
	 //The FFT length for the spectrogram in bins
	
		public int n_fft = 256;

		/**
		 * The FFT hop in sample bins.
		 */
		public int hop_length = 8;

		/**
		 * The sample rate to interpolate or decimate to in samples per second. i.e.
		 * this is the sample rate of the training data.
		 */
		public float sR = 256000;

		/**
		 * The pore emphasis factor. This dictates how much the lower frequences in the
		 * wave data are attenuated.
		 */
		public double preemphases = 0.98;

		/**
		 * The minimum dB level for normalising the dB spectral amplitudes.
		 */
		public double min_level_dB = -100;

		/**
		 * The reference dB level for normalising the dB spectral amplitudes.
		 */
		public double ref_level_dB = 0;

		/**
		 * Minimum value to clamp spectrogram to after normalisation.
		 */
		public double clampMin = 0;

		/**
		 * Maximum value to clamp spectrogram to after normalisation.
		 */
		public double clampMax = 1;

		/**
		 * The minimum frequency to interpolate the spectrogram image from.
		 */
		public double fmax = 100000;

		/**
		 * The maximum frequency to interpolate the spectrogram image from.
		 */
		public double fmin = 40000;

		/**
		 * The number of vertical bins to interpolate the spectrogram image to.
		 */
		public int n_freq_bins = 256;

		/**
		 * The type of frequency compression ot nuse.
		 */
		public String freq_compression = "linear";
		
		
}
