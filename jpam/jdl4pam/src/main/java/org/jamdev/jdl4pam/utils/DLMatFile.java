package org.jamdev.jdl4pam.utils;

import java.io.File;
import java.io.IOException;

import org.jamdev.jpamutils.spectrogram.SpecTransform;

import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;

/**
 * Some functions to output MATLAB data for testing. 
 * @author Jamie Macaulay
 *
 */
public class DLMatFile {

	/**
	 * Export a specTransform object to a .mat file 
	 * @param specTransfrom - the spectrgram transform. 
	 * @param file .mat file to export to
	 */
	public static void exportSpecSurface(SpecTransform specTransfrom, File file) {
		// Create MAT file with a scalar in a nested struct

		double[][] specData = specTransfrom.getTransformedData(); 
		
		exportSpecArray(specData, specTransfrom.getSpectrgram().getSampleRate(),   file); 
	}
	
	
	/**
	 * Export an 2D array to a .mat file. 
	 * @param array - the array to export.
	 * @param sampleRate - the sample rate
	 * @param file
	 */
	public static void exportSpecArray(double[][] array, float sampleRate,  File file) {
		
	Matrix matrix =  array2Matrix(array);
		
		MatFile matFile = Mat5.newMatFile()
			    .addArray("spectrogram", matrix)
			    .addArray("sample_rate", Mat5.newScalar(sampleRate));

		try {
			Mat5.writeToFile(matFile, file);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	
	
	/**
	 * Get a Matrix object from a double[][] array. 
	 * @param specData - the double[][] array to convert. 
	 * @return the matrix object. 
	 */
	public static Matrix array2Matrix(double[][] arrayD) {
		Matrix matrix = Mat5.newMatrix(arrayD[0].length, arrayD.length);
		for (int i=0; i<arrayD.length; i++) {
			for (int j=0; j<arrayD[0].length; j++) {
				matrix.setDouble(j,i, arrayD[i][j]);
			}
		}
		
		return matrix;
	}
	

	/**
	 * Get a Matrix object from a double[] array. 
	 * @param specData - the double array to convert. 
	 * @return the matrix object. 
	 */
	public static Matrix array2Matrix(double[] arrayD) {
		Matrix matrix = Mat5.newMatrix(arrayD.length, 1);
		for (int i=0; i<arrayD.length; i++) {
			matrix.setDouble(i,0, arrayD[i]);
		}
		
		return matrix;
	}

	/**
	 * Get a Matrix object from a int[] array. 
	 * @param specData - the int array to convert. 
	 * @return the matrix object. 
	 */
	public static Matrix array2Matrix(int[] samplesChunk) {
		Matrix matrix = Mat5.newMatrix(samplesChunk.length, 1);
		for (int i=0; i<samplesChunk.length; i++) {
				matrix.setInt(i,0, samplesChunk[i]);
		}
		
		return matrix;
	}
	

	/**
	 * Get a Matrix object from a short[] array. 
	 * @param specData - the short array to convert. 
	 * @return the matrix object. 
	 */
	public static Matrix array2Matrix(short[] samplesChunk) {
		Matrix matrix = Mat5.newMatrix(samplesChunk.length, 1);
		for (int i=0; i<samplesChunk.length; i++) {
				matrix.setInt(i,0, samplesChunk[i]);
		}
		
		return matrix;
	}
	
	/**
	 * Get a Matrix object from a int[][] array. 
	 * @param specData - the int[][] array to convert. 
	 * @return the matrix object. 
	 */
	public static Matrix array2Matrix(int[][] arrayD) {
		Matrix matrix = Mat5.newMatrix(arrayD[0].length, arrayD.length);
		for (int i=0; i<arrayD.length; i++) {
			for (int j=0; j<arrayD[0].length; j++) {
				matrix.setInt(j,i, arrayD[i][j]);
			}
		}
		
		return matrix;
	}
	


}
