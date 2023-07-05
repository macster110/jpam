package org.jamdev.jdl4pam.genericmodel;

import ai.djl.ndarray.types.Shape;

/**
 * Holds information on the deep learning model.
 * 
 * @author Jamie Macaulay 
 *
 */
public class ModelInfo {
	
	/**
	 * The input shape for the audio data
	 */
	public Shape inputShape; 
	
	/**
	 * The output shape for predictions. 
	 */
	public Shape outputShape; 
	

}