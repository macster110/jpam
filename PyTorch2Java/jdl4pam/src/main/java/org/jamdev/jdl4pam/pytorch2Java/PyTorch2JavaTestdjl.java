package org.jamdev.jdl4pam.pytorch2Java;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import org.jamdev.jdl4pam.utils.DLUtils;

import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.inference.Predictor;
import ai.djl.ndarray.NDArray;
import ai.djl.ndarray.NDList;
import ai.djl.ndarray.NDManager;
import ai.djl.ndarray.types.Shape;
import ai.djl.nn.Block;
import ai.djl.translate.Batchifier;
import ai.djl.translate.TranslateException;
import ai.djl.translate.Translator;
import ai.djl.translate.TranslatorContext;

/**
 * Test loading a Pytorch model using the djl library. 
 *  
 * @author Jamie Macaulay 
 *
 */
public class PyTorch2JavaTestdjl {

	public static void main(String[] args) {

		//seems like i have to stick with version 1.6 just now as 1.7 throws an exception

		String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/bats_denmark/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000_JAMIE.pk"; 
		//		 String modelpath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/BAT_15_80_6ms_12hop_256fft.pk";
		//		 String modelpath = "/Users/au671271/git/pytorch2java/PyTorch2Java/src/main/java/pytorch2Java/demo-model.pt1";

		//		Engine dlEngine = Engine.getEngine("PyTorch");  
		//		Model model = dlEngine.newModel(modelPath, Device.defaultDevice()); 

		Path modelDir = Paths.get("/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/bats_denmark/");
		String modelName= "BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000_JAMIE.pk";
		Model model = Model.newInstance(modelName);

		Map<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("extraFiles" , "dataOpts");

		try {
			model.load(modelDir, modelName, hashMap);
		} catch (MalformedModelException | IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		Block block = model.getBlock(); 

		System.out.println("Model properties " + model.getProperty("dataOpts"));

		//create some dummy data 
		float[][] specTest = DLUtils.makeDummySpectrogram(256, 128); 

		//create the translator of the data. 
		Translator<float[][], float[]> translator = new Translator<float[][], float[]>(){    
			@Override
			public NDList processInput(TranslatorContext ctx, float[][] data) {
				NDManager manager = ctx.getNDManager();

				//create the shape for the tensor.
				//				long[] shape = {1L, 1L, input[0], input[1]}; 

				Shape shape = new Shape(1L, data.length, data[0].length); 

				float[] specgramFlat = DLUtils.flattenDoubleArrayF(data); 

				NDArray array = manager.create(specgramFlat, shape); 

				System.out.println("Hello: 1 " + array.getShape()); 
				return new NDList (array);
			}

			@Override
			public float[] processOutput(TranslatorContext ctx, NDList list) {
				System.out.println("Hello: 2 " + list); 

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



		//predictor for the model
		Predictor<float[][], float[]> predictor = model.newPredictor(translator);

		try {
			System.out.println("Predict: ");
			float[] results  = predictor.predict(specTest);
			DLUtils.printArray(results);
		} catch (TranslateException e) {
			System.out.println("Error on model: "); 
			e.printStackTrace();
		}
	}

}
