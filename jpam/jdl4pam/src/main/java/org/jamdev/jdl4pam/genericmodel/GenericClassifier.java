package org.jamdev.jdl4pam.genericmodel;

import java.util.ArrayList;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;

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
		loadModel(modelPath);
		
		genericModelParams.defaultInputShape = genericModel.getInputShape();
				
		genericModelParams.defaultInputShape = genericModel.getOutShape();

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
	public double[] runModel(double[] rawWaveData, float sR, boolean softMax) {

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
			float[][][] data;
			for (int i=0; i<10; i++) {
				//long time1 = System.currentTimeMillis();
				data = new float[][][] {DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData())}; 
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
				if (softMax) {
					prob[j] = DLUtils.softmax(output[j], output); 
				}
				else {
					prob[j] = output[j]; 
				}
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



}
