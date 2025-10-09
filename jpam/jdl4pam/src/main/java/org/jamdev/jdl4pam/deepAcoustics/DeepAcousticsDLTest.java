package org.jamdev.jdl4pam.deepAcoustics;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.deepAcoustics.Pred2BoxDJL3.DeepAcousticsNetwork;
import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformParser2;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.utils.DLMatFile;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.JamArr;
import org.jamdev.jpamutils.spectrogram.SpecTransform;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.json.JSONObject;

import ai.djl.Model;
import ai.djl.engine.Engine;
import ai.djl.inference.Predictor;
import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.format.Mat5File;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;
import us.hebi.matlab.mat.types.Struct;

/**
 * A test class for DeepAcousticsModel
 */
public class DeepAcousticsDLTest {
	
	public static float THRESH = 0.5f;  //default threshold for bounding boxes.
	
	
	/**
	 * Process an image with the model. 
	 * @param model - the model to use.
	 * @param dataF3 - the input data in the format [height, width, channels] where channels is 3 for RGB.
	 * @return the results from the model.
	 */
	public static List<DeepAcousticResultArray> processDLImage(Model model, float[][][] dataF3, ArrayList<double[][]> anchorBoxes){
		return processDLImage( model, dataF3,  anchorBoxes, 1);
	}


