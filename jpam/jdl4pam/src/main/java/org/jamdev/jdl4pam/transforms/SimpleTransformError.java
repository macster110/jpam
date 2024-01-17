package org.jamdev.jdl4pam.transforms;

public class SimpleTransformError implements TransformError {
	
	public SimpleTransformError(String message) {
		this.message = message;
	}

	String message;
	
	@Override
	public String getMessage() {
		return message;
	}

}
