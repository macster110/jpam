package org.jamdev.jdl4pam.genericmodel;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;

import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.engine.Engine;
import ai.djl.inference.Predictor;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.TranslateException;

/**
 * Some test functions for loading Google's Humpback whale classifier. For more
 * information on this classifier please check out.
 * 
 * Allen et al., “A Convolutional Neural Network for Automated Detection of
 * Humpback Whale Song in a Diverse, Long-Term Passive Acoustic Dataset.”
 * 
 */
public class HumpbackGoogle {

	/**
	 * Load Google's humpback model.
	 * 
	 * @param modelPath - path to model
	 * @return model object which has loaded google;s model.
	 */
	public static Model loadGoogleHumpbackModel(String modelPath) {

		File file = new File(modelPath);

		Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); // the directory of the file (in case the file is
																		// local this should also return absolute
																		// directory)
		String modelName = file.getName();

		System.out.println(Engine.getAllEngines());

		Model model = Model.newInstance(modelPath, "TensorFlow");

		try {
			model.load(modelDir, "saved_model.pb");
		} catch (MalformedModelException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println("Input: " + model.describeInput().keys());
		System.out.println("Output: " + model.describeOutput().values());
		System.out.println("DataType: " + model.getDataType());

		for (int i = 0; i < model.describeInput().size(); i++) {
			Shape shape = model.describeInput().get(i).getValue();

			System.out.println("Shape dim: " + model.describeInput().get(i).getKey() + "  " + shape.dimension()
					+ " nInput: " + model.describeInput().size());

			System.out.print("Shape " + i + " : ");
			for (int j = 0; j < shape.dimension(); j++) {
				System.out.print(shape.get(j) + "  ");
			}
			System.out.println("");

		}

		return model;

	}
	
