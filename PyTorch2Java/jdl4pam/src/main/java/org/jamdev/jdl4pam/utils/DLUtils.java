package org.jamdev.jdl4pam.utils;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jpamutils.wavFiles.AudioData;
import org.jamdev.jpamutils.wavFiles.WavFile;


/**
 * Contains useful functions. 
 * 
 * @author Jamie Macaulay 
 *
 */
public class DLUtils {


	/**
	 * Make a dummy spectrogram for testing. Filled with random values.  
	 * @param len - the length of the spectrogram in bins. 
	 * @param height - the height of the spectrgram in bins. 
	 * @return a dummy spectrogram with random values. 
	 */
	public static float[][] makeDummySpectrogram(int len, int len2){

		//		int len = 256; 
		//		int len2 = 128; 

		float[][] specDummy = new float[len][len2]; 

		Random rand = new Random(); 
		for (int i=0; i<len; i++){
			for (int j=0; j<len2; j++) {
				specDummy[i][j] = 2F*(rand.nextFloat()-0.5F);

				if (specDummy[i][j]>1) {
					specDummy[i][j]=1F;
				}
				if (specDummy[i][j]<0) {
					specDummy[i][j]=0F;
				}
			}
		}
		return specDummy; 
	}


	/** 
	 * Convert an arbitrary-dimensional rectangular double array to flat vector.<br>
	 * Can pass double[], double[][], double[][][], etc.
	 */
	public static double[] flattenDoubleArray(Object doubleArray) {
		if (doubleArray instanceof double[])
			return (double[]) doubleArray;

		LinkedList<Object> stack = new LinkedList<>();
		stack.push(doubleArray);

		int[] shape = arrayShape(doubleArray);
		int length = prod(shape);
		double[] flat = new double[length];
		int count = 0;

		while (!stack.isEmpty()) {
			Object current = stack.pop();
			if (current instanceof double[]) {
				double[] arr = (double[]) current;
				for (int i = 0; i < arr.length; i++)
					flat[count++] = arr[i];
			} else if (current instanceof Object[]) {
				Object[] o = (Object[]) current;
				for (int i = o.length - 1; i >= 0; i--)
					stack.push(o[i]);
			} else
				throw new IllegalArgumentException("Base array is not double[]");
		}

		if (count != flat.length)
			throw new IllegalArgumentException("Fewer elements than expected. Array is ragged?");
		return flat;
	}



	/** 
	 * Convert an arbitrary-dimensional rectangular double array to flat vector.<br>
	 * Can pass double[], double[][], double[][][], etc.
	 */
	public static float[] flattenDoubleArrayF(Object floatArray) {
		if (floatArray instanceof float[])
			return (float[]) floatArray;

		LinkedList<Object> stack = new LinkedList<>();
		stack.push(floatArray);

		int[] shape = arrayShape(floatArray);
		int length = prod(shape);
		float[] flat = new float[length];
		int count = 0;

		while (!stack.isEmpty()) {
			Object current = stack.pop();
			if (current instanceof float[]) {
				float[] arr = (float[]) current;
				for (int i = 0; i < arr.length; i++)
					flat[count++] = arr[i];
			} else if (current instanceof Object[]) {
				Object[] o = (Object[]) current;
				for (int i = o.length - 1; i >= 0; i--)
					stack.push(o[i]);
			} else
				throw new IllegalArgumentException("Base array is not float[]");
		}

		if (count != flat.length)
			throw new IllegalArgumentException("Fewer elements than expected. Array is ragged?");
		return flat;
	}


	/** Calculate the shape of an arbitrary multi-dimensional array. Assumes:<br>
	 * (a) array is rectangular (not ragged) and first elements (i.e., array[0][0][0]...) are non-null <br>
	 * (b) First elements have > 0 length. So array[0].length > 0, array[0][0].length > 0, etc.<br>
	 * Can pass any Java array opType: double[], Object[][][], float[][], etc.<br>
	 * Length of returned array is number of dimensions; returned[i] is size of ith dimension.
	 */
	public static int[] arrayShape(Object array) {
		int nDimensions = 0;
		Class<?> c = array.getClass().getComponentType();
		while (c != null) {
			nDimensions++;
			c = c.getComponentType();
		}


		int[] shape = new int[nDimensions];
		Object current = array;
		for (int i = 0; i < shape.length - 1; i++) {
			shape[i] = ((Object[]) current).length;
			current = ((Object[]) current)[0];
		}

		if (current instanceof Object[]) {
			shape[shape.length - 1] = ((Object[]) current).length;
		} else if (current instanceof double[]) {
			shape[shape.length - 1] = ((double[]) current).length;
		} else if (current instanceof float[]) {
			shape[shape.length - 1] = ((float[]) current).length;
		} else if (current instanceof long[]) {
			shape[shape.length - 1] = ((long[]) current).length;
		} else if (current instanceof int[]) {
			shape[shape.length - 1] = ((int[]) current).length;
		} else if (current instanceof byte[]) {
			shape[shape.length - 1] = ((byte[]) current).length;
		} else if (current instanceof char[]) {
			shape[shape.length - 1] = ((char[]) current).length;
		} else if (current instanceof boolean[]) {
			shape[shape.length - 1] = ((boolean[]) current).length;
		} else if (current instanceof short[]) {
			shape[shape.length - 1] = ((short[]) current).length;
		} else
			throw new IllegalStateException("Unknown array opType"); //Should never happen
		return shape;
	}

