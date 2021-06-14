package org.jamdev.jdl4pam.transforms;

import java.io.Serializable;

import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;

/**
 * Parameters that can be saved for a transform.
 * @author Jamie Macaulay 
 *
 */
public class DLTransfromParams implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	/**
	 * The type of the transfrom; 
	 */
	public DLTransformType dltransfromType; 
	
	/**
	 * Basic params.
	 */
	public Number[] params; 
	
	

}
