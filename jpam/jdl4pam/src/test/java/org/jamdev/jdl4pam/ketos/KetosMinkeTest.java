package org.jamdev.jdl4pam.ketos;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.ketos.KetosAudioProcess.KetosResult;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.junit.Test;

import ai.djl.MalformedModelException;

/**
 * Test the Minke model works
 * 
 * @author Jamie Macaulay
 *
 */
public class KetosMinkeTest {
	
	/**
	 * Test batch processing a sound file using a Ketos model
	 * <p>
	 * Note: this is base don old JSON recipe format
	 */
	@Test
	public void KetosMinkeBathc() {
		
		/** 
		 * Example running Ketos model on a wav file. 
		 */
		String relModelPath = 	"./src/test/java/org/jamdev/jdl4pam/resources/Ketos/minke_whale/ketos_model_MW.ktpb";

		/****Wav files*****/
		//jasco_reduced - use for right whales hallo-kw-det_v1
		String relWavFilePath = "./src/test/java/org/jamdev/jdl4pam/resources/Ketos/minke_whale/1705_FLAC_1705_20171106_185953_253.wav";
	
		
		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();
		
		path = Paths.get(relWavFilePath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();
		
		System.out.println(modelPath);

		//Open wav files.
		AudioData soundData;
		double hop = 5.; //seconds
		try {
			soundData = DLUtils.loadWavFile(wavFilePath);

			//the ketos model.
			KetosModel ketosModel = new KetosModel(new File(modelPath));
			
			System.out.println("KETOS SETTINGS: " + ketosModel.getAudioReprFile());

			ArrayList<KetosResult> results = KetosAudioProcess.processSoundData( ketosModel,  soundData, hop, KetosAudioProcess.VERBOSITY_MEDIUM); 
			
			for (int i=0; i<results.size()-1; i++) {
				System.out.println(hop*i + " " + results.get(i).prediction[0] + " " + results.get(i).prediction[1]);
			}
			
//			//check prediction results are within 10%
//			//Note we forget the weird edge cases (start and end of file) here for Ketos
//			for (int i=1; i<results.size()-1; i++) {
////				System.out.println(i + ": prediction: " + results.get(i).prediction[1] + " true: " + ketosPredicitons[i][2]);
//				assertTrue(results.get(i).prediction[1]> ketosPredicitons[i][2]-0.1 && results.get(i).prediction[1]< ketosPredicitons[i][2]+0.1); 
//			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MalformedModelException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	

}
