package org.jamdev.jdl4pam.transforms;

import org.jamdev.jpamutils.wavFiles.AudioData;

/**
 * A transform of the waveform. Performs time domain transforms. 
 * 
 * @author Jamie Macaulay 
 *
 */
public class WaveTransform extends SimpleTransform {


	/**
	 * The audio data class. This contains audio data, 
	 */
	private AudioData soundData; 

	/**
	 * The waveform transform type flag
	 */
	private DLTransformType flag;
	
	
	/**
	 * Create a waveform transform including the initial raw audiodata. 
	 * <p>
	 * See WaveTransform.WaveTransformType for a description of each transform. 
	 * <p>
	 * Each transform type has a unique set of parameters. These are
	 * <ul>
	 *<li>PREEMPHSIS: The pre-emphasis factor (between 0 and 1)</li>
	 *<li>DECIMATE: the sample rate in samples per second</li>
	 *<li>TRIM: - the start sample, the end sample</li>
	 *</ul>
	 * 
	 * @param flag - the type flag for the transform
	 * @param params - the parameters associated with thetransform type. 
	 */
	public  WaveTransform(AudioData audioData, DLTransformType flag, Number... params) {
		this.flag=flag; 
		this.params = params;
		this.soundData=audioData; 
	}

	/**
	 * Create a waveform transform.
	 * <p>
	 * See WaveTransform.WaveTransformType for a description of each transform. 
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
	public WaveTransform(DLTransformType flag, Number... params) {
		this.flag=flag; 
		this.params = params;
	}


	@Override
	public DLTransform transformData(DLTransform transfrom) {
		WaveTransform waveTransform = (WaveTransform) transfrom; 
		switch (flag) {
		case DECIMATE:
			soundData = waveTransform.getWaveData().interpolate(params[0].floatValue()); 
//			soundData = waveTransform.getWaveData();
			break;
		case PREEMPHSIS:
			soundData = waveTransform.getWaveData().preEmphasis(params[0].floatValue()); 
			break;
		case TRIM:
			soundData = waveTransform.getWaveData().trim(params[0].intValue(), params[1].intValue()); 
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
	public void setWaveData(AudioData soundData) {
		this.soundData=soundData; 
	}

	@Override
	public DLTransformType getDLTransformType() {
		return flag;
	}

}
