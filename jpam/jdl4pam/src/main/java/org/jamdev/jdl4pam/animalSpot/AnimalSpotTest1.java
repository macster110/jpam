package org.jamdev.jdl4pam.animalSpot;

public class AnimalSpotTest1 {
	
	
	public static void main(String[] args) {
		String modelPath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/AnimalSpot/Bats_1/1_BAT_MULTI_JAMIE_5ms_256fft_10hop_MM_0_100_128_256_AUG_LN_WITHJAMIEDATA_AUGMENTATION_V1.pk";

		//wav file 
		try {			
			//first open the model and get the correct parameters. 
			AnimalSpotModel soundSpotModel = new AnimalSpotModel(modelPath); 

			//System.out.println(soundSpotModel.getRawParamsString());
			//create the DL params. 
			AnimalSpotParams dlParams = new AnimalSpotParams(soundSpotModel.getTransformsString());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}


}
