package org.jamdev.jdl4pam.koogu;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.jamdev.jdl4pam.genericmodel.WaveformTranslator;
import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;




import ai.djl.Model;
import ai.djl.engine.Engine;
import ai.djl.inference.Predictor;

public class KooguDLTest {
	
	
	
	/**
	 * Run the right whale model. 
	 * @param modelPath - the path the saved_model.pb file
	 * @param wavFilePath - path to a wav file. 
	 * @param startChunck - the locatation to start form in the file (in seconds). 
	 * @return predicitons. 
	 */
	public static float[] runKooguDL(String modelPath, String wavFilePath, int startChunck) {
		float sr = 1000; 
		
		int nRuns = 5; 
		//int startchunk =  (int) (190.2*sr); 

		int chunkSize = (int) (1000*2.25); 
		
		try {

			File file = new File(modelPath); 

			Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
			String modelName = file.getName(); 

			System.out.println(Engine.getAllEngines()); 

			Model model = Model.newInstance(modelPath, "TensorFlow"); 

			model.load(modelDir, "saved_model.pb");

			System.out.println("Input: " + model.describeInput().values()); 
			System.out.println("Output: " + model.describeOutput().values()); 

			WaveformTranslator translator = new WaveformTranslator(model.describeInput()); 
			
			//predictor for the model
			Predictor<float[][], float[]> predictor = model.newPredictor(translator);


			///load the wave data. 
			//Open wav files. 
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);		

			//create the transforms. 
			ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

			//waveform transforms. 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sr)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, startChunck, startChunck+chunkSize)); 
			//			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.PREEMPHSIS, preemphases)); 
//			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, 256, 100)); 
//			//in the python code they have an sfft of 129xN where N is the number of chunks. They then
//			//choose fft data between bin 5 and 45 in the FFT. 	This roughly between 40 and 350 Hz. 
//			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCROPINTERP, 47.0, 357.0, 40)); 
//			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISEROWSUM)); 

			//generate the transforms. 
			ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlTransformParamsArr); 
			
			((WaveTransform) transforms.get(0)).setWaveData(soundData); 

			//run the tansforms. 
			DLTransform transform = transforms.get(0); 
			for (int i=0; i<transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform); 
			}
			
			
			double[] dataD = ((WaveTransform) transform).getWaveData().getScaledSampleAmplitudes();
			
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
				output = predictor.predict(batchData); 
				long time2 = System.currentTimeMillis();
				System.out.println("Time to run model: " + (time2-time1) + " ms"); 
	
				long totaltime2 = System.currentTimeMillis();
	
				System.out.println("Total time to run model: " + (totaltime2-totaltime1) + " ms"); 
			}
			
			for (int i=0; i<output.length ; i++) {
				System.out.println(output[i]);
			}

			//			Criteria criteria = Criteria.builder().
			//					 optModelUrls(modelPath).build();
			//			 
			//			 ModelZoo.loadModel(criteria);

				return output; 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null; 

		} 
		
		
		

	}
	
	/**
	 * Test the classifier on a wave file. 
	 * @param args - the arguments. 
	 */
	public static void main(String[] args) {

		// let's test on some right whale data. 

		//right whale at 3.01.201 - 181 seconds. 
		//the second  class is right whale. class 0 = noise, Class 1= right whale. 
		String wavFilePath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Koogu/right_whale/right_whale_koogu.wav";

		//		String modelPath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/model_lenet_dropout_input_conv_all.hdf5"; 
		String modelPath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Koogu/right_whale/model/koogu_narw_model/saved_model.pb";
		float sr = 1000; 
		int startchunk =  0; //(int) (2.25*sr); //right whale call
	
//		String outMatlabPath = "/Users/au671271/MATLAB-Drive/MATLAB/PAMGUARD/deep_learning/generic_classifier/rightwhaespec.mat";
		
		float[] output  = runKooguDL(modelPath, wavFilePath, startchunk); 
		

		for (int j = 0; j<output.length; j++) {
			System.out.println("Output: " + j + " : " + output[j]);
		}
	}
	

}
