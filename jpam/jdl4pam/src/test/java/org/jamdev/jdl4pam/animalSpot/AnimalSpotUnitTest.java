package org.jamdev.jdl4pam.animalSpot;

import static org.junit.Assert.assertTrue;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.JamArr;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.junit.Test;

public class AnimalSpotUnitTest {

		/**
		 * Test animal spot on a pipistrellus. The 4th class prediction (counting from 0) should be >90% and all other classes should <1%.
		 */
	    @Test
	    public void animalSpotBatTest()
	    {
	    	
	    	//relative paths to the resource folders.
	    	String relModelPath  ="./src/test/java/org/jamdev/jdl4pam/resources/animalSpot/bat_multi_species/1_BAT_MULTI_JAMIE_5ms_256fft_10hop_MM_0_100_128_256_AUG_LN_WITHJAMIEDATA_AUGMENTATION_V1.pk";
			String relWavPath  ="./src/test/java/org/jamdev/jdl4pam/resources/animalSpot/bat_multi_species/20200817_011424.wav";
	 
		
			Path path = Paths.get(relModelPath);
			//note that normalize gets rid of all the redundant elements (e.g. .)
			String modelPath = path.toAbsolutePath().normalize().toString();
			
			path = Paths.get(relWavPath);
			String wavPath = path.toAbsolutePath().normalize().toString();
	
			System.out.println(modelPath); 
	
			int[] samplesChunk = new int[] {0, 1999}; // the sample chunk to use. 
	
			//run the model. 
			double[] prob = org.jamdev.jdl4pam.animalSpot.AnimalSpotTest.runAnimalSpot(modelPath,  wavPath, samplesChunk); 
			
	
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


	/**
	 * Test animal spot on a pipistrellus. The 4th class prediction (counting from 0) should be >90% and all other classes should <1%.
	 */
	@Test
	public void animalSpotBlueWhaleTest()
	{
//
//		double[][] predictions = new double[][] {
//			{0, 2},
//			{112.0,	118.999},
//			{529.0,	533.0},
//			{601.0	,609.0},
//			{703.0,	714.0},
//			{771.0,	782.0}
//		};
		
		double[][] predictions = new double[][] {
			{116.0,	117.999},
			{129.0,	130.999},
		};


		//relative paths to the resource folders.
		String relModelPath  ="./src/test/java/org/jamdev/jdl4pam/resources/animalSpot/blue_whale/ANIMAL-SPOT.pk";
		String relWavPath  ="./src/test/java/org/jamdev/jdl4pam/resources/animalSpot/blue_whale/2019-09-04T09-30-06.wav";

		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();

		path = Paths.get(relWavPath);
		String wavPath = path.toAbsolutePath().normalize().toString();

		System.out.println(modelPath); 


		//first open the model and get the correct parameters. 
		try {
			AnimalSpotModel soundSpotModel = new AnimalSpotModel(modelPath);


			//Open wav files. 
			AudioData soundData = DLUtils.loadWavFile(wavPath);
			
			System.out.println("Sample rate: " + soundData.getSampleRate());  


			for (int i=0; i<predictions.length ;i++) {
				
				int[] samplesChunk = new int[] {(int) (predictions[i][0]*soundData.sampleRate), (int) (predictions[i][1]*soundData.sampleRate)}; // the sample chunk to use. 
				JamArr.printArray(samplesChunk);

				//run the model. 
				double[] prob = org.jamdev.jdl4pam.animalSpot.AnimalSpotTest.runAnimalSpot(soundSpotModel,  soundData, samplesChunk, 1, true);
				
				System.out.println("Predicitons: ");  
				JamArr.printArray(prob);
				
//				for (int j = 0; j<prob.length; j++) {
//					if (i==1) {
//						//pipi class should be >0.9
//						assertTrue( prob[i]>0.9 );
//					}
//					else {
//						//all other species should be less than 0.1
//						assertTrue( prob[i]<0.1 );
//					}
//				}

			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}



}
