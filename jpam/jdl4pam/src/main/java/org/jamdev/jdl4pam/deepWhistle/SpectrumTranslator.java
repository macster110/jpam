package org.jamdev.jdl4pam.deepWhistle;

import java.util.ArrayList;

import org.jamdev.jdl4pam.utils.DLUtils;

import ai.djl.ndarray.NDArray;
import ai.djl.ndarray.NDList;
import ai.djl.ndarray.NDManager;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.Batchifier;
import ai.djl.translate.Translator;
import ai.djl.translate.TranslatorContext;

/**
 * Translator to convert a spectrum into the format required for a deep
 */
public class SpectrumTranslator  implements Translator<float[][], float[]> {       

	//long hop = (long) (3.92*10000L); 

	/**
	 * Create the input shape 
	 */
	private Shape inputShape;
	
	/**
	 * Create the output shape
	 */
	private Shape outputShape;


	/**
	 * Constructor for the waveform translator. The translator gets the data
	 * into a format ready for the model 
	 * @param shape -the shape to set. 
	 */
	public SpectrumTranslator(Shape inputShape, Shape outputShape) {
		this.inputShape = inputShape; 
		this.outputShape = outputShape; 		

	}


	@Override
	public NDList processInput(TranslatorContext ctx, float[][] data) {
		//System.out.println("Hello: 1 " ); 
		NDManager manager = ctx.getNDManager();

		float[] specgramFlat = DLUtils.flattenDoubleArrayF(data); 

		NDArray array = manager.create(specgramFlat, inputShape); 
		//array.setName("input.1"); //need this for ONXX model

		//		NDArray array = manager.create(data); 
		//System.out.println("NDArray size: " + array.size() + " " + data[0][0]); 

		ArrayList<NDArray> arrays = new ArrayList<NDArray>();
				
		NDList input = new NDList(arrays); 
		input.add(array);

		return input;
	}


	/**
	 * Add non-audio data to the output data list. Note this is intended to be subclassed for more complex models. 
	 * @param shapeIndex - the index of the input shape. 
	 * @return the data. 
	 */
	public NDArray generateExtraData(NDManager manager , Shape shape, int index) {
//		System.out.println("Shape: " +  shape); 
		return manager.create(1000L); //add the hop for Google model by default. This is just a scaler. 

	}

	@Override
	public float[]  processOutput(TranslatorContext ctx, NDList list) {

		NDArray temp_arr = list.get(0);

		//System.out.println("Output2: " + list); 


		//System.out.println("Output3: " + list.get(0).getFloat(0)); 

		Number[] number = temp_arr.toArray(); 

		float[] results = new float[number.length]; 
		for (int i=0; i<number.length; i++) {
			results[i] = number[i].floatValue(); 
		}

		//System.out.println("results: " + results.length); 

		return results; 
	}

	@Override
	public Batchifier getBatchifier() {
		// The Batchifier describes how to combine a batch together
		// Stacking, the most common batchifier, takes N [X1, X2, ...] arrays to a single [N, X1, X2, ...] array
		return null;
	}


	/**
	 * Get the default input shape. 
	 * @return the default input shape. 
	 */
	public Shape getInputShape() {
		return inputShape;
	}

	/**
	 * Set the shape. 
	 * @param the input shape. 
	 */
	public void setInputShape(Shape inputShape) {
		this.inputShape = inputShape;
	}


};



