package org.jamdev.jdl4pam.transforms.jsonfile;

import java.util.ArrayList;
import java.util.List;
import org.jamdev.jdl4pam.FrameWork;
import org.jamdev.jdl4pam.genericmodel.DefaultGenericParams;
import org.jamdev.jdl4pam.genericmodel.DefaultGenericParams.GenericModel;
import org.jamdev.jdl4pam.genericmodel.GenericModelParams;
import org.jamdev.jdl4pam.genericmodel.ModelInfo;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.json.JSONArray;
import org.json.JSONObject;

import ai.djl.ndarray.types.Shape;

/**
 * Write and read the transforms to a JSON file. In 2023 this replaced the
 * original parser as a default metadata format.
 * 
 * @author Jamie Macaulay
 *
 */
public class DLTransformParser2 {

	/**
	 * The version of the metadata. 
	 */
	public static final double DL_JSON_VERSION = 1.0;
	
	
	private static final String DL_JSON_DESCRIPTION = "Metadata for acoustic deep learning"; 


	/**
	 * Write parameters to a JSON object. 
	 * @param genericParams - the parameters to write. 
	 * @return JSON object containing parameter data. 
	 */
	public static JSONObject writeJSONParams(GenericModelParams genericParams) {

		JSONObject mainObject = new JSONObject();

		/**
		 * Write the model type. 
		 */
		writeJSONModelType(FrameWork.GENERIC, mainObject); 

		/**
		 * The version number
		 */
		writeJSONVersion(DL_JSON_VERSION, mainObject);

		/**
		 * Write the shape
		 */
		writeJSONShape(genericParams.defaultInputShape, genericParams.defaultOutputShape, mainObject);

		/**
		 * Write the class names
		 */
		writeJSONCLassInfo(genericParams.classNames, genericParams.classNames.length, mainObject);

		/**
		 * Write the class names
		 */
		writeJSONSegLen(genericParams.segLen,  mainObject);

		/**
		 * Write the class names
		 */
		writeJSONCLassInfo(genericParams.classNames, genericParams.classNames.length, mainObject);

		//		/**
		//		 * Write the target species.
		//		 */
		//		String[] targetSpecies = new String[] { "Eubalaena glacialis", "Noise" };
		//
		//		writeJSONTargetSpecies(targetSpecies, mainObject);

		JSONObject jsonObject = writeJSONTransforms(genericParams.dlTransforms, mainObject);


		return jsonObject; 

	}


	/**
	 * Read parameters from a JSON object. 
	 * @param mainObject - JSON object containing the parameters. 
	 * @return a genericParams object
	 * 	 */
	public static GenericModelParams readJSONParams(JSONObject mainObject) {

		GenericModelParams modelParams = new GenericModelParams(); 

		ArrayList<DLTransfromParams> dlTransforms =  readJSONDLtransforms(mainObject); 

		double segLen =  readJSONSegLen(mainObject); 

		String[] classNames = readJSONClassInfo(mainObject); 

		ModelInfo modelInfo = readJSONModelInfo(mainObject); 

		modelParams.dlTransforms = dlTransforms; 
		modelParams.segLen = segLen; 

		if (modelInfo!=null) {
			modelParams.defaultInputShape = modelInfo.inputShape;
			modelParams.defaultOutputShape = modelInfo.outputShape;
		}

		if (classNames!=null) {
			modelParams.classNames = classNames; 
		}

		return modelParams; 
	}



	/**
	 * Write the model type. 
	 */
	public static void writeJSONModelType(FrameWork frameWork,JSONObject  mainObject) {
		JSONObject frameworkObject = new JSONObject();

		frameworkObject.put("framework", frameWork.getLabel());

		mainObject.put("framework_info", frameworkObject);
	}


	/**
	 * Create a JSON object from a a list of transforms
	 * 
	 * @param classNames - the names for each class. Note this can be null.
	 * @param nClass     - the number of classes
	 * @param -          the main JSON object to write to.
	 * @return the updated JSON object.
	 */
	public static JSONObject writeJSONCLassInfo(String[] classNames, int nClass, JSONObject mainObject) {
		JSONObject classObject = new JSONObject();

		if (classNames != null && classNames.length > 0) {
			JSONArray classNameArray = new JSONArray();
			for (int i = 0; i < classNames.length; i++) {
				classNameArray.put(classNames[i]);
			}
			classObject.put("name_class", classNameArray);

		}
		classObject.put("num_class", nClass);

		mainObject.put("class_info", classObject);

		return mainObject;
	}

	/**
	 * Read the class names from the a JSON object 
	 * 
	 * @param mainObject - JSON object containing the parameters. 
	 * @return he names for each class. Note this can be null.
	 */
	public static String[] readJSONClassInfo(JSONObject mainObject) {
		JSONObject classObject = mainObject.getJSONObject("class_info"); 

		int nClass = classObject.getInt("num_class"); 

		if (classObject.has("name_class")) {

			JSONArray classNamesObject = classObject.getJSONArray("name_class"); 

			String[] classNames = new String[classNamesObject.length()]; 

			for (int i = 0; i < classNamesObject.length(); i++) {
				classNames[i] = classNamesObject.getString(i); 
			}

			return classNames;
		}
		else {

			return null; 
		}
	}


