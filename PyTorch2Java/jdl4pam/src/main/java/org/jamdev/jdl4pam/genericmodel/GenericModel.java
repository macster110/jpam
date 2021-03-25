package org.jamdev.jdl4pam.genericmodel;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.apache.commons.io.FilenameUtils;
import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.engine.Engine;
import ai.djl.inference.Predictor;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.TranslateException;


/**
 * The generic model. 
 * 
 * @author Jamie Macaulay
 *
 */
public class GenericModel {


	/**
	 * The currently loaded model 
	 */
	private Model model;

	/**
	 * The predictor for the model. 
	 */
	Predictor<float[][][], float[]> predictor;

	/**
	 * The input shape from the loaded model. 
	 */
	private Shape inputShape = null; 

	/**
	 * The output shape from the model. 
	 */
	private Shape outShape = null; 


	private SpectrogramTranslator translator; 


	public GenericModel(String modelPath) throws MalformedModelException, IOException{

		File file = new File(modelPath); 

		//String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/bats_denmark/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000_JAMIE.pk"; 

		Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
		String modelName = file.getName(); 

		String extension = FilenameUtils.getExtension(file.getAbsolutePath());

		System.out.println("Generic Model: Available engines: " + Engine.getAllEngines()); 


		Model model; 
		switch  (extension) {
		case "pb":
			model = Model.newInstance(modelPath, "TensorFlow"); 
			model.load(modelDir, "saved_model.pb");
			break; 
		case "py":
			model = Model.newInstance(modelName);
			model.load(modelDir, modelName);
			break; 
		default:
			//will try to load a model automatically - problematic but let's see. 
			model = Model.newInstance(modelPath); 
			break;
		}

		if (model == null) {
			System.err.println("Generic Model: Could not load model: " + modelPath);
		}

		else {
			if (model!=null && model.describeInput()!=null) {
				System.out.println("Generic Model: Input: " + model.describeInput().get(0).getValue()); 
				inputShape =  model.describeInput().get(0).getValue();
			}
			if (model!=null && model.describeOutput()!=null) {
				System.out.println("Generic Model: Output: " + model.describeOutput().get(0).getValue()); 
				outShape = model.describeOutput().get(0).getValue();
			}

			translator = new SpectrogramTranslator(inputShape); 

			//predictor for the model
			predictor = model.newPredictor(translator);
		}

	}

	/**
	 * Get the model shape for the input. 
	 * @return the input shape. 
	 */
	public Shape getInputShape() {
		return inputShape;
	}

	/**
	 * Set the input shape. 
	 * @param inputShape - the input shape. 
	 */
	public void setInputShape(Shape inputShape) {
		this.inputShape = inputShape;
		translator.setShape(inputShape);
	}

	/**
	 * Get the output shape. The shape is null if the model does not specify shape. 
	 * @return the output shape. 
	 */
	public Shape getOutShape() {
		return outShape;
	}


	/**
	 * Run the model.
	 * @param specImage - the spectrogram image
	 * @return the results 
	 */
	public float[] runModel(float[][][] specImage) {
		try {
			float[] results  = predictor.predict(specImage);
			//DLUtils.printArray(results);
			return results; 
		} catch (TranslateException e) {
			System.out.println("Error on model: "); 
			e.printStackTrace();
		}
		return null;
	}





}
