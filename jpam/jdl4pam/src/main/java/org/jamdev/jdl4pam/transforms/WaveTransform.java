package org.jamdev.jdl4pam.transforms;

import org.jamdev.jpamutils.wavFiles.AudioData;
import org.jamdev.jpamutils.wavFiles.FilterParams;

/**
 * A transform of the waveform. Performs time domain transforms. 
 * 
 * @author Jamie Macaulay 
 *
 */
public class WaveTransform extends SimpleTransform {


	private static final String NO_SAMPLES_ERROR = "There are no samples to transform";

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
	 * Each transform type has a unique set of parameters. Examples are
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
	 * Each transform type has a unique set of parameters. Examples are
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
//		this.setError(null); //clear any error
		WaveTransform waveTransform = (WaveTransform) transfrom; 
		
		switch (flag) {
		case DECIMATE:			
			soundData = waveTransform.getWaveData().interpolate(params[0].floatValue());
			break;
		case DECIMATE_SCIPY:
			soundData = waveTransform.getWaveData().interpolate_scipy(params[0].floatValue());
			break;
		case PREEMPHSIS:
			soundData = waveTransform.getWaveData().preEmphasis(params[0].floatValue());
			break;
		case TRIM:
			soundData = waveTransform.getWaveData().trim(params[0].intValue(), params[1].intValue());
			break;
		case PEAK_TRIM:
			soundData = waveTransform.getWaveData().selectPeak(params[0].intValue(), params[1].intValue());
			break;
		case FILTER:
//			System.out.println("Filter waveform1: " + waveTransform.getWaveData().samples.length); 
			FilterParams filtParams = transform2FilterParams(params);
			soundData = waveTransform.getWaveData().filter(filtParams);
//			System.out.println("Filter waveform2: " + soundData.samples.length); 
			break;
		case NORMALISE_WAV:
			if (params==null || params.length==0) soundData = waveTransform.getWaveData().normalise(0,1, AudioData.MEANNORM);
			else if (params.length==2) soundData = waveTransform.getWaveData().normalise(params[0].floatValue(), params[1].floatValue(), AudioData.PGNORM);
			else soundData = waveTransform.getWaveData().normalise(params[0].floatValue(), params[1].floatValue(), params[2].intValue());
			break;
		default:
			break;
		}

		return this; 
	}


	/**
	 * Convert the array of numbers stored in a FILTER transform into a FilterParams 
	 * object. 
	 * <p>
	 * The filter parameters are complex and so conversion to an object is for programming
	 * convenience to reduce errors. 
	 * @param params - the standard transform params for a FILTER transform
	 * @return filter object equivalent to params. 
	 */
	public static FilterParams transform2FilterParams(Number[] params) {
		FilterParams filtParams= new FilterParams();
		filtParams.filterMethod = params[2].intValue();
		filtParams.filterType = params[0].intValue();
		filtParams.order = params[1].intValue();
		filtParams.lowCut = params[3].doubleValue();
		filtParams.highCut = params[4].doubleValue();

		return filtParams;
	}


	/**
	 * Convert the FilterParams object to number array for FILTER transform 
	 * <p>
	 * The filter parameters are complex and so conversion to an object is for programming
	 * convenience to reduce errors. 
	 * @param params - the FilterParams object for a FILTER transform
	 * @return number array with params from FilterParams. 
	 */
	public static Number[] filterParams2transform(FilterParams params) {
		Number[] paramsN = new Number[5];
		paramsN[0] = params.filterType;
		paramsN[1] = params.order;
		paramsN[2] = params.filterMethod;
		paramsN[3] = params.lowCut;
		paramsN[4] = params.highCut;
		return paramsN; 
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
