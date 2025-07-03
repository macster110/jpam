package org.jamdev.jdl4pam.deepAcoustics;


import java.util.ArrayList;
import java.util.List;

import org.jamdev.jdl4pam.deepAcoustics.Pred2BoxDJL3.DeepAcousticsNetwork;
import org.jamdev.jdl4pam.deepAcoustics.Pred2BoxDJL3.YoloPostProcessorResult;
import org.jamdev.jdl4pam.utils.DLUtils;

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
public class DeepAcousticsTranslator implements Translator<float[][][][], List<DeepAcousticResultArray>> {


	/**
	 * Create the shape 
	 */
	private DeepAcousticsNetwork network;


	private float thresh = 0.01f;  //default threshold for bounding boxes.


	/**
	 * Constructor for the spectrogram translator. The translator is essentially 
	 * @param shape -the shape to set. 
	 */
	public DeepAcousticsTranslator(DeepAcousticsNetwork shape) {
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
	public List<DeepAcousticResultArray>  processOutput(TranslatorContext ctx, NDList list) {

		//System.out.println("List size: " + list.size()); 
		
		//each result is a bounding box array for one spectrogram segment.
		// Multiple segments can be processed at once, so we return an ArrayList of DeepAcousticResultArray objects.
		ArrayList<DeepAcousticResultArray> results = new ArrayList<DeepAcousticResultArray>();

		DeepAcousticResultArray boundingBoxes;
	
		YoloPostProcessorResult result; 
		
		long nResults = list.get(0).getShape().get(0);
		
		for (int i=0; i<nResults; i++) {			
			result = Pred2BoxDJL3.yoloPostProcess(
					 ctx.getNDManager(), // Parent manager
					 list,    // Input as NDList
			         network, thresh, i);
			
			if (result==null || result.bboxes == null || result.bboxes.length == 0) {
				System.out.println("No bounding boxes found");
				results.add(new DeepAcousticResultArray());
				continue;
			}
			
			boundingBoxes = new DeepAcousticResultArray(); 
			boundingBoxes.setImageHeight((int) this.network.imShape.get(1));
			boundingBoxes.setImageWidth((int) this.network.imShape.get(2));

			DeepAcousticsResult dAResult;
			for (int j=0; j<result.bboxes.length; j++) {
				//System.out.println("Result: " + result.bboxes[i].getShape()); 
				dAResult = new DeepAcousticsResult(result.bboxes[j], result.scores[j], result.classes[j]);
				boundingBoxes.add(dAResult);
			}
			
			results.add(boundingBoxes);
			
		}
		 
//		System.out.println("Result: " + result.bboxes.length + " bounding boxes found");
//		
//		for (int i=0; i<result.bboxes.length; i++) {
//			//System.out.println("Result: " + result.bboxes[i].getShape()); 
//			System.out.println("Result: boxes: " +  i);
//			JamArr.printArray(result.bboxes[i]);
//			System.out.println("	 " );
//			
//			System.out.println("Result: Confidence: " +  i);
//			JamArr.printArray(result.scores);
//			System.out.println("	 " );
//			
//			System.out.println("Result: classes: " +  i);
//			JamArr.printArray(result.classes[i]);
//			System.out.println("	 " );
//		}
		//System.out.println("Result: " + result.getBoundingBoxes().get(0).getShape());

		//Now we need to convert the result to a bounding box array.
		
		return results; 
	}


	public float getThresh() {
		return thresh;
	}


	public void setThresh(float thresh) {
		this.thresh = thresh;
	}


	@Override
	public Batchifier getBatchifier() {
		// The Batchifier describes how to combine a batch together
		// Stacking, the most common batchifier, takes N [X1, X2, ...] arrays to a single [N, X1, X2, ...] array
		
		//This must be null for the DeepAcousticsTranslator
		return null;
	}


	/**
	 * Get the default input shape. 
	 * @return the default input shape. 
	 */
	public DeepAcousticsNetwork getNetwrok() {
		return network;
	}

}
