package org.jamdev.jdl4pam.generic;

import static org.junit.Assert.assertTrue;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.jamdev.jdl4pam.genericmodel.HumpbackGoogle;

import org.junit.Test;

public class HumpbackTest {
	
	/**
	 * Test a right whale classifier from Marie Roch's group. 
	 */
	@Test
	public void rightWhaleTest()
	{
		
    	//relative paths to the resource folders.
    	String relModelPath  =	"./src/main/java/org/jamdev/jdl4pam/resources/generic/ghumpback/humpback_whale_1/saved_model.pb";
		String relWavPath  =	"./src/main/java/org/jamdev/jdl4pam/resources/generic/ghumpback/humpback.wav";
 
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


}
