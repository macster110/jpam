package org.jamdev.jdl4pam.transforms;

import java.util.ArrayList;

import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;

/**
 * Generates a transform class from Enum and paramters. 
 * 
 * @author Jamie Macaulay
 *
 */
public class DLTransformsFactory {

	/**
	 * Generate a default DLTransfrom object from a DLtransforms type. The transforms will have default parameters. 
	 * @param dlTransformType - the transform type
	 * @param sR- tghe sample rate in samples per seconds.
	 */
	public static DLTransform makeDLTransform(DLTransformType dlTransformType, float sR) {

		DLTransform dlTransform = null; 

		switch (dlTransformType) {
		case DECIMATE:
			dlTransform = new WaveTransform(dlTransformType, new Number[] {sR}); 
			break;
		case PREEMPHSIS:
			dlTransform = new WaveTransform(dlTransformType, new Number[] {0.98}); 
			break;
		case NORMALISE_WAV:
			dlTransform = new WaveTransform(dlTransformType, null); 
			break;
		case SPEC2DB:
			dlTransform = new FreqTransform(dlTransformType, null); 
			break;
		case SPECCLAMP:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {0.0, 1.0}); 
			break;
		case SPECCROPINTERP:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {0.0, (double) sR/2 , 256}); 
			break;
		case SPECNORMALISE:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {-100.0, 0.0}); 
			break;
		case SPECNORMALISEROWSUM:
			dlTransform = new FreqTransform(dlTransformType, null); 
			break;
		case SPECTROGRAM:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {1024, 8}); 
			break;
		case TRIM:
			dlTransform = new WaveTransform(dlTransformType, new Number[] {0, 2048}); 
			break;
		case ENHANCE:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {1.0}); 
			break;
		case FILTER_ISOLATED_SPOTS:
			dlTransform = new FreqTransform(dlTransformType, null); //TODO 
			break;
		case GAUSSIAN_FILTER:
			dlTransform = new FreqTransform(dlTransformType,  new Number[] {0.5}); //sigma
			break;
		case MEDIANFILTER:
			dlTransform = new FreqTransform(dlTransformType, null); 
			break;
		case REDUCETONALNOISE_MEAN:
			dlTransform = new FreqTransform(dlTransformType, 30); 
			break;
		case REDUCETONALNOISE_MEDIAN:
			dlTransform = new FreqTransform(dlTransformType, null);
			break;
		case SPECNORMALISESTD:
			dlTransform = new FreqTransform(dlTransformType,  new Number[] {0.0, 1.0}); 
			break;
		case SPECNORMALISE_MINIMAX:
			dlTransform = new FreqTransform(dlTransformType, null); 
			break;
		default:
			break;

		}
		return dlTransform;
	}


	/**
	 * Generate a DLTransfrom object from DL transfrom parameters. 
	 * @param dlTransfromParams
	 * @return
	 */
	public static DLTransform makeDLTransform(DLTransfromParams dlTransfromParams) {

		DLTransform dlTransform; 

		switch (dlTransfromParams.dltransfromType) {
		case DECIMATE:
			dlTransform = new WaveTransform(DLTransformType.DECIMATE, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		case PREEMPHSIS:
			dlTransform = new WaveTransform(DLTransformType.PREEMPHSIS, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
//		case SPEC2DB:
//			dlTransform = new FreqTransform(DLTransformType.SPEC2DB, ((SimpleTransformParams) dlTransfromParams).params); 
//			break;
//		case SPECCLAMP:
//			dlTransform = new FreqTransform(DLTransformType.SPECCLAMP, ((SimpleTransformParams) dlTransfromParams).params); 
//			break;
//		case SPECCROPINTERP:
//			dlTransform = new FreqTransform(DLTransformType.SPECCROPINTERP, ((SimpleTransformParams) dlTransfromParams).params); 
//			break;
//		case SPECNORMALISE:
//			dlTransform = new FreqTransform(DLTransformType.SPECNORMALISE, ((SimpleTransformParams) dlTransfromParams).params); 
//			break;
//		case SPECNORMALISEROWSUM:
//			dlTransform = new FreqTransform(DLTransformType.SPECNORMALISEROWSUM, ((SimpleTransformParams) dlTransfromParams).params); 
//			break;
//		case SPECTROGRAM:
//			dlTransform = new FreqTransform(DLTransformType.SPECTROGRAM, ((SimpleTransformParams) dlTransfromParams).params); 
//			break;
		case TRIM:
			dlTransform = new WaveTransform(DLTransformType.TRIM, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		case NORMALISE_WAV:
			dlTransform = new WaveTransform(DLTransformType.NORMALISE_WAV, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		default:
			dlTransform = new FreqTransform(dlTransfromParams.dltransfromType, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		}
		return dlTransform;
	}

	/**
	 * Generate a list of transform objects from an array  of transform parameters. 
	 * @param dlTransfromParams - the DL transform parameters. 
	 * @return - list of corresponding transform objects 
	 */
	public static ArrayList<DLTransform> makeDLTransforms(ArrayList<DLTransfromParams> dlTransfromParams) {
		ArrayList<DLTransform>  transforms = new  ArrayList<DLTransform>(); 
		for (int i=0; i<dlTransfromParams.size(); i++) {
			transforms.add(makeDLTransform(dlTransfromParams.get(i))); 
			//System.out.println("dlTransfromParams.get(i): " + dlTransfromParams.get(i)); 
		}
		return transforms; 
	}


}
