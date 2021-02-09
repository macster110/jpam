package org.jamdev.jdl4pam.SoundSpot;

import java.io.IOException;
import java.util.ArrayList;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;

/**
 * Run a sound spot model. 
 * <p>
 * SoundSpot is a model trained using the AnimalSpot framework 
 * https://github.com/ChristianBergler/ORCA-SPOT
 * 
 * The model accepts a time/frequency image and contains metadata which
 * indicates how to convert raw sound data into the correct type of 
 * time/frequency image. 
 * 
 * 
 * @author Jamie Macaulay
 *
 */
public class SoundSpotClassifier {

	/**
	 * The current sound spot model. 
	 */
	private SoundSpotModel soundSpotModel;


	/**
	 * Paramters for the SoundSpot model. 
	 */
	private SoundSpotParams soundSpotParams;


	/**
	 * Run the Sounds
	 */
	public SoundSpotClassifier() {

	}
	
	/**
	 * Constructor for the SoundSpotClassifier. 
	 * @param modelPath - path to a SoundSpot model. 
	 */
	public SoundSpotClassifier(String modelPath) {
		loadModel(modelPath); 
	}



	/**
	 * Load a sound spot model. This loads the model into memory
	 * and extracts the metadata from the model creating a SoundSpotParams class. 
	 * @param modelPath - the path to the model. 
	 * @return true if the model was loaded successfully. 
	 */
	public boolean loadModel(String modelPath) {
		//first open the model and get the correct parameters. 
		try {
			soundSpotModel = new SoundSpotModel(modelPath);
			//create the DL params. 
			soundSpotParams = new SoundSpotParams(soundSpotModel.getTransformsString());
			return true; 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false; 
		} 
	}



	/**
	 * Run the currently loaded model on a chunk of sound data. 
	 * @param rawWaveData - a raw chunk of sound data with peak levels between -1 and 1. 
	 * @return the probability of each class in the model. 
	 */
	public double[] runModel(double[] rawWaveData, float sR) {

		//wav file 
		try {			

			//open .wav files. 
			AudioData soundData = new AudioData(rawWaveData, sR); 

			//generate the transforms. 
			ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(soundSpotParams.dlTransforms); 


			((WaveTransform) transforms.get(0)).setWaveData(soundData); 

			DLTransform transform = transforms.get(0); 
			for (int i=0; i<transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform); 
			}


			float[] output = null; 
			float[][][] data;
			for (int i=0; i<10; i++) {
				//long time1 = System.currentTimeMillis();
				data = new float[][][] {DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData())}; 
				output = soundSpotModel.runModel(data); 
				//long time2 = System.currentTimeMillis();
				//System.out.println("Time to run model: " + (time2-time1) + " ms"); 
			}

			double[] prob = new double[output.length]; 
			for (int j=0; j<output.length; j++) {
				//python code for this. 
				//				    	prob = torch.nn.functional.softmax(out).numpy()[n, 1]
				//			                    pred = int(prob >= ARGS.threshold)		    	
				//softmax function
				prob[j] = DLUtils.softmax(output[j], output); 
				//System.out.println("The probability is: " + prob[j]); 
			}

			return prob; 

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * Get the sound spot model. 
	 * @return the sound spot model. 
	 */
	public SoundSpotModel getSoundSpotModel() {
		return soundSpotModel;
	}


	/**
	 * Get the sound spot parameters class. 
	 * @return the sound spot paramaters class. 
	 */
	public SoundSpotParams getSoundSpotParams() {
		return soundSpotParams;
	}

	
	/**
	 * Test the classifier on a wave file. 
	 * @param args - the arguments. 
	 */
	public static void main(String[] args) {
		
		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/call_393_2019_S4U05619MOL2-20180917-051012_2525_2534.wav";
		int[] samplesChunk = new int[] {0, 1274}; // the sample chunk to use. 
		String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/bats_denmark/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000_JIT.pk";
	
		//Open wav files. 
		try {
			
			AudioData soundData;
			soundData = DLUtils.loadWavFile(wavFilePath);
			soundData = soundData.trim(samplesChunk[0], samplesChunk[1]); 
			
			SoundSpotClassifier soundSpotClassifier = new SoundSpotClassifier(modelPath); 

			double[] result = soundSpotClassifier.runModel(soundData.getScaledSampleAmpliudes(), soundData.sampleRate); 
			
		    for (int j=0; j<result.length; j++) {
		    	System.out.println("The probability of class " + j + " is "  + result[j]); 
		    }


		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
