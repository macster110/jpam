package org.jamdev.jdl4pam.dlpam;

import java.io.IOException;

import org.jamdev.jdl4pam.SoundSpot.SoundSpotModel;
import org.jamdev.jdl4pam.SoundSpot.SoundSpotParams;

import ai.djl.MalformedModelException;

/**
 * Test the loading of a SoundSpot model 
 * @author Jamie Macaulay 
 *
 */
public class SoundSpotModelTest {

	public static void main( String[] args ) {
		
		String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/bats_denmark/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000_JIT.pk"; 
		//first open the model and get the correct parameters. 
		SoundSpotModel soundSpotModel;
		try {
			soundSpotModel = new SoundSpotModel(modelPath);
						
			System.out.println(soundSpotModel.getRawParamsString());
			System.out.println(soundSpotModel.getTransformsString());

			//create the DL params. 
			SoundSpotParams dlParams = new SoundSpotParams(soundSpotModel.getTransformsString());
			
			System.out.println(dlParams.toString());

			
		} catch (MalformedModelException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		

	}

}
