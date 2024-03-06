package org.jamdev.jdl4pam.ketos;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformsParser;
import org.jamdev.jdl4pam.utils.DLMatFile;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.JamArr;
import org.jamdev.jpamutils.wavFiles.AudioData;

import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;
import us.hebi.matlab.mat.types.Struct;

/**
 * A simple example of using a Ketos model to analyse a single chunk of data. 
 * @author Jamie Macaulay 
 *
 */
public class KetosModelTest  {
	
	
	/**
	 * Run a Ketos model on a single chunk of sound data. 
	 * @param modelPath - the model path. 
	 * @param wavFilePath - path to an audio file. 
	 * @param outMatPath - MATLAB file to save transforms to. 
	 * @param chunk - the chunk of sound data to process from the audio file. 
	 * @return the transformed data for input into the model. 
	 */
	public static double[][] simpleModelTest(String modelPath, String wavFilePath, String outMatPath, double[] chunk) {
		
		try {
			//create struct to save data to and set up matrix to save transforms
			Struct struct = Mat5.newStruct();
			Matrix transfromedDataM;

			//Open wav files.
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);
			Matrix transfromedData;
			double[] soundDataD = soundData.getScaledSampleAmplitudes(); 
			System.out.println("Scaled amplitudes: " + soundDataD[0] + " " + soundDataD[1]);
//			Matrix transfromedDataM = DLMatFile.array2Matrix(soundData.getScaledSampleAmplitudes());
//			struct.set("audio", transfromedDataM);

			//the ketos model.
			KetosModel ketosModel = new KetosModel(new File(modelPath));

			//read the JSOn string from the file.
			String jsonString = DLTransformsParser.readJSONString(new File(ketosModel.getAudioReprFile()));


			//get the audio representation file.
			KetosParams ketosParams = new KetosParams(jsonString);
			
			System.out.println(ketosParams);

			/******* Trim the sound file to correct size ******/
			AudioData soundDataChunk; 
			soundDataChunk = soundData.trim((int) (chunk[0]*soundData.sampleRate), (int) (chunk[1]*soundData.sampleRate));
			
			transfromedDataM = DLMatFile.array2Matrix(soundDataChunk.getScaledSampleAmplitudes());
			struct.set("trimmed_audio", transfromedDataM);

			//generate the transforms.
			ArrayList<DLTransform> transforms = DLTransformsFactory.makeDLTransforms(ketosParams.dlTransforms);

			ketosModel.setInputShape(ketosParams.defaultInputShape);
			//			FreqTransform a = new FreqTransform(new DLTransform.DLTransformType("SPECTROGRAMKETOS"), transforms.get(2).getDLTransformType())

			/******* Run through transforms and grab spectrogram image ******/

			((WaveTransform) transforms.get(0)).setWaveData(soundDataChunk);

			DLTransform specTransform = transforms.get(0);
			DLTransform transform = transforms.get(0);
			for (int i = 0; i < transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform);
				
				if (transforms.get(i) instanceof FreqTransform) {
					transfromedDataM = DLMatFile.array2Matrix(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
					struct.set(transforms.get(i).getDLTransformType().getJSONString(), transfromedDataM);
					System.out.println(transforms.get(i).getDLTransformType() + "  " + + JamArr.min(((FreqTransform) transforms.get(i)).getSpecTransfrom().getTransformedData()));
				}
				if (transforms.get(i) instanceof WaveTransform) {
					transfromedDataM = DLMatFile.array2Matrix(((WaveTransform) transform).getWaveData().getScaledSampleAmplitudes());
					struct.set(transforms.get(i).getDLTransformType().getJSONString(), transfromedDataM);
					System.out.println(transforms.get(i).getDLTransformType() + "  " + + JamArr.min(((WaveTransform) transforms.get(i)).getWaveData().getSampleAmplitudes()));
				}
				
				if (transforms.get(i).getDLTransformType().name().equals("SPECTROGRAMKETOS")) {
					specTransform = transform;
				} 
				
			
			}


			/**** Write the model to a mat file so it can be easily viewed***/

			double[][] transformedData = ((FreqTransform) transform).getSpecTransfrom().getTransformedData();
			transfromedDataM = DLMatFile.array2Matrix(transformedData);
			struct.set("model_input", transfromedDataM);
			System.out.println("Data shape: " + transformedData.length + "  "  + transformedData[0].length);


			/*********************** Run the Model ************************/

			float[] output = null; 
			float[][][] data;
			int nStack = 1; //number of specs to give to the classifier. 
			for (int i=0; i<10; i++) {
				long time1 = System.currentTimeMillis();
				data = new float[nStack][][]; 
				for (int j=0; j<nStack; j++) {
					data[j] = DLUtils.toFloatArray(transformedData); 
				}
				output = ketosModel.runModel(data); 
				long time2 = System.currentTimeMillis();
				System.out.println("Time to run model: " + (time2-time1) + " ms"); 
			}

			double[] prob = new double[output.length]; 
			for (int j=0; j<output.length; j++) {
				//python code for this. 
				//		    	prob = torch.nn.functional.softmax(out).numpy()[n, 1]
				//	                    pred = int(prob >= ARGS.threshold)		    	
				//softmax function
				System.out.println("The output is: " + output[j]); 


				prob[j] = DLUtils.softmax(output[j], output); 
				//System.out.println("The probability is: " + prob[j]); 
			}
			
			
			//save MATLAB data; 
			MatFile matFile = Mat5.newMatFile()
					.addArray("data_transforms", struct);
			try {
				Mat5.writeToFile(matFile, outMatPath);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return transformedData; 

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null; 
		}
		
	}
	
