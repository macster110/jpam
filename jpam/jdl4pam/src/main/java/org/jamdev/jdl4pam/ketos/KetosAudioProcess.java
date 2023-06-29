package org.jamdev.jdl4pam.ketos;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformsParser;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.json.JSONObject;

import ai.djl.MalformedModelException;

/**
 * 
 * Functions for running Ketos models on sound files.
 * <p>
 * Ketos has a slightly weird way of analysing wav files. It creates a sample
 * offset in the file, zero pads this and then processes the rest of the data
 * with that offset. So, for example, it migth offset the start of the file by a
 * few hundred samples, and then create consecutive time windows. This can make
 * it hard to compare Ketos models in JPam to those in Python. KetosProcess
 * provides functions to run Ketos models in the same way the Ketos Python
 * library would.
 * 
 * 
 * @author Jamie Macaulay
 *
 */
public class KetosAudioProcess {

	
	public static int VERBOSITY_NONE = 0; 


	public static int VERBOSITY_MEDIUM = 1; 


	public static int VERBOSITY_HIGH = 2; 

	/**
	 * Process sound data. This is equivalent of  creating an AudioFrameLoader and then running
	 * process in the Ketos Python library, 
	 * @param ketosModel - the ketos model to use. 
	 * @param soundData - the audio data to process. 
	 * @return a list of KetosResult objects within information on time and model predictions. 
	 */
	public static ArrayList<KetosResult> processSoundData(KetosModel ketosModel, AudioData soundData){
		return processSoundData( ketosModel,  soundData, null); 
	}

	/**
	 * Process sound data. This is equivalent of  creating an AudioFrameLoader and then running
	 * process in the Ketos Python library, 
	 * @param ketosModel - the ketos model to use. 
	 * @param soundData - the audio data to process. 
	 * @param hop - the window hop size for the audio file (not the FFT hop). 
	 * @return a list of KetosResult objects within information on time and model predictions. 
	 */
	public static ArrayList<KetosResult> processSoundData(KetosModel ketosModel, AudioData soundData, Double hop){
		return processSoundData( ketosModel,  soundData, hop, VERBOSITY_NONE); 
	}


