package org.jamdev.jtorch4pam.DeepLearningBats;

/**
 * Parameters for running the deep learning algorithm
 * <p>
 * Note that parameter names are in python format to keep them 
 * consistant with the Python code. 
 * 
 * @author Jamne Macaulay 
 *
 */
public class DLParams {
//	
//	17:22:24|D|dataOpts: {
//    "samplingrate": 256000,
//    "preemphases": 0.98,
//    "n_fft": 256,
//    "hop_length": 8,
//    "n_freq_bins": 256,
//    "fmin": 40000,
//    "fmax": 100000,
//    "freq_compression": "linear",
//    "min_level_db": -100,
//    "ref_level_db": 0
//}
	
	/**
	 * The FFT length for the spectrogram in bins
	 */
	public int n_fft = 256; 
	
	/**
	 * The FFT hop in sample bins. 
	 */
	public int hop_length = 8; 
	
	/**
	 * The sample rate to interpolate or decimate to in samples per second
	 */
	public float sR = 256000; 
	
	/**
	 * The pore emphasis factor. This dictates how much the lower frequences in 
	 * the wave data are attenuated. 
	 */
	public double preemphases = 0.98; 
	
	/**
	 * The minimum dB level for normalising the dB spectral amplitudes. 
	 */
	public double min_level_dB = 100; 
	
	/**
	 * The reference dB level for normalising the dB spectral amplitudes. 
	 */
	public double ref_level_dB = 30;

	/**
	 * Minimum value to clamp spectrogram to after normalisation. 
	 */
	public double clampMin = 0;

	/**
	 * Maximum value to clamp spectrogram to after normalisation. 
	 */
	public double clampMax = 1; 


}