	/**
	 * Process an image with the model. 
	 * @param model - the model to use.
	 * @param dataF3 - the input data in the format [height, width, channels] where channels is 3 for RGB.
	 * @param nSpec - the number of spectrograms to process (usually 1). If more than 1 then duplicate spectrograms are used. 
	 * @return the results from the model.
	 */
	public static List<DeepAcousticResultArray> processDLImage(Model model, float[][][] dataF3, ArrayList<double[][]> anchorBoxes, int nSpec){

		try {

//			System.out.println("Input: " + model.describeInput().values());
//			System.out.println("anchorBoxes: " + anchorBoxes);

			
			DeepAcousticsNetwork network = new DeepAcousticsNetwork(model.describeInput().get(0).getValue(), anchorBoxes);


			DeepAcousticsTranslator translator = new DeepAcousticsTranslator(network);
			translator.setThresh(THRESH);

			//predictor for the model
			Predictor<float[][][][], List<DeepAcousticResultArray>> predictor = model.newPredictor(translator);

			int nRuns = 1;

			//System.out.println("Length arr: " + dataF3.length + " " + dataF3[0].length + " " + dataF3[0][0].length);


			float[][][][] data;
			List<DeepAcousticResultArray> results = null;
			for (int i=0; i<nRuns; i++) {
				long time1 = System.currentTimeMillis();
				//				data = DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
				//				System.out.println("Data input size: " + data.length + "   " + data[0].length);
				data = new float[nSpec][][][]; 
				for (int j=0; j<nSpec; j++) {
					//data[j]=  DLUtils.makeDummySpectrogram(40, 40); 
					data[j]=  dataF3; 
				}

				results = predictor.predict(data); 
				long time2 = System.currentTimeMillis();
				System.out.println("Time to run model " + nSpec +  " times: " + (time2-time1) + " ms" + " input: "+ data.length + " output: " + results.size()); 
				//				for (int j=0; j<results.size(); j++) {
				//					System.out.println(String.format("Confidence %.2f x %.2f, y %.2f, width %.2f, height %.2f", 
				//							results.get(j).getConfidence(), results.get(j).getX(), results.get(j).getY(), results.get(j).getWidth(), results.get(j).getHeight()));
				//				}


			}

			return results;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}



	/**
	 * Test the model on a single image. 
	 * @param modelPath - the path to the model
	 * @param matFilePath - the path to the MAT file containing the image data
	 * @param matFileOut - the path to save the output MAT file with results
	 */
	public static void imageDLTest(String modelPath, SpecInfo specInfo, String matFilePath, String matFileOut){

		float[][][] dataF3 = loadMatImage(matFilePath); 

		// load the model 
		File file = new File(modelPath); 

		Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
		String modelName = file.getName(); 

		Model model = Model.newInstance(modelPath, "TensorFlow"); 

		try {


			model.load(modelDir, "saved_model.pb");

			System.out.println("Input: " + model.describeInput().values()); 
			System.out.println("Output: " + model.describeOutput().values()); 
			
			List<DeepAcousticResultArray> results = processDLImage(model, dataF3, specInfo.anchorBoxes);

			//Create a mat file with the results.
			if (matFileOut!=null) {
				// Create MAT file with a scalar in a nested struct
				MatFile matFile = Mat5.newMatFile();


				Struct matResults =results2Mat( results.get(0));

				float[][] im = new float[dataF3.length ][dataF3[0].length];

				for (int i=0; i<dataF3.length ;i++) {
					for (int j=0; j<dataF3[0].length ;j++) {
						im[i][j] = dataF3[i][j][0];
					}
				}

				matFile.addArray(
						("im_java"), DLMatFile.array2Matrix(im));
				matFile.addArray(
						("results_java"), matResults);
				
				Mat5.writeToFile(matFile, matFileOut); 
			}

			model.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * Load an example image of the MAT file. 
	 */
	private static float[][][] loadMatImage(String matFile) {

		try {
			Mat5File matFileJ = Mat5.readFromFile(matFile);
			Matrix mlDoubleArray = (Matrix) matFileJ.getArray("im");
			//Read a 3D array

			// 8. Get the dimensions of the array
			int[] dimensions = mlDoubleArray.getDimensions(); // e.g., [2, 3, 4]

			float[][][] myJavaArray= new float[dimensions[0]][dimensions[1]][dimensions[2]];


			// 10. Access the data
			System.out.println("Accessing data elements:");
			// Iterate through the dimensions
			for (int i = 0; i < dimensions[0]; i++) { // Dimension 1 (e.g., rows)
				for (int j = 0; j < dimensions[1]; j++) { // Dimension 2 (e.g., columns)
					for (int k = 0; k < dimensions[2]; k++) { // Dimension 3 (e.g., pages/depth)

						// Get the element at the specific (i, j, k) index
						// NOTE: The library uses column-major order internally, but the get(indices...)
						// method handles the mapping from row-major style indexing.
						float value = mlDoubleArray.getFloat(new int[]{i,j,k});

						// Print the value and its index
						//System.out.printf("Element (%d, %d, %d) = %.4f\n", i, j, k, value);

						// You can store these values in a Java 3D array if needed:
						myJavaArray[i][j][k] = value;
					}
				}
			}

			return myJavaArray;


		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}


	public static float[][] transformsTest(AudioData soundData, SpecInfo modelInfo, String outMatlabPath){


		//create the transforms. 
		float sR = soundData.getSampleRate();

		int chunkStart = (int) (sR*modelInfo.startChunkSec);; 

		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		//transforms
		//the clip length is three seconds
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, chunkStart, ((int) (modelInfo.chunkSizeSec)*sR) + chunkStart));
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAMKETOS, modelInfo.fftLen, modelInfo.fftHop, modelInfo.chunkSizeSec)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECFREQTRIM, modelInfo.minFreq, modelInfo.maxFreq)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPEC2DB, null));
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISE_MINIMAX)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECFLIP)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.CLAHE2, 0.005f, 0.4f)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECRESIZE, modelInfo.imageSize[0], modelInfo.imageSize[1], SpecTransform.RESIZE_BILINEAR)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISE_MINIMAX)); 

		//generate the transforms. 
		ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlTransformParamsArr); 
		
		JSONObject jsonObject = new JSONObject();
		jsonObject = DLTransformParser2.writeJSONTransforms(dlTransformParamsArr, jsonObject);
		System.out.println(jsonObject.toString(1));

		((WaveTransform) transforms.get(0)).setWaveData(soundData); 

		//run the tansforms. 
		MatFile matFile = null;
		if (outMatlabPath!=null) {
			matFile = Mat5.newMatFile();
		}
		DLTransform transform = transforms.get(0); 
		double[][] dataD;
		for (int i=0; i<transforms.size(); i++) {
					System.out.println("Transform " + i + ": " + transforms.get(i).getDLTransformType().getJSONString());

			transform = transforms.get(i).transformData(transform); 

			if (transform instanceof FreqTransform) {
				dataD = ((FreqTransform) transform).getSpecTransfrom().getTransformedData();
				Matrix matrixSpec=  DLMatFile.array2Matrix(dataD);
				System.out.print(transforms.get(i).getDLTransformType() + "  size " + dataD.length + " x " + dataD[0].length);

				if (matFile!=null) {
					matFile.addArray(transform.getDLTransformType().getJSONString(), matrixSpec);
				}
			}
		}

		float[][] dataF =  DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
		dataF = JamArr.transposeMatrix(dataF); //transpose to make it [height, width] for the model input.
				System.out.println("Data input size: " + dataF.length + " x " + dataF[0].length);
		//			
		//			
		//			FastBitmap fastBitMap = new FastBitmap(dataF[0].length, dataF.length); 
		//			
		//			
		//			for (int i=0; i<dataF.length; i++) {
		//				for (int j=0; j<dataF[0].length; j++) {
		//					fastBitMap.setGray(i, j, (int) (255.*dataF[i][j]));
		//				}
		//			}
		//			
		//			Clahe clahe = new  Clahe(12, 600, 4f); 
		//			clahe.applyInPlace(fastBitMap);
		//			
		//			double[][] dataClahe = new double[dataF.length][dataF[0].length];
		//			for (int i=0; i<dataF.length; i++) {
		//				for (int j=0; j<dataF[0].length; j++) {
		//					dataClahe[i][j] = fastBitMap.getGray(i, j)/255.;
		//				}
		//			}
		//			
		//			
		//			Matrix matrixSpecClahe=  DLMatFile.array2Matrix(dataClahe);
		//			matFile.addArray("clahe", matrixSpecClahe); 
		if (matFile!=null) {
			Matrix matrixSpec=  DLMatFile.array2Matrix(dataF);

			matFile.addArray("inputimage", matrixSpec); 

			try {
				Mat5.writeToFile(matFile, outMatlabPath);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}


		return dataF;

	}
	/**
	 * Run the blue whale model as close to pure DJL as possible 
	 * @param modelPath - the path the saved_model.pb file
	 * @param wavFilePath - path to a wav file. 
	 * @param startChunck - the location to start form in the file (in samples). 
	 * @return predicitons. 
	 */
	public static  List<DeepAcousticResultArray> runDolphinDL(String modelPath, String wavFilePath, SpecInfo modelInfo){

		//Run the model a number of times to get an average time.
		int nRuns = 1; 
	
				
		try {

			// load the model 
			File file = new File(modelPath); 

			Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
			String modelName = file.getName(); 

			System.out.println(Engine.getAllEngines()); 

			Model model = Model.newInstance(modelPath, "TensorFlow"); 

			model.load(modelDir, "saved_model.pb");
			
//			System.out.println(model.describeOutput().get(0).getValue());
//
			///load the wave data. 
			//Open wav files. 
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);

			float sR = soundData.getSampleRate();

			//transform the audio data and turn into image. 
			float[][] dataF =  transformsTest( soundData,   modelInfo, null);

			//			//TEMP
			//			Matrix im = Mat5.readFromFile("C:/Users/Jamie Macaulay/MATLAB Drive/MATLAB/PAMGUARD/deep_learning/deepAcoustics/deepacoustics_mat.mat").getArray("im");
			//			double[][] imJ = DLMatFile.matrix2array(im);
			//			dataF = JamArr.doubleToFloat(imJ);
			//		
			//NEED TO COLOURISE SPECTROGRAM TO MAKE IT A 3D INPUT
			float[][][] dataF3 = new float[modelInfo.imageSize[0]][modelInfo.imageSize[1]][3];
			for (int i=0; i<modelInfo.imageSize[0]; i++) {
				for (int j=0; j<modelInfo.imageSize[1]; j++) {
					dataF3[i][j] = new float[] {dataF[i][j],dataF[i][j],dataF[i][j]};
				}
			}

//					System.out.println("Data input size: " + dataF3.length + " x " + dataF3[0].length + " x " + dataF3[0][0].length);//
			List<DeepAcousticResultArray>  results = null;
			for (int i=0; i<nRuns; i++) {
				results = processDLImage(model, dataF3, modelInfo.anchorBoxes);
			}

			return results; 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null; 

		} 

	}

	//	/**
	//	 * Filter the anchor boxes to get the final bounding box results. 
	//	 * @param results - the results filterted. 
	//	 * @param minThresh
	//	 * @return
	//	 */
	//	public static ArrayList<DeepAcousticsResult> filterResults(ArrayList<DeepAcousticsResult> results, double minThresh){
	//		ArrayList<DeepAcousticsResult> filtResults = new ArrayList<DeepAcousticsResult>();
	//		float[] classProb = new float[results.size()];
	//
	//
	//		//filter by objectiveness score
	//		double objectness;
	//		for (int i=0; i<results.size(); i++) {
	//			classProb[i] = JamArr.max(results.get(i).getPredicitions());
	//			objectness = classProb[i]*results.get(i).getConfidence();
	//
	//			System.out.println(String.format("Confidence %.2f x %.2f, y %.2f, width %.2f, height %.2f", 
	//					results.get(i).getConfidence(), results.get(i).getX(), results.get(i).getY(), results.get(i).getWidth(), results.get(i).getHeight()));
	//
	//			if (objectness>minThresh) {
	//				filtResults.add(results.get(i));
	//			}
	//		}
	//		return filtResults;	
	//	}

	
	/**
	 * Convert deep acoustic results to a MATLAB struct. 
	 * @param results - the results to convert
	 * @return a MATLAB struct with the results
	 */
	public static Struct results2Mat(DeepAcousticResultArray results) {
		Struct matResults = Mat5.newStruct(1, results.size());
		
		for (int i=0; i< results.size(); i++) {
			matResults.set("boundingbox", i, DLMatFile.array2Matrix(results.get(i).getBoundingBox())); 
			matResults.set("confidence", i, Mat5.newScalar(results.get(i).getConfidence())); 
			matResults.set("predictions", i, DLMatFile.array2Matrix(results.get(i).getPredicitions())); 
		}
		
		return matResults;
	 }
	 

	/** 
	 * Information about the spectrogram to use.
	 * */
	public static class SpecInfo {

		public ArrayList<double[][]> anchorBoxes;
		
		public double minFreq = 2000; 
		public double maxFreq = 22000; 
		public double winSizeSec = 3.0; 
		public int fftHop = 202; 
		public int fftLen = 1009; 
		public double chunkSizeSec = 3.0;
		public double startChunkSec = 0.0;
		public int[] imageSize = new int[] {160, 160}; //height, width.

		public SpecInfo() {
			anchorBoxes = new ArrayList<double[][]>();
			//for dolphinDL
			anchorBoxes.add(new double[][]{{26.,19.}});
			anchorBoxes.add(new double[][]{{89.,18.}});
			anchorBoxes.add(new double[][]{{86.,51.}});
		}
		
		/**
		 * Set the default values for the dolphin whistle model. DarkNet_11_Whsitles
		 */
		public void dolphinDefaults() {
			minFreq = 2000; //Minimum frequency to include in spectrogram in Hz
			maxFreq = 22000;  //Maximum frequency to include in spectrogram in Hz
			fftHop = 202;  //the FFT hop size in samples.
			fftLen = 1009; //the FFT length in samples.
			chunkSizeSec = 3.0; //The window size in seconds for the chunk of sound data passed to the model.
			
			anchorBoxes = new ArrayList<double[][]>();
			//for dolphinDL
			anchorBoxes.add(new double[][]{{26.,19.}});
			anchorBoxes.add(new double[][]{{89.,18.}});
			anchorBoxes.add(new double[][]{{86.,51.}});
			
			imageSize = new int[] {160, 160}; 
		}
		
		/**
		 * Set the default values for the dolphin whistle model. DarkNet_11_Whsitles
		 */
		public void multiSpeciesDefaults() {
			minFreq = 0; 
			maxFreq = 200; 
			fftHop = 256- 205; 
			fftLen = 256; 
			
			chunkSizeSec = 35.;
			
			anchorBoxes = new ArrayList<double[][]>();
			//for dolphinDL
			anchorBoxes.add(new double[][]{{78.,121.},{43,169.},{23., 117.}});
			anchorBoxes.add(new double[][]{{28.,71.},{56,27.},{20., 25.}});
			
			imageSize = new int[] {288, 288}; 

		}


	}

	/**
	 * Test the classifier on a wave file. 
	 * @param args - the arguments. 
	 */
	public static void main(String[] args) {


//		/*** Run a simple image test to check that the model works. ***/
//
//		String matOut = "/Users/jdjm/MATLAB-Drive/MATLAB/PAMGUARD/deep_learning/deepAcoustics/testResizxeImIN_scores_java.mat";
//
//		//Test an image so that we are sure we get the same ouput from Pythoing and Java
//		String matFilePath= "/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/DarkNet_11_Whsitles/testResizeImIn.mat";
		
//		/******Run the DarkNet dolphin whistle model on a wav file. *****/
//		
//		//String modelPath = "/home/jamiemac/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/ModelExports/Test_TFSavedModel_DarkNet_250307/saved_model.pb";
//		String modelPath = "/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/DarkNet_Whistles/ModelExports/Test_TFSavedModel_DarkNet_250404/saved_model.pb";
//		//imageDLTest( modelPath,  matFilePath, matOut);
//
//		/** Run a transforms test to check that the transforms work. ***/
//		//Dolphin wav file
//		String wavFilePath = "/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/DarkNet_Whistles/DarkNet_11_Whsitles/IMMS_Combined_Test.wav";
//		//
//		//output MATLAB path
//		String outMatPath = "/Users/jdjm/MATLAB-Drive/MATLAB/PAMGUARD/deep_learning/deepAcoustics/deepAcoustic_whistle_spec_test.mat";
//		
//		SpecInfo info = new SpecInfo();
//		info.dolphinDefaults(); //defaults for the dolphin whistle model.
//		
		
		/******Run the TestTFTinyMCwFix multi species whistle model on a wav file. *****/

		//String modelPath = "/home/jamiemac/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/ModelExports/Test_TFSavedModel_DarkNet_250307/saved_model.pb";
		String modelPath = "/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/TinyT_Multi_Species/ModelExports/Test_TFSavedModel_MCTinywFix_250912/saved_model.pb";
		//imageDLTest( modelPath,  matFilePath, matOut);

		/** Run a transforms test to check that the transforms work. ***/
		//Dolphin wav file
		String wavFilePath = "/Users/jdjm/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/TinyT_Multi_Species/Multi_class_test_files/HYDBBA106_20170106_1150_1215.wav";
		//
		//output MATLAB path
		String outMatPath = "/Users/jdjm/MATLAB-Drive/MATLAB/PAMGUARD/deep_learning/deepAcoustics/deepAcoustic_multispecies_spec_test.mat";
		
		SpecInfo info = new SpecInfo();
		info.multiSpeciesDefaults();
		info.startChunkSec = 35.0; //start at 60 seconds into the file.
	


		try {
			//System.out.println("Hello Deep Acoustics DL Test");

			AudioData soundData = DLUtils.loadWavFile(wavFilePath);

			float[][] image = transformsTest(soundData,  info, outMatPath);
			
			List<DeepAcousticResultArray> results = runDolphinDL( modelPath, wavFilePath, info) ; 
			
			for (int i=0; i<results.size(); i++) {
				
				System.out.println();

				for (int j=0; j<results.get(i).size(); j++) {

					System.out.print(String.format("Result %d Confidence %.2f ", 
							j,results.get(i).get(j).getConfidence()));


					System.out.print("Predictions:  ");

					JamArr.printArray(results.get(i).get(j).getPredicitions());

				}

			}
			
//			System.out.println("Hello Deep Acoustics DL Test results: " + results.size() + " " + results.get(0).getBoundingBox().length);
		
			//Append the bounding box results to the transformed data. 
			
			   // Read the existing MAT file
	        MatFile matFile = Mat5.readFromFile(outMatPath);

	        // Create a new scalar variable
	        Struct newStruct =  results2Mat(results.get(0)) ;

	        // Add the new variable to the MatFile object
	        matFile.addArray("java_results", newStruct);

	        // Write the modified MatFile object back to the file.
	        // This will overwrite the file but include the new variable and retain old ones.
	        Mat5.writeToFile(matFile, outMatPath);
		
		} catch (IOException | UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	}
