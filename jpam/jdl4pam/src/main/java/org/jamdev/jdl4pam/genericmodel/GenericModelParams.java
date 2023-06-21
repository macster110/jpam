package org.jamdev.jdl4pam.genericmodel;

import java.util.ArrayList;

import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;

import ai.djl.ndarray.types.Shape;

import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;


/**
 * The model parameters
 * 
 * @author Jamie Macaulay
 *
 */
public class GenericModelParams {
	
	/**
	 * A list of transforms for the data. Each chunk of raw sound data has a series of transforms applied. 
	 * These are encoded in the model and then used to generate a list of DLTransfrom objects which transform 
	 * raw sound data. For example, data might be decimated, converted to spectrogram, interpolated and normalised 
	 * before being sent for classification. 
	 * 
	 */
	public ArrayList<DLTransfromParams> dlTransforms; 
	
	/**
	 * The class names. 
	 */
	public String[] classNames = null;
	
	/**
	 * The default shape of the input. 
	 */
	public Shape defaultInputShape = null;
	
	/**
	 * The default shape of the output. 
	 */
	public Shape defaultOutputShape = null;
	
	/**
	 * The target segment length in milliseconds. The segment
	 * length is the duration of sound sent to the model. 
	 * Can be null because not all models require a segment length. 
	 */
	public Double segLen = null;
	
	public GenericModelParams() {
		defualtParams(); 
	}

	/**
	 * Create some default parameters so that the model transforms are not null. 
	 */
	private void defualtParams() {
		
		/**
		 * The minimum dB level for normalising the dB spectral amplitudes.
		 */
		double min_level_dB = -100;

		/**
		 * The reference dB level for normalising the dB spectral amplitudes.
		 */
		double ref_level_dB = 0;
		
		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		//waveform transforms. 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.PREEMPHSIS, 0.98)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, 512, 128)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPEC2DB)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISE, min_level_dB, ref_level_dB)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCLAMP, 0, 1)); 
		
		this.dlTransforms = dlTransformParamsArr; 
		
	}



	
}

