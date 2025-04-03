package org.jamdev.jdl4pam.deepAcoustics;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.utils.DLMatFile;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.JamArr;
import org.jamdev.jpamutils.clahe.Clahe;
import org.jamdev.jpamutils.clahe.FastBitmap;
import org.jamdev.jpamutils.wavFiles.AudioData;

import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.engine.Engine;
import ai.djl.inference.Predictor;
import ai.djl.ndarray.types.Shape;
import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.format.Mat5File;
import us.hebi.matlab.mat.types.Array;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;

/**
 * A test class for DeepAcousticsModel
 */
public class DeepAcousticsDLTest {
	
	
	/*8
	 * Simply tests whether we get the same results from an image
	 */
	public static void imageTest(String modelPath, String matFilePath, String matFileOut){
		// load the model 
		File file = new File(modelPath); 

		Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
		String modelName = file.getName(); 

		Model model = Model.newInstance(modelPath, "TensorFlow"); 

		try {
			model.load(modelDir, "saved_model.pb");


			System.out.println("Input: " + model.describeInput().values()); 
			System.out.println("Output: " + model.describeOutput().values()); 

			DeepAcousticsTranslator translator = new DeepAcousticsTranslator(model.describeInput().get(0).getValue());

			//predictor for the model
			Predictor<float[][][][], DeepAcousticResultArray> predictor = model.newPredictor(translator);

			int nRuns = 1;

			float[][][] dataF3 = loadMatImage(matFilePath); 
			
			System.out.println("Length arr: " + dataF3.length + " " + dataF3[0].length + " " + dataF3[0][0].length);
			

			float[][][][] data;
			DeepAcousticResultArray results = null;
			for (int i=0; i<nRuns; i++) {
				long time1 = System.currentTimeMillis();
				//				data = DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
				//				System.out.println("Data input size: " + data.length + "   " + data[0].length);
				int nSpec = 1;
				data = new float[nSpec][][][]; 
				for (int j=0; j<nSpec; j++) {
					//data[j]=  DLUtils.makeDummySpectrogram(40, 40); 
					data[j]=  dataF3; 
				}

				results = predictor.predict(data); 
				long time2 = System.currentTimeMillis();
				System.out.println("Time to run model: " + (time2-time1) + " ms"); 
				for (int j=0; j<results.size(); j++) {
					System.out.println(String.format("Confidence %.2f x %.2f, y %.2f, width %.2f, height %.2f", 
							results.get(i).getConfidence(), results.get(i).getX(), results.get(i).getY(), results.get(i).getWidth(), results.get(i).getHeight()));
				}


			}

			if (matFileOut!=null) {
				// Create MAT file with a scalar in a nested struct
				MatFile matFile = Mat5.newMatFile();

				for (int i=0; i< results.getRawScores().size(); i++) {
					matFile.addArray(
							("scores_" + i), DLMatFile.array2Matrix(results.getRawScores().get(i))); 
				}
				float[][] im = new float[dataF3.length ][dataF3[0].length];
				
				for (int i=0; i<dataF3.length ;i++) {
					for (int j=0; j<dataF3[0].length ;j++) {
						im[i][j] = dataF3[i][j][0];
					}
				}

				matFile.addArray(
						("im_java"), DLMatFile.array2Matrix(im)); 
	
				Mat5.writeToFile(matFile, matFileOut); 
			}

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
                        myJavaArray[j][i][k] = value;
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


	public static float[][] transformsTest(AudioData soundData, String outMatlabPath){


		//create the transforms. 
		float sR = soundData.getSampleRate();

		int chunkSize = (int) (sR*3.0);; 

		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		//transforms
		//the clip length is three seconds
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, 0, chunkSize));
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAMKETOS, 1009, 202, 3.0)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPEC2DB));
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISE_MINIMAX)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECFLIP)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.CLAHE, 12, 255, 2f)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECRESIZE, 160, 160)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISE_MINIMAX)); 

		//generate the transforms. 
		ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlTransformParamsArr); 

		((WaveTransform) transforms.get(0)).setWaveData(soundData); 

		//run the tansforms. 
		MatFile matFile = null;
		if (outMatlabPath!=null) {
			matFile = Mat5.newMatFile();
		}
		DLTransform transform = transforms.get(0); 
		double[][] dataD;
		for (int i=0; i<transforms.size(); i++) {
			transform = transforms.get(i).transformData(transform); 

			if (transform instanceof FreqTransform) {
				dataD = ((FreqTransform) transform).getSpecTransfrom().getTransformedData();
				Matrix matrixSpec=  DLMatFile.array2Matrix(dataD);
				if (matFile!=null) {
					matFile.addArray(transform.getDLTransformType().getJSONString(), matrixSpec);
				}
			}
		}

		float[][] dataF =  DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
