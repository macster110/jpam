package org.jamdev.jdl4pam.deepAcoustics;

import java.util.ArrayList;

public class DeepAcousticResultArray extends ArrayList<DeepAcousticsResult> {

	private static final long serialVersionUID = 1L;
	
	ArrayList<float[]> rawScores = new ArrayList<float[]> ();

	/**
	 * Add raw scores from each set of bounding boxes. 
	 * @param newArr
	 */
	public void addRawScores(float[] newArr) {
		rawScores.add(newArr);
	}

	public ArrayList<float[]> getRawScores() {
		return rawScores;
	}
	
	

}