	/**
	 * Process sound data. This is equivalent of  creating an AudioFrameLoader and then running
	 * process in the Ketos Python library, 
	 * @param ketosModel - the ketos model to use. 
	 * @param soundData - the audio data to process. 
	 * @param hop - the window hop size for the audio file (not the FFT hop). 
	 * @param verbosity - the verbosity. 0 will print nothing to console. 1 will print data. 
	 * @return a list of KetosResult objects within information on time and model predictions. 
	 */
	public static ArrayList<KetosResult> processSoundData(KetosModel ketosModel, AudioData soundData, Double hop, int verbosity){

		//read the JSOn string from the file.
		String jsonString = DLTransformsParser.readJSONString(new File(ketosModel.getAudioReprFile()));

		ArrayList<KetosResult> ketosResults = new ArrayList<KetosResult>(); 

		//get the audio representation file.
		KetosParams ketosParams = new KetosParams(jsonString);

		double duration;
		if (ketosParams.getDuration() != null) {
			duration = ketosParams.getDuration(); 
		}
		else {
			duration = ketosParams.seglen;
		}

		if (hop == null) {
			hop = duration; 
		}

		AudioData soundDataChunk; 

		int numTimeSegs = (int) Math.ceil((soundData.getLengthInSeconds() - duration) / hop) + 1;
		
		double modelTime = 0; //avergae model time


		for (int timewind= 0; timewind<numTimeSegs; timewind++) {


			/******* Trim the sound file to correct size ******/


			double[] offsets = computeOffsets(jsonString, timewind * duration );
			double startTime = 0.;
			if (offsets[2] < 0){
				startTime = 0.;
			}
			else {
				startTime = offsets[2];
			}

			// Time limits of the audio would be after the new duration computed in the KetosParams function
			double[] timelims = new double[]{startTime, startTime + ketosParams.seglen}; //5 second window


			int[] timelims_samples = new int[]{(int) (DLUtils.numSamplesKetos(startTime,
					soundData.sampleRate, Boolean.FALSE)), (int) (DLUtils.numSamplesKetos(timelims[1], soundData.sampleRate, Boolean.FALSE))};

			soundDataChunk = soundData.trim(timelims_samples[0], timelims_samples[1]);

			//System.out.println("Start time: " + timelims[0] +  " end: " + timelims[1] + " duration: " + (timelims[1]-timelims[0]));


			//generate the transforms.
			ArrayList<DLTransform> transforms = DLTransformsFactory.makeDLTransforms(ketosParams.dlTransforms);

			ketosModel.setInputShape(ketosParams.defaultInputShape);
			//			FreqTransform a = new FreqTransform(new DLTransform.DLTransformType("SPECTROGRAMKETOS"), transforms.get(2).getDLTransformType())


			/******* Run through transforms and grab spectrogram image ******/

			((WaveTransform) transforms.get(0)).setWaveData(soundDataChunk);

			DLTransform specTransform = transforms.get(0);
			DLTransform transform = transforms.get(0);
			for (int i = 0; i < transforms.size(); i++) {
				//System.out.println(transforms.get(i).getDLTransformType());
				transform = transforms.get(i).transformData(transform);
				if (transforms.get(i).getDLTransformType().name().equals("SPECTROGRAMKETOS")) {
					specTransform = transform;
				} 
			}


			/**** Write the model to a mat file so it can be easily viewed***/

			double[][] transformedData = ((FreqTransform) transform).getSpecTransfrom().getTransformedData();


			/*********************** Run the Model ************************/


			float[] output = null; 
			float[][][] data;
			int nStack = 1; //number of specs to give to the classifier. 
			for (int i=0; i<nStack; i++) {
				long time1 = System.currentTimeMillis();
				data = new float[nStack][][]; 
				for (int j=0; j<nStack; j++) {
					data[j] = DLUtils.toFloatArray(transformedData); 
				}
				output = ketosModel.runModel(data); 
				long time2 = System.currentTimeMillis();
				modelTime += (time2-time1); 
			}

			if (verbosity>0) System.out.print("Start time: " + String.format("%.3f", timelims[0])  + " ");  

			if (verbosity>0) System.out.print(" Prediction: ");  
			double[] prob = new double[output.length]; 
			for (int j=0; j<output.length; j++) {
				//python code for this. 
				//		    	prob = torch.nn.functional.softmax(out).numpy()[n, 1]
				//	                    pred = int(prob >= ARGS.threshold)		    	
				//softmax function
				if (verbosity>0) System.out.print(String.format("%.4f", output[j]) + "  "); 

				prob[j] = output[j]; 
				//System.out.println("The probability is: " + prob[j]); 

			}
			if (verbosity>0) System.out.println(" ");  
		


			ketosResults.add(new KetosResult(prob, timelims[0], ketosParams.seglen)); 	

			/**************************************************************/
		}

		if (verbosity>0) System.out.println("Average time to run each chunk " + String.format("%.4f", modelTime/numTimeSegs) + " ms"); 
		
		return ketosResults;

	}
	

