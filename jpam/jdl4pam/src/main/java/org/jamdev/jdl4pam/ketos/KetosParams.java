package org.jamdev.jdl4pam.ketos;

import java.io.File;
import java.util.ArrayList;

import org.jamdev.jdl4pam.genericmodel.GenericModelParams;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformsParser;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Parameters for a Ketos model, including parasing json file to transforms. 
 * @author Jamie Macaulay
 *
 */
public class KetosParams extends GenericModelParams {

	//settingss for bats used by christian
	//	17:22:24|D|dataOpts: {
	//    "samplingrate": 256000,
	//    "preemphases": 0.98,
	//    "n_fft": 256,
	//    "hop_length": 8,
	//    "n_freq_bins": 256,
	//    "fmin": 40000,
	//    "fmax": 100000,
	//    "freq_compression": "linear",
	//    "min_level_db": -100,
	//    "ref_level_db": 0
	//}


	/**
	 * The default segment length for the classifier (seconds). 
	 */
	public double seglen = 11.0; //seconds
	public double offsetAudio = 0.; // to update each new time window

	//	/**
	//	 * The numebr of output classes.
	//	 */
	//	public int outputClass = 2;   


	/**
	 * Create a default set of Sound Spot params. 
	 */
	public KetosParams() {
		defaultParams();
	}


	/**
	 * Constructor for SoundSpotParams which parses a raw string extracted from a Sound Spot model. 
	 * @param rawString - the raw parameters string from the model. 
	 */
	public KetosParams(String rawString) {
		parseRawString(rawString); 
	}

