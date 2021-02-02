package org.jamdev.jdl4pam.genericmodel;

import java.io.File;
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
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;

import ai.djl.Model;
import ai.djl.engine.Engine;
import ai.djl.inference.Predictor;

/**
 * Create the generic classifier. 
 * 
 * @author Jamie Macaulay
 *
 */
public class GenericClassifier {
	
	
	/**
	 * The generic model. 
	 */
	private GenericModel genericModel;
	
	
	/**
	 * The generic model parameters. 
	 */
	private GenericModelParams genericModelParams = new GenericModelParams(); 
	
	
	public GenericClassifier(String modelPath) {
		loadModel( modelPath);
	}
	
	/**
	 * Load a sound spot model. This loads the model into memory
	 * and extracts the metadata from the model creating a SoundSpotParams class. 
	 * @param modelPath - the path to the model. 
	 * @return true if the model was loaded successfully. 
	 */
	public boolean loadModel(String modelPath) {
		//first open the model and get the correct parameters. 
		try {
			genericModel = new GenericModel(modelPath);
			return true; 
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false; 
		} 
	}



	/**
	 * Run the currently loaded model on a chunk of sound data. 
	 * @param rawWaveData - a raw chunk of sound data with peak levels between -1 and 1. 
	 * @return the probability of each class in the model. 
	 */
	public double[] runModel(double[] rawWaveData, float sR) {

		//wav file 
		try {			

			//open .wav files. 
			AudioData soundData = new AudioData(rawWaveData, sR); 

			//generate the transforms. 
			ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(genericModelParams.dlTransforms); 


			((WaveTransform) transforms.get(0)).setWaveData(soundData); 

			DLTransform transform = transforms.get(0); 
			for (int i=0; i<transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform); 
			}


			float[] output = null; 
			float[][] data;
			for (int i=0; i<10; i++) {
				//long time1 = System.currentTimeMillis();
				data = DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData()); 
				output = genericModel.runModel(data); 
				//long time2 = System.currentTimeMillis();
				//System.out.println("Time to run model: " + (time2-time1) + " ms"); 
			}

			double[] prob = new double[output.length]; 
			for (int j=0; j<output.length; j++) {
				//python code for this. 
				//				    	prob = torch.nn.functional.softmax(out).numpy()[n, 1]
				//			                    pred = int(prob >= ARGS.threshold)		    	
				//softmax function
				prob[j] = DLUtils.softmax(output[j], output); 
				//System.out.println("The probability is: " + prob[j]); 
			}

			return prob; 

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * Get the model parameters. This handles how to transform the data for the model. 
	 * @return the model paramters.
	 */
	public GenericModelParams getGenericModelParams() {
		return genericModelParams;
	}
	
	

	/**
	 * Set the model parameters. 
	 * @param - the model parameters to set. 
	 */
	public void setGenericModelParams(GenericModelParams genericModelParams) {
		this.genericModelParams = genericModelParams;
	}


	
	/**
	 * Test the classifier on a wave file. 
	 * @param args - the arguments. 
	 */
	public static void main(String[] args) {
		
		// let's test on some right whale data. 
		
		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/call_393_2019_S4U05619MOL2-20180917-051012_2525_2534.wav";
		int[] samplesChunk = new int[] {0, 4000}; // the sample chunk to use. 
		
		
//		String modelPath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/model_lenet_dropout_input_conv_all.hdf5"; 
		String modelPath = "/Users/au671271/Desktop/model_lenet_dropout_input_conv_all/saved_model.pb";
		
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
			Predictor<double[][], float[]> predictor = model.newPredictor(translator);
			
			
			///load the wave data. 
			//Open wav files. 
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);
			soundData = soundData.trim(samplesChunk[0], samplesChunk[1]); 
			
					
			//create the transforms. 
			ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

			//waveform transforms. 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, soundData.getSampleRate())); 
//			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.PREEMPHSIS, preemphases)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, 256, 100)); 
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISEROWSUM)); 

			//generate the transforms. 
			ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlTransformParamsArr); 
			
			
			((WaveTransform) transforms.get(0)).setWaveData(soundData); 
			
			//run the tansforms. 
			DLTransform transform = transforms.get(0); 
			for (int i=0; i<transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform); 
			}
			
						
			float[] output = null; 
			double[][] data;
			for (int i=0; i<1; i++) {
				long time1 = System.currentTimeMillis();
//				data = DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData());
//				System.out.println("Data input size: " + data.length + "   " + data[0].length);
				data = DLUtils.makeDummySpectrogramd(40, 40); 
				output =  predictor.predict(data); 
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
