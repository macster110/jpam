package org.jamdev.jdl4pam.koogu;

import static org.junit.Assert.assertTrue;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.jamdev.jdl4pam.genericmodel.GenericModel;
import org.jamdev.jdl4pam.genericmodel.GenericModelParams;
import org.jamdev.jdl4pam.genericmodel.HumpbackGoogle;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformParser2;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformsParser;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.json.JSONObject;
import org.junit.Test;

import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;

public class KooguTest {


	//	@Test
	//	public void kooguJSONTest()
	//	{
	//		float sr = 1000; 
	//		int chunkSize  =  (int) (2.25*sr); //right whale call
	//
	//		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();
	//
	//		//waveform transforms. 
	//		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sr)); 
	//		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, 0, chunkSize));
	//
	//		GenericModelParams genericModelParams = new GenericModelParams(); 
	//
	//		genericModelParams.dlTransforms = dlTransformParamsArr;
	//		genericModelParams.segLen = 2.25*1000;
	//		genericModelParams.classNames = new String[] {"Noise, Right Whale"}; 
	//
	//
	//		GenericModelParams params;
	//		try {
	//			params = JSONParseTest.jsonParseTest(genericModelParams);
	//			
	//			assertTrue(genericModelParams.equals(params) ); 
	//
	//		} catch (Exception e) {
	//			// TODO Auto-generated catch block
	//			e.printStackTrace();
	//		}
	//
	//	}