	/**
	 * Add a target species to the JSON object. The target species are used only for
	 * record keeping and UI interactions. They are not necessary in the metadata,
	 * do not necessarily need to correspond to class names (although that is
	 * recommended) and can be null.
	 * 
	 * @param speciesNames - a list of target species names
	 * @param -            the main JSON object to write to.
	 * @return the updated JSON object
	 */
	public static JSONObject writeJSONTargetSpecies(String[] speciesNames, JSONObject mainObject) {

		JSONObject speciesObject = new JSONObject();

		JSONArray speciesNameArray = new JSONArray();
		for (int i = 0; i < speciesNames.length; i++) {
			speciesNameArray.put(speciesNames[i]);
		}
		speciesObject.put("name", speciesNameArray);

		mainObject.put("target", speciesObject);

		return mainObject;
	}


	/**
	 * Read the target species from JSON object. The target species are used only for
	 * record keeping and UI interactions. They are not necessary in the metadata,
	 * do not necessarily need to correspond to class names (although that is
	 * recommended) and can be null.
	 * 
	 * @param -  the main JSON object to read from.
	 * @return a list of target species names
	 */
	public static String[] readJSONTargetSpecies(JSONObject mainObject) {

		if (mainObject.has("target")) {

			JSONObject speciesObject = mainObject.getJSONObject("target"); 

			JSONArray speciesNameArray = speciesObject.getJSONArray("name");
			String[] targetNames = new String[speciesNameArray.length()]; 
			for (int i = 0; i < speciesNameArray.length(); i++) {
				targetNames[i] = speciesNameArray.getString(i);
			}
			return targetNames;

		}
		else {
			return null; 
		}
	}



	/**
	 * Add segment length to a JSON object. 
	 * 
	 * @param segLen - the segment length
	 * @param -       the main JSON object to write to.
	 * @return the updated JSON object
	 */
	public static JSONObject writeJSONSegLen(double segLen, JSONObject mainObject) {

		JSONObject segLenObject = new JSONObject();

		segLenObject.put("size_ms", segLen);

		mainObject.put("seg_size", segLenObject);

		return mainObject;
	}


	/**
	 * Read the segment length from JSON object. 
	 * @param mainObject - the JSON object containing parameters. 
	 * @return the segment length in milliseconds. 
	 */
	public static double readJSONSegLen(JSONObject mainObject) {
		JSONObject segLenObject = mainObject.getJSONObject("seg_size"); 

		return segLenObject.getDouble("size_ms");
	}


	/**
	 * Read the version from JSON object. 
	 * @param mainObject - the JSON object containing parameters. 
	 * @return the version number of the JSON file. 
	 */
	public static double readJSONVersionInfo(JSONObject mainObject) {
		JSONObject segLenObject = mainObject.getJSONObject("version_info"); 

		return segLenObject.getDouble("version");
	}

	/**
	 * Add a version info JSON object.
	 * 
	 * @param version - the version number for the metadata schema
	 * @param -       the main JSON object to write to.
	 * @return the updated JSON object
	 */
	public static JSONObject writeJSONVersion(double version, JSONObject mainObject) {

		JSONObject versionObject = new JSONObject();

		versionObject.put("version", version);

		mainObject.put("version_info", versionObject);
		mainObject.put("description", DL_JSON_DESCRIPTION);


		return mainObject;
	}


	/**
	 * Add model information to the JSON object.
	 * 
	 * @param modelInfo  - ModelInfo object containing information about the model. 
	 * @param -           the main JSON object to write to.
	 * @return the updated JSON object.
	 */
	public static JSONObject writeModelInfo(ModelInfo modelInfo, JSONObject mainObject) {

		JSONObject shapeObject = new JSONObject();

		if ( modelInfo.inputShape!=null) {
			writeJSONShapeObject("input_shape", modelInfo.inputShape, shapeObject);
		}
		if ( modelInfo.outputShape!=null) {
			writeJSONShapeObject("output_shape", modelInfo.outputShape, shapeObject);
		}

		mainObject.put("model_info", shapeObject);

		return mainObject;
	}

	/**
	 * Add model information to the JSON object.
	 * <p>
	 * Note this is a convenience function and calls writeModelInfo(modelInfo, mainObject)
	 * . 
	 * @param inputshape  - the input shape for the model
	 * @param outputshape - the output shape for the model
	 * @param -           the main JSON object to write to.
	 * @return the updated JSON object.
	 */
	public static JSONObject writeJSONShape(Shape inputshape, Shape outputShape, JSONObject mainObject) {
		ModelInfo modelInfo = new ModelInfo(); 

		modelInfo.inputShape = inputshape; 
		modelInfo.outputShape = outputShape; 

		return writeModelInfo( modelInfo,  mainObject);
	}

