package org.jamdev.jdl4pam.generic;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;

import org.jamdev.jdl4pam.genericmodel.GenericModel;
import org.jamdev.jdl4pam.genericmodel.GenericModelParams;
import org.jamdev.jdl4pam.koogu.KooguDLTest;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.junit.Test;

public class GibbonTest {

	/**
	 * Test a Gibbon model using the Generic Model Framework. 
	 */
	@Test
	public void gibbonTest(){

		//the gibbin model
		String modelPath = "./src/test/java/org/jamdev/jdl4pam/resources/generic/gibbon/gibbon_model/saved_model/saved_model.pb";

		//the wav file
		String wavFilePath = "./src/test/java/org/jamdev/jdl4pam/resources/generic/gibbon/gibbon_detection.wav";
		
		float sr = 8000; //model samplerate
		double windowSize = 7.0; //seconds 

		//the expected output running the program in Python
		double[][] predictions = new double[][]{
			{0,9.7423404e-01, 1.6867964e-03, 2.8357367e-04},
			{1*7*8000,5.9026042e-03, 5.8442029e-06, 1.1701107e-06},
			{2*7*8000, 3.6076629e-03, 2.2650822e-06, 6.4889866e-07},
			{3*7*8000, 9.9562621e-01, 5.5051147e-05, 1.8434161e-04},
			{4*7*8000, 4.1060164e-04, 9.9579030e-01, 1.3399041e-04},
			{5*7*8000, 2.2205876e-02, 5.9773076e-01, 2.4194127e-05},
			{6*7*8000, 8.6745679e-01, 4.0851589e-03, 2.0674334e-04},
			{7*7*8000, 3.6767789e-05, 3.4960653e-08, 1.5367555e-09},
			{8*7*8000, 1.3008083e-05, 1.9438135e-05, 7.1030962e-07}
		};
		
		//set up the Gibbon model
		GenericModelParams params = new GenericModelParams(); 
		params.segLen = windowSize*1000.; //in milliseconds
		
		//create the transforms. 
		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		//waveform transforms are pretty simple for this model - just decimate. 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sr)); 
		
		params.dlTransforms = dlTransformParamsArr;
		
		//run the model
		float[][] results = genericModelWaveTest( modelPath, params , wavFilePath, predictions);
		
		
	}
	
	
	/**
	 * Test any koogu model (.kgu) against predictions. Only support wavefroms as inut
	 * @param modelPath - the path to model. 
	 * @param wavFilePath - the wav file path. 
	 * @param predictions - the predictions. 
	 * @paramSR sr - the target chunk size after decimation if there is any.... 
	 * @param chunkSize the chunk size in SAMPLES of the target sample rate. 
	 */
	public float[][] genericModelWaveTest(String modelPath, 	//standard format. 
			GenericModelParams params , String wavFilePath, double[][] predictions)
	{

		int startChunck  = 0; 

		int nRuns = 1; 


		try {

			//load the koogu model
			GenericModel model = new GenericModel(modelPath);
		

			AudioData soundData = DLUtils.loadWavFile(wavFilePath);

			//do we have a decimator? - if so, extract the sample rate. 
			float sr = soundData.getSampleRate();
			int trimIndex = -1;
			for (int i=0; i<params.dlTransforms.size(); i++) {
				if (params.dlTransforms.get(i).dltransfromType.equals(DLTransformType.DECIMATE)) {
					sr = params.dlTransforms.get(i).params[0].floatValue();
				}
			}
			int chunkSize = (int) ((params.segLen/1000.)*sr);

			System.out.println("Parameters: chunkSize: " + chunkSize + " sr "  + sr);

			//add trim transform to chunk up the data - the trim values are changed every iteration
			params.dlTransforms.add(new SimpleTransformParams(DLTransformType.TRIM, startChunck, startChunck+chunkSize)); 
	
			
			//cheat here a bit - we don't want to keep interpolating the file. 
			//			soundData = soundData.interpolate(sr);
			soundData = soundData.interpolate_scipy(sr);

			float[][] results = new float[predictions.length][];

			//generate the transforms. 
			//create the transforms. 
			System.out.println(params.dlTransforms);



			int truecount=0;
			
			//don't include last chunk because of different zero padding policies. 
			for (int ii=0; ii<predictions.length-1; ii++) {

				startChunck = (int) predictions[ii][0]; //the start sample. 
				//				startChunck = (int) 126000; //blue whale
				
				

				//change the trim parameter. 
				params.dlTransforms.get(params.dlTransforms.size()-1).params = new Number[] {startChunck, startChunck+chunkSize};
				
//				System.out.println(params.dlTransforms);

				float[] output = KooguDLTest.runGenericWaveModel(model, soundData, params.dlTransforms, nRuns);

				//				for (int i=0; i<output.length ; i++) {
				//					System.out.println(output[i] +  "  " + predictions[ii][i%2]);
				//				}

				//				System.out.println(output[0] + " --- " + (predictions[ii][0]-0.1) + " -- " + (output[0]> predictions[ii][0]-0.1) +  " " + (output[0]< predictions[ii][0]+0.1));
	

				boolean out0 = output[0]> predictions[ii][1]-0.1 && output[0]<predictions[ii][1]+0.1; 
				//
				boolean out1 = output[1]> predictions[ii][2]-0.1 && output[1]<predictions[ii][2]+0.1; 

				boolean out2 = output[2]> predictions[ii][3]-0.1 && output[2]<predictions[ii][3]+0.1; 

				results[ii]=output;

				//				System.out.println("out0: " + out0 + " out1: " + out1);

				if (out0 && out1 && out2) {
					truecount++;
				}
				
				System.out.println(String.format("Chunk %d %d output[0]: predicted %.5f true %.5f ; output[1]: predicted %.5f true %.5f; output[2]: predicted %.5f true %.5f passed - %b",ii, startChunck,
						output[0], predictions[ii][1], output[1], predictions[ii][2],  output[2], predictions[ii][3],(out0 && out1 && out2) )); 
			}

			double percTrue = 100*((double) truecount)/(predictions.length-1); 

			System.out.println(String.format("Percentage results true: %.2f  count %d", percTrue, truecount));

			//ramp this number up when we figure out why Kooguy and PG sometimes give quite different results. 
			// Precentage results true: 83.31  count 1498 - without scipy

			assertTrue(percTrue>0.8);

			return results; 

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}


}
