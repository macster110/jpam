package org.jamdev.jdl4pam.genericmodel;



import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

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

	//long hop = (long) (3.92*10000L); 

	/**
	 * Create the shape 
	 */
	private Shape shape;

	/**
	 * The shapes associated with the model. 
	 */
	private PairList<String, Shape> shapes;

	private Integer shapeIndex = null; 


	/**
	 * Constructor for the waveform translator. The translator gets the data
	 * into a format ready for the model 
	 * @param shape -the shape to set. 
	 */
	public WaveformTranslator(PairList<String, Shape> shapes) {
		this.shapes = shapes; 		
	}


	@Override
	public NDList processInput(TranslatorContext ctx, float[][] data) {
		//System.out.println("Hello: 1 " ); 
		NDManager manager = ctx.getNDManager();

		//We need to find the index of the shape that is for audio. If there is more than one shape pick the 
		//one the largest number of dimensions unless explicitly set. 
		int shapeAudioIndex = 0; 
		if (this.shapeIndex==null) {
			if (shapes.size()>1){
				int shapeDim = 0; 
				for (int i =0; i<shapes.size(); i++) {
					if (shapes.get(i).getValue().dimension()>shapeDim) {
						shapeDim = shapes.get(i).getValue().dimension();
						shapeAudioIndex = i; 
					}
				}
			}
		}
		else {
			shapeAudioIndex = this.shapeIndex;
		}


		long[] shapeL = new long[shapes.get(shapeAudioIndex).getValue().dimension()]; 

		for (int i=0; i<shapeL.length; i++) {
			shapeL[i] =1L;
		}

		//System.out.println("Shape: " + shapes.get(shapeAudioIndex).getValue() + " " + shapeL.length);

		//two scenarios here with shape - either a model has some shape like (-1, 512) which specifies
		//a stack of waves or a model has a shape of (-1) or say (512) specifying the input is a 1D array. 
		if (shapeL.length>=2) {
			shapeL[0] = data.length;
			shapeL[1] = data[0].length; 
		}
		else {
			//set the input shape as the first waveform. 
			shapeL[0] = data[0].length;
		}

		shape = new Shape(shapeL); 

		float[] specgramFlat = DLUtils.flattenDoubleArrayF(data); 

		NDArray array = manager.create(specgramFlat, shape); 


		//		NDArray array = manager.create(data); 
		//System.out.println("NDArray size: " + array.size() + " " + data[0][0]); 

		ArrayList<NDArray> arrays = new ArrayList<NDArray>();

		//System.out.println("Shape size: " + shapes.size());

		//		//this is a little bit of a weird one 
		//		if (shapes.size()>1) {
		//			NDArray hoparray = manager.create(-1);
		//			arrays.add(hoparray); //add the hop
		//		}

		int n=0; 
		while  (n<shapes.size()) {
			//we cross our fingers here and hope that the extra data are not needed. Otherwise
			//this will have be subclassed. 
			if (n!=shapeAudioIndex) {
				arrays.add(generateExtraData(manager, shapes.get(n).getValue(), n)); //add the hop
			}
			n++; 
		}
		arrays.add(shapeAudioIndex, array); //add the waveform information. 
				
		NDList output = new NDList(arrays); 

		return output;
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


