package org.jamdev.jdl4pam.genericmodel;

import java.util.ArrayList;
import java.util.Arrays;

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
	
	@Override
	public boolean equals(Object o) {
		
		GenericModelParams params = (GenericModelParams) o;
		

		//check the transforms are the same. 		
		if (this.dlTransforms!=null && params.dlTransforms == null) {
			return false; 
		}
		if (params.dlTransforms!=null && this.dlTransforms == null) {
			return false; 
		}
		
		//iterate through the transofrms and check each one is equal. 
		if (this.dlTransforms!=null) {
			
			if (this.dlTransforms.size()!=dlTransforms.size()) {
				return false; 
			}
				
			for (int i=0; i<this.dlTransforms.size();i++) {
				if (!this.dlTransforms.get(i).equals(params.dlTransforms.get(i))) {
					return false; 
				}
			}
		}
		else {
			//both transforms must be null and so can still be equal
		}
		
		
		//check the rest. 
		
		boolean isEqual = 
				this.segLen == params.segLen &&
				this.defaultOutputShape.equals(params.defaultOutputShape) && 
				this.defaultInputShape.equals(params.defaultInputShape) &&
				Arrays.equals(	this.classNames, params.classNames); 
		
		
		return isEqual; 
		
	}



	
}

