package org.jamdev.jdl4pam.deepWhistle;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;

import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.inference.Predictor;
import ai.djl.ndarray.NDList;
import ai.djl.ndarray.types.Shape;
import ai.djl.nn.Blocks;
import ai.djl.repository.zoo.Criteria;
import ai.djl.repository.zoo.ModelNotFoundException;
import ai.djl.training.util.ProgressBar;
import ai.djl.translate.TranslateException;

public class DeepWhistleTest {

	/**
	 * Some quick tests for deepWhistle
	 * @param args
	 */
	public static void main(String[] args) {
		loadPyTorchdeepWhistle();
	}
	
	
	/**
	 * Tests that the model resturns the same output as MATLAB
	 */
	public static void testPyTorchdeepWhistle() {
		
		
	}



	/**
	 * Simple function which loads up the deep PyTorch whistle model and then runs it on completely random data
	 */
	public static void loadPyTorchdeepWhistle() {
		Path modelDirectory = Paths.get("/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/deepWhistle/"); 
		// 2. Define the name of your ONNX model file
		String modelName = "DWC-I.pt"; 

		Model loadedModel = Model.newInstance("Hello"); 

		try {

			loadedModel.load(modelDirectory, modelName);

			System.out.println("input: " + loadedModel.describeInput());
			if (loadedModel.describeInput()!=null) {
				for (int i=0; i<loadedModel.describeInput().size() ;i++) {
					System.out.println(loadedModel.describeInput().get(i).getValue());
				}
			}

			System.out.println("properties: " + loadedModel.getProperties());



			// 3. Call Model.load() using the configured Criteria
			//    Use try-with-resources for automatic resource management (model.close())
			int FFT_LEN =361;
			int N_RUNS =1400; 


			SpectrumTranslator spectrumTranslator = new SpectrumTranslator(new Shape(new long[] {1, 1,FFT_LEN, N_RUNS}), new Shape(new long[] {FFT_LEN}));

			//predictor for the model if using images as input
			Predictor<float[][], float[]> specPredictor = loadedModel.newPredictor(spectrumTranslator);

			//generate some random data.
			float[] inputArr = new float[FFT_LEN];
			for (int i=0; i<inputArr.length; i++) {
				inputArr[i]=(float) Math.random();
			}

			float[][] batchInput = new float[N_RUNS][];
			for (int j=0; j<batchInput.length; j++) {
				batchInput[j] = Arrays.copyOf(inputArr, inputArr.length);
			}

			long start = System.currentTimeMillis();

			System.out.println("Begin model prediction: " + N_RUNS + " runs");
			float[] output = specPredictor.predict(batchInput);

			long end = System.currentTimeMillis();

			System.out.println("End model prediction: " + output.length + " in " + (end-start) + " millis");




			//			       for (int i=0; i<loadedModel.describeOutput().size() ;i++) {
			//			    	   System.out.println(loadedModel.describeOutput().get(i));
			//			       }

		} catch (MalformedModelException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TranslateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

	/**
	 * Simple function which loads up the ONXX  whistle model and then runs it on completely random data
	 */
	public static void loadONNXdeepWhistle() {

		Path modelDirectory = Paths.get("/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/Silbido/"); 
		// 2. Define the name of your ONNX model file
		String modelName = "Li_et_al_2020_deep_silbido_361x1500.onnx"; 


		// 2. Build the Criteria object to configure loading
		//    This tells Model.load() WHAT and HOW to load.
		Criteria<NDList, NDList> criteria = Criteria.builder()
				// Specify expected input and output types (e.g., NDList for raw tensors)
				.setTypes(NDList.class, NDList.class) 

				// CRITICAL: Specify the engine for ONNX models
				.optEngine("OnnxRuntime")           

				// Specify the location of the model file
				.optModelPath(modelDirectory)       
				.optModelName(modelName)            

				// Optional: Show progress
				.optProgress(new ProgressBar())     
				.build(); // Build the configuration object

		// 3. Call Model.load() using the configured Criteria
		//    Use try-with-resources for automatic resource management (model.close())
		try {
			int FFT_LEN =361;
			int N_RUNS =1500; 

			Model loadedModel = criteria.loadModel();
			//			loadedModel.add(Blocks.inputBlock(new Shape(1, numChannels, imageHeight, imageWidth)));

			//			loadedModel = Model.newInstance("Hello", "OnnxRuntime"); 
			//			loadedModel.load(modelDirectory, modelName);

			System.out.println("input");
			for (int i=0; i<loadedModel.describeInput().size() ;i++) {
				System.out.println(loadedModel.describeInput().get(i).getValue());
			}

			System.out.println("properties: " + loadedModel.getProperties());

			SpectrumTranslator spectrumTranslator = new SpectrumTranslator(new Shape(new long[] {1, 1,FFT_LEN, N_RUNS}), new Shape(new long[] {FFT_LEN}));

			//predictor for the model if using images as input
			Predictor<float[][], float[]> specPredictor = loadedModel.newPredictor(spectrumTranslator);

			//generate some random data.
			float[] inputArr = new float[FFT_LEN];
			for (int i=0; i<inputArr.length; i++) {
				inputArr[i]=(float) Math.random();
			}

			float[][] batchInput = new float[N_RUNS][];
			for (int j=0; j<batchInput.length; j++) {
				batchInput[j] = Arrays.copyOf(inputArr, inputArr.length);
			}

			long start = System.currentTimeMillis();

			System.out.println("Begin model prediction: " + N_RUNS + " runs");
			float[] output = specPredictor.predict(batchInput);

			long end = System.currentTimeMillis();

			System.out.println("End model prediction: " + output.length + " in " + (end-start) + " millis");




			//			       for (int i=0; i<loadedModel.describeOutput().size() ;i++) {
			//			    	   System.out.println(loadedModel.describeOutput().get(i));
			//			       }


		} catch (MalformedModelException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ModelNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (TranslateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
