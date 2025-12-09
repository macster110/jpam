package org.jamdev.jdl4pam.deepWhistle;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformParser2;
import org.jamdev.jdl4pam.utils.DLMatFile;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.JamArr;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.json.JSONObject;

import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.inference.Predictor;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.TranslateException;
import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.format.Mat5File;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;


/*
 * Simple test class to load and run the deepWhistle PyTorch model using DJL. 
 * 
 * @author Jamie Macaulay
 *
 */
public class DeepWhistleTest {

	/**
	 * Some quick tests for deepWhistle. 
	 * @param args
	 */
	public static void main(String[] args) {
		//simple test which just loads the models and fires some random data into it. 
		//loadPyTorchdeepWhistleTest();

		String modelPath = "/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/deepWhistle/DWC-I.pt"; 
		String testSpecPath = "/Users/jdjm/MATLAB-Drive/MATLAB/PAMGUARD/deep_learning/silbido/model_input_example.mat";

		float[][] modelInput = loadMatSpec( testSpecPath,  "normalized_blk");
		modelInput=JamArr.transposeMatrix(modelInput);

		float imageLenS = 21; //the length of time in seconds the image represents.

		int nSegments = (int) imageLenS; //each sefgment is 1 second long.

		System.out.println("The input data is " + modelInput[0].length + " freq bins x " + modelInput.length + " time bins");

		//predictor for the model if using images as input
		Predictor<float[][], float[]> specPredictor = loadPyTorchdeepWhistleModel(modelPath, modelInput[0].length, modelInput.length);

		System.out.println("");	
		System.out.println("----Running deepWhistle model on large image----");

		//run the example data
		float[][] modelResults = null;
		
		for (int i =0; i<1; i++) {
			
			modelResults = runPyTorchDeepWhislte(specPredictor, modelInput); 
		}
		specPredictor.close();

		System.out.println("The ouput data is " + modelResults[0].length + " freq bins x " + modelResults.length + " time bins");

		System.out.println("");	
		System.out.println("----Running deepWhistle model on segmented image----");

		int fftN2 = (int) (modelInput.length/nSegments);
		
		System.out.println("The input data is " + modelInput[0].length + " freq bins x " +fftN2 + " time bins");	


		specPredictor = loadPyTorchdeepWhistleModel(modelPath, modelInput[0].length, fftN2);
		

		float[][] segment = new float[fftN2][]; 
		float[][] modelResults2 = new float[modelInput.length][modelInput[0].length];
		
		long startTime = System.currentTimeMillis();
		for (int i=0; i<nSegments; i++){
			//extract the segment
			for (int j=0; j<fftN2; j++) {
				segment[j] = modelInput[i*fftN2 + j];
			}

			//run the model on the segment
			float[][] segmentResults = runPyTorchDeepWhislte(specPredictor, segment); 

			//copy the results back into the full output array. 
			for (int k=0; k<fftN2; k++) {
				modelResults2[i*fftN2 + k] = segmentResults[k];
			}
		}
		
		System.out.println("Time to run segmented model: " + (System.currentTimeMillis()-startTime) + " ms");
		
		
		System.out.println("");	
		System.out.println("----Running deepWhistle model with transforms from JPAM----");

		String wavFilePath = "/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/delphinID/delphinIDmodels/Ggr242/PAM_20200918_123600_032.wav";
		
		//the default settings are 
		//Frequency range 5000 - 50000 Hz
		// Framing 361 FFT length, 21 Hz hop (i.e. 1500 FFT per 31.25 sec)
		DeepWhistleInfo modelInfo = new DeepWhistleInfo(193, 768, 5000.0f, 50000.0f, 20.f);
		///load the wave data. 
		//Open wav files. 
		AudioData soundData = null;
		float[][] modelInputJava = null;
		float[][] modelResultsJava2 = null;
		try {
			
			
			soundData = DLUtils.loadWavFile(wavFilePath);
			
			modelInputJava = transformWav( soundData,  modelInfo);
			
			//predictor for the model if using images as input
			specPredictor = loadPyTorchdeepWhistleModel(modelPath, modelInputJava[0].length, modelInputJava.length);
			modelResultsJava2 = runPyTorchDeepWhislte(specPredictor, modelInputJava); 


		} catch (IOException | UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		//specPredictor.close();
		

		// Read the existing MAT file and write the new variable to that file. 
		MatFile matFile;
		try {
			matFile = Mat5.readFromFile(testSpecPath);


			// Create a new scalar variable
			Matrix outputResult =  DLMatFile.array2Matrix(modelResults);
			Matrix outputResult2 =  DLMatFile.array2Matrix(modelResults2);
			Matrix inputResult =  DLMatFile.array2Matrix(modelInputJava);
			Matrix inputResult2 =  DLMatFile.array2Matrix(modelResultsJava2);

			Matrix soundDataM =  DLMatFile.array2Matrix(soundData.getScaledSampleAmplitudes());


			// Add the new variable to the MatFile object
			matFile.addArray("predicted_blk_java", outputResult);
			
			//add the segmented data
			matFile.addArray("predicted_blk_java_seg", outputResult2);
			
			// Add the new variable to the MatFile object
			matFile.addArray("predicted_blk_java_input", inputResult2);
			
			//add the normalized_blk
			matFile.addArray("normalized_blk_java", inputResult);

			//add the normalized_blk
//			matFile.addArray("sound_data", soundDataM);
			// Write the modified MatFile object back to the file.
			// This will overwrite the file but include the new variable and retain old ones.
			Mat5.writeToFile(matFile, testSpecPath);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("Finished writing output to MAT file.");

	}
	
	public static float[][] transformWav(AudioData soundData, DeepWhistleInfo modelInfo){
		
			int chunkStart = 0;

			//create the transforms. 
			float sR = soundData.getSampleRate();

			ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();
			
			//so that transforms are
			// spectrogram - create a spectrogram - note silbido does not use a window function weirdly...
			//then trim the frequency
			//multiply by log10. 
			///clamp the values between mac_clip and min_clip - this is between 0 and 6 in Silbido
			//transforms
			//Then do a min mac normalisation
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, chunkStart, ((int) (modelInfo.chunkSizeSec)*sR) + chunkStart));
//			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, 1024,512)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAMKETOS, modelInfo.fftLen, modelInfo.fftHop, 20.0)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECFREQTRIM, modelInfo.minFreq, modelInfo.maxFreq)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPEC_LOG10));
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPEC_ADD, 2.1));
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCLAMP, 0, 6.));
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISE_MINIMAX, 0, 6)); 
			
			//generate the transforms. 
			ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlTransformParamsArr); 
			
			JSONObject jsonObject = new JSONObject();
			jsonObject = DLTransformParser2.writeJSONTransforms(dlTransformParamsArr, jsonObject);
			System.out.println(jsonObject.toString(1));

			
