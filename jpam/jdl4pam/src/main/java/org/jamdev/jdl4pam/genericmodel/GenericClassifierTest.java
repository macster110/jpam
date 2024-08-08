package org.jamdev.jdl4pam.genericmodel;

import java.io.IOException;
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
import org.jamdev.jpamutils.wavFiles.AudioData;

import ai.djl.MalformedModelException;
import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;

/**
 * 
 * Test the generic classifier on Tensorflow and Pytorch models
 * 
 * @author Jamie Macaulay 
 *
 */
public class GenericClassifierTest {

	public static void spectrogramTest() {
		//the audio file to test
//		String wavFilePath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/SouthernRightWhale001-v1/sar98_trk3_8000.wav";
		String wavFilePath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/SouthernRightWhale001-v1/wav_files_timestamp/PAM_20010327_113000.wav";

//		String wavFilePath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/SouthernRightWhale001-v1/sar98_trk3_8000.wav";

		//define some bits and pieces we need for the classiifer. 
		float sr = 2000; 
		//		int startchunk =  (int) (181.2*sr); //right whale call
		int startchunk =  (int) (190.2*sr); 

		int chunkSize = 4000; 

		AudioData soundData;
		try {
			soundData = DLUtils.loadWavFile(wavFilePath);

			//create the transforms. 
			ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

			//waveform transforms. 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sr)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, startchunk, startchunk+chunkSize)); 
			//			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.PREEMPHSIS, preemphases)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, 256, 100)); 

			//test generating the transforms - also done in the classifier
			ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlTransformParamsArr); 

			((WaveTransform) transforms.get(0)).setWaveData(soundData); 

			DLTransform transform = transforms.get(0); 
			for (int i=0; i<transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform); 
			}
			
			FreqTransform freqTranform = ((FreqTransform) transforms.get(2)); 
			
			double[][] specdata = freqTranform.getSpecTransfrom().getTransformedData(); 

			System.out.println("Spec shape:  " + specdata.length + " " + specdata[0].length);
			
			//DLUtils.printArray(specdata);
			
			System.out.println("Last spec: " + specdata[specdata.length-1][0]); 

		} catch (IOException | UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	public static void rightWhaleTest() {

		//the model path
		String modelPath = "/Users/au671271/Desktop/model_lenet_dropout_input_conv_all/saved_model.pb";

		//the audio file to test
		//String wavFilePath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/SouthernRightWhale001-v1/sar98_trk3_8000.wav";
		String wavFilePath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/SouthernRightWhale001-v1/wav_files_timestamp/PAM_20010327_113000.wav";

		//define some bits and pieces we need for the classiifer. 
		float sr = 2000; 
		int startchunk =  (int) (181.2*sr); //right whale call
		//int startchunk =  (int) (190.2*sr); 

		int chunkSize = 4000; 

		AudioData soundData;
		try {
			soundData = DLUtils.loadWavFile(wavFilePath);

			//create the transforms. 
			ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

			//waveform transforms. 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sr)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, startchunk, startchunk+chunkSize)); 
			//			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.PREEMPHSIS, preemphases)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, 256, 100)); 
			//in the python code they have an sfft of 129xN where N is the number of chunks. They then
			//choose fft data between bin 5 and 45 in the FFT. 	This roughly between 40 and 350 Hz. 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCROPINTERP, 47.0, 357.0, 40)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISEROWSUM)); 

			//generic classifier
			GenericClassifier genericClassifier = new GenericClassifier(modelPath); 
			genericClassifier.getGenericModelParams().dlTransforms = dlTransformParamsArr;

			double[] output = genericClassifier.runModel(soundData.getScaledSampleAmplitudes() , soundData.getSampleRate(), true); 

			for (int j = 0; j<output.length; j++) {
				System.out.println("Output: " + j + " : " + output[j]);
			}

		} catch (IOException | UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	
	public static void clickDLTest() {
		
		System.out.println("****PAMGuard click DL test****");

		//the model path
		String modelPath = "C:/Users/Jamie Macaulay/git/PAMGuard/src/test/resources/rawDeepLearningClassifier/Generic/risso_click/uniform_model/saved_model.pb";
//		String modelPath  = "/Users/au671271/git/PAMGuard/src/test/resources/rawDeepLearningClassifier/Generic/risso_click/uniform_model/saved_model.pb";
		//modelPath = Paths.get(modelPath).toAbsolutePath().normalize().toString();;

		//Load a small wav file with click data export from PAMGuard. 
		String wavFilePath = "C:/Users/Jamie Macaulay/git/PAMGuard/src/test/resources/rawDeepLearningClassifier/Generic/risso_click/clickwave_1.wav";
//		String wavFilePath = "/Users/au671271/git/PAMGuard/src/test/resources/rawDeepLearningClassifier/Generic/risso_click/clickwave.wav";
		//wavFilePath = Paths.get(wavFilePath).toAbsolutePath().normalize().toString();;

		String outmatfile = "C:/Users/Jamie Macaulay/MATLAB Drive/MATLAB/PAMGUARD/deep_learning/generic_classifier/click_transformed_java.mat";

		//define some bits and pieces we need for the classifier. 
		float sr = 500000; 

		AudioData soundData;
		try {
			soundData = DLUtils.loadWavFile(wavFilePath);
			
			//create the transforms. 
			ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

			//waveform transforms. 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE_SCIPY, 250000.)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.PEAK_TRIM, 128, 1)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.NORMALISE_WAV, 0., 1, AudioData.ZSCORE)); 

			//generic classifier
			GenericModel genericModel;
			try {
			
			
			//create transforms
			ArrayList<DLTransform> transforms = DLTransformsFactory.makeDLTransforms(dlTransformParamsArr);

			((WaveTransform) transforms.get(0)).setWaveData(soundData);

			// run the tansforms.
			DLTransform transform = transforms.get(0);
			for (int i = 0; i < transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform);
//				System.out.println("Transform len: " + ((WaveTransform) transform).getWaveData().getScaledSampleAmplitudes().length);
			}

			double[] dataD = ((WaveTransform) transform).getWaveData().getScaledSampleAmplitudes();
			
//			JamArr.printArray(dataD);
			
			//save the click transfrom to a file
			MatFile matFile = Mat5.newMatFile().addArray("click_transformed", DLMatFile.array2Matrix(dataD)); 


			Mat5.writeToFile(matFile, outmatfile);

			
//			dataD = JamArr.product(dataD, 0.99);

			float[] dataF = new float[dataD.length];
			for (int i = 0; i < dataF.length; i++) {
				dataF[i] = (float) dataD[i];
			}
			
			System.out.println("Min max waveform");
			JamArr.printArray(JamArr.minmax(dataD));
			
			float[][] waveStack = new float[][] {dataF};
			
			
			/***Load and run the model***/
			
			genericModel = new GenericModel(modelPath);

			float[] output = genericModel.runModel(waveStack);

			for (int j = 0; j<output.length; j++) {
				System.out.println("Output: " + j + " : " + output[j]);
			}
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 

		} catch (IOException | UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * The bat Pytorch test. 
	 */
	public static void batPyTorchTest() {


	}

	public static void main(String args[]) {
		clickDLTest();
	}



}