	private static JSONObject writeJSONShapeObject(String key, Shape inputshape, JSONObject shapeObject) {
		JSONArray inputShapeArray = new JSONArray();
		for (int i = 0; i < inputshape.getShape().length; i++) {
			inputShapeArray.put(inputshape.getShape()[i]);
		}
		shapeObject.put(key, inputShapeArray);

		return shapeObject;
	}


	/**
	 * Read the JSON model information
	 * @param mainObject - the JSON object containing parameters. 
	 * @return the model information 
	 */
	public static ModelInfo readJSONModelInfo(JSONObject mainObject) {

		ModelInfo info = new ModelInfo();

		if (mainObject.has("model_info")) {

			JSONObject modelObject = mainObject.getJSONObject("model_info"); 

			if (modelObject.has("input_shape")) {
				info.inputShape =  readJSONShapeObject(modelObject, "input_shape"); 
			}
			if (modelObject.has("output_shape")) {
				info.outputShape =  readJSONShapeObject(modelObject, "output_shape"); 
			}

			return info; 

		}
		else {
			return null; 
		}
	}


	private static Shape readJSONShapeObject(JSONObject object, String key) {
		JSONArray array = object.getJSONArray(key); 

		long[] shapeL = new long[array.length()]; 
		for (int i = 0; i < array.length(); i++) {
			shapeL[i] = array.getLong(i); 
		}

		return new Shape(shapeL);
	}


	/**
	 * Add a list of transforms to the JSON object.
	 * 
	 * @param dlTransforms - a list of transform parameters.
	 * @param -            the main JSON object to write to.
	 * @return the updated JSON object.
	 */
	public static JSONObject writeJSONTransforms(List<DLTransfromParams> dlTransforms, JSONObject mainObject) {

		JSONArray jsonArray = new JSONArray();

		for (int i = 0; i < dlTransforms.size(); i++) {
			JSONObject object = new JSONObject();

			object.put("name", DLTransformsParser.getJSONDLTransformName(dlTransforms.get(i).dltransfromType));

			//			JSONArray array = new JSONArray();

			object.put("params", DLTransformsParser.writeJSONParamsObject(dlTransforms.get(i)));


			jsonArray.put(object);
		}

		mainObject.put("transforms", jsonArray);

		return mainObject;
	}





	/**
	 * Read a list of DL transform parameters from a JSON file. 
	 * @param mainObject - the JSON object containing parameters. 
	 * @return a list of transform paramter objects. 
	 */
	public static ArrayList<DLTransfromParams>  readJSONDLtransforms(JSONObject mainObject) {
		//first parse the transforms.
		JSONArray jsonArray = mainObject.getJSONArray("transforms"); 

		//System.out.println("String len: " + jsonstrings.length);

		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		JSONObject jsonObjectParams; 
		DLTransfromParams dlTransformParams = null; 
		for (int i=0; i<jsonArray.length(); i++) {

			String transformName = (String) jsonArray.getJSONObject(i).get("name"); 

			jsonObjectParams  = (JSONObject) jsonArray.getJSONObject(i).get("params"); 
			
			DLTransformType dlTransType= DLTransformsParser.getTransformType(transformName); 
			
			if (dlTransType==null) continue;

			dlTransformParams = DLTransformsParser.parseDLTransformParams(dlTransType, jsonObjectParams);  

			dlTransformParamsArr.add(dlTransformParams);

		}

		return dlTransformParamsArr; 

	}
	
	
	/**
	 * Check whether a JOSNObject is a V2+ version of paramters. If so the functions in DLtransforParser2 will
	 * work for converting the file. 
	 * @param jsonObject - the JSON object. 
	 * @return true if JSON metadata format is V2+. 
	 */
	public static boolean isParamsV2(JSONObject jsonObject){
		boolean isParamsV2 =false; 
		
		//does the object have a version
		if (jsonObject.has("version_info") ) {
			JSONObject versionObject = jsonObject.getJSONObject("version_info"); 
			
			//lots of JSON metadata might have a version number so to be absolutely sure...
			if (versionObject.has("version")) {
				isParamsV2=true;
			}
		}
		
		return isParamsV2;
	}


	public static void main(String[] args) {

		GenericModelParams params =  DefaultGenericParams.getDefaultParams(GenericModel.RIGTH_WHALE_SHUI); 


		/****Write the JSON Object****/

		/**
		 * Write the JSON object. 
		 */
		JSONObject mainObject = writeJSONParams(params); 
		/**
		 * Write the target species.
		 */
		String[] targetSpecies = new String[] { "Eubalaena glacialis", "Noise" };

		writeJSONTargetSpecies(targetSpecies, mainObject);

		System.out.println(mainObject.toString(2));

		/****Read the JSON Object****/

		GenericModelParams params2 =  readJSONParams( mainObject); 

		double version = readJSONVersionInfo(mainObject); 

		String[] targetNames = readJSONTargetSpecies(mainObject); 


	}


}
