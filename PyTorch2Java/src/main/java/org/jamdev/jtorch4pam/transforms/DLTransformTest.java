package org.jamdev.jtorch4pam.transforms;

import java.io.IOException;
import java.util.ArrayList;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jtorch4pam.SoundSpot.SoundSpotParams;
import org.jamdev.jtorch4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jtorch4pam.utils.DLMatFile;
import org.jamdev.jtorch4pam.utils.DLUtils;
import org.jamdev.jtorch4pam.wavFiles.AudioData;

import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;

/**
 * Test the DLtransform idea. 
 * @author Jamie Macaulay 
 *
 */
public class DLTransformTest {
	
	
	public static void main(String[] args) {
		
		
		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/call_393_2019_S4U05619MOL2-20180917-051012_2525_2534.wav";
		int[] samplesChunk = new int[] {0, 1274}; // the sample chunk to use. 
		
		//output file path to test what the java spectrgram transforms look like. 
		String outputMatfile = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/DLTransformTest.mat"; 

		
		//create the DL params. 
		SoundSpotParams dlParams = new SoundSpotParams();
		
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
		
		
		try {
			Mat5.writeToFile(matFile, outputMatfile);
		} catch (IOException e) {
			e.printStackTrace();
		}


		
	}

	
}
