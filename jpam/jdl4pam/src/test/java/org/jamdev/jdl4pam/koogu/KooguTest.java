package org.jamdev.jdl4pam.koogu;

import static org.junit.Assert.assertTrue;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.genericmodel.GenericModel;
import org.jamdev.jdl4pam.genericmodel.GenericModelParams;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.WaveTransform;
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
	 * Test a right whale classifier from Marie Roch's group. 
	 */
	@Test
	public void kooguRightWhaleTest()
	{

		//relative paths to the resource folders.
		String relModelPath  =	"./src/main/java/org/jamdev/jdl4pam/resources/Koogu/right_whale/model/koogu_narw_model/saved_model.pb";
		String relWavPath  =	"./src/main/java/org/jamdev/jdl4pam/resources/Koogu/right_whale/right_whale_koogu.wav";

		double[][] predictions = new double[][] {{0,1},{1,0}}; //right whale in second chunk. 

		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();

		path = Paths.get(relWavPath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();


		//the target sample rate
		float sr = 1000; 

		int chunkSize  =  (int) (2.25*sr); //right whale call
		int startChunck  = 0; 

		int nRuns = 5; 

		try {

			GenericModel model = new GenericModel( modelPath);


			AudioData soundData = DLUtils.loadWavFile(wavFilePath);

			GenericModelParams genericModelParams = new GenericModelParams(); 

			for (int ii=0; ii<predictions.length; ii++) {
				
				startChunck = (int) (ii*2.25*sr) ;
				
				//generate the transforms. 
				//create the transforms. 
				ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

				//waveform transforms. 
				dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sr)); 
				dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, startChunck, startChunck+chunkSize));

				ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlTransformParamsArr); 


				((WaveTransform) transforms.get(0)).setWaveData(soundData); 

				//run the tansforms. 
				DLTransform transform = transforms.get(0); 
				for (int i=0; i<transforms.size(); i++) {
					transform = transforms.get(i).transformData(transform); 
				}


				double[] dataD = ((WaveTransform) transform).getWaveData().getScaledSampleAmpliudes();

				float[] dataF = new float[dataD.length]; 
				for (int i=0; i<dataF.length; i++) {
					dataF[i]= (float) dataD[i];
				}




				System.out.println("Data input size: " + dataF.length);

				int nBatch = 5; //the number of batches. 
				float[] output = null; 
				long totaltime1 = System.currentTimeMillis();

				float[][] batchData = new float[nBatch][]; 
				for (int j=0; j<nBatch; j++) {
					batchData[j] = dataF; 
				}

				for (int j=0; j<nRuns; j++) {
					long time1 = System.currentTimeMillis();

					output = model.runModel(batchData);
					long time2 = System.currentTimeMillis();
					System.out.println("Time to run model: " + (time2-time1) + " ms"); 

					long totaltime2 = System.currentTimeMillis();

					System.out.println("Total time to run model: " + (totaltime2-totaltime1) + " ms"); 
				}

//				for (int i=0; i<output.length ; i++) {
//					System.out.println(output[i] +  "  " + predictions[ii][i%2]);
//				}

				//					System.out.println(output[0] + " --- " + (predictions[ii][0]-0.1) + " -- " + (output[0]> predictions[ii][0]-0.1) +  " " + (output[0]< predictions[ii][0]+0.1));

				assertTrue(output[0]> predictions[ii][0]-0.1 && output[0]< predictions[ii][0]+0.1); 

				assertTrue(output[1]> predictions[ii][1]-0.1 && output[1]< predictions[ii][1]+0.1); 


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
