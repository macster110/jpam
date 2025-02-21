package org.jamdev.jdl4pam.generic;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.genericmodel.GenericModel;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.JamArr;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.junit.jupiter.api.Test;

import ai.djl.MalformedModelException;

public class GoogleMultiSpeciesTest {

	/**
	 * Test Google's humpback whale model. 
	 */
		@Test
		public void multiSpeciesGoogleTest() {
	
			System.out.println("*****Generic DL: Humpback whale test*****"); 
	
			//relative paths to the resource folders.
			String relModelPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/gmulti-species/multispecies-whale-tensorflow2-default-v2/saved_model.pb";
			String relWavPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/gmulti-species/Cross_24kHz.wav";
	
			Path path = Paths.get(relModelPath);
	
			String modelPath =  path.toAbsolutePath().normalize().toString();
	
			path = Paths.get(relWavPath);
			String wavFilePath = path.toAbsolutePath().normalize().toString();
	
			//TEMP 
			//load audio
			AudioData soundData;
			try {
				soundData = DLUtils.loadWavFile(wavFilePath);
	
				double[] amplitudes = soundData.getScaledSampleAmplitudes();
	
				float[] ampltiudesf = JamArr.doubleToFloat(amplitudes);
				float[] ampltiudesfchunk = new float[120000]; 
				int offset = 0; 
				System.arraycopy(ampltiudesf, 0+offset, ampltiudesfchunk, 0, 120000);
	
				System.out.println("MAX AMPLITUDE: " + JamArr.max(amplitudes)); 
	
				GenericModel genericModel  = new GenericModel(modelPath) ;
				
				
				float[][] input = new float[][]{ampltiudesfchunk}; 
				
	//			input = JamArr.transposeMatrix(input); 
				
				System.out.println("input: " + input.length); 
	
				float[] output2 = genericModel.runModel(input); 
	
				System.out.println("----TEST OUT----" + output2.length); 
				JamArr.printArray(output2);
	
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


	/**
	 * Test Google's humpback whale model. 
	 */
	@Test
	public void multiSpeciesGoogleTest2() {

		System.out.println("*****Generic DL: Humpback whale test*****"); 

		//relative paths to the resource folders.
		String relModelPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/gmulti-species/multispecies-whale-tensorflow2-default-v2/saved_model.pb";
		String relWavPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/gmulti-species/NOPP6_EST_20090329_121500.wav";
		String relWavPath2  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/gmulti-species/NOPP6_EST_20090329_121500_upsample_pg.wav";

		String[] paths = new String[] {relWavPath, relWavPath2};

		Path path = Paths.get(relModelPath);

		String modelPath =  path.toAbsolutePath().normalize().toString();


		//int offset = 24000*500;; //index 101
		int offset = 24000*70;; //index 15

		//TEMP 
		//load audio
		AudioData soundData;
		float targetSr = 24000; 

		try {

			GenericModel genericModel  = new GenericModel(modelPath) ;

			float[][] results = new float[paths.length][]; 

			for (int i=0; i<paths.length ; i++) {

				path = Paths.get(paths[i]);
				String wavFilePath = path.toAbsolutePath().normalize().toString();
				soundData = DLUtils.loadWavFile(wavFilePath);
				
				//do the upsampling if needed
				if (soundData.getSampleRate()!=targetSr) {
//					System.out.println("Hello!"); 
					 soundData = soundData.interpolate(targetSr) ;
				}

				double[] amplitudes = soundData.getScaledSampleAmplitudes();
				float[] ampltiudesf = JamArr.doubleToFloat(amplitudes);
				
				
				float[] ampltiudesfchunk = new float[120000]; 

				System.arraycopy(ampltiudesf, 0+offset, ampltiudesfchunk, 0, 120000);


				float[][] input = new float[][]{ampltiudesfchunk}; 

				//			input = JamArr.transposeMatrix(input); 

				float[] output2 = genericModel.runModel(input); 
				results[i]=output2;

				System.out.println(i + "----TEST OUT----" + output2.length); 
				JamArr.printArray(output2);
			}

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
