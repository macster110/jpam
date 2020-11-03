package org.jamdev.jtorch4pam.transforms;

import org.jamdev.jtorch4pam.wavFiles.AudioData;

/**
 * A transform of the waveform. 
 * @author Jamie Macaulay 
 *
 */
public class WaveTransform implements DLTransform {

	/**
	 * Type of waveform transform that are available. 
	 *  {@link #PREEMPHSIS}
	 *  {@link #DECIMATE}
	 *  {@link #TRIM}
	 *  
	 * @author Jamie Macaulay
	 *
	 */
	public enum WaveTransformType {
		/**
		 * Basic filter which reduces lower frequencies.
		 */
		PREEMPHSIS, 
		
		/**
		 * Decimates the signal to a high or lower amplitude including anti-aliasing filters. 
		 */
		DECIMATE, 
		
		/**
		 * Trims the acoustic data to new length.
		 */
		TRIM
	}	

	/**
	 * The audio data class. This contains audio data, 
	 */
	private AudioData soundData; 

	/**
	 * The waveform transform type flag
	 */
	private WaveTransformType flag;
	
	/**
	 * The parameters. 
	 */
	private Number[] params;
	
	
	/**
	 * Create a waveform transform including the initial raw audiodata. 
	 * <p>
	 * See {@link WaveTransform.WaveTransformType} for a description of each transform. 
	 * <p>
	 * Each transform type has a unique set of parameters. These are
	 * <ul>
	 *<li>PREEMPHSIS: The pre-emphasis factor (between 0 and 1)</li>
	 *<li>DECIMATE: the sample rate in samples per second</li>
	 *<li>TRIM: - the start sample, the end sample</li>
	 *</ul>
	 * 
	 * @param flag - the type fflag for the transform
	 * @param params - the parameters associated with thetransform type. 
	 */
	public  WaveTransform(AudioData audioData, WaveTransformType flag, Number... params) {
		this.flag=flag; 
		this.params = params;
		this.soundData=audioData; 
	}

	/**
	 * Create a waveform transform.
	 * <p>
	 * See {@link WaveTransform.WaveTransformType} for a description of each transform. 
	 * <p>
	 * Each transform type has a unique set of parameters. These are
	 * <ul>
	 *<li>PREEMPHSIS: The pre-emphasis factor (between 0 and 1)</li>
	 *<li>DECIMATE: the sample rate in samples per second</li>
	 *<li>TRIM: - the start sample, the end sample</li>
	 *</ul>
	 * 
	 * @param flag - the type fflag for the transform
	 * @param params - the parameters associated with thetransform type. 
	 */
	public  WaveTransform(WaveTransformType flag, Number... params) {
		this.flag=flag; 
		this.params = params;
	}

	@Override
	public DLTransform transformData(DLTransform transfrom) {
		WaveTransform waveTransform = (WaveTransform) transfrom; 
		switch (flag) {
		case DECIMATE:
			soundData = waveTransform.getWaveData().interpolate(params[0].floatValue()); 
			break;
		case PREEMPHSIS:
			soundData = waveTransform.getWaveData().interpolate(params[0].floatValue()); 
			break;
		case TRIM:
			soundData = waveTransform.getWaveData().interpolate(params[0].floatValue()); 
			break;
		default:
			break;
		}
		
		return this; 
	}

	public AudioData getWaveData() {
		return soundData; 
	}
	
	/**
	 * Set the audioData.
	 * @return the audiodata. 
	 */
	public AudioData setWaveData() {
		return soundData; 
	}

}
