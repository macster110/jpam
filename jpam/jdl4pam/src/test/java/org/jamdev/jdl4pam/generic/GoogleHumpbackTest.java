package org.jamdev.jdl4pam.generic;

import static org.junit.Assert.assertTrue;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.genericmodel.HumpbackGoogle;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.junit.Test;

import ai.djl.Model;


public class GoogleHumpbackTest {
	
	/**
	 * Test a humpback whale classifier from Google.
	 * <p>
	 * Note that this test uses lower level code from the ai.djl library and some functions from
	 * jdl4pam. 
	 */
	@Test
	public void humpbackWhale()
	{
		
		System.out.println("Humpback Pacific test:");
		
    	//relative paths to the resource folders.
    	String relModelPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/ghumpback/humpback_whale_1/saved_model.pb";
		String relWavPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/ghumpback/humpback.wav";
 
		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();
		
		path = Paths.get(relWavPath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();


		int startChunk =  0; //humpback whale call
		
		//int startchunk =  (int) (190.2*sr); 

		int chunkSize = (int) (3.92*10000); 
	
		//run the right whale model. 
		float[] output  = HumpbackGoogle.runHumpbackWhaledl(modelPath, wavFilePath, startChunk, chunkSize); 

		for (int j = 0; j<output.length; j++) {
			System.out.println("Output: " + j + " : " + output[j]);
		}
				
		//the output should be 0.9062276
		assertTrue( output[0]>0.906 ); //humpback whale detection

	}
	
	
	
	
	/**
	 * Test a humpback whale classifier from Vincent. no publication yet. 
	 * <p>
	 * Note that this test uses lower level code from the ai.djl library and some functions 
	 * jdl4pam. 
	 */
	@Test
	public void humpBackWhaleAtlantic()
	{
		
		System.out.println("Humpback Atlantic test:");
    	//relative paths to the resource folders.
//    	String relModelPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/ghumpback_atlantic/FlatHBNA/saved_model.pb";
//		String relWavPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/ghumpback_atlantic/Challenger_sample_humpback_detector.wav";
//		String resultsPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/ghumpback_atlantic/Challenger_sample_humpback_detector_annotations.txt";

		
		String relModelPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/ghumpback_atlantic/FlatHBNA/saved_model.pb";
		String relWavPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/ghumpback_atlantic/SAMOSAS_EL1_humpback.wav";
		String resultsPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/generic/ghumpback_atlantic/SAMOSAS_EL1_humpback_annotations.txt";

		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();
		
		path = Paths.get(relWavPath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();
		
		try {

		
		//load the model
		Model model = HumpbackGoogle.loadGoogleHumpbackModel(modelPath);
		
		///load the wave data. 
		AudioData soundData = DLUtils.loadWavFile(wavFilePath);
		
	
		//run the humpback whale classifier. 
		
		File file = new File(resultsPath);
		FileReader fr = new FileReader(file);
		BufferedReader br = new BufferedReader(fr);
		String line;
		int ind=0; 
		
		//run through all the different thinks
			while((line = br.readLine()) != null){
			  if (ind>0) {
				  
				  //read the data from the text file
			      String[] data = line.split("\t");
			      int chunkID = Integer.valueOf(data[0]);

			      double startTimeS = Double.valueOf(data[1]);
			      double endTimeS = Double.valueOf(data[2]);
			      double prediction = Double.valueOf(data[5]);

				  int startChunk = (int) (soundData.sampleRate*startTimeS); //humpback whale call
				  int chunkSize = (int) Math.ceil((endTimeS-startTimeS)*soundData.sampleRate); 
				  
				  
				  System.out.println("ChunkSie: " + chunkSize);
				  
				  float[] output = HumpbackGoogle.runHumpbackWhaledl(model,  soundData,  startChunk,  chunkSize, 1);
				  
				  System.out.println(String.format("Chunk %d %d Predicted output: %.2f true output: %.2f passed: %b", chunkID, startChunk,
						  output[0], prediction, output[0]>prediction*0.9 && output[0]<prediction*1.1)); 
				  
				  //allow 10% scrumph to take account of slight differences in Java input. 
				  assertTrue(output[0]>prediction*0.9 && output[0]<prediction*1.1); //humpback whale detection

 
			  }
			  ind++;
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


}
