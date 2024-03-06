package org.jamdev.jdl4pam.deepAcoustics;

import java.util.Arrays;

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
	 * Create a deep acoustics results form the raw output from the model. 
	 * @param result
	 */
	public DeepAcousticsResult(float[] result){
		confidence =  result[0];
		x =  result[1];
		y =  result[2];
		width = result[3];
		height =  result[4];
		predicitions = Arrays.copyOfRange(result, 5, (int) result.length-1);
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