//			soundData = soundData.multiply((2^16)/2);
			
			((WaveTransform) transforms.get(0)).setWaveData(soundData); 

			DLTransform transform = transforms.get(0); 
			double[][] dataD;
			for (int i=0; i<transforms.size(); i++) {
						
				System.out.println("Transform " + i + ": " + transforms.get(i).getDLTransformType().getJSONString());
	
				transform = transforms.get(i).transformData(transform); 
				
				if (transform instanceof FreqTransform && i>=1) {
					System.out.println(transform.getDLTransformType().getJSONString());
					double max  =  JamArr.max( ((FreqTransform) transform).getSpecTransfrom().getTransformedData());
					double min  =  JamArr.min( ((FreqTransform) transform).getSpecTransfrom().getTransformedData());
					
					System.out.println("min max: " + i + ": " +min +  "  " + max);
				}

			}
			
			float[][] dataF =  DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());

			return dataF; 
	}
	
	public static class DeepWhistleInfo {
		public int fftLen;
		public int fftHop;
		public float chunkSizeSec;
		public float minFreq;
		public float maxFreq;
		
		public DeepWhistleInfo(int fftLen, int fftHop, float minFreq, float maxFreq, float chunkSizeSec) {
			this.fftLen=fftLen;
			this.fftHop=fftHop;
			this.minFreq=minFreq;
			this.maxFreq=maxFreq;
			this.chunkSizeSec=chunkSizeSec;
		}
	}



	/**
	 * Load the deepWhistle into memory and create a predictor that can be called to run the model. 
	 * @param modelPathS - the path to the PyTorch model file
	 * @param fftLen - the fft length used in the model
	 * @param fftNum - the number of runs (i.e. number of FFT
	 * @return the predictor which returns a flattened confidence surface. 
	 */
	public static Predictor<float[][], float[]>  loadPyTorchdeepWhistleModel(String modelPathS, long fftLen, long fftNum) {

		Path modelPath = Paths.get(modelPathS); 

		//get the parent
		Path modelDirectory = modelPath.getParent();
		// Define the name of your ONNX model file
		String modelName = modelPath.getFileName().toString();


		Model loadedModel = Model.newInstance("DeepWhistle"); 

		try {

			loadedModel.load(modelDirectory, modelName);

			System.out.println("Model input description: " + loadedModel.describeInput());
			
			if (loadedModel.describeInput()!=null) {
				for (int i=0; i<loadedModel.describeInput().size() ;i++) {
					System.out.println(loadedModel.describeInput().get(i).getValue());
				}
			}

			System.out.println("Model properties: " + loadedModel.getProperties());

			SpectrumTranslator spectrumTranslator = new SpectrumTranslator(new Shape(new long[] {1, 1,fftLen, fftNum}), new Shape(new long[] {fftLen}));

			//predictor for the model if using images as input
			Predictor<float[][], float[]> specPredictor = loadedModel.newPredictor(spectrumTranslator);
			return specPredictor;

		} catch (MalformedModelException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

		return null;
	}


	/**
	 * Simple function which loads up the deep PyTorch whistle model and then runs it on completely random data
	 */
	public static void loadPyTorchdeepWhistleTest() {
		String modelPath = "/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/deepWhistle/DWC-I.pt"; 


		//define the fft length

		int FFT_LEN =361;
		int N_RUNS =1400; 

		//predictor for the model if using images as input
		Predictor<float[][], float[]> specPredictor = loadPyTorchdeepWhistleModel(modelPath, FFT_LEN, N_RUNS);

		//generate some random data.
		float[] inputArr = new float[FFT_LEN];
		for (int i=0; i<inputArr.length; i++) {
			inputArr[i]=(float) Math.random();
		}

		float[][] batchInput = new float[N_RUNS][];
		for (int j=0; j<batchInput.length; j++) {
			batchInput[j] = Arrays.copyOf(inputArr, inputArr.length);
		}


		System.out.println("Begin model prediction: " + N_RUNS + " no. FFT");
		float[] output;
		try {
			long start = System.currentTimeMillis();
			output = specPredictor.predict(batchInput);
			long end = System.currentTimeMillis();
			System.out.println("End model prediction: " + output.length + " in " + (end-start) + " millis");
		} catch (TranslateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}


	/**
	 * Simple function which loads up the deep PyTorch whistle model and then runs it on completely random data
	 */
	public static float[][] runPyTorchDeepWhislte(Predictor<float[][], float[]> specPredictor, float[][] spectrogram) {

		System.out.println("Begin model prediction: " + spectrogram.length + " no. FFT");
		float[] output;
		try {
			
			float[][] input =JamArr.transposeMatrix(spectrogram);

			long start = System.currentTimeMillis();

			output = specPredictor.predict(input);

			float[][] confMap = JamArr.to2D(output,  input[0].length);

			long end = System.currentTimeMillis();

			System.out.println("End model prediction: " + spectrogram.length + " in " + (end-start) + " millis");

			return JamArr.transposeMatrix(confMap);

		} catch (TranslateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null; 
	}

	/**
	 * Load an example image of the MAT file. 
	 */
	public static float[][] loadMatSpec(String matFile, String varName) {

		try {
			Mat5File mfr = Mat5.readFromFile(new File(matFile));

			Matrix matrix = mfr.getMatrix(varName); 

			double[][] model_input  = DLMatFile.matrix2array(matrix);

			return JamArr.doubleToFloat(model_input);


		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}


	//	/**
	//	 * Simple function which loads up the ONXX  whistle model and then runs it on completely random data
	//	 */
	//	public static void loadONNXdeepWhistle() {
	//
	//		Path modelDirectory = Paths.get("/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/Silbido/"); 
	//		// 2. Define the name of your ONNX model file
	//		String modelName = "Li_et_al_2020_deep_silbido_361x1500.onnx"; 
	//
	//
	//		// 2. Build the Criteria object to configure loading
	//		//    This tells Model.load() WHAT and HOW to load.
	//		Criteria<NDList, NDList> criteria = Criteria.builder()
	//				// Specify expected input and output types (e.g., NDList for raw tensors)
	//				.setTypes(NDList.class, NDList.class) 
	//
	//				// CRITICAL: Specify the engine for ONNX models
	//				.optEngine("OnnxRuntime")           
	//
	//				// Specify the location of the model file
	//				.optModelPath(modelDirectory)       
	//				.optModelName(modelName)            
	//
	//				// Optional: Show progress
	//				.optProgress(new ProgressBar())     
	//				.build(); // Build the configuration object
	//
	//		// 3. Call Model.load() using the configured Criteria
	//		//    Use try-with-resources for automatic resource management (model.close())
	//		try {
	//			int FFT_LEN =361;
	//			int N_RUNS =1500; 
	//
	//			Model loadedModel = criteria.loadModel();
	//			//			loadedModel.add(Blocks.inputBlock(new Shape(1, numChannels, imageHeight, imageWidth)));
	//
	//			//			loadedModel = Model.newInstance("Hello", "OnnxRuntime"); 
	//			//			loadedModel.load(modelDirectory, modelName);
	//
	//			System.out.println("input");
	//			for (int i=0; i<loadedModel.describeInput().size() ;i++) {
	//				System.out.println(loadedModel.describeInput().get(i).getValue());
	//			}
	//
	//			System.out.println("properties: " + loadedModel.getProperties());
	//
	//			SpectrumTranslator spectrumTranslator = new SpectrumTranslator(new Shape(new long[] {1, 1,FFT_LEN, N_RUNS}), new Shape(new long[] {FFT_LEN}));
	//
	//			//predictor for the model if using images as input
	//			Predictor<float[][], float[]> specPredictor = loadedModel.newPredictor(spectrumTranslator);
	//
	//			//generate some random data.
	//			float[] inputArr = new float[FFT_LEN];
	//			for (int i=0; i<inputArr.length; i++) {
	//				inputArr[i]=(float) Math.random();
	//			}
	//
	//			float[][] batchInput = new float[N_RUNS][];
	//			for (int j=0; j<batchInput.length; j++) {
	//				batchInput[j] = Arrays.copyOf(inputArr, inputArr.length);
	//			}
	//
	//			long start = System.currentTimeMillis();
	//
	//			System.out.println("Begin model prediction: " + N_RUNS + " runs");
	//			float[] output = specPredictor.predict(batchInput);
	//
	//			long end = System.currentTimeMillis();
	//
	//			System.out.println("End model prediction: " + output.length + " in " + (end-start) + " millis");
	//
	//
	//		} catch (MalformedModelException | IOException e) {
	//			// TODO Auto-generated catch block
	//			e.printStackTrace();
	//		} catch (ModelNotFoundException e) {
	//			// TODO Auto-generated catch block
	//			e.printStackTrace();
	//		} catch (TranslateException e) {
	//			// TODO Auto-generated catch block
	//			e.printStackTrace();
	//		}
	//	}

}