//		System.out.println("Data input size: " + dataF.length + " x " + dataF[0].length);
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
			Matrix matrixSpec=  DLMatFile.array2Matrix(((FreqTransform) transform).getSpecTransfrom().getTransformedData());

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
	public static ArrayList<DeepAcousticsResult> runDolphinDL(String modelPath, String wavFilePath, int startChunck) {


		int nRuns =10; 
		try {

			// load the model 
			File file = new File(modelPath); 

			Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
			String modelName = file.getName(); 

			System.out.println(Engine.getAllEngines()); 

			Model model = Model.newInstance(modelPath, "TensorFlow"); 

			model.load(modelDir, "saved_model.pb");

			System.out.println("Input: " + model.describeInput().values()); 
			System.out.println("Output: " + model.describeOutput().values()); 

			DeepAcousticsTranslator translator = new DeepAcousticsTranslator(model.describeInput().get(0).getValue());

			//predictor for the model
			Predictor<float[][][][], DeepAcousticResultArray> predictor = model.newPredictor(translator);

			///load the wave data. 
			//Open wav files. 
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);

			float sR = soundData.getSampleRate();

			//transform the audio data and turn into image. 
			float[][] dataF =  transformsTest( soundData,  null);
			
//			//TEMP
//			Matrix im = Mat5.readFromFile("C:/Users/Jamie Macaulay/MATLAB Drive/MATLAB/PAMGUARD/deep_learning/deepAcoustics/deepacoustics_mat.mat").getArray("im");
//			double[][] imJ = DLMatFile.matrix2array(im);
//			dataF = JamArr.doubleToFloat(imJ);
//		
			//NEED TO COLOURISE SPECTROGRAM TO MAKE IT A 3D INPUT
			float[][][] dataF3 = new float[160][160][3];
			for (int i=0; i<160; i++) {
				for (int j=0; j<160; j++) {
					dataF3[i][j] = new float[] {dataF[i][j],dataF[i][j],dataF[i][j]};
				}
			}
	

			DeepAcousticResultArray output = null; 
			float[][][][] data;
			for (int i=0; i<nRuns; i++) {
				long time1 = System.currentTimeMillis();
				//				data = DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
				//				System.out.println("Data input size: " + data.length + "   " + data[0].length);
				int nSpec = 1;
				data = new float[nSpec][][][]; 
				for (int j=0; j<nSpec; j++) {
					//data[j]=  DLUtils.makeDummySpectrogram(40, 40); 
					data[j]=  dataF3; 
				}

				output = predictor.predict(data); 
				long time2 = System.currentTimeMillis();
				System.out.println("Time to run model: " + (time2-time1) + " sio.savemat(\"testResizeImIn.mat\", x);\n"
						+ "ms"); 

			}

			//			Criteria criteria = Criteria.builder().
			//					 optModelUrls(modelPath).build();
			//			 
			//			 ModelZoo.loadModel(criteria);

			return output; 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null; 

		} 

	}

	/**
	 * Filter the anchor boxes to get the final bounding box results. 
	 * @param results - the results filterted. 
	 * @param minThresh
	 * @return
	 */
	public static ArrayList<DeepAcousticsResult> filterResults(ArrayList<DeepAcousticsResult> results, double minThresh){
		ArrayList<DeepAcousticsResult> filtResults = new ArrayList<DeepAcousticsResult>();
		float[] classProb = new float[results.size()];
		
		
		//filter by objectiveness score
		double objectness;
		for (int i=0; i<results.size(); i++) {
			classProb[i] = JamArr.max(results.get(i).getPredicitions());
			objectness = classProb[i]*results.get(i).getConfidence();
			
			System.out.println(String.format("Confidence %.2f x %.2f, y %.2f, width %.2f, height %.2f", 
					results.get(i).getConfidence(), results.get(i).getX(), results.get(i).getY(), results.get(i).getWidth(), results.get(i).getHeight()));
			
			if (objectness>minThresh) {
				filtResults.add(results.get(i));
			}
		}
		return filtResults;	
	}





	/**
	 * Test the classifier on a wave file. 
	 * @param args - the arguments. 
	 */
	public static void main(String[] args) {

//		//Dolphin wav file
//		String wavFilePath = "/home/jamiemac/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/Detection_Example_DarkNet_11_Whistles/IMMS_Combined_Test.wav";
//
//		//output MATLAB path
//		String outMatPath = "/home/jamiemac/MATLAB-Drive/MATLAB/PAMGUARD/deep_learning/deepAcoustics/deepAcoustic_spec_test.mat";
//
//		//		String modelPath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/model_lenet_dropout_input_conv_all.hdf5"; 
//		String modelPath = "/home/jamiemac/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/ModelExports/Test_TFSavedModel_DarkNet_250307/saved_model.pb";
//
//		int startchunk=0;
//		//		String outMatlabPath = "/Users/au671271/MATLAB-Drive/MATLAB/PAMGUARD/deep_learning/generic_classifier/rightwhaespec.mat";
//
//		///load the wave data. 
//		//Open wav files. 
//		AudioData soundData;
//
//		try {
//			soundData = DLUtils.loadWavFile(wavFilePath);
//
//			transformsTest(soundData, outMatPath);
//		} catch (IOException | UnsupportedAudioFileException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//
//		ArrayList<DeepAcousticsResult> results = runDolphinDL(modelPath, wavFilePath, startchunk); 
//		
//		/**
//		 * Filter the results
//		 */
//		ArrayList<DeepAcousticsResult> filtResults = filterResults(results,  0.5);
//		
//		//Results before
//		System.out.println("Results: " + results.size()  + " filt " + filtResults.size());
		
		
		//now that we have the results perform a simple filter. 
		//the output shape
		//Output: [(-1, 20, 20, 6), (-1, 10, 10, 6), (-1, 5, 5, 6)]

//		for (int j = 0; j<output.size(); j++) {
//			System.out.println("Output: " + j + " : " + output.get(j).length);
////			JamArr.printArray(output.get(j));
//			
//			Shape shape = new Shape(new long[] {-1,20,20,6});
//			
//		}
		
		String matOut = "/home/jamiemac/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/TensorFlow/testResizxeImIN_scores_java.mat";

		//Test an image so that we are sure wqe get the same ouput from Pythoing and Java
		String matFilePath= "/home/jamiemac/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/TensorFlow/testResizeImIn.mat";
		String modelPath = "/home/jamiemac/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/ModelExports/Test_TFSavedModel_DarkNet_250307/saved_model.pb";
		
		imageTest( modelPath,  matFilePath, matOut);
		
	}

}
