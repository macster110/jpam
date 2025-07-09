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
	
	/**
	 * Calculate the bounding box start time in milliseconds based on the segment start time, segment duration, and the bounding box. 
	 * @param segStart - the start time of the segment in millis.
	 * @param segDurationMillis - the duration of the segment in millis.
	 * @param deepAcousticsResult - the DeepAcousticsResult object containing the bounding box information.
	 * 
	 * @param deepAcousticsResult
	 */
	public long calcBoundingBoxMillis(long segStart, double segDurationMillis, DeepAcousticsResult deepAcousticsResult) {
		 //calculate the bounding box time in milliseconds
		long startTime = (long) (segStart + (deepAcousticsResult.getX() / imWidth) * segDurationMillis);
		
		return startTime;
	}
	
	/**
	 * Calculate the bounding box start time in samples based on the segment start time, segment duration, and the bounding box. 
	 * @param segStartSamples - the start time of the segment in samples.
	 * @param segDurationSamples - the duration of the segment in samples.
	 * @param deepAcousticsResult - the DeepAcousticsResult object containing the bounding box information.
	 * @return the start time in samples
	 */
	public long calcBoundingBoxSampleStart(long segStartSamples, double segDurationSamples, DeepAcousticsResult deepAcousticsResult) {
		 //calculate the bounding box time in milliseconds
		long startSamples = (long) (segStartSamples + (deepAcousticsResult.getX() / imWidth) * segDurationSamples);
		
		return startSamples;
	}


}
