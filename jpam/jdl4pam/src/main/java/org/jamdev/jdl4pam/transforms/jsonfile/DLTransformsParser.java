package org.jamdev.jdl4pam.transforms.jsonfile;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.jamdev.jdl4pam.animalSpot.AnimalSpotModel;
import org.jamdev.jdl4pam.animalSpot.AnimalSpotParams;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jpamutils.wavFiles.FilterParams;
import org.json.JSONObject;

import ai.djl.MalformedModelException;

import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;

/**
 * Write the transforms to a JSON file. Note that this is not the most elegant way of writing data files, however, 
 * i's how Python exports maps which means that Python and Java can inter-change files. This 
 * @author Jamie Macaulay 
 *
 */
public class DLTransformsParser {



	/**
	 * Create a JSON object from a a list of transforms
	 * @param dlTransforms - a list of transform paramters. 
	 * @return the JSONObject for the transform paramters. 
	 */
	public static JSONObject writeJSONObject(List<DLTransfromParams> dlTransforms) {

		JSONObject object = new JSONObject();
		for (int i=0; i<dlTransforms.size(); i++) {
			object.put(getJSONDLTransformName(dlTransforms.get(i).dltransfromType),  writeJSONParamsObject(dlTransforms.get(i)).toString()); 
		}

		return object; 
	}

	/**
	 * Write a list of parameters to a string. 
	 * @param file - the file to write to . 
	 * @param dlTransforms - the transform paramters list
	 * @return true of the file was written successfully. 
	 */
	public static String writeJSONString(List<DLTransfromParams> dlTransforms) {
		JSONObject object = writeJSONObject(dlTransforms); 

		//System.out.println(object.get("amplitude_to_decibel").toString()); 

		//Ok this is annoying but we have to do this to make sure the string is in order of the 
		//transforms. 
		String jsonString = object.toString(); 

		System.out.println(jsonString); 


		//get rid of { and } at start and of string. 
		jsonString = jsonString.substring(1, jsonString.length()-2); 


		String[] jsonStrings = jsonString.split("\",\""); 

		String orderedJSONString =""; 
		for (int i=0; i<dlTransforms.size(); i++) {
			String jsonName = getJSONDLTransformName(dlTransforms.get(i).dltransfromType); 
			for (int j=0; j<jsonStrings.length; j++) {
				if (jsonStrings[j].contains(jsonName)) {
					if (j==0) {
						//do not want the extra " for the first be, 
						orderedJSONString += jsonStrings[j]+"\"," ; 
					}
					else {
						orderedJSONString += "\"" + jsonStrings[j]+"\"," ; 
					}
				}
			}
		}
		//get rid of last ","
		orderedJSONString = orderedJSONString.substring(0, orderedJSONString.length()-1); 

		orderedJSONString= "{" + orderedJSONString + "}"; 

		//		System.out.println(orderedJSONString); 

		return orderedJSONString; 

		//		// Write the content in file 
		//		try(FileWriter fileWriter = new FileWriter(file)) {
		//			fileWriter.write(orderedJSONString);
		//			fileWriter.close();
		//			return true; 
		//		} catch (IOException e) {
		//			// Exception handling
		//			e.printStackTrace();
		//			return false;
		//		}

	}

