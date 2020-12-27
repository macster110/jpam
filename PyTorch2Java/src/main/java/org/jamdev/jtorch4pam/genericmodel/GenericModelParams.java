package org.jamdev.jtorch4pam.genericmodel;

import java.util.ArrayList;

import org.jamdev.jtorch4pam.transforms.DLTransfromParams;

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
	
}

