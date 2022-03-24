package org.jamdev.jdl4pam.genericmodel;


import org.jamdev.jdl4pam.utils.DLUtils;

import ai.djl.ndarray.NDArray;
import ai.djl.ndarray.NDList;
import ai.djl.ndarray.NDManager;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.Batchifier;
import ai.djl.translate.Translator;
import ai.djl.translate.TranslatorContext;

/**
 * The translator for the model. Ensure the input data is compatible for the model and the output  data 
 * is properly organised. 
 * 
 * @author Jamie Macaulay 
 *
 */
public class SpectrogramTranslator implements Translator<float[][][], float[]> {    

	/**
	 * Create the shape 
	 */
	private Shape shape;


	/**
	 * Constructor for the spectrogram translator. The translator is essentially 
	 * @param shape -the shape to set. 
	 */
	public SpectrogramTranslator(Shape shape) {
		this.shape = shape; 
	}
	
	
	@Override
	public NDList processInput(TranslatorContext ctx, float[][][] data) {
		//System.out.println("Hello: 1 " ); 
		NDManager manager = ctx.getNDManager();

		//this is for the soundspot - different models probablu have difference shapes. 
		//Shape shape = new Shape(data.length, 1L, data[0].length, data[0][0].length); 

		//this is for right whale tensorflow classiife.r 
		//this was the shap0e for the right whale classifie.r. 
		//Shape shape = new Shape(data.length, data[0].length, data[0][0].length, 1L); 
		Shape shape; 
		if (this.shape!=null) {
			
			if (this.shape.dimension()==4) {
				//need to the first element to be the number od data frames  Input: [(-1, 40, 40, 1)]
				 shape = new Shape(data.length, this.shape.get(1), this.shape.get(2), this.shape.get(3)); 
			}
			else {
				//might not be a 4 element shape
				 shape = new Shape(data.length, this.shape.get(1), this.shape.get(2)); 
			}
		}
		else {
			//try this shape. 
			 shape = new Shape(data.length, data[0].length, data[0][0].length, 1L); 
		}
		
		//System.out.println("NDArray shape: " + shape); 

		float[] specgramFlat = DLUtils.flattenDoubleArrayF(data); 
		
		NDArray array = manager.create(specgramFlat, shape); 
		
//		NDArray array = manager.create(data); 

		//System.out.println("NDArray size: " + array.size()); 

		return new NDList (array);
	}

	@Override
	public float[]  processOutput(TranslatorContext ctx, NDList list) {
		//System.out.println("Output: " + list.size()); 

		NDArray temp_arr = list.get(0);

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
	public Shape getShape() {
		return shape;
	}

	/**
	 * Set the shape. 
	 * @param the input shape. 
	 */
	public void setShape(Shape shape) {
		this.shape = shape;
	}
};


