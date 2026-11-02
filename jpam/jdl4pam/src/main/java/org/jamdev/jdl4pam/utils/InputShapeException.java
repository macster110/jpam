package org.jamdev.jdl4pam.utils;

/**
 * Thrown when the input data do not match the input shape of a model, e.g. a
 * spectrogram has a different number of time or frequency bins to the model
 * input. This is a problem with the transforms or the model metadata, not the
 * model or the device it runs on.
 *
 * @author Jamie Macaulay
 */
public class InputShapeException extends IllegalArgumentException {

	private static final long serialVersionUID = 1L;

	public InputShapeException(String message) {
		super(message);
	}

	/**
	 * Find an input shape exception in the causes of an exception. Model
	 * predictors wrap exceptions thrown by translators.
	 *
	 * @param e - the exception.
	 * @return the input shape exception or null if the exception was not caused by one.
	 */
	public static InputShapeException find(Throwable e) {
		while (e != null) {
			if (e instanceof InputShapeException) return (InputShapeException) e;
			e = e.getCause();
		}
		return null;
	}
}
