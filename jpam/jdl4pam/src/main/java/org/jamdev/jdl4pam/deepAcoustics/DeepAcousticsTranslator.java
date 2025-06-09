package org.jamdev.jdl4pam.deepAcoustics;


import org.jamdev.jdl4pam.deepAcoustics.Pred2BoxDJL3.Network;
import org.jamdev.jdl4pam.deepAcoustics.Pred2BoxDJL3.YoloPostProcessorResult;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.JamArr;

import ai.djl.ndarray.NDArray;
import ai.djl.ndarray.NDList;
import ai.djl.ndarray.NDManager;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.Batchifier;
import ai.djl.translate.Translator;
import ai.djl.translate.TranslatorContext;

/**
 * Special translator for DeepAcoustics models because they have quite a different input and output compared to
 * most deep learning models for acoustics. 
 * <p>
 * For example. the input and output shapes are Input: [(-1, 160, 160, 3)]
 *	Output: [(-1, 20, 20, 6), (-1, 10, 10, 6), (-1, 5, 5, 6)]
 * <p>
 * @author Jamie Macaulay
 */
public class DeepAcousticsTranslator implements Translator<float[][][][], DeepAcousticResultArray> {


	/**
	 * Create the shape 
	 */
	private Network network;

	/**
	 * The audio shape index
	 */
	private Integer shapeIndex;


	/**
	 * Constructor for the spectrogram translator. The translator is essentially 
	 * @param shape -the shape to set. 
	 */
	public DeepAcousticsTranslator(Network shape) {
		this.network = shape; 
	}


	@Override
	public NDList processInput(TranslatorContext ctx, float[][][][] data) {
		//System.out.println("Hello: 1 " ); 
		NDManager manager = ctx.getNDManager();

		//this is for the soundspot - different models probably have difference shapes. 
		//Shape shape = new Shape(data.length, 1L, data[0].length, data[0][0].length); 

		//this is for right whale tensorflow classiife.r 
		//this was the shap0e for the right whale classifie.r. 
		//Shape shape = new Shape(data.length, data[0].length, data[0][0].length, 1L); 
		Shape shape; 

		shape = new Shape(data.length, this.network.imShape.get(1), this.network.imShape.get(2), this.network.imShape.get(3)); 

		//need to the first element to be the number of data frames  Input: [(-1, 40, 40, 1)]

		float[] specgramFlat = DLUtils.flattenDoubleArrayF(data); 
		
		//System.out.println("Input shape " + shape);

		NDArray array = manager.create(specgramFlat, shape); 

		return new NDList (array);
	}

	@Override
	public DeepAcousticResultArray  processOutput(TranslatorContext ctx, NDList list) {

		//System.out.println("Output: " + list.size()); 
		DeepAcousticResultArray boundingBoxes= new DeepAcousticResultArray(); 
	
		
		 YoloPostProcessorResult result  = Pred2BoxDJL3.yoloPostProcess(
				 ctx.getNDManager(), // Parent manager
				 list,    // Input as NDList
		         network);
		
		System.out.println("Result: " + result.bboxes.length + " bounding boxes found");
		
		for (int i=0; i<result.bboxes.length; i++) {
			//System.out.println("Result: " + result.bboxes[i].getShape()); 
			System.out.println("Result: boxes: " +  i);
			JamArr.printArray(result.bboxes[i]);
			System.out.println("	 " );
			
			System.out.println("Result: Confidence: " +  i);
			JamArr.printArray(result.scores);
			System.out.println("	 " );
			
			System.out.println("Result: classes: " +  i);
			JamArr.printArray(result.classes);
			System.out.println("	 " );
		}
		//System.out.println("Result: " + result.getBoundingBoxes().get(0).getShape());

		//Now we need to convert the result to a bounding box array.
		
		if (result==null || result.bboxes == null || result.bboxes.length == 0) {
			System.out.println("No bounding boxes found");
			return boundingBoxes; 
		}
		
//		DeepAcousticsResult dAResult;
//		for (int i=0; i<result.bboxes.length; i++) {
//			//System.out.println("Result: " + result.bboxes[i].getShape()); 
//			dAResult = new DeepAcousticsResult(result.bboxes[i], result.classes[i], result.scores);
//			
//		
//			boundingBoxes.add(result);
//		}
		

		return boundingBoxes; 
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
	public Network getNetwrok() {
		return network;
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

}
