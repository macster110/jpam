package org.jamdev.jdl4pam.deepAcoustics;



/**
 * A single bounding box result from a DeepAcoustic classifier. Note that multiple results are returned for each input 
 * image. 
 * @author Jamie Macaulay
 *
 */
public class DeepAcousticsResult {

	/**
	 * The confidence score zero to one
	 */
	private float confidence;
	
	/**
	 * The height of the bounding box in pixels of input image. 
	 */
	private float height;
	
	/**
	 * Top left co-ordinate of bounding box y in pixels of input image. 
	 */
	private float y;
	
	/**
	 * Top left co-ordinate of bounding box x in pixels of input image. 
	 */
	private float x;
	
	/**
	 * The predictions value for different species. 
	 */
	private float[] predicitions;

	/**
	 * The height of the bounding box in pixels of input image. 
	 */
	private float width; 

	
	
	
	public DeepAcousticsResult(double[] ds, float f, float[] scores) {
		this.confidence = (float) ds[0];
		this.y = (float) ds[1];
		this.x = (float) ds[2];
		this.height = (float) ds[3];
		this.width = (float) ds[4];
		this.predicitions = scores;
		
		if (this.predicitions == null || this.predicitions.length == 0) {
			this.predicitions = new float[] {f}; //if no predictions then just return the confidence score
		}
		
		if (this.predicitions.length != scores.length) {
			throw new IllegalArgumentException("Predictions length does not match scores length");
		}
		
		if (this.confidence < 0 || this.confidence > 1) {
			throw new IllegalArgumentException("Confidence must be between 0 and 1");
		}
		
		if (this.height <= 0 || this.width <= 0) {
			throw new IllegalArgumentException("Height and width must be greater than zero");
		}
		
		if (this.y < 0 || this.x < 0) {
			throw new IllegalArgumentException("Y and X coordinates must be non-negative");
		}
	}


	/**
	 * Get the confidence the bounding box contains a call. 
	 * @return confidence score from 0 to 1. 
	 */
	public float getConfidence() {
		return confidence;
	}


	/**
	 * Get the height of the bounding box.
	 * @return height in pixels of the input image. 
	 */
	public float getHeight() {
		return height;
	}


	/**
	 * Get the Top left co-ordinate of bounding box y in pixels of input image. 
	 * @return the top left y location of bounding box in pixels of input image. 
	 */
	public float getY() {
		return y;
	}



	/**
	 * Get the Top left co-ordinate of bounding box x in pixels of input image. 
	 * @return the top left x location of bounding box in pixels of input image. 
	 */
	public float getX() {
		return x;
	}


	/**
	 * Get the (species) class predictions for the bounding box
	 * @return list of different prediciton values from 0-1. 
	 */
	public float[] getPredicitions() {
		return predicitions;
	}


	/**
	 * Get the width of the bounding box.
	 * @return width in pixels of the input image. 
	 */
	public float getWidth() {
		return width;
	}

}
