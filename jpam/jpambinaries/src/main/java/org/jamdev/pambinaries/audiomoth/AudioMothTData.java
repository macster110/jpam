package org.jamdev.pambinaries.audiomoth;

/**
 * A single trigger chunk from an AudioMoth trigger. 
 * @author Jamie Macaulay 
 *
 */
public class AudioMothTData {
	
	/**
	 * The 16-bit waveform 
	 */
	public short[] wave; 

	/**
	 * The start sample into the wave file. 
	 */
	public long sampleStart; 
	
	/**
	 * The sample rate. 
	 */
	public float sR; 
	
	/**
	 * The date-time of the start of the chunk in Java millis. 
	 */
	public long timeMillis; 
	
	/**
	 * Constructor for the AudioMothTData. Stores a single chunk of triggered data. 	
	 */
	public AudioMothTData() {
		//must manually add the fields after calling this constructor. 
	}
	
	
	/**
	 * Constructor for AudioMoth data. Stores a single chunk of triggered data. 
	 * @param sampleStart - the start sample. 
	 * @param timeMillis - the time date number in millis
	 * @param wave - the waveform/ 
	 * @param sR - the sample rate. 
	 */
	public AudioMothTData(long sampleStart, long timeMillis, short[] wave, float sR){
		this.sampleStart=sampleStart;
		this.timeMillis=timeMillis;
		this.wave=wave; 
		this.sR=sR; 
	}
	
}
