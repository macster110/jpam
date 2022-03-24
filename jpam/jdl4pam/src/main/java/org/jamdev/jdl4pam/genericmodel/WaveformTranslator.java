package org.jamdev.jdl4pam.genericmodel;



import java.util.ArrayList;

import org.jamdev.jdl4pam.utils.DLUtils;

import ai.djl.ndarray.NDArray;
import ai.djl.ndarray.NDList;
import ai.djl.ndarray.NDManager;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.Batchifier;
import ai.djl.translate.Translator;
import ai.djl.translate.TranslatorContext;
import ai.djl.util.PairList;

/**
 * The translator for the model. Ensure the input data is compatible for the model and the output  data 
 * is properly organised. This translator is specifically for models which accept raw waveforms rather than
 * the more common spectrogram images. The input is a batch of waveforms i.e float[batch size][no. samples]; 
 * 
 * @author Jamie Macaulay 
 *
 */
public class WaveformTranslator implements Translator<float[][], float[]> {    
	
	long hop = (long) (3.92*10000L); 

	/**
	 * Create the shape 
	 */
	private Shape shape;

	/**
	 * The shapes associated with the model. 
	 */
	private PairList<String, Shape> shapes;
	
	/**
	 * Constructor for the waveform translator. The translator is essentially gets the data
	 * into a format ready for the mdoel 
	 * @param shape -the shape to set. 
	 */
	public WaveformTranslator(PairList<String, Shape> shapes) {
		this.shapes = shapes; 
	}
	


	/**
	 * Constructor for the waveform translator. The translator is essentially 
	 * @param shape -the shape to set. 
	 */
	public WaveformTranslator(PairList<String, Shape> shapes, long hop) {
		this.shapes = shapes; 
		this.hop=hop; 
	}
	
	
	@Override
	public NDList processInput(TranslatorContext ctx, float[][] data) {
		//System.out.println("Hello: 1 " ); 
		NDManager manager = ctx.getNDManager();

		
		Shape shape; 
		
		//this is the most liekly shape of waveform information but this may need to be changed in the future. 
		shape = new Shape(data.length, data[0].length, 1L); 
	
		
		//System.out.println("NDArray shape: " + shape); 

		float[] specgramFlat = DLUtils.flattenDoubleArrayF(data); 
		
		NDArray array = manager.create(specgramFlat, shape); 
		
		NDArray hoparray = manager.create(hop);

//		NDArray array = manager.create(data); 
		//System.out.println("NDArray size: " + array.size()); 
		
		ArrayList<NDArray> arrays = new ArrayList<NDArray>();
		
		//System.out.println("Shape size: " + shapes.size());
		
		if (shapes.size()>1) {
			arrays.add(hoparray); //add the hop
		}
		arrays.add(array); //add the waveform information. 
		
		//System.out.println("NDArray size: " + dummy.size()); 
		//System.out.println("NDArray size: " + arrays.size()); 

		return new NDList (arrays);
	}

	@Override
	public float[]  processOutput(TranslatorContext ctx, NDList list) {
		//System.out.println("Output: " + list.size()); 

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


	public double[] getWaveform() {
		// TODO Auto-generated method stub
		return null;
	}
};


