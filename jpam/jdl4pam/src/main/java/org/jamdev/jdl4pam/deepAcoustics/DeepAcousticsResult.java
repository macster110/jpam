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

	
	
	/**
	 * Constructor for the DeepAcousticsResult. 
	 * @param boundingBox - the bounding box in the format [x, y width, height] in pixels of input image. 
	 * @param confidence - the confidence score from 0 to 1. 
	 * @param classes - the predictions for different species in the bounding box. 
	 */
	public DeepAcousticsResult(double[] boundingBox, float confidence, float[] classes) {
		
		this.confidence = confidence;
		this.x = (float) boundingBox[0];
		this.y = (float) boundingBox[1];
		this.width = (float) boundingBox[2];
		this.height = (float) boundingBox[3];
		this.predicitions = classes;
		
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

	/**
	 * Convenience function for the bounding box in the format [x, y, width, height] in pixels of input image. 
	 * 
	 * Preferably, use the individual getters for x, y, width and height.
	 * 
	 * @return the bounding box as a double array
	 */
	public double[] getBoundingBox() {
		return new double[] {x,y,width,height};
	}

}
