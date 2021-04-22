package org.jamdev.jdl4pam.animalSpot;

import java.io.IOException;
import java.util.ArrayList;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.utils.DLMatFile;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;

import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;


/**
 * 
 * Create a transforms test based on the transform params in a SoundSpot model. 	
 * 
 *
 * @author Jamie Macaulay
 *
 */
public class AnimalSpotTransfromsTest {



	public static void main(String[] args) {

		try {

			//the wav file path
			String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/call_393_2019_S4U05619MOL2-20180917-051012_2525_2534.wav";
			int[] samplesChunk = new int[] {0, 1274}; // the sample chunk to use. 

			//the model path
//			String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/bats_denmark/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000_JIT.pk"; 
			String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/BAT_MODEL_3/BAT_JAMIE_4ms_256fft_8hop_-100_20_15_60_128_256_NOJIT_BAT_DATA_NAUG_V1_JIT.pk"; 

			//output file path to test what the java spectrgram transforms look like. 
			String outputMatfile = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/DLTransformTest.mat"; 
			
			
			//first open the model and get the correct parameters. 
			AnimalSpotModel soundSpotModel;
			soundSpotModel = new AnimalSpotModel(modelPath);

			System.out.println(soundSpotModel.getTransformsString());

			//create the DL params from the transforms string
			AnimalSpotParams dlParams = new AnimalSpotParams(soundSpotModel.getTransformsString());

			AudioData soundData = null; 
			//Open wav files. 
			try {
				soundData = DLUtils.loadWavFile(wavFilePath);
				soundData = soundData.trim(samplesChunk[0], samplesChunk[1]); 
			} catch (IOException | UnsupportedAudioFileException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			//generate the transforms. 
			ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlParams.dlTransforms); 


			((WaveTransform) transforms.get(0)).setWaveData(soundData); 

			DLTransform transform = transforms.get(0); 
			for (int i=0; i<transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform); 
			}


			System.out.println("Transfrom: " + ((FreqTransform) transform).getSpecTransfrom()); 
			//now the last transform contains the data we need. 

			Matrix matrixSpec=  DLMatFile.array2Matrix(((FreqTransform) transform).getSpecTransfrom().getTransformedData());


			MatFile matFile = Mat5.newMatFile()
					.addArray("SpecDLTransform", matrixSpec); 


			Mat5.writeToFile(matFile, outputMatfile);


		}

		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

	}
	
}
