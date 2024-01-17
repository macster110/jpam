package org.jamdev.jdl4pam.transforms;

/**
 * Error reporting for transforms
 */
public interface TransformError {
	
	/**
	 * Get human readable error message. 
	 * @return the error message. 
	 */
	public String getMessage();

}
