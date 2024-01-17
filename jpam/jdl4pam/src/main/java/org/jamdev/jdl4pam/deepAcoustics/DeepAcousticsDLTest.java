package org.jamdev.jdl4pam.deepAcoustics;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.jamdev.jdl4pam.genericmodel.SpectrogramTranslator;
import org.jamdev.jdl4pam.genericmodel.WaveformTranslator;
import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.opencv.imgproc.CLAHE;

import ai.djl.Model;
import ai.djl.engine.Engine;
import ai.djl.inference.Predictor;

/**
 * A test class for DeepAcousticsModel
 */
public class DeepAcousticsDLTest {
	
	/**
	 * Run the blue whale model as close to pure DJL as possible 
	 * @param modelPath - the path the saved_model.pb file
	 * @param wavFilePath - path to a wav file. 
	 * @param startChunck - the location to start form in the file (in samples). 
	 * @return predicitons. 
	 */
	public static float[] runDolphinDL(String modelPath, String wavFilePath, int startChunck) {
		float sr = 250; 
		int nRuns = 5; 

		int chunkSize = (int) (sr*3.0);; 
		
		try {

			File file = new File(modelPath); 

			Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
			String modelName = file.getName(); 

			System.out.println(Engine.getAllEngines()); 

			Model model = Model.newInstance(modelPath, "TensorFlow"); 

			model.load(modelDir, "saved_model.pb");

			System.out.println("Input: " + model.describeInput().values()); 
			System.out.println("Output: " + model.describeOutput().values()); 

			SpectrogramTranslator translator = new SpectrogramTranslator(model.describeInput().get(0).getValue());
			
			//predictor for the model
			Predictor<float[][][], float[]> predictor = model.newPredictor(translator);


			///load the wave data. 
			//Open wav files. 
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);
			
		
			//create the transforms. 
			ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

			//waveform transforms. 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.NORMALISE_WAV)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, 1024,512)); 


			//generate the transforms. 
			ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlTransformParamsArr); 
			
			((WaveTransform) transforms.get(0)).setWaveData(soundData); 

			//run the tansforms. 
			DLTransform transform = transforms.get(0); 
			for (int i=0; i<transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform); 
			}

			float[][] dataF =  DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
			System.out.println("Data input size: " + dataF.length);
			
			//NEED TO COLOURISE SPECTROGRAM TO MAKE INOT A 3D INPUT
			

			
			
			
//			Matrix matrixSpec=  DLMatFile.array2Matrix(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
//
//			MatFile matFile = Mat5.newMatFile()
//					.addArray("spectrogram", matrixSpec); 
//
//			try {
//				Mat5.writeToFile(matFile, outMatlabPath);
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}

			float[] output = null; 
			float[][][] data;
			for (int i=0; i<nRuns; i++) {
				long time1 = System.currentTimeMillis();
				//				data = DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
				//				System.out.println("Data input size: " + data.length + "   " + data[0].length);
				int nSpec = 1;
				data = new float[nSpec][][]; 
				for (int j=0; j<nSpec; j++) {
					//data[j]=  DLUtils.makeDummySpectrogram(40, 40); 
					data[j]=  dataF; 
				}

				output = predictor.predict(data); 
				long time2 = System.currentTimeMillis();
				System.out.println("Time to run model: " + (time2-time1) + " ms"); 

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
	 * Test the classifier on a wave file. 
	 * @param args - the arguments. 
	 */
	public static void main(String[] args) {

		//Dolphin wav file
		String wavFilePath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/deepAcoustics/Detection_Example_DarkNet_11_Whistles/IMMS_Combined_Test.wav";

		//		String modelPath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/model_lenet_dropout_input_conv_all.hdf5"; 
		String modelPath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/deepAcoustics/DA_Network11_pbConv/saved_model.pb";
		
		int startchunk=0;
//		String outMatlabPath = "/Users/au671271/MATLAB-Drive/MATLAB/PAMGUARD/deep_learning/generic_classifier/rightwhaespec.mat";
		
		float[] output  = runDolphinDL(modelPath, wavFilePath, startchunk); 
		
		for (int j = 0; j<output.length; j++) {
			System.out.println("Output: " + j + " : " + output[j]);
		}
	}

}
