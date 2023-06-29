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
	
	@Override
	public boolean equals(Object o) {

		SimpleTransform transform = (SimpleTransform) o; 

		if (params ==null && transform.params!=null) return false;
		if (transform.params ==null && params!=null) return false;

		if (params!=null) {

			if (params.length != transform.params.length) return false; 

			for (int i=0; i<params.length; i++) {
				if (!params[i].equals(transform.params[i])) {
					return false;  
				}
			}
		}
		
		return transform.getDLTransformType().equals(this.getDLTransformType()); 
	}

	

}
