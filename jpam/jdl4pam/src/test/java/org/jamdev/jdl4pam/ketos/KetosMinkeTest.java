package org.jamdev.jdl4pam.ketos;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.jamdev.jdl4pam.ketos.KetosAudioProcess.KetosResult;
import org.jamdev.jdl4pam.koogu.KooguTest;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.junit.Test;

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
		String relModelPath = 	"./src/test/java/org/jamdev/jdl4pam/resources/Ketos/minke_whale/ketos_model.ktpb";

		/****Wav files*****/
		//jasco_reduced - use for right whales hallo-kw-det_v1
//		String relWavFilePath = "./src/test/java/org/jamdev/jdl4pam/resources/Ketos/minke_whale/1705_FLAC_1705_20171106_185953_253.wav";
		String relWavFilePath = "./src/test/java/org/jamdev/jdl4pam/resources/Ketos/minke_whale/79296_Brunswick03_002K_M06_UTCm5_CH6_20161227_110000.wav";
	
		//Path to predictions file
		String predictionPath = "./src/test/java/org/jamdev/jdl4pam/resources/Ketos/minke_whale/classif_scores.csv";
		
		Path path = Paths.get(predictionPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String ketosPredictionsPath = path.toAbsolutePath().normalize().toString();
		//get the predictions
		double[][] ketosPredicitons = KooguTest.getPredictions(ketosPredictionsPath,1);
		
		System.out.println("Predicitons: " + ketosPredicitons.length);
//		JamArr.printArray(predictions);
		
		path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();
		
		path = Paths.get(relWavFilePath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();
		
		System.out.println(modelPath);

		//Open wav files.
		AudioData soundData;
		double hop = 1.02; //seconds
		try {
			soundData = DLUtils.loadWavFile(wavFilePath);

			//the ketos model.
			KetosModel ketosModel = new KetosModel(new File(modelPath));
			
//			System.out.println("KETOS SETTINGS: " + ketosModel.getAudioReprFile());

			ArrayList<KetosResult> results = KetosAudioProcess.processSoundData(ketosModel, soundData, hop, KetosAudioProcess.VERBOSITY_MEDIUM); 
			
//			for (int i=0; i<results.size()-1; i++) {
//				System.out.println(String.format(" time: %.2f pred[0] %.2f true[0] %.2f pred[1] %.2f true[1] %.2f ", 
//						results.get(i).startTime,  results.get(i).prediction[0], ketosPredicitons[i][1], results.get(i).prediction[1],  ketosPredicitons[i][2]));
//			}
			
			//check prediction results are within 10%
			//Note we forget the weird edge cases (start and end of file) here for Ketos
			boolean[] match = new boolean[results.size()-1];
			double matchCount = 0;
			for (int i=1; i<results.size()-1; i++) {
//				System.out.println(i + ": prediction: " + results.get(i).prediction[1] + " true: " + ketosPredicitons[i][2]);
				
				match[i] = (results.get(i).prediction[1]> (ketosPredicitons[i][2]-0.1) && results.get(i).prediction[1]<(ketosPredicitons[i][2]+0.1)); 
				System.out.println(String.format(" time: %.2f pred[0] %.2f true[0] %.2f pred[1] %.2f true[1] %.2f %b", 
						results.get(i).startTime,  results.get(i).prediction[0], ketosPredicitons[i][1], results.get(i).prediction[1],  ketosPredicitons[i][2], match[i]));
				if (match[i]) {
					matchCount++;
				}
			}
			
			System.out.println(String.format("Correct results = %.3f percent", 100*matchCount/results.size()));
			
			assertTrue(matchCount/results.size() > 0.95);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	

}