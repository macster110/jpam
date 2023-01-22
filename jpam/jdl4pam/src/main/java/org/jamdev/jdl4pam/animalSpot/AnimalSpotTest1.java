package org.jamdev.jdl4pam.animalSpot;

public class AnimalSpotTest1 {
	
	
	public static void main(String[] args) {
		String modelPath = "/Volumes/GoogleDrive-108005893101854397430/My Drive/PAMGuard_dev/Deep_Learning/AnimalSpot/Minke_spot/models/MS-all-2048/model/minke-spot.pk";

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
