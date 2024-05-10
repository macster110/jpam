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
	
//	/**
//	 * Error message
//	 */
//	private TransformError error;

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
		
		if (!(o instanceof SimpleTransform)) return false; 
	
		SimpleTransform transform = (SimpleTransform) o; 
		
		if (params ==null && transform.params!=null) return false;
		if (transform.params ==null && params!=null) return false;

		if (params!=null) {

			if (params.length != transform.params.length) {
//				System.out.println("Simple transform not same length ");
				return false; 
			}

			for (int i=0; i<params.length; i++) {
				if (!params[i].equals(transform.params[i])) {
//					System.out.println("Simple transform not equal: " + i + "  " +  params[i] + "  " + transform.params[i]);
					return false;  
				}
			}
		}
		
		return transform.getDLTransformType().equals(this.getDLTransformType()); 
	}
	
//	/**
//	 * Get the error object for the transform. Is null if there is no error. 
//	 * @return the error object or null if there is no error. 
//	 */
//	public TransformError getError() {
//	   return this.error;
//	}
//
//	/**
//	 * Set the transform error. Set to null toclear errors. 
//	 * @param the error to set. 
//	 */
//	public void setError(TransformError object) {
//		this.error = object; 
//	}
//	
//	/**
//	 * Check whether the last transform caused an error. See getError();
//	 * @return true if an error has occurred. 
//	 */
//	public boolean isError() {
//		return error!=null;
//	}
	

}
