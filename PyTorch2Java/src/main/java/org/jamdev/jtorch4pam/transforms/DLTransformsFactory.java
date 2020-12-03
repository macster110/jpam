package org.jamdev.jtorch4pam.transforms;

import java.util.ArrayList;

import org.jamdev.jtorch4pam.transforms.DLTransform.DLTransformType;

/**
 * Generates a transform class from Enum and paramters. 
 * 
 * @author Jamie Macaulay
 *
 */
public class DLTransformsFactory {


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
		case SPEC2DB:
			dlTransform = new FreqTransform(DLTransformType.SPEC2DB, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		case SPECCLAMP:
			dlTransform = new FreqTransform(DLTransformType.SPECCLAMP, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		case SPECCROPINTERP:
			dlTransform = new FreqTransform(DLTransformType.SPECCROPINTERP, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		case SPECNORMALISE:
			dlTransform = new FreqTransform(DLTransformType.SPECNORMALISE, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		case SPECTROGRAM:
			dlTransform = new FreqTransform(DLTransformType.SPECTROGRAM, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		case TRIM:
			dlTransform = new WaveTransform(DLTransformType.TRIM, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		default:
			dlTransform=null; 
			break;
		}
		return dlTransform;
	}
	
	/**
	 * Generate a list of transfrom objects from an array  of transform params. 
	 * @param dlTransfromParams - the DL transfrom params. 
	 * @return - list of corresponding transform objects 
	 */
	public static ArrayList<DLTransform> makeDLTransforms(ArrayList<DLTransfromParams> dlTransfromParams) {
		 ArrayList<DLTransform>  transforms = new  ArrayList<DLTransform>(); 
		for (int i=0; i<dlTransfromParams.size(); i++) {
			transforms.add(makeDLTransform(dlTransfromParams.get(i))); 
		}
		return transforms; 
	}


}