	/**
	 * Create a float array from a double array
	 * @param arr - the input double array	
	 * @return corresponding float array 
	 */
	public static float[] toFloatArray(double[] arr) {
		if (arr == null) return null;
		int n = arr.length;
		float[] ret = new float[n];
		for (int i = 0; i < n; i++) {
			ret[i] = (float)arr[i];
		}
		return ret;
	}


	/**
	 * Create a double array from a float array
	 * @param arr - the input float array	
	 * @return corresponding float array 
	 */
	public static double [] toDoubleArray(float[] arr) {
		if (arr == null) return null;
		int n = arr.length;
		double[] ret = new double[n];
		for (int i = 0; i < n; i++) {
			ret[i] = arr[i];
		}
		return ret;
	}

	/**
	 * Create a float array from a double array
	 * @param arr - the input double array	
	 * @return corresponding float array 
	 */
	public static float[][] toFloatArray(double[][] arr) {
		if (arr == null) return null;
		int n = arr.length;
		int nn = arr[0].length;

		float[][] ret = new float[n][nn];
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < nn; j++) {
				ret[i][j] = (float)arr[i][j];
			}
		}
		return ret;
	}


	/**
	 * Create a double array from a float array
	 * @param arr - the input float array	
	 * @return corresponding float array 
	 */
	public static double[][] toFloatArray(float[][] arr) {
		if (arr == null) return null;
		int n = arr.length;
		int nn = arr[0].length;

		double[][] ret = new double[n][nn];
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < nn; j++) {
				ret[i][j] = arr[i][j];
			}
		}
		return ret;
	}

	/**
	 * Product of an int array
	 * @param mult the elements
	 *            to calculate the sum for
	 * @return the product of this array
	 */
	public static int prod(List<Integer> mult) {
		if (mult.size() < 1)
			return 0;
		int ret = 1;
		for (int i = 0; i < mult.size(); i++)
			ret *= mult.get(i);
		return ret;
	}

	/**
	 * Product of an int array
	 * @param mult the elements
	 *            to calculate the sum for
	 * @return the product of this array
	 */
	public static int prod(int... mult) {
		if (mult.length < 1)
			return 0;
		int ret = 1;
		for (int i = 0; i < mult.length; i++)
			ret *= mult[i];
		return ret;
	}

	/**
	 * Print all elements in a 2D double[][] array. 
	 * @param array - the array to print. 
	 */
	public static void printArray(double[][] array) {
		for (int j=0; j<array.length; j++) {
			System.out.println("");
			for (int i=0; i<array[j].length; i++) {
				System.out.print(array[j][i] + " : ");
			}
		}
		System.out.println("");
	}

	/**
	 * Print all elements in a 2D int[][] array. 
	 * @param array - the array to print. 
	 */
	public static void printArray(int[][] array) {
		for (int j=0; j<array.length; j++) {
			System.out.println("");
			for (int i=0; i<array[j].length; i++) {
				System.out.print(array[j][i] + " : ");
			}
		}
		System.out.println("");
	}
	
	/**
	 * Print all elements float[] array. 
	 * @param results - the array to print
	 */
	public static void printArray(float[] array) {
		for (int j=0; j<array.length; j++) {
			System.out.print(array[j]+ " : ");
		}
		System.out.println("");
	}


	/**
	 * Softmax function for float values. 
	 * @param input - the input value. 
	 * @param neuronValuesF - the input vector.
	 * @return the calculated softmax value. 
	 */
	public static double softmax(float input, float[] neuronValuesF) {
		double[] neuronValues = DLUtils.toDoubleArray(neuronValuesF); 
		double total = Arrays.stream(neuronValues).map(Math::exp).sum();
		return Math.exp(input) / total;
	}

	public static double softmax(double input, double[] neuronValues) {
		double total = Arrays.stream(neuronValues).map(Math::exp).sum();
		return Math.exp(input) / total;
	}


	/*
	 * Load a wav file. 
	 */
	public static AudioData loadWavFile(String path) throws IOException, UnsupportedAudioFileException {
		// reads the first 44 bytes for header
		WavFile wavFile = new  WavFile(new File(path));
		AudioFormat format = wavFile.getAudioFileFormat().getFormat(); 

		int channels = format.getChannels(); 

		// load data
		AudioInputStream inputStream  = wavFile.getAudioInputStream(); 

		//first downsample
		//now downsample the data if need bed 
		byte[] data;

		data = new byte[inputStream.available()];
		inputStream.read(data);	  
		//		}

		if (channels==1) {
			//no need to do anything else. 

		}
		else {
			//extract single channel data 
			data = WavFile.getSingleChannelByte(format, data,  0); 
		}

		int[] samples = WavFile.getSampleAmplitudes(format, data);

		int sampleRate = (int) format.getSampleRate();

		return new AudioData(samples, sampleRate); 

	}

}