	/**
	 * Run some wav data through Google's humpback whale deep learning model. Note that this runs five batches - that means the model is 
	 * 
	 * @param model      - model object which has loaded Google's humpback model.
	 * @param soundData  - sound data to process.
	 * @param startChunk - the start of the audio chunk to process in SAMPLES from
	 *                   start of file.
	 * @param chunkSize  - the end of the audio chunk to process in SAMPLES from the
	 *                   start of the file. Note that the audio chunk size must
	 *                   correspond to the sixe expect by the model.
	 * @param nRuns - the number of times to process the data - 1 means the model is called once. 
	 * @return the prediction outputs for the selected audio chunk.
	 */
	public static float[] runHumpbackWhaledl(Model model, AudioData soundData, int startChunk, int chunkSize, int nRuns) {
		// create the transforms - here the google model accepts a waveform and does all
		// the
		// transoforms itself.
		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		// waveform transforms.
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.TRIM, startChunk, startChunk + chunkSize));
		
		return runGenericWaveModel( model,  soundData,  dlTransformParamsArr, startChunk,  chunkSize,  nRuns); 
	}

	/**
	 * Run some wav data through Google's humpback whale deep learning model. Note that this only supports the input of raw wave data, not spectrograms. 
	 * 
	 * @param model      - model object which has loaded Google's humpback model.
	 * @param soundData  - sound data to process.
	 * @param startChunk - the start of the audio chunk to process in SAMPLES from
	 *                   start of file.
	 * @param chunkSize  - the end of the audio chunk to process in SAMPLES from the
	 *                   start of the file. Note that the audio chunk size must
	 *                   correspond to the sixe expect by the model.
	 * @param nRuns - the number of times to process the data - 1 means the model is called once. 
	 * @return the prediction outputs for the selected audio chunk.
	 */
	public static float[] runGenericWaveModel(Model model, AudioData soundData, ArrayList<DLTransfromParams> dlTransformParamsArr, int startChunk, int chunkSize, int nRuns) {
		WaveformTranslator translator = new WaveformTranslator(model.describeInput());

		// predictor for the model
		Predictor<float[][], float[]> predictor = model.newPredictor(translator);
		
		// dlTransformParamsArr.add(new
		// SimpleTransformParams(DLTransformType.PREEMPHSIS, preemphases));

		// generate the transforms.
		ArrayList<DLTransform> transforms = DLTransformsFactory.makeDLTransforms(dlTransformParamsArr);

		((WaveTransform) transforms.get(0)).setWaveData(soundData);

		// run the tansforms.
		DLTransform transform = transforms.get(0);
		for (int i = 0; i < transforms.size(); i++) {
			transform = transforms.get(i).transformData(transform);
		}

		double[] dataD = ((WaveTransform) transform).getWaveData().getScaledSampleAmplitudes();

		float[] dataF = new float[dataD.length];
		for (int i = 0; i < dataF.length; i++) {
			dataF[i] = (float) dataD[i];
		}
		//System.out.println("Data input size: " + dataF.length +  "  " + dataF[0]);

		int nBatch = 5; // the number of batches.
		float[] output = null;
		long totaltime1 = System.currentTimeMillis();

		float[][] batchData = new float[nBatch][];
		for (int j = 0; j < nBatch; j++) {
			batchData[j] = dataF;
		}

		for (int j = 0; j < nRuns; j++) {
			long time1 = System.currentTimeMillis();
			try {
				output = predictor.predict(batchData);
			} catch (TranslateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			long time2 = System.currentTimeMillis();
//			System.out.println("Time to run model: " + (time2 - time1) + " ms");

			long totaltime2 = System.currentTimeMillis();

//			System.out.println("Total time to run model: " + (totaltime2 - totaltime1) + " ms");
		}

//		for (int i = 0; i < output.length; i++) {
//			System.out.println(output[i]);
//		}

		return output;

	}

	/**
	 * Convenience function to run some wav data through Google's humpback whale
	 * deep learning model.
	 * 
	 * @param modelPath   - file path to the model - will be end with saved_model.pb
	 * @param wavFilePath - file path to wav file to process.
	 * @param startChunk  - the start of the audio chunk to process in SAMPLES from
	 *                    start of file.
	 * @param chunkSize   - the size of the audio chunk to process in SAMPLES from
	 *                    the start of the file. Note that the audio chunk size must
	 *                    correspond to the size expect by the model.
	 * @return the prediction outputs for the selected audio chunk.
	 */
	public static float[] runHumpbackWhaledl(String modelPath, String wavFilePath, int startChunk, int chunkSize) {

		try {

			// load the model.
			Model model = loadGoogleHumpbackModel(modelPath);

			/// load the wave data.
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);

			// run the model
			return runHumpbackWhaledl(model, soundData, startChunk, chunkSize, 10);

		} catch (Exception e) {
			e.printStackTrace();
			return null;

		}

	}

	/**
	 * Test the classifier on a wave file.
	 * 
	 * @param args - the arguments.
	 */
	public static void main(String[] args) {

		// let's test on some right whale data.

//		/****Google's original HumpBack whale classifier*****/
//		//the second  class is humpback whale. class 0 = noise, Class 1= right whale. 
//		String wavFilePath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Google/humpback_whale/sound.wav";
//		//String modelPath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Right_whales_DG/model_lenet_dropout_input_conv_all.hdf5"; 
//		String modelPath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Google/humpback_whale/humpback_whale_1/saved_model.pb";

		/**** Vincent HumpBack whale classifier *****/
		// the second class is humpback whale. class 0 = noise, Class 1= right whale.
		String wavFilePath = "D:/Dropbox//PAMGuard_dev/Deep_Learning/Google/humpback_whale/sound.wav";

		// the model
		String modelPath = "D:/Dropbox/PAMGuard_dev/Deep_Learning/Google/humpback_whale_atlantic/FlatHBNA/saved_model.pb";

		int startChunk = 0; // humpback whale call

		// int startchunk = (int) (190.2*sr);

		int chunkSize = (int) (3.92 * 10000);

		// run the humpback whale classifier.
		runHumpbackWhaledl(modelPath, wavFilePath, startChunk, chunkSize);

	}

}
