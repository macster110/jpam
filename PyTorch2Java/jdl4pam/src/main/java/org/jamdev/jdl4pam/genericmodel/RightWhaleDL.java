package org.jamdev.jdl4pam.genericmodel;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.utils.DLMatFile;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;

import ai.djl.Model;
import ai.djl.engine.Engine;
import ai.djl.inference.Predictor;
import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;

/**
 * Scrappy test for loading a right whale classifier. 
 * 
 * @author Jamie Macaulay 
 *
 */
public class RightWhaleDL {
	/**
	 * Test the classifier on a wave file. 
	 * @param args - the arguments. 
	 */
	public static void main(String[] args) {

		// let's test on some right whale data. 

		//right whale at 3.01.201 - 181 sexonds. 
		
		String wavFilePath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/SouthernRightWhale001-v1/sar98_trk3_8000.wav";


		//		String modelPath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/model_lenet_dropout_input_conv_all.hdf5"; 
		String modelPath = "/Users/au671271/Desktop/model_lenet_dropout_input_conv_all/saved_model.pb";
		
	
		
		
		String outMatlabPath = "/Users/au671271/Google Drive/Programming/MATLAB/PAMGUARD/deep_learning/generic_classifier/rightwhaespec.mat";

		float sr = 2000; 
		int startchunk =  (int) (181.2*sr); 
		int chunkSize = 4000; 
		
		try {

			File file = new File(modelPath); 

			Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
			String modelName = file.getName(); 

			System.out.println(Engine.getAllEngines()); 

			Model model = Model.newInstance(modelPath, "TensorFlow"); 

			model.load(modelDir, "saved_model.pb");

			System.out.println("Input: " + model.describeInput().values()); 
			System.out.println("Output: " + model.describeOutput().values()); 

			SpectrogramTranslator translator = new SpectrogramTranslator(); 
			//predictor for the model
			Predictor<float[][][], float[]> predictor = model.newPredictor(translator);


			///load the wave data. 
			//Open wav files. 
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);
			
			
			int[] samplesChunk = new int[] {0, 4000}; // the sample chunk to use. 


			//create the transforms. 
			ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

			//waveform transforms. 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sr)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, startchunk, startchunk+chunkSize)); 
			//			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.PREEMPHSIS, preemphases)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, 256, 100)); 
			//in the python code they have an sfft of 129xN where N is the number of chunks. They then
			//choose fft data between bin 5 and 45 in the FFT. 	This roughly between 40 and 350 Hz. 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCROPINTERP, 47.0, 357.0, 40)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISEROWSUM)); 


			//generate the transforms. 
			ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlTransformParamsArr); 
			

			((WaveTransform) transforms.get(0)).setWaveData(soundData); 

			//run the tansforms. 
			DLTransform transform = transforms.get(0); 
			for (int i=0; i<transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform); 
			}

			float[][] dataF =  DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
			System.out.println("Data input size: " + dataF.length + "   " + dataF[0].length);
			
			Matrix matrixSpec=  DLMatFile.array2Matrix(((FreqTransform) transform).getSpecTransfrom().getTransformedData());

			MatFile matFile = Mat5.newMatFile()
					.addArray("spectrogram", matrixSpec); 

			try {
				Mat5.writeToFile(matFile, outMatlabPath);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}



			float[] output = null; 
			float[][][] data;
			for (int i=0; i<1; i++) {
				long time1 = System.currentTimeMillis();
				//				data = DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
				//				System.out.println("Data input size: " + data.length + "   " + data[0].length);
				int nSpec = 400;
				data = new float[nSpec][][]; 
				for (int j=0; j<nSpec; j++) {
					data[j]=  DLUtils.makeDummySpectrogram(40, 40); 
				}

				output = predictor.predict(data); 
				long time2 = System.currentTimeMillis();
				System.out.println("Time to run model: " + (time2-time1) + " ms"); 
			}

			//			Criteria criteria = Criteria.builder().
			//					 optModelUrls(modelPath).build();
			//			 
			//			 ModelZoo.loadModel(criteria);


		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 


		//		//Open wav files. 
		//		try {
		//			
		//			GenericModelParams genericModelParams = new GenericModelParams();
		//			
		//			AudioData soundData;
		//			soundData = DLUtils.loadWavFile(wavFilePath);
		//			soundData = soundData.trim(samplesChunk[0], samplesChunk[1]); 
		//			
		//			GenericClassifier genericClassifier = new GenericClassifier(modelPath); 
		//
		//			double[] result = genericClassifier.runModel(soundData.getScaledSampleAmpliudes(), soundData.sampleRate); 
		//			
		//		    for (int j=0; j<result.length; j++) {
		//		    	System.out.println("The probability of class " + j + " is "  + result[j]); 
		//		    }
		//
		//
		//		} catch (IOException e) {
		//			// TODO Auto-generated catch block
		//			e.printStackTrace();
		//		} catch (UnsupportedAudioFileException e) {
		//			// TODO Auto-generated catch block
		//			e.printStackTrace();
		//		}
	}

}