	/**
	 * Write a list of parameters to a text file. Should be a .pgtf file for consistency. 
	 * @param file - the file to write to . 
	 * @param dlTransforms - the transform paramters list
	 * @return true of the file was written successfully. 
	 */
	public static boolean writeJSONFile(File file, List<DLTransfromParams> dlTransforms) {
		String orderedJSONString = writeJSONString(dlTransforms); 
		// Write the content in file 
		try(FileWriter fileWriter = new FileWriter(file)) {
			fileWriter.write(orderedJSONString);
			fileWriter.close();
			return true; 
		} catch (IOException e) {
			// Exception handling
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * Read a JSON file from a string. 
	 * @param file - the file. 
	 * @return the JSON string. 
	 */
	public static String readJSONString(File file) {

		try(FileReader fileReader = new FileReader(file)) {
			int ch =0; 
			String jsonData = ""; 
			while(ch != -1) {
				ch = fileReader.read();
				jsonData+=(char)ch; 

				//System.out.print((char)ch);

				//have the string data. now make a json object. 
			}
			fileReader.close();
			return jsonData; 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null; 
		}
	}


	/**
	 * Load the JSON file which contains DLTransfroms. 
	 * @param the JSON file to loads
	 */
	public static ArrayList<DLTransfromParams> readJSONFile(File file) {
		// Read the content from file
		try {
			String jsonData = readJSONString(file); 

			return parseTransfromParams(jsonData); 

		} 
		catch (Exception e) {
			e.printStackTrace(); 
			return null; 
		}
	}

	/**
	 * Create a json object which contains parameter values from a DLTransfromParams 
	 * @param dlTransformType - the transform type.
	 * @param jsonObjectParams - JSON object containing the parameters.  
	 * @return
	 */	
	@SuppressWarnings("unchecked")
	public static JSONObject writeJSONParamsObject(DLTransfromParams dlTransfromParams) {

		JSONObject paramsObject = new JSONObject(); 

		switch (dlTransfromParams.dltransfromType) {
		case DECIMATE:
		case DECIMATE_SCIPY:
			paramsObject.put("sr", ((SimpleTransformParams) dlTransfromParams).params[0].doubleValue()); 
			break;
		case PREEMPHSIS:
			paramsObject.put("pre_empf_factor", ((SimpleTransformParams) dlTransfromParams).params[0].doubleValue()); 
			break;
		case FILTER:
			FilterParams filterParams = WaveTransform.transform2FilterParams(((SimpleTransformParams) dlTransfromParams).params); 

			paramsObject.put("filtertype", filterParams.filterType); 
			paramsObject.put("filtermethod", filterParams.filterMethod); 
			paramsObject.put("order", filterParams.order); 
			paramsObject.put("lowcut", filterParams.lowCut); 
			paramsObject.put("highcut", filterParams.highCut); 

			break;
		case PEAK_TRIM:
			paramsObject.put("pad", ((SimpleTransformParams) dlTransfromParams).params[0].intValue()); 
			paramsObject.put("peak_method", ((SimpleTransformParams) dlTransfromParams).params[1].intValue());
			break;
		case SPEC2DB:
			if (((SimpleTransformParams) dlTransfromParams).params[0]!=null) {
				paramsObject.put("min_db", ((SimpleTransformParams) dlTransfromParams).params[0].doubleValue()); 
			}
			//otherwise nothing to add here - no params. 
			break;
		case SPECCLAMP:
			//nothing to add here - params are assumed to be 0 and 1 
			break;
		case SPECNORMALISEROWSUM:
			//nothing to add here - no params. 
			break; 
		case SPECCROPINTERP:
			paramsObject.put("fmin", ((SimpleTransformParams) dlTransfromParams).params[0].doubleValue()); 
			paramsObject.put("fmax", ((SimpleTransformParams) dlTransfromParams).params[1].doubleValue()); 
			paramsObject.put("bins", ((SimpleTransformParams) dlTransfromParams).params[2].intValue()); 
			break;
		case SPECNORMALISE:
			paramsObject.put("min_db", ((SimpleTransformParams) dlTransfromParams).params[0].doubleValue()); 
			paramsObject.put("ref_db", ((SimpleTransformParams) dlTransfromParams).params[1].doubleValue()); 
		case SPECTROGRAM:		
			paramsObject.put("fft", ((SimpleTransformParams) dlTransfromParams).params[0].intValue()); 
			paramsObject.put("hop", ((SimpleTransformParams) dlTransfromParams).params[1].intValue()); 
			break;
		case TRIM:
			paramsObject.put("min", ((SimpleTransformParams) dlTransfromParams).params[0].intValue()); 
			paramsObject.put("max", ((SimpleTransformParams) dlTransfromParams).params[1].intValue()); 
			break;
		case ENHANCE:
			paramsObject.put("enhancement", ((SimpleTransformParams) dlTransfromParams).params[0].doubleValue()); 
			break;
		case FILTER_ISOLATED_SPOTS:
			//TODO
			break;
		case GAUSSIAN_FILTER:
			paramsObject.put("sigma", ((SimpleTransformParams) dlTransfromParams).params[0].doubleValue()); 
			break;
		case MEDIANFILTER:
			//TODO
			break;
		case REDUCETONALNOISE_MEAN:
			paramsObject.put("time_const_len", ((SimpleTransformParams) dlTransfromParams).params[0].intValue()); 
			break;
		case REDUCETONALNOISE_MEDIAN:
			//nothing to add here - no params. 

			break;
		case SPECNORMALISESTD:
			paramsObject.put("mean", ((SimpleTransformParams) dlTransfromParams).params[0].intValue()); 
			paramsObject.put("std", ((SimpleTransformParams) dlTransfromParams).params[1].intValue()); 
			break;
		case SPECNORMALISE_MINIMAX:
			//nothing to add here - no params. 
			break;
		case NORMALISE_WAV:
			break;
		case SPECTROGRAMKETOS:
			paramsObject.put("fft", ((SimpleTransformParams) dlTransfromParams).params[0].intValue()); 
			paramsObject.put("hop", ((SimpleTransformParams) dlTransfromParams).params[1].intValue());
			paramsObject.put("window_size", ((SimpleTransformParams) dlTransfromParams).params[2].doubleValue());
			break;
		case SPECRESIZE:
			paramsObject.put("time_bins", ((SimpleTransformParams) dlTransfromParams).params[0].intValue()); 
			paramsObject.put("freq_bins", ((SimpleTransformParams) dlTransfromParams).params[1].intValue());
			break;
		default:
			break;
		}

		return paramsObject; 
	}


	/**
	 * Get the parameters from a JSOn string if the transform type is known.   
	 * @param dlTransformType - the transform type.
	 * @param jsonObjectParams - JSON object containing the parameters.  
	 * @return a DLTransform object. 
	 */	
	public static DLTransfromParams parseDLTransformParams(DLTransformType dlTransformType, JSONObject jsonObjectParams) {

		Number[] number;

		/**
		 * The transform paramters. 
		 */
		DLTransfromParams dlTransformParams = null; 

		switch (dlTransformType) {
		case DECIMATE:
		case DECIMATE_SCIPY:
			number = new Number[1]; 
			number[0] = jsonObjectParams.getFloat("sr"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case PEAK_TRIM:
			number = new Number[2]; 
			number[0] = jsonObjectParams.getInt("pad"); 
			number[1] = jsonObjectParams.getInt("peak_method"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case PREEMPHSIS:
			number = new Number[1]; 
			number[0] = jsonObjectParams.getDouble("pre_empf_factor"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case NORMALISE_WAV:
			dlTransformParams = new SimpleTransformParams(dlTransformType); 
			break;
		case FILTER:
			FilterParams filterParams = new FilterParams();

			filterParams.filterMethod = jsonObjectParams.getInt("filtermethod"); 
			filterParams.filterType = jsonObjectParams.getInt("filtertype"); 
			filterParams.order = jsonObjectParams.getInt("order"); 
			filterParams.lowCut = jsonObjectParams.getInt("lowcut"); 
			filterParams.highCut = jsonObjectParams.getInt("highcut"); 

			dlTransformParams = new SimpleTransformParams(dlTransformType, WaveTransform.filterParams2transform(filterParams));
			break;
		case SPEC2DB:
			number = new Number[1]; 
			number[0] = jsonObjectParams.getDouble("min_db"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number[0] == null? null : number); 
			break;
		case SPECNORMALISEROWSUM:
			dlTransformParams = new SimpleTransformParams(dlTransformType); 
			break;
		case SPECCLAMP:
			number = new Number[2]; 
			number[0] = 0.0; //- there is no JSON string for this in pytroch library 
			number[1] = 1.0; 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case SPECCROPINTERP:
			number = new Number[3]; 
			if (jsonObjectParams.has("fmin")) {
				//Standard format. 
				number[0] = jsonObjectParams.getDouble("fmin"); 
				number[1] = jsonObjectParams.getDouble("fmax"); 
				number[2] = jsonObjectParams.getInt("bins"); 
			}
			if (jsonObjectParams.has("start")) {
				//Ketos format. 
				number[0] = jsonObjectParams.getDouble("start"); 
				number[1] = jsonObjectParams.getDouble("end"); 
				number[2] = jsonObjectParams.getInt("length"); 
			}
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 

			break;
		case SPECNORMALISE:

			//System.out.println ("DLTransformsParser: min_db: ---  " + jsonObjectParams.getString("min_db") + "  " +  jsonObjectParams.getString("min_db").getClass()); 
			if (String.valueOf(jsonObjectParams.get("min_db")).equals("None")) {
				//in SoundSpot a "None" means use the min max normalisation instead. A little messy but this is how animal spot metadata works. 
				dlTransformParams = new SimpleTransformParams(DLTransformType.SPECNORMALISE_MINIMAX); 
			}
			else {
				number = new Number[2]; 
				number[0] = jsonObjectParams.getDouble("min_db"); 
				number[1] = jsonObjectParams.getDouble("ref_db"); 
				dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			}
			break;
		case SPECNORMALISE_MINIMAX:
			dlTransformParams = new SimpleTransformParams(dlTransformType); 
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
		case SPECNORMALISESTD:
			number = new Number[2]; 
			//may need to add defaults. 
			if (jsonObjectParams.has("mean")) {
				number[0] = jsonObjectParams.getDouble("mean"); 
			}
			else {
				number[0] = Double.valueOf(0.0);
			}

			if (jsonObjectParams.has("std")) {
				number[1] = jsonObjectParams.getDouble("std"); 
			}
			else {
				number[1] = Double.valueOf(1.0);
			}
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case REDUCETONALNOISE_MEAN:
			number = new Number[1]; 

			if (jsonObjectParams.has("time_const_len")) {
				number[0] = jsonObjectParams.getInt("time_const_len"); 
			}
			else {
				number[0] = Integer.valueOf(30);
			}
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case REDUCETONALNOISE_MEDIAN:
			dlTransformParams = new SimpleTransformParams(dlTransformType); 
			break;
		case MEDIANFILTER:
			dlTransformParams = new SimpleTransformParams(dlTransformType); 
			break;
		case ENHANCE:
			number = new Number[1]; 
			if (jsonObjectParams.has("enhancement")) {
				number[0] = jsonObjectParams.getDouble("enhancement");
			}
			else {
				number[0] = Double.valueOf(1.0);
			}
			dlTransformParams = new SimpleTransformParams(dlTransformType, number);
			break;
		case GAUSSIAN_FILTER:
			number = new Number[1]; 
			number = new Number[1]; 
			if (jsonObjectParams.has("sigma")) {
				number[0] = jsonObjectParams.getDouble("sigma");
			}
			else {
				number[0] = Double.valueOf(0.5);
			}
			dlTransformParams = new SimpleTransformParams(dlTransformType, number);
			break;
		case FILTER_ISOLATED_SPOTS:
			//TODO
			break;
		case SPECTROGRAMKETOS:
			number = new Number[2]; 
			number[0] = jsonObjectParams.getInt("fft"); 
			number[1] = jsonObjectParams.getInt("hop"); 
			number[2] = jsonObjectParams.getDouble("window_size"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case SPECRESIZE:		
			number = new Number[2]; 
			number[0] = jsonObjectParams.getInt("time_bins"); 
			number[1] = jsonObjectParams.getInt("freq_bins"); 
			dlTransformParams = new SimpleTransformParams(dlTransformType, number); 
			break;
		case SPECFLIP:
			dlTransformParams = new SimpleTransformParams(dlTransformType); 
		default:
			dlTransformParams = new SimpleTransformParams(dlTransformType); 
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

		//get the Json strings sorted in order as they appear. 
		String[] jsonstrings = getSortedJSonStrings(rawString); 

		//System.out.println("String len: " + jsonstrings.length);

		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();


		JSONObject jsonObjectParams; 
		DLTransfromParams dltarnsformParams = null; 
		for (int i=0; i<jsonstrings.length; i++) {
			//System.out.println(jsonstrings[i] + "  " + getTransformType(jsonstrings[i])); 
			dltarnsformParams = null;

			if (getTransformType(jsonstrings[i])!=null) {
				//may need some special cases here but most can be handled by this 
				jsonObjectParams = new JSONObject(jsonObject.getString(jsonstrings[i])); 
				dltarnsformParams = parseDLTransformParams(getTransformType(jsonstrings[i]), jsonObjectParams); 

				//System.out.println("DLTransform Params: " +  dltarnsformParams); 
				dlTransformParamsArr.add(dltarnsformParams); 
			}

			//			switch (jsonstrings[i]) {
			//			case "amplitude_to_decibel":
			//				jsonObjectParams = new JSONObject(jsonObject.getString("amplitude_to_decibel")); 
			//				dltarnsformParams = parseDLTransformParams(DLTransformType.SPEC2DB, jsonObjectParams); 
			//				dlTransformParamsArr.add(dltarnsformParams); 
			//				break;
			//			case "pre_emph":
			//				jsonObjectParams = new JSONObject(jsonObject.getString("pre_emph")); 
			//				dltarnsformParams = parseDLTransformParams(DLTransformType.PREEMPHSIS, jsonObjectParams); 
			//				dlTransformParamsArr.add(dltarnsformParams); 
			//				break;
			//			case "spectrogram":
			//				jsonObjectParams = new JSONObject(jsonObject.getString("spectrogram")); 
			//				dltarnsformParams = parseDLTransformParams(DLTransformType.SPECTROGRAM, jsonObjectParams); 
			//				dlTransformParamsArr.add(dltarnsformParams); 
			//				break;
			//			case "normalize":
			//				jsonObjectParams = new JSONObject(jsonObject.getString("normalize")); 
			//				dltarnsformParams = parseDLTransformParams(DLTransformType.SPECNORMALISE, jsonObjectParams); 
			//				dlTransformParamsArr.add(dltarnsformParams); 
			//				//				//also add the clamp here - it is separate in PG but integrated in AnimalSpot. 
			//				//				dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCLAMP, 0.0, 1.0)); 
			//				break;
			//			case "load_audio":
			//				jsonObjectParams = new JSONObject(jsonObject.getString("load_audio")); 
			//				dltarnsformParams = parseDLTransformParams(DLTransformType.DECIMATE, jsonObjectParams);
			//				dlTransformParamsArr.add(dltarnsformParams); 
			//				break;
			//			case "freq_compression":
			//				jsonObjectParams = new JSONObject(jsonObject.getString("freq_compression")); 
			//				dltarnsformParams = parseDLTransformParams(DLTransformType.SPECCROPINTERP, jsonObjectParams);
			//				dlTransformParamsArr.add(dltarnsformParams); 
			//				break;
			//			case "trim":
			//				jsonObjectParams = new JSONObject(jsonObject.getString("trim")); 
			//				dltarnsformParams = parseDLTransformParams(DLTransformType.TRIM, jsonObjectParams);
			//				dlTransformParamsArr.add(dltarnsformParams); 
			//				break;
			//			case "clamp":
			//				jsonObjectParams = new JSONObject(jsonObject.getString("clamp")); 
			//				dltarnsformParams = parseDLTransformParams(DLTransformType.SPECCLAMP, jsonObjectParams); 
			//				dlTransformParamsArr.add(dltarnsformParams); 
			//				break;
			//			case "norm_row_sum":
			//				jsonObjectParams = new JSONObject(jsonObject.getString("norm_row_sum")); 
			//				dltarnsformParams = parseDLTransformParams(DLTransformType.SPECNORMALISEROWSUM, jsonObjectParams); 
			//				dlTransformParamsArr.add(dltarnsformParams); 
			//				break;
			//			}

		}

		return dlTransformParamsArr; 

	}


	/**
	 * Get the string name for a transform
	 * @return
	 */
	public static String getJSONDLTransformName(DLTransformType dlTransformType) {
		//		String jsonStringName = null; 
		//		switch (dlTransformType) {
		//		case DECIMATE:
		//			jsonStringName = "load_audio";
		//			break;
		//		case PREEMPHSIS:
		//			jsonStringName = "pre_emph";
		//			break;
		//		case SPEC2DB:
		//			jsonStringName = "amplitude_to_decibel"; 
		//			break;
		//		case SPECCLAMP:
		//			jsonStringName = "clamp";
		//			break;
		//		case SPECCROPINTERP:
		//			jsonStringName = "freq_compression";
		//			break;
		//		case SPECNORMALISE:
		//			jsonStringName = "normalize";
		//			break;
		//		case SPECNORMALISEROWSUM:
		//			jsonStringName = "norm_row_sum";
		//			break;
		//		case SPECTROGRAM:
		//			jsonStringName = "spectrogram";
		//			break;
		//		case TRIM:
		//			jsonStringName = "trim";
		//			break;
		//		default:
		//			break;
		//		}

		return dlTransformType.getJSONString(); 
	}


	/**
	 * Get the transform type from the JSON string name. 
	 * @return the transform type from the string name. 
	 */
	public static DLTransformType getTransformType(String string) {
		DLTransformType[] dlTransformTypes = DLTransformType.values();

//		System.out.println(" DLTransformType: " + string + "|"); 
		for (DLTransformType dlTransformType: dlTransformTypes) {
			if (dlTransformType.getJSONString().equals(string)) {
				return dlTransformType; 				
			}
		}

		return null; 
		//		switch (string) {
		//		case "amplitude_to_decibel":
		//			return DLTransformType.SPEC2DB; 
		//		case "pre_emph":
		//			return DLTransformType.PREEMPHSIS; 
		//		case "spectrogram":
		//			return DLTransformType.SPECTROGRAM; 
		//		case "normalize":
		//			return DLTransformType.SPECNORMALISE; 
		//		case "load_audio":
		//			return DLTransformType.DECIMATE; 
		//		case "freq_compression":
		//			return DLTransformType.SPECCROPINTERP; 
		//		case "trim":
		//			return DLTransformType.TRIM; 
		//		case "clamp":
		//			return DLTransformType.SPECCLAMP; 
		//		case "norm_row_sum":
		//			return DLTransformType.SPECNORMALISEROWSUM; 
		//		case "reduce_tonal_noise_median":
		//			return DLTransformType.REDUCETONALNOISE_MEDIAN; 
		//		case "reduce_tonal_noise_mean":
		//			return DLTransformType.REDUCETONALNOISE_MEAN; 
		//		case "enhance_signal":
		//			return DLTransformType.ENHANCE; 
		//		case "normalise_std":
		//			return DLTransformType.NORMALISESTD; 
		//		}
		//		return null; 
	}


	/**
	 * Get strings sorted in the order that they appear in the raw JSON string
	 * @return the sorted list of strings. 
	 */
	public static String[] getSortedJSonStrings(String rawString) {

		JSONObject jsonObject = new JSONObject(rawString);

		String[] jsonStrings = JSONObject.getNames(jsonObject); 

		int[]  index = new int[jsonStrings.length]; 
		for (int i=0; i<jsonStrings.length; i++) {
			index[i] = rawString.indexOf(jsonStrings[i]); 
		}

		//sort the string array by the int array, 
		final List<String> stringListCopy = Arrays.asList(jsonStrings);
		ArrayList<String> sortedList = new ArrayList<String>(stringListCopy);
		Collections.sort(sortedList, (left, right) -> index[stringListCopy.indexOf(left)] - index[stringListCopy.indexOf(right)]);

		return sortedList.toArray(jsonStrings); 
	}



	/**
	 * Test the file writer. 
	 * @param input arguments. 
	 */
	public static void main(String args[]) {

		//let's test by first loading a SoundSpot model that contains params- then we save that model metadata to a JSON file 
		//and then we test by loading the file again. 

		String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/bats_denmark/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000_JIT.pk";


		String outFile = "/Users/au671271/Desktop/dlparams.pdtf"; 

		//first open the model and get the correct parameters. 
		AnimalSpotModel soundSpotModel;
		try {
			soundSpotModel = new AnimalSpotModel(modelPath);

			//create the DL params. 
			AnimalSpotParams dlParams = new AnimalSpotParams(soundSpotModel.getTransformsString());

			System.out.println("----Loaded from model------"); 
			System.out.println(dlParams.toString()); 

			writeJSONFile(new File(outFile), dlParams.dlTransforms); 

			ArrayList<DLTransfromParams> dlTransforms = readJSONFile(new File(outFile));  

			System.out.println("----Saved to file and then loaded again------"); 

			String string =""; 
			string += "***********\n"; 
			for (int i=0; i<dlTransforms.size(); i++) {
				string += dlTransforms.get(i).toString() + "\n"; 
			}

			string += "***********\n"; 

			System.out.println(string); 



		} catch (Exception e) {
			e.printStackTrace();
		}
		//			e.printStackTrace();
		//		} catch (IOException e) {
		//			// TODO Auto-generated catch block
		//			e.printStackTrace();
		//		} 
	}


}
