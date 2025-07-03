package org.jamdev.jdl4pam.deepAcoustics;

import java.util.ArrayList;

/**
 * A list of DeepAcousticsResult objects (i.e. a description of bounding boxes) that also stores the image height and width
 * that the bounding boxes are referenced to. 
 * <p>
 * This is used to store the results of a deep learning model for acoustic detection.
 * 
 * @author Jamie Macaulay
 */
public class DeepAcousticResultArray extends ArrayList<DeepAcousticsResult> {

	private static final long serialVersionUID = 1L;
	
	/**
	 * The image height
	 */
	private int imHeight;

	/**
	 * The image width.
	 */
	private int imWidth;

	public void setImageHeight(int height) {
		this.imHeight = height;
		
	}
	
	public void setImageWidth(int width) {
		this.imWidth = width;
	}
	
	/**
	 * Get the image height that the bounding boxes are referenced to. 
	 * @return the image height
	 */
	public int getImHeight() {
		return imHeight;
	}

	/**
	 * Get the image width that the bounding boxes are referenced to. 
	 * @return the image width
	 */
	public int getImWidth() {
		return imWidth;
	}


}
