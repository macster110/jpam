package org.jamdev.jdl4pam.generic;

import static org.junit.Assert.assertTrue;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.jamdev.jdl4pam.genericmodel.RightWhaleDL;
import org.junit.Test;

/**
 * Test a right whale classifier from Marie Roch's group. 
 * <p>
 * For more info see
 * <p>
 * Shiu, Y., Palmer, K.J., Roch, M.A., Fleishman, E., Liu, X., Nosal, E.-M., Helble, T., Cholewiak, D., Gillespie, D., Klinck, H., 2020. 
 * Deep neural networks for automated detection of marine mammal species. Scientific Reports 10, 607. https://doi.org/10.1038/s41598-020-57549-y
 */
public class RightWhaleTest {

	/**
	 * Test a right whale classifier from Marie Roch's group. 
	 */
	@Test
	public void rightWhaleTest()
	{
		
    	//relative paths to the resource folders.
    	String relModelPath  =	"./src/main/java/org/jamdev/jdl4pam/resources/generic/rightwhale/model_lenet_dropout_input_conv_all/saved_model.pb";
		String relWavPath  =	"./src/main/java/org/jamdev/jdl4pam/resources/generic/rightwhale/sar98_trk3_8000.wav";
 
		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();
		
		path = Paths.get(relWavPath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();

		float sr = 2000; 
		int startchunk =  (int) (181.2*sr); //right whale call

		//run the right whale model. 
		float[] output  = RightWhaleDL.runRightWhaleDL(modelPath, wavFilePath, startchunk); 

		for (int j = 0; j<output.length; j++) {
			System.out.println("Output: " + j + " : " + output[j]);
		}
	
		
		//the wav file contains a right whale detection at 181.2 seconds into the file. 
		
		assertTrue( output[0]<0.01 ); //noise
		assertTrue( output[1]>0.98 ); //right whale

	}

}