	public KetosParams(String rawString, double audioOffset) {
		this.offsetAudio = audioOffset;
		parseRawString(rawString);
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
	public double[] computeOffsets(String rawString){
		// Parse JSON file to extract values
		//first parse the transforms.
		JSONObject jsonObject = new JSONObject(rawString);

		//the spectrogram.
		JSONObject specObject = jsonObject.getJSONObject("spectrogram");

		// New sample rate.
		double sampleRate = getKetosDouble(specObject, "rate");//very important

		//set the segment length.
		double total_duration = getKetosDouble(specObject, "duration");

		int n_fft = DLUtils.numSamplesKetos(getKetosDouble(specObject, "window"), sampleRate, Boolean.TRUE);
		int hop_length = DLUtils.numSamplesKetos(getKetosDouble(specObject, "step"), sampleRate, Boolean.TRUE);

		/******** Between these trails: from load_audio_for_spec.py in spectrogram.py ********/
		// Compute specParamsOffsets
		double[] specParamsOffsets = new double[5];
		specParamsOffsets[0] = n_fft;
		specParamsOffsets[1] = hop_length;

		int num_segs = DLUtils.numSamplesKetos(total_duration, sampleRate/hop_length, Boolean.FALSE);

		int offset_len = DLUtils.numSamplesKetos(this.offsetAudio, sampleRate, Boolean.FALSE) - n_fft/2 + hop_length/2;

		double nominalOffset = this.offsetAudio;

		// modify offset and duration to extend audio segment at both ends
		double offset_ext = offset_len / sampleRate;
		specParamsOffsets[2] = offset_ext;

		// if the offset is negative, pad with zeros on the left
		int num_pad_left = Math.max(0, -offset_len);
		specParamsOffsets[3] = num_pad_left;
		double left_ext = nominalOffset - offset_ext;
		double total_duration_ext = (num_segs * hop_length + n_fft) / sampleRate;
		double right_ext = total_duration_ext - total_duration - left_ext;
		// When loading several audio for different representations, is it allowed to have multiple durations in Ketos?
		double duration_ext =  total_duration + left_ext;
		duration_ext =  duration_ext + right_ext - left_ext;

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
	 * Get the parameters from a JSON string if the transform type is known.   
	 * @param jsonObjectParams - JSON object containing the parameters.  
	 * @return the DLTransfromParams generated by the JSONObject. 
	 */	
	public static DLTransfromParams parseDLTransformParams(JSONObject jsonObjectParams) {

		//Get the transform type
		String transformName = jsonObjectParams.getString("name");  

		//convert to JPAM default JSON names. 
		switch (transformName) {
		case "normalize":
			//ketos does not specify the type of normalisation used so we must do that here as there are many 
			//different types of normalisation for DLTransfroms. 
			transformName = "normalisestd";
			break; 
		case "reduce_tonal_noise":
			//This a little tricky. There are two transform types in DLTransfromType, a running median and a running mean
			//but Ketos considers this a single transform wiht two options so must separate here.
			//  {"name": "reduce_tonal_noise", "method": "MEDIAN"},
			//  {"name": "reduce_tonal_noise", "method": "RUNNING_MEAN", "time_const_len": 3}	
			//  {"name": "reduce_tonal_noise"},
			if (jsonObjectParams.has("method")) {
				String method = jsonObjectParams.getString("method"); 
				if (method.equals("RUNNING_MEAN")) {
					transformName = "reduce_tonal_noise_mean";
				}
				else {
					transformName = "reduce_tonal_noise_median";
				}
			}
			else {
				//no method then assume median 
				transformName = "reduce_tonal_noise_median";
			}
			break; 

		case "crop":
			if (jsonObjectParams.get("start")==null) {
				return null;
			}
			else {
				transformName = "freq_compression";
			}
		}

		DLTransformType type = DLTransformsParser.getTransformType(transformName);


		return DLTransformsParser.parseDLTransformParams(type, jsonObjectParams); 
	}

	/**
	 * Get the parameters from a JSOn string if the transform type is known.   
	 * @param dlTransformType - the transform type.
	 * @param jsonObjectParams - JSON object containing the parameters.  
	 * @return the DLTransfromParams generated by the JSONObject. 
	 */	
	public static DLTransfromParams parseDLTransformParams(DLTransformType dlTransformType, JSONObject jsonObjectParams) {
		return DLTransformsParser.parseDLTransformParams(dlTransformType, jsonObjectParams); 
	}

	/**
	 * Parse a parameters string from the SoundSpotModel. 
	 * @param rawString - the raw string. 
	 */ 
	private void parseRawString(String rawString) {
		System.out.println(rawString); 

		//load the transfroms from the string metadata
		//this.dlTransforms =   parseTransfromParams( rawString); 

		//example

		//		{
		//		    "spectrogram": {
		//		"rate": "1000 Hz", 
		//		        "window": "0.256 s",
		//		        "step": "0.032 s",
		//		        "freq_min": "0 Hz",
		//		        "freq_max": "500 Hz",
		//		        "window_func": "hamming",
		//		        "type": "MagSpectrogram",
		//		        "duration": "3.0 s",
		//		"transforms": [{"name": "reduce_tonal_noise"},
		//		                       {"name": "enhance_signal"},
		//		                       {"name": "normalize", "mean": 0.0, "std": 1.0}],
		//		        "dtype": "float32",
		//		        "input_ndims": 4,
		//		        "input_shape": [1, 94, 129, 1]
		//		    }
		//		}

		//first parse the transforms.
		JSONObject jsonObject = new JSONObject(rawString);

		//the spectrogram.
		JSONObject specObject = jsonObject.getJSONObject("spectrogram");


		// New sample rate.
		double sampleRate = getKetosDouble(specObject, "rate");//very important

		//set the segment length.
		double total_duration = getKetosDouble(specObject, "duration");

		System.out.println("WINDOW: " + getKetosDouble(specObject, "window") + " sampleRate: " + (getKetosDouble(specObject, "window") * sampleRate));

		double[] offsets = computeOffsets(rawString);
		this.seglen = offsets[4];

		//normalise sample rate
		Boolean normaliseWav = false;
		if (specObject.has("normalize_wav")) {
			normaliseWav= specObject.getBoolean("normalize_wav"); 
		}
		
		//System.out.println("FFT: " + n_fft + " Hope length: " + hop_length);

		double freq_min = getKetosDouble(specObject, "freq_min"); 
		double freq_max = getKetosDouble(specObject, "freq_max");

		if(sampleRate/2 < freq_min){
			freq_min = 0.;
		}
		if(sampleRate/2 < freq_max){
			freq_max = sampleRate/2;
		}
		if(freq_max < freq_min){
			freq_min = 0.;
			freq_max = sampleRate/2;
		}

		JSONArray expectedShapeJSON = specObject.getJSONArray("input_shape"); 
		int[] expectedShape = new int[expectedShapeJSON.length()];

		for(int j = 0; j < expectedShapeJSON.length(); j++){               
			expectedShape[j] = expectedShapeJSON.getInt(j);               
		}


		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();
		//we are assiming a mag spectrogram here. 


		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sampleRate)); 
		if (normaliseWav!=null && normaliseWav.booleanValue()) {
			dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.NORMALISE_WAV, sampleRate, 1)); // one for ketos version
		}
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAMKETOS, offsets[0], offsets[1], total_duration, freq_min, freq_max));
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCROPINTERP, freq_min, freq_max, expectedShape[2]));
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPEC2DB));

		//A model may have no additional transforms, in which case JSON will throw an exception or the transformObjects will be null. 
		if (specObject.has("transforms")) {
			//the order of these is important. 
			JSONArray transformObjects = specObject.getJSONArray("transforms");

			if (transformObjects!=null  && transformObjects.length()>0) {

				//System.out.println("transformObjects: "  +transformObjects);
				DLTransfromParams params; 
				for (int i=0; i<transformObjects.length(); i++) {

					JSONObject object = (JSONObject) transformObjects.get(i);

					params =  parseDLTransformParams(object); 

					if (params!=null) {
						dlTransformParamsArr.add(params);
					}
					//System.out.println(object); 
				}
			}
		}
