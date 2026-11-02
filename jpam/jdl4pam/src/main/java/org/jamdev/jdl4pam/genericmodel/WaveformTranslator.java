package org.jamdev.jdl4pam.genericmodel;



import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jdl4pam.utils.InputShapeException;

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
 * the more common spectrogram images. The input is a batch of waveforms i.e float[batch size][samples]; 
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
	 * The input shape for the waveform from the model metadata. This is used for
	 * models which do not describe their inputs e.g. TorchScript models.
	 */
	private Shape inputShape = null;


	/**
	 * Constructor for the waveform translator. The translator gets the data
	 * into a format ready for the model 
	 * @param shape -the shape to set. 
	 */
	public WaveformTranslator(PairList<String, Shape> shapes) {
		this.shapes = shapes; 		
	}


	/**
	 * Constructor for the waveform translator for a model which does not describe
	 * its inputs, e.g. a TorchScript model, where the input shape is known from
	 * the model metadata.
	 * @param inputShape - the input shape e.g. [-1, 7500] for a batch of waveforms
	 *                   or [7500] for a single waveform.
	 */
	public WaveformTranslator(Shape inputShape) {
		this.inputShape = inputShape;
	}


	@Override
	public NDList processInput(TranslatorContext ctx, float[][] data) {
		NDManager manager = ctx.getNDManager();

		//TorchScript models do not describe their inputs so the shapes can be null.
		boolean hasShapes = shapes != null && shapes.size() > 0;

		//We need to find the index of the shape that is for audio. If there is more than one shape pick the 
		//one the largest number of dimensions unless explicitly set. 
		int shapeAudioIndex = 0; 
		if (hasShapes) {
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
		}

		//the shape described by the model is used if there is one. Otherwise (e.g. TorchScript models) use
		//the input shape from the metadata. Some metadata shapes have extra dimensions which the model does not
		//accept e.g. [-1, 1125, 1, 1] for a model input of [-1, 1125].
		Shape declaredShape = hasShapes ? shapes.get(shapeAudioIndex).getValue() : inputShape;

		float[] specgramFlat = DLUtils.flattenDoubleArrayF(data); 
		long[] dataShape = new long[] {data[0].length};

		//two scenarios here with shape - either a model has some shape like (-1, 512) which specifies
		//a stack of waves or a model has a shape of (-1) or say (512) specifying the input is a 1D array. 
		if (declaredShape == null) {
			//no shape information - assume a batch of waveforms. 
			shape = new Shape(data.length, data[0].length);
		}
		else if (declaredShape.dimension() == 1) {
			//a single waveform
			if (data.length != 1 || (declaredShape.get(0) > 0 && declaredShape.get(0) != data[0].length)) {
				throw new InputShapeException(String.format("The input data do not match the model input shape. "
						+ "The model expects a single waveform of shape %s but there are %d waveform(s) of %d samples.",
						declaredShape, data.length, data[0].length));
			}
			shape = new Shape(data[0].length);
		}
		else {
			//a batch of waveforms - throws an exception if the data do not fit the model input shape
			shape = DLUtils.batchShape(declaredShape, data.length, dataShape, specgramFlat.length);
		}

		NDArray array = manager.create(specgramFlat, shape); 

		ArrayList<NDArray> arrays = new ArrayList<NDArray>();

		if (hasShapes) {
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
		}
		else {
			arrays.add(array);
		}

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
	 * Get the input shape for the waveform from the model metadata.
	 * @return the input shape or null.
	 */
	public Shape getInputShape() {
		return inputShape;
	}

	/**
	 * Set the input shape for the waveform e.g. from the model metadata. This is
	 * used if the model does not describe its inputs e.g. TorchScript models.
	 * Otherwise the shape described by the model is used.
	 * @param inputShape - the input shape e.g. [-1, 7500].
	 */
	public void setInputShape(Shape inputShape) {
		this.inputShape = inputShape;
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