	/**
	 * From Ketos documentation:
	 * <a href="https://docs.meridian.cs.dal.ca/ketos/_modules/ketos/audio/spectrogram.html#load_audio_for_spec">...</a>
	 *
	 * Extract spectrogram parameters and compute offsets from a JSON file for the specific purpose of computing
	 * the spectrogram.
	 * The loaded audio covers a time interval that extends slightly beyond that specified, [offset, offset+duration],
	 * as needed to compute the full spectrogram without padding with zeros at either end.
	 *
	 * @param rawString - the raw parameters string from the model.
	 * @return double[]
	 *  double[0] - number of samples in the FFT to compute spectrogram (n_fft) [samples]
	 *  double[1] - number of samples between two time windows to compute spectrogram (hop_length) [samples]
	 *  double[2] - nominal offset [samples]
	 *  double[3] - number of samples to append on the left side of the audio [samples] (num_pad_left)
	 *  double[4] - number of seconds of a spectrogram [seconds] (duration_ext)
	 */
	public static double[] computeOffsets(String rawString, double offsetAudio){

		// Parse JSON file to extract values
		//first parse the transforms.
		JSONObject jsonObject = new JSONObject(rawString);

		//the spectrogram.
		JSONObject specObject = jsonObject.getJSONObject("spectrogram");

		// New sample rate.
		double sampleRate = KetosParams.getKetosDouble(specObject, "rate");//very important

		//set the segment length.
		double total_duration = KetosParams.getKetosDouble(specObject, "duration");


		int n_fft = DLUtils.numSamplesKetos(KetosParams.getKetosDouble(specObject, "window"), sampleRate, Boolean.TRUE);
		int hop_length = DLUtils.numSamplesKetos(KetosParams.getKetosDouble(specObject, "step"), sampleRate, Boolean.TRUE);

		/******** Between these trails: from load_audio_for_spec.py in spectrogram.py ********/
		// Compute specParamsOffsets
		double[] specParamsOffsets = new double[5];
		specParamsOffsets[0] = n_fft;
		specParamsOffsets[1] = hop_length;

		int num_segs = DLUtils.numSamplesKetos(total_duration, sampleRate/hop_length, Boolean.FALSE);

		int offset_len = DLUtils.numSamplesKetos(offsetAudio, sampleRate, Boolean.FALSE) - n_fft/2 + hop_length/2;

		//System.out.println("Offset_len: " + offset_len);

		double nominalOffset = offsetAudio;

		// modify offset and duration to extend audio segment at both ends
		double offset_ext = offset_len / sampleRate;
		specParamsOffsets[2] = offset_ext;

		// if the offset is negative, pad with zeros on the left
		int num_pad_left = Math.max(0, -offset_len);
		specParamsOffsets[3] = num_pad_left;
		double left_ext = nominalOffset - offset_ext;



		double total_duration_ext = (num_segs * hop_length + n_fft) / sampleRate;

		//System.out.println("total_duration_ext: " + total_duration_ext);


		double right_ext = total_duration_ext - total_duration - left_ext;
		// When loading several audio for different representations, is it allowed to have multiple durations in Ketos?
		double duration_ext =  total_duration + left_ext;
		duration_ext =  duration_ext + right_ext - left_ext;

		//System.out.println("duration_ext: " + total_duration_ext);

		if (total_duration_ext != duration_ext){
			if (num_pad_left > 0){
				specParamsOffsets[3] = num_pad_left;
			}
		}
		specParamsOffsets[4] = duration_ext;
		/*******************************************************/

		return specParamsOffsets;
	}




	/**
	 * 
	 * Holds results from a Ketos classifier. 
	 * @author Jamie Macaulay
	 *
	 */
	public static class KetosResult {

		public KetosResult(double[] prediction, double startTime, double duration) {
			this.startTime=startTime;
			this.prediction = prediction; 
			this.duration=duration; 
		}

		/**
		 * The results form the model. 
		 */
		public double[] prediction; 

		/**
		 * The start time. 
		 */
		public double startTime; 

		/**
		 * The duration. 
		 */
		public double duration; 

	}

	public static void main(String[] args) {
		
		/** 
		 * Example running Ketos model on a wav file. 
		 */
		
		String modelPath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/narw_2/hallo-kw-det_v1_test/hallo-kw-det_v1.ktpb";

		/****Wav files*****/
		//jasco_reduced - use for right whales hallo-kw-det_v1
		String wavFilePath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/narw_2/hallo-kw-det_v1_test/audio/jasco_reduced.wav";

		//Open wav files.
		AudioData soundData;
		try {
			soundData = DLUtils.loadWavFile(wavFilePath);

			//the ketos model.
			KetosModel ketosModel = new KetosModel(new File(modelPath));

			processSoundData( ketosModel,  soundData, 5., VERBOSITY_MEDIUM); 

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MalformedModelException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}




	}

}
