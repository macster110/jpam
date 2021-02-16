package org.jamdev.jdl4pam.genericmodel;

import java.io.IOException;
import java.util.ArrayList;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;

/**
 * 
 * Test the generic classifier on Tensorflow and Pytorch models
 * 
 * @author Jamie Macaulay 
 *
 */
public class GenericClassifierTest {

	public static void rightWhaleTest() {

		//the model path
		String modelPath = "/Users/au671271/Desktop/model_lenet_dropout_input_conv_all/saved_model.pb";

		//the audio file to test
		String wavFilePath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/SouthernRightWhale001-v1/sar98_trk3_8000.wav";

		//define some bits and pieces we need for the classiifer. 
		float sr = 2000; 
		//		int startchunk =  (int) (181.2*sr); //right whale call
		int startchunk =  (int) (190.2*sr); 

		int chunkSize = 4000; 

		AudioData soundData;
		try {
			soundData = DLUtils.loadWavFile(wavFilePath);

			//generic classifier
			GenericClassifier genericClassifier = new GenericClassifier(modelPath); 

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

			
			genericClassifier.getGenericModelParams().dlTransforms = dlTransformParamsArr;

			double[] output = genericClassifier.runModel(soundData.getScaledSampleAmpliudes() , soundData.getSampleRate()); 
			
			for (int j = 0; j<output.length; j++) {
				System.out.println("Output: " + j + " : " + output[j]);
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
		rightWhaleTest();
	}



}
