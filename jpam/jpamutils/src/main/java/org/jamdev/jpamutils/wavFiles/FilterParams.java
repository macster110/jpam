package org.jamdev.jpamutils.wavFiles;

/**
 * Class for holding filter parameters. 
 */
public class FilterParams {
	
	/**
	 * The filter type - LOWPASS, HIGHPASS, BANDPASS
	 */
	public int filterType = AudioData.HIGHPASS;
	
	/**
	 * The filter method - BUTTERWORTH, CHEBYSHEV
	 */
	public int filterMethod = AudioData.BUTTERWORTH;

	/**
	 * The filter order
	 */
	public int order = 2;

	/**
	 * The lower frequency bound - ignored if low pass
	 */
	public double lowCut = 10;

	/**
	 * The higher frequency bound - ignored if high pass
	 */
	public double highCut = 20000;
	
}