////		//FIXEM
//		//add the interpolation at the end to make sure we get the expected shape. We were one bin out with right whales for the FFT length. 
//		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCROPINTERP, freq_min, freq_max, 
//				(int) expectedShape[2])); //important to cast to int for GUI stuff in JavaFX

		//		
		//must order these in the correct way!l 
		//			switch (jsonstrings[i]) {
		//			case "min_level_db":
		//				this.min_level_dB = jsonObject.getDouble("min_level_db"); 
		//				break;
		//			case "n_freq_bins":
		//				this.n_freq_bins = jsonObject.getInt("n_freq_bins");
		//				break;
		//			case "preemphases":
		//				this.preemphases = jsonObject.getDouble("preemphases");
		//				break;
		//			case "ref_level_db":
		//				this.ref_level_dB = jsonObject.getDouble("ref_level_db");
		//				break;
		//			case "n_fft":
		//				this.n_fft = jsonObject.getInt("n_fft");
		//				break;
		//			case "fmin":
		//				this.fmin = jsonObject.getDouble("fmin");
		//				break;
		//			case "fmax":
		//				this.fmax = jsonObject.getDouble("fmax");
		//				break;
		//			case "sr":
		//				this.sR  = jsonObject.getFloat("sr");
		//				break;
		//			case "hop_length":
		//				this.hop_length = jsonObject.getInt("hop_length");
		//				break;
		//			case "freq_compression":
		//				this.freq_compression = jsonObject.getString("freq_compression"); 
		//				break;
		//			}

		this.dlTransforms = dlTransformParamsArr; 

	}


	/**
	 * Get the ketos double value from a JSONObject. Ketos params are strings 
	 * which include the unit. They must be parsed to a double. 
	 * @param key
	 * @return
	 */
	private Double getKetosDouble(JSONObject jsonObject, String key) {

		String paramS = jsonObject.getString(key); 

		String[] vals = paramS.split(" "); 

		return Double.valueOf(vals[0]); 
	}

	/**
	 * Get the ketos int value from a JSONObject. Ketos params are strings 
	 * which include the unit. They must be parsed to a double. 
	 * @param key - the json key. 
	 * @return
	 */
	private Integer getKetosInt(JSONObject jsonObject, String key) {

		String paramS = jsonObject.getString(key); 

		String[] vals = paramS.split(" "); 

		return Integer.valueOf(vals[0]); 
	}

	@Override
	public String toString() {
		String string = ""; 

		string += "***********\n"; 

		string += "Segment length: " + seglen + " milliseconds\n"; 


		if (classNames!=null) {
			string += "***********\n"; 

			string += "No. classes: " + this.classNames.length + "  \n"; 

			for (int i=0; i<this.classNames.length; i++) {
				string += classNames[i] + "\n"; 
			}
		}

		string += "***********\n"; 
		for (int i=0; i<this.dlTransforms.size(); i++) {
			string += dlTransforms.get(i).toString() + "\n"; 
		}

		string += "***********\n"; 

		return string; 
	} 


	public static void main(String[] args) {
		File file = new File("/Users/au671271/ketos_models/narw/audio_repr.json"); 



		try {

			//read the JSOn string from the the file. 
			String jsonString  = DLTransformsParser.readJSONString(file);

			//get the audio representation file. 
			KetosParams ketosParams = new KetosParams(jsonString); 

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}




	/**
	 * Create a default set of paramters. this can be for testing etc. 
	 */
	private void defaultParams() {
		//

		//The FFT length for the spectrogram in bins

		int n_fft = 256;

		/**
		 * The FFT hop in sample bins.
		 */
		int hop_length = 8;

		/**
		 * The sample rate to interpolate or decimate to in samples per second. i.e.
		 * this is the sample rate of the training data.
		 */
		float sR = 256000;

		/**
		 * The pore emphasis factor. This dictates how much the lower frequences in the
		 * wave data are attenuated.
		 */
		double preemphases = 0.98;

		/**
		 * The minimum dB level for normalising the dB spectral amplitudes.
		 */
//		double min_level_dB = -100;
		double min_level_dB = -200;

		/**
		 * The reference dB level for normalising the dB spectral amplitudes.
		 */
		double ref_level_dB = 0;

		/**
		 * Minimum value to clamp spectrogram to after normalisation.
		 */
		double clampMin = 0;

		/**
		 * Maximum value to clamp spectrogram to after normalisation.
		 */
		double clampMax = 1;

		/**
		 * The minimum frequency to interpolate the spectrogram image from.
		 */
		double fmax = 100000;

		/**
		 * The maximum frequency to interpolate the spectrogram image from.
		 */
		double fmin = 40000;

		/**
		 * The number of vertical bins to interpolate the spectrogram image to.
		 */
		int n_freq_bins = 256;

		/**
		 * The type of frequency compression ot nuse.
		 */
		String freq_compression = "linear";


		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		// now generate a;l the parameter class
		SimpleTransformParams dlTransfromParams;

		//waveform transforms. 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sR)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.PREEMPHSIS, preemphases)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, n_fft, hop_length)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCROPINTERP, fmin, fmax, n_freq_bins)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPEC2DB)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISE, min_level_dB, ref_level_dB)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCLAMP, clampMin, clampMax)); 

		this.dlTransforms = dlTransformParamsArr; 

	}







}
