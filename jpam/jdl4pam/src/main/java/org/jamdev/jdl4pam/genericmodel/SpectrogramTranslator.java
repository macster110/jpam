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
 * The translator for generic image based models. Note that bespoke version of this are 
 * used for some frameowrks. 
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
	 * The audio shape index
	 */
	private Integer shapeIndex;


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
				//need to the first element to be the number of data frames  Input: [(-1, 40, 40, 1)]
				 shape = new Shape(data.length, this.shape.get(1), this.shape.get(2), this.shape.get(3)); 
			}
			else {
				//might not be a 4 element shape
				 shape = new Shape(data.length, this.shape.get(1), this.shape.get(2)); 
			}
		}
		else {
			//try this shape just for a punt.
			 shape = new Shape(data.length, data[0].length, data[0][0].length, 1L); 
		}
		
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
	
	/**
	 * Get the audio shape index. This can be null in which case the shape with the largest
	 * dimensions will be assumed to be the input data. Note that often only one input shape 
	 * is retrieved from the model in which case this index is redundant. 
	 * @param shapeIndex - the shape index. 
	 */
	public Integer getAudioShapeIndex() {
		return shapeIndex;
	}


	/**
	 * Set the audio shape index.  This can be null in which case the shape with the largest
	 * dimensions will be assumed to be the input data.  Note that often only one input shape 
	 * is retrieved from the model in which case this index is redundant. 
	 * @param shapeIndex - the shape index. 
	 */
	public void setAudioShapeIndex(Integer shapeIndex) {
		this.shapeIndex = shapeIndex;
	}
};