	/**
	 * Test opening an archived Koogu model. 
	 */
	@Test
	public void kooguModelTestBlueWhale() {

		System.out.println("Koogu - test Blue Whale model"); 

		//relative paths to the resource folders.
		String relModelPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/blue_whale/blue_whale_24.kgu";
		String relWavPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/blue_whale/20190527_190000.wav";

		String relPredicitonFile  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/blue_whale/rawScores_20190527_190000.csv";

		Path path = Paths.get(relPredicitonFile);

		double[][] predictions = getPredictions(path.toAbsolutePath().normalize().toString());
		//		double[][] predictions = new double[][] {{0,0,1}};

		//		double[][] predictions = new double[][] {{0,1},{1,0},{1,0}, {1,0}, {1,0}, {1,0}, {1,0}, {1,0},{1,0},{1,0}}; //right whale in second chunk. 

		path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();

		path = Paths.get(relWavPath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();

		//run the Koogu test. 
		float[][] results = kooguModelTest(modelPath,  wavFilePath,  predictions); 

		//export as the same filename but a mat file
		relPredicitonFile = relPredicitonFile.replace("csv", "mat"); 
		exportMatFile(results,  relPredicitonFile);

	}


	/**
	 * Test a blue whale classifier form Brian Miller. 
	 */
	@Test
	public void kooguTestBlueWhale() {

		System.out.println("Koogu - test Blue Whale model"); 

		//relative paths to the resource folders.
		String relModelPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/blue_whale/BmD_24_tf_model/koogu/saved_model.pb";
		String relWavPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/blue_whale/20190527_190000.wav";

		String relPredicitonFile  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/blue_whale/rawScores_20190527_190000.csv";

		Path path = Paths.get(relPredicitonFile);

		double[][] predictions = getPredictions(path.toAbsolutePath().normalize().toString());
		//		double[][] predictions = new double[][] {{0,0,1}};

		//		double[][] predictions = new double[][] {{0,1},{1,0},{1,0}, {1,0}, {1,0}, {1,0}, {1,0}, {1,0},{1,0},{1,0}}; //right whale in second chunk. 

		path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();

		path = Paths.get(relWavPath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();

		//the target sample rate
		float sr = 250; 

		///note you must check audiospec metadata file to get the correct chunk size
		int chunkSize  =  (int) (4.5*sr); //blue whale call 23
		//		int chunkSize  =  (int) (5*sr); //blue whale call 24

		//run the Koogu test. 
		float[][] results = kooguTest(modelPath,  wavFilePath,  predictions,  sr,  chunkSize); 

		//export as the same filename but a mat file
		relPredicitonFile = relPredicitonFile.replace("csv", "mat"); 
		exportMatFile(results,  relPredicitonFile);

	}

	/**
	 * Export a MATLAB file of prediction results
	 * @param results - the results to export to MAT file
	 * @param filename - the name of the file to export to - shoulds end in .mat
	 */
	private void exportMatFile(float[][] results, String filename) {

		Path path = Paths.get(filename);


		Matrix resultsM  = Mat5.newMatrix(results.length, results[0].length);

		for (int i=0; i<results.length; i++) {
			for (int j=0; j<results[i].length; j++) {
				resultsM.setFloat(i, j, results[i][j]);
			}
		}

		MatFile matFile = Mat5.newMatFile()
				.addArray("predictions", resultsM);

		// Serialize to disk using default configurations
		try {
			Mat5.writeToFile(matFile, path.toAbsolutePath().normalize().toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * Read a Koogu rawScroes_XXx.csv file. Should handle different number of output classes. 
	 * @param resultsPath - the path to the file
	 * @return the raw scores - first columns is the sample start - other columns are the prediction scores.
	 */
	public static double[][] getPredictions(String resultsPath) {
		return getPredictions(resultsPath, 0);
	}

	/**
	 * Read a Koogu rawScroes_XXx.csv file. Should handle different number of output classes. 
	 * @param resultsPath - the path to the file
	 * @param skip - number of lines to skip at start. 
	 * @return the raw scores - first columns is the sample start - other columns are the prediction scores.
	 */
	public static double[][] getPredictions(String resultsPath, int skip) {
		//run the humpback whale classifier. 

		File file = new File(resultsPath);
		FileReader fr;
		try {
			fr = new FileReader(file);
			fr.getEncoding();
			//			System.out.println("Encoding: " + fr.getEncoding());

			BufferedReader br = new BufferedReader(fr);
			//get number of lines so we can pre-allocate an array.
			int lines = 0;
			String line = br.readLine();
			while (line  != null) {
				//				System.out.println(line);
				line = br.readLine(); 
				lines++;
			}

			br.close();

			int ind=0; 

			double[][] predicitons = new double[lines][];

			fr = new FileReader(file);
			br = new BufferedReader(fr);
			//run through all the different thinks
			int count = 0;
			while((line = br.readLine()) != null){

				if (count<skip) {
					count++;
					continue;
				}
									//read the data from the text file
//								System.out.println(line);

				String[] data = line.split(",");
				double[] predictionLine = new double[data.length];

				for (int i=0; i<data.length; i++) {
					predictionLine[i]= Double.valueOf(data[i]);
				}

				predicitons[ind]=predictionLine;

				ind++;
				count++;
			}

			br.close();


			return predicitons;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}


	/**
	 * Test a right whale classifier from Koogu
	 */
	@Test
	public void kooguRightWhaleTest()
	{

		System.out.println("Koogu - test Right Whale model"); 

		//relative paths to the resource folders.
		String relModelPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/right_whale/model/koogu_narw_model/saved_model.pb";
		String relWavPath  =	"./src/test/java/org/jamdev/jdl4pam/resources/Koogu/right_whale/right_whale_koogu.wav";

		//the target sample rate
		float sr = 1000; 

		int chunkSize  =  (int) (2.25*sr); //right whale call

		double[][] predictions = new double[][] {{0, 0,1},{chunkSize, 1,0}}; //right whale in second chunk. 

		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();

		path = Paths.get(relWavPath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();

		//		float[] results = KooguDLTest.runKooguDL( modelPath,  wavFilePath,  0);


		//run the Koogu test. 
		kooguTest(modelPath,  wavFilePath,  predictions,  sr,  chunkSize); 

	}


	/**
	 * Test a koogu model against predictions. 
	 * @param modelPath - the path to model. 
	 * @param wavFilePath - the wav file path. 
	 * @param predictions - the predictions. 
	 * @paramSR sr - the target chunk size after decimation if there is any.... 
	 * @param chunkSize the chunk size in SAMPLES of the target sample rate. 
	 */
	public float[][] kooguTest(String modelPath, String wavFilePath, double[][] predictions, float sr, int chunkSize)
	{

		int startChunck  = 0; 

		int nRuns = 1; 

		try {

			GenericModel model = new GenericModel(modelPath);

			AudioData soundData = DLUtils.loadWavFile(wavFilePath);

			//cheat here a bit - we don't want to keep interpolating the file. 
			//			soundData = soundData.interpolate(sr);
			soundData = soundData.interpolate_scipy(sr);

			float[][] results = new float[predictions.length][];

			int truecount=0;
			for (int ii=0; ii<predictions.length; ii++) {

				startChunck = (int) predictions[ii][0]; //the start sample. 
				//				startChunck = (int) 126000; //blue whale

				//generate the transforms. 
				//create the transforms. 
				ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

				//waveform transforms. 
				//				dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sr)); 
				dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.FILTER, AudioData.HIGHPASS, 9, AudioData.BUTTERWORTH, 30, -1));
				dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, startChunck, startChunck+chunkSize));
				dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.NORMALISE_WAV));
				
				System.out.println(dlTransformParamsArr);


				float[] output = KooguDLTest.runGenericWaveModel(model, soundData, dlTransformParamsArr, nRuns);

				//				for (int i=0; i<output.length ; i++) {
				//					System.out.println(output[i] +  "  " + predictions[ii][i%2]);
				//				}

				//				System.out.println(output[0] + " --- " + (predictions[ii][0]-0.1) + " -- " + (output[0]> predictions[ii][0]-0.1) +  " " + (output[0]< predictions[ii][0]+0.1));
				System.out.println(String.format("Chunk %d %d output[0]: predicted %.5f true %.5f ; output[1]: predicted %.5f true %.5f",ii, startChunck,
						output[0], predictions[ii][1], output[1], predictions[ii][2])); 

				boolean out0 = output[0]> predictions[ii][1]-0.1 && output[0]<predictions[ii][1]+0.1; 
				//
				boolean out1 = output[1]> predictions[ii][2]-0.1 && output[1]<predictions[ii][2]+0.1; 

				results[ii]=output;

				//				System.out.println("out0: " + out0 + " out1: " + out1);

				if (out0 && out1) {
					truecount++;
				}
			}

			double percTrue = 100*((double) truecount)/predictions.length; 

			System.out.println(String.format("Precentage results true: %.2f  count %d", percTrue, truecount));

			//ramp this number up when we figure out why Kooguy and PG sometimes give quite different results. 
			// Precentage results true: 83.31  count 1498 - without scipy

			assertTrue(percTrue>0.8);

			return results; 

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	/**
	 * Test any koogu model (.kgu) against predictions. 
	 * @param modelPath - the path to model. 
	 * @param wavFilePath - the wav file path. 
	 * @param predictions - the predictions. 
	 * @paramSR sr - the target chunk size after decimation if there is any.... 
	 * @param chunkSize the chunk size in SAMPLES of the target sample rate. 
	 */
	public float[][] kooguModelTest(String modelPath, String wavFilePath, double[][] predictions)
	{

		int startChunck  = 0; 

		int nRuns = 1; 


		try {

			//load the koogu model
			KooguModel model = new KooguModel(modelPath);
			
			System.out.println(model.getAudioReprFile());

			String jsonString = DLTransformsParser.readJSONString(new File(model.getAudioReprFile()));

			//Need to figure out if this is the new or old format. 
			JSONObject jsonObject = new JSONObject(jsonString);

			AudioData soundData = DLUtils.loadWavFile(wavFilePath);


			boolean isParamsV2 =DLTransformParser2.isParamsV2(jsonObject); 

			//standard format. 
			GenericModelParams params = DLTransformParser2.readJSONParams(jsonObject);
			System.out.println(params.segLen);

			
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
			for (int ii=0; ii<predictions.length; ii++) {

				startChunck = (int) predictions[ii][0]; //the start sample. 
				//				startChunck = (int) 126000; //blue whale
				
				

				//change the trim paramter. 
				params.dlTransforms.get(params.dlTransforms.size()-1).params = new Number[] {startChunck, startChunck+chunkSize};
				
//				System.out.println(params.dlTransforms);

				float[] output = KooguDLTest.runGenericWaveModel(model, soundData, params.dlTransforms, nRuns);

				//				for (int i=0; i<output.length ; i++) {
				//					System.out.println(output[i] +  "  " + predictions[ii][i%2]);
				//				}

				//				System.out.println(output[0] + " --- " + (predictions[ii][0]-0.1) + " -- " + (output[0]> predictions[ii][0]-0.1) +  " " + (output[0]< predictions[ii][0]+0.1));
				System.out.println(String.format("Chunk %d %d output[0]: predicted %.5f true %.5f ; output[1]: predicted %.5f true %.5f",ii, startChunck,
						output[0], predictions[ii][1], output[1], predictions[ii][2])); 

				boolean out0 = output[0]> predictions[ii][1]-0.1 && output[0]<predictions[ii][1]+0.1; 
				//
				boolean out1 = output[1]> predictions[ii][2]-0.1 && output[1]<predictions[ii][2]+0.1; 

				results[ii]=output;

				//				System.out.println("out0: " + out0 + " out1: " + out1);

				if (out0 && out1) {
					truecount++;
				}
			}

			double percTrue = 100*((double) truecount)/predictions.length; 

			System.out.println(String.format("Precentage results true: %.2f  count %d", percTrue, truecount));

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
