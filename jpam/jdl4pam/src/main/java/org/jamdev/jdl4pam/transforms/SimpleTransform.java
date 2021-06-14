package org.jamdev.jdl4pam.transforms;

/**
 * A transfrom which has a set on numbers as input parameters. 
 * @author Jamie Macaulay 
 *
 */
public abstract class SimpleTransform implements DLTransform {
	
	/**
	 * The parameters. 
	 */
	protected Number[] params;

	/**
	 * Get the parameters for the transform
	 * @return the parameters array. 
	 */
	public Number[] getParams() {
		return params;
	}

	/**
	 * Set the parameters or the transfrom 
	 * @param params - the parameter array to set. 
	 */
	public void setParams(Number[] params) {
		this.params = params;
	}
	
	

}
