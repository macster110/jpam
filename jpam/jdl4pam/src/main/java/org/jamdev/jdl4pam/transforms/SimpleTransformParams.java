package org.jamdev.jdl4pam.transforms;

import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;

/**
 * Simple transform parameters. 
 * 
 * @author Jamie Macaulay 
 *
 */
public class SimpleTransformParams extends DLTransfromParams {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	/**
	 * Constructor for  simple transform parameters. 
	 * @param dlTransformType - the type of transform
	 * @param params - a list of parameters for that transform. See 
	 */
	public SimpleTransformParams(DLTransformType dlTransformType, Number... params) {
		this.dltransfromType = dlTransformType;
		this.params = params;
	}

	
//	/**
//	 * The paramters for the transform. 
//	 */
//	public Number[] params; 
	
	@Override
	public String toString() {
		
		String string = null;
		switch (dltransfromType) {
		case DECIMATE:
		case DECIMATE_SCIPY:
			string = dltransfromType.toString() + " sR: " + params[0];
			break;
		case PREEMPHSIS:
			string = dltransfromType.toString() + " factor: " + params[0];
			break;
		case SPEC2DB:
			string = dltransfromType.toString() + " mindB " + ((params == null || params.length==0 )? null : params[0].toString());
			break;
		case SPECCLAMP:
			string = dltransfromType.toString() + " min: " + params[0] + " max: " + params[1];
			break;
		case SPECCROPINTERP:
			string = dltransfromType.toString() + " min freq: " + params[0] + " max freq: " + params[1] + " bins: " + params[2];;
			break;
		case SPECNORMALISE:
			string = dltransfromType.toString() + " min dB: " + params[0] + " ref dB: " + params[1];
			break;
		case SPECTROGRAM:
			string = dltransfromType.toString() + " fft length: " + params[0] + " fft hop: " + params[1];
			break;
		case SPECTROGRAMKETOS:
			string = dltransfromType.toString() + " fft length: " + params[0] + " fft hop: " + params[1] + " window: " + params[2];
			break;
		case TRIM:
			string = dltransfromType.toString() + " min samples: " + params[0] + " max samples: " + params[1];
			break;
		case SPECNORMALISEROWSUM:
			string = dltransfromType.toString() + "  " + params;
			break;
		default:
			string = dltransfromType.toString();
			break;
		}
		return string;
	}


	public void setGray(int x, int y, int gray) {
		// TODO Auto-generated method stub
		
	}
	
	
	

}
