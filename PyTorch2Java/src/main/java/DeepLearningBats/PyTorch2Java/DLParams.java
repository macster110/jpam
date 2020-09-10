package DeepLearningBats.PyTorch2Java;

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
	
	/**
	 * The FFT length for the spectrogram in bins
	 */
	public int n_fft = 512; 
	
	/**
	 * The FFT hop in sample bins. 
	 */
	public int hop_length = 256; 
	
	/**
	 * The sample rate to interpolate or decimate to in samples per second
	 */
	public float sR = 128000; 
	
	
	public double min_level_dB = 100; 
	
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
