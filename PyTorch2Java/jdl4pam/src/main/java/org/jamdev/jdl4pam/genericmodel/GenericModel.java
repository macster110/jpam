package org.jamdev.jdl4pam.genericmodel;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.jamdev.jdl4pam.utils.DLUtils;

import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.inference.Predictor;
import ai.djl.ndarray.NDArray;
import ai.djl.ndarray.NDList;
import ai.djl.ndarray.NDManager;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.Batchifier;
import ai.djl.translate.TranslateException;
import ai.djl.translate.Translator;
import ai.djl.translate.TranslatorContext;


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
	Predictor<float[][], float[]> predictor; 


	public GenericModel(String modelPath) throws MalformedModelException, IOException{

		File file = new File(modelPath); 

		//String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/bats_denmark/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000_JAMIE.pk"; 

		Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
		String modelName = file.getName(); 

		SpectrogramTranslator translator = new SpectrogramTranslator(); 

		model = Model.newInstance(modelName);

		model.load(modelDir, modelName);

		//predictor for the model
		predictor = model.newPredictor(translator);

	}

	/**
	 * Run the model.
	 * @param specImage - the spectrogram image
	 * @return the results 
	 */
	public float[] runModel(float[][] specImage) {
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


	/**
	 * The translator for the model. Ensure the input data is compatible for the model and the output  data 
	 * is properly organised. 
	 * 
	 * @author Jamie Macaulay 
	 *
	 */
	public class SpectrogramTranslator implements Translator<float[][], float[]> {    

		@Override
		public NDList processInput(TranslatorContext ctx, float[][] data) {
			//System.out.println("Hello: 1 " ); 
			NDManager manager = ctx.getNDManager();

			Shape shape = new Shape(1L, data.length, data[0].length); 

			float[] specgramFlat = DLUtils.flattenDoubleArrayF(data); 

			NDArray array = manager.create(specgramFlat, shape); 

			//System.out.println("Hello: 1a " ); 

			return new NDList (array);
		}

		@Override
		public float[] processOutput(TranslatorContext ctx, NDList list) {
			//System.out.println("Hello: 2 " + list); 

			NDArray temp_arr = list.get(0);

			Number[] number = temp_arr.toArray(); 

			float[] results = new float[number.length]; 
			for (int i=0; i<number.length; i++) {
				results[i] = number[i].floatValue(); 
			}

			return results; 
		}

		@Override
		public Batchifier getBatchifier() {
			// The Batchifier describes how to combine a batch together
			// Stacking, the most common batchifier, takes N [X1, X2, ...] arrays to a single [N, X1, X2, ...] array
			return Batchifier.STACK;
		}
	};



}
