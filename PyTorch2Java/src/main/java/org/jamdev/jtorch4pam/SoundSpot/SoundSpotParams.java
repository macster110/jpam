package org.jamdev.jtorch4pam.SoundSpot;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.jamdev.jtorch4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jtorch4pam.transforms.DLTransfromParams;
import org.jamdev.jtorch4pam.transforms.SimpleTransformParams;
import org.json.JSONObject;

/**
 * Parameters for running the deep learning algorithm
 * <p>
 * Note that parameter names are in python format to keep them 
 * consistant with the Python code. 

 * 
 * @author Jamne Macaulay 
 *
 */
public class SoundSpotParams {

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
	 * The default segment length for the classifier. 
	 */
	public double seglen = 11.0; //milliseconds  

	/**
	 * A list of transforms for the data. Each chunk of raw sound data has a series of transforms applied. 
	 * These are encoded in the model and then used to generate a list of DLTransfrom objects which transform 
	 * raw sound data. For example, data might be decimated, converted to spectrogram, interpolated and normalised 
	 * before being sent for classification. 
	 * 
	 */
	public ArrayList<DLTransfromParams> dlTransforms; 
	/**
	 * The class names. 
	 */
	public String[] classNames = new String[]{"Bat", "Noise"};  


	/**
	 * Create a default set of Sound Spot params. 
	 */
	public SoundSpotParams() {
		defaultParams();
	}


	/**
	 * Constructor for SoundSpotParams which parses a raw string extracted from a Sound Spot model. 
	 * @param rawString - the raw parameters string from the model. 
	 */
	public SoundSpotParams(String rawString) {
		parseRawString(rawString); 
	}

