package wavFiles;

/**
 * Holds wav file data
 * @author Jamie Macaulay
 *
 */
public class WavFileData {
	
	/**
	 * Samples in u
	 */
	public int[] samples;
	
	/**
	 * The sample rate in samples per second
	 */
	public int sampleRate;

	public WavFileData(int[] samples, int sampleRate){
		this.samples=samples; 
		this.sampleRate = sampleRate;
	}

	/**
	 * Get the sample rate in samples per second. 
	 * @return the sample rate in samples per second. 
	 */
	public int getSampleRate() {
		return sampleRate;
	}

	/**
	 * Get the sample amplitudes in raw bits e.g. +/- 2^16 /2 for 16 bit files. 
	 * @return the sample amplitudes
	 */
	public int[] getSampleAmplitudes() {
		return samples;
	}

	/**
	 * Get the length in seconds. 
	 * @return the length of the file in seconds
	 */
	public double getLengthInSeconds() {
		return samples.length / (double) sampleRate;
	}
	

}
