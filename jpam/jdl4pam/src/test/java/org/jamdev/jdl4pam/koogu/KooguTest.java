package org.jamdev.jdl4pam.koogu;

import static org.junit.Assert.assertTrue;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.genericmodel.GenericModel;
import org.jamdev.jdl4pam.genericmodel.GenericModelParams;

import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.json.JSONParseTest;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.junit.Test;

import ai.djl.MalformedModelException;

public class KooguTest {


	@Test
	public void kooguJSONTest()
	{
		float sr = 1000; 
		int chunkSize  =  (int) (2.25*sr); //right whale call

		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		//waveform transforms. 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sr)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, 0, chunkSize));

		GenericModelParams genericModelParams = new GenericModelParams(); 

		genericModelParams.dlTransforms = dlTransformParamsArr;
		genericModelParams.segLen = 2.25*1000;
		genericModelParams.classNames = new String[] {"Noise, Right Whale"}; 


		GenericModelParams params;
		try {
			params = JSONParseTest.jsonParseTest(genericModelParams);
			
			assertTrue(genericModelParams.equals(params) ); 

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * Test a blue whale classifier form Brian Miller. 
	 */
	@Test
	public void kooguTestBlueWhale() {

		System.out.println("Koogu test Blue Whale model"); 

		//relative paths to the resource folders.
		String relModelPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/blue_whale/BmD_23_tf_model/koogu/saved_model.pb";
		String relWavPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/blue_whale/20190527_190000.wav";

		double[][] predictions = new double[][] {{0,1},{1,0},{1,0}, {1,0}, {1,0}, {1,0}, {1,0}, {1,0},{1,0},{1,0}}; //right whale in second chunk. 

		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();

		path = Paths.get(relWavPath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();

		//the target sample rate
		float sr = 1000; 

		int chunkSize  =  (int) (5*sr); //blue whale call
		
		//run the Koogu test. 
//		kooguTest(modelPath,  wavFilePath,  predictions,  sr,  chunkSize); 

	}

	/**
	 * Test a right whale classifier from Koogu
	 */
	@Test
	public void kooguRightWhaleTest()
	{

		System.out.println("Koogu test Right Whale model"); 

		//relative paths to the resource folders.
		String relModelPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/right_whale/model/koogu_narw_model/saved_model.pb";
		String relWavPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/right_whale/right_whale_koogu.wav";

		double[][] predictions = new double[][] {{0,1},{1,0}}; //right whale in second chunk. 

		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();

		path = Paths.get(relWavPath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();

		//		float[] results = KooguDLTest.runKooguDL( modelPath,  wavFilePath,  0);

		//the target sample rate
		float sr = 1000; 

		int chunkSize  =  (int) (2.25*sr); //right whale call
		
		//run the Koogu test. 
		kooguTest(modelPath,  wavFilePath,  predictions,  sr,  chunkSize); 

	}


	/**
	 * Test a koogu model against predictions. 
	 * @param modelPath - the path to model. 
	 * @param wavFilePath - the wav file path. 
	 * @param predictions - the predictions. 
	 * @paramSR sr - the target sample rate. 
	 * @param chunkSize the chunk size in SAMPLES. 
	 */
	public void kooguTest(String modelPath, String wavFilePath, double[][] predictions, float sr, int chunkSize)
	{

		int startChunck  = 0; 

		int nRuns = 1; 

		try {

			GenericModel model = new GenericModel(modelPath);

			AudioData soundData = DLUtils.loadWavFile(wavFilePath);

			for (int ii=0; ii<predictions.length; ii++) {

				startChunck = (int) (ii*chunkSize) ;

				//generate the transforms. 
				//create the transforms. 
				ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

				//waveform transforms. 
				dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sr)); 
				dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, startChunck, startChunck+chunkSize));

				float[] output = KooguDLTest.runGenericWaveModel(model, soundData, dlTransformParamsArr, nRuns);

				//				for (int i=0; i<output.length ; i++) {
				//					System.out.println(output[i] +  "  " + predictions[ii][i%2]);
				//				}

				//				System.out.println(output[0] + " --- " + (predictions[ii][0]-0.1) + " -- " + (output[0]> predictions[ii][0]-0.1) +  " " + (output[0]< predictions[ii][0]+0.1));
				System.out.println(String.format("Chunk %d %d Predicted output[0]: %.2f true output[0]: %.2f output[0]: %.2f true output[0]: %.2f",ii, startChunck,
						  output[0], predictions[ii][0], output[1], predictions[ii][1])); 
				  
//				assertTrue(output[0]> predictions[ii][0]-0.1 && output[0]< predictions[ii][0]+0.1); 
//
//				assertTrue(output[1]> predictions[ii][1]-0.1 && output[1]< predictions[ii][1]+0.1); 


			}

		} catch (MalformedModelException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 


	}



}