	/**
	 * Get the paramters from a JSOn string if the transfrom type is known.   
	 * @param dlTransformType - the transfrom type.
	 * @param jsonObjectParams - JSON object containing the parameters.  
	 * @return
	 */	
	public static DLTransfromParams parseDLTransformParams(DLTransformType dlTransformType, JSONObject jsonObjectParams) {

		Number[] number;

		/**
		 * The transform paramters. 
		 */
		DLTransfromParams dlTransformParams = null; 

		switch (dlTransformType) {
		case DECIMATE:
			number = new Number[1]; 
			number[0] = jsonObjectParams.getFloat("sr"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case PREEMPHSIS:
			number = new Number[1]; 
			number[0] = jsonObjectParams.getDouble("pre_empf_factor"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case SPEC2DB:
			dlTransformParams = new SimpleTransformParams(dlTransformType, null); 
			break;
		case SPECCLAMP:
			number = new Number[2]; 
			number[0] = 0.0; //- there is no JSON string for this in pytroch library 
			number[1] = 1.0; 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case SPECCROPINTERP:
			number = new Number[3]; 
			number[0] = jsonObjectParams.getDouble("fmin"); 
			number[1] = jsonObjectParams.getDouble("fmax"); 
			number[2] = jsonObjectParams.getInt("bins"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 

			break;
		case SPECNORMALISE:
			number = new Number[2]; 
			number[0] = jsonObjectParams.getDouble("min_db"); 
			number[1] = jsonObjectParams.getDouble("ref_db"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case SPECTROGRAM:		
			number = new Number[2]; 
			number[0] = jsonObjectParams.getInt("fft"); 
			number[1] = jsonObjectParams.getInt("hop"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 

			break;
		case TRIM:
			number = new Number[2]; 
			number[0] = jsonObjectParams.getInt("min"); 
			number[1] = jsonObjectParams.getInt("max"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		default:
			break;

		}

		return dlTransformParams; 
	}


	/**
	 * Parse the transform parameters from the raw metadata string. 
	 * @param rawString - the raw metadata string. 
	 * @return a list of transform parameter objects.
	 */
	public static ArrayList<DLTransfromParams>  parseTransfromParams(String rawString) {
		//first parse the transforms.
		JSONObject jsonObject = new JSONObject(rawString);

		//get the Json strings sorted in order azs they appear. 
		String[] jsonstrings = getSortedJSonStrings(rawString); 


		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();


		JSONObject jsonObjectParams; 
		DLTransfromParams dltarnsformParams = null; 
		for (int i=0; i<jsonstrings.length; i++) {
			//System.out.println(jsonstrings[i]); 
			dltarnsformParams = null;
			switch (jsonstrings[i]) {
			case "amplitude_to_decibel":
				jsonObjectParams = new JSONObject(jsonObject.getString("amplitude_to_decibel")); 
				dltarnsformParams = parseDLTransformParams(DLTransformType.SPEC2DB, jsonObjectParams); 
				dlTransformParamsArr.add(dltarnsformParams); 
				break;
			case "pre_emph":
				jsonObjectParams = new JSONObject(jsonObject.getString("pre_emph")); 
				dltarnsformParams = parseDLTransformParams(DLTransformType.PREEMPHSIS, jsonObjectParams); 
				dlTransformParamsArr.add(dltarnsformParams); 
				break;
			case "spectrogram":
				jsonObjectParams = new JSONObject(jsonObject.getString("spectrogram")); 
				dltarnsformParams = parseDLTransformParams(DLTransformType.SPECTROGRAM, jsonObjectParams); 
				dlTransformParamsArr.add(dltarnsformParams); 
				break;
			case "normalize":
				jsonObjectParams = new JSONObject(jsonObject.getString("normalize")); 
				dltarnsformParams = parseDLTransformParams(DLTransformType.SPECNORMALISE, jsonObjectParams); 
				dlTransformParamsArr.add(dltarnsformParams); 
				//also add the clamp here - it is seperate in PG but integrated in AnimalSpot. 
				dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCLAMP, 0.0, 1.0)); 

				break;
			case "load_audio":
				jsonObjectParams = new JSONObject(jsonObject.getString("load_audio")); 
				dltarnsformParams = parseDLTransformParams(DLTransformType.DECIMATE, jsonObjectParams);
				dlTransformParamsArr.add(dltarnsformParams); 
				break;
			case "freq_compression":
				jsonObjectParams = new JSONObject(jsonObject.getString("freq_compression")); 
				dltarnsformParams = parseDLTransformParams(DLTransformType.SPECCROPINTERP, jsonObjectParams);
				dlTransformParamsArr.add(dltarnsformParams); 
				break;
			}

		}

		return dlTransformParamsArr; 

	}

	/**
	 * Parse a parameters string from the SoundSpotModel. 
	 * @param rawString - the raw string. 
	 */ 
	private void parseRawString(String rawString) {
		System.out.println(rawString); 

		//load the transfroms from the string metadata
		this.dlTransforms =   parseTransfromParams( rawString); 

		//first parse the transforms.
		JSONObject jsonObject = new JSONObject(rawString);

		//		//now get the class names. 
		String classString = jsonObject.getString("class_info"); 
		//ugly but owrks - cannot use 
		String classNamesRaw = classString.substring(classString.indexOf("name_class :")+12, classString.length()-1);


		//		int nClass  = jsonObjectParams.getInt("num_class"); 
		//		String classNamesRaw  = jsonObjectParams.getString("name_class"); 
		String[] classNames = classNamesRaw.split(",");
		for (int i=0; i<classNames.length; i++) {
			classNames[i]=classNames[i].trim(); //remove whitespace

		}
		this.classNames = classNames; 

		JSONObject jsonObjectParams = new JSONObject(jsonObject.getString("seg_size")); 
		double segsIZE  = jsonObjectParams.getInt("size_ms"); 

		this.seglen = segsIZE; 


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

	}

	@Override
	public String toString() {
		String string = ""; 
		
		string += "***********\n"; 
		
		string += "Segment length: " + seglen + " milliseconds\n"; 
		
		string += "***********\n"; 
		string += "No. classes: " + this.classNames.length + "  \n"; 
		for (int i=0; i<this.classNames.length; i++) {
			string += classNames[i] + "\n"; 
		}

		string += "***********\n"; 
		for (int i=0; i<this.dlTransforms.size(); i++) {
			string += dlTransforms.get(i).toString() + "\n"; 
		}

		string += "***********\n"; 

		return string; 
	} 

	/**
	 * Get strings sorted in the order that they appear in the raw JSON string
	 * @return the sorted list of strings. 
	 */
	private static String[] getSortedJSonStrings(String rawString) {

		JSONObject jsonObject = new JSONObject(rawString);

		String[] jsonStrings = JSONObject.getNames(jsonObject); 

		int[]  index = new int[jsonStrings.length]; 
		for (int i=0; i<jsonStrings.length; i++) {
			index[i] = rawString.indexOf(jsonStrings[i]); 
		}

		//sort the string arrya by the int array, 
		final List<String> stringListCopy = Arrays.asList(jsonStrings);
		ArrayList<String> sortedList = new ArrayList<String>(stringListCopy);
		Collections.sort(sortedList, (left, right) -> index[stringListCopy.indexOf(left)] - index[stringListCopy.indexOf(right)]);

		return sortedList.toArray(jsonStrings); 
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
		double min_level_dB = -100;

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