	public static void main(String[] args) {
		
		//test on a right whale. 
		//File file = new File("/Volumes/GoogleDrive/My Drive/PAMGuard_dev/Deep_Learning/Meridian/right_whales/for_pamguard/narw.ktpb"); 
		//		File file = new File("/Volumes/GoogleDrive-108005893101854397430/My Drive/PAMGuard_dev/Deep_Learning/Meridian/humpback_whales/SOCAL_Mn_Network.ktpb");

		//classic right whale detector from ketos
		//		File file = new File("/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/narw_2/kw_detector_v11_5s_test/kw_detector_v11_5s.ktpb");

		//a new classifier based on a different architecture
//		String modelPath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/narw_2/hallo-kw-det_v1_test/hallo-kw-det_v1.ktpb";
		
	
		/****Wav files*****/

		//the wav file to test.
		//		String wavFilePath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/right_whales/for_pamguard/input.wav"; 
		//		double timelims = new double[] {0, 3.0}; 

		//JASCO_resampled_20k - use for right whales
		//		String wavFilePath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/narw_2/JASCO_resampled_20k.wav";

		//jasco_reduced - use for right whales hallo-kw-det_v1
//		String wavFilePath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/narw_2/hallo-kw-det_v1_test/audio/jasco_reduced.wav";
//		double[] chunk = new double[]{4.9843, 10.052900000000001}; 
//		double[] chunk = new double[]{44.9843, 50.05290000000001}; 
		/****Output MAT file for diagnosis****/
//		String outputMatfile = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/narw_2/hallo-kw-det_v1_test/transformed_data_ketos.mat";
		
		
		//Minke Whale model. 
		String modelPath = "D:\\Dropbox\\PAMGuard_dev\\Deep_Learning\\Ketos\\minke_whales\\minke_2\\ketos_model.ktpb";
		String wavFilePath = "D:\\Dropbox\\PAMGuard_dev\\Deep_Learning\\Ketos\\minke_whales\\minke_2\\79296_Brunswick03_002K_M06_UTCm5_CH6_20161227_110000.wav";
//		double[] chunk = new double[]{1.02, 1.02+5.226}; 
//		double[] chunk = new double[]{53.04, 53.04+5.226}; 
		double[] chunk = new double[] {264.18, 264.18+5.266}; //example which was not working well
//		double[] chunk = new double[] {621.18, 621.18+5.266}; //example which was not working well

		/****Output MAT file for diagnosis****/
		String outputMatfile = "C:\\Users\\Jamie Macaulay\\MATLAB Drive\\MATLAB\\PAMGUARD\\deep_learning\\ketos_classifier\\minke_wahle_java.mat";


		//run the ketos model. 
		double[][] transformedData = simpleModelTest( modelPath,  wavFilePath, outputMatfile, chunk); 
		
		System.out.println("Image size: " + transformedData.length + " x " + transformedData[0].length);


		System.exit(0);
	}


}
