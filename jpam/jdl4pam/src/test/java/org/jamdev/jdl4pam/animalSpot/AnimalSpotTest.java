package org.jamdev.jdl4pam.animalSpot;

import static org.junit.Assert.assertTrue;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.junit.Test;

public class AnimalSpotTest {

	/**
	 * Test animal spot on a pipistrellus. The 4th class prediction (counting from 0) should be >90% and all other classes should <1%.
	 */
    @Test
    public void animalSpotBatTest()
    {
    	
    	//relative paths to the resource folders.
    	String relModelPath  ="./src/main/java/org/jamdev/jdl4pam/resources/animalSpot/bat_multi_species/1_BAT_MULTI_JAMIE_5ms_256fft_10hop_MM_0_100_128_256_AUG_LN_WITHJAMIEDATA_AUGMENTATION_V1.pk";
		String relWavPath  ="./src/main/java/org/jamdev/jdl4pam/resources/animalSpot/bat_multi_species/20200817_011424.wav";
 
	
		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();
		
		path = Paths.get(relWavPath);
		String wavPath = path.toAbsolutePath().normalize().toString();

		System.out.println(modelPath); 

		int[] samplesChunk = new int[] {0, 1999}; // the sample chunk to use. 

		//run the model. 
		double[] prob = org.jamdev.jdl4pam.animalSpot.AnimalSpotBatTest.runAnimalSpotBat(modelPath,  wavPath, samplesChunk); 
		

        for (int i =0; i<prob.length; i++) {
        	if (i==4) {
        		//pipi class should be >0.9
        		assertTrue( prob[i]>0.9 );
        	}
        	else {
        		//all other species should be less than 0.1
        	    assertTrue( prob[i]<0.1 );
        	}
        }
    }
    

}
