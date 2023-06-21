package org.jamdev.jdl4pam.transforms.jsonfile;

import java.util.List;

import org.jamdev.jdl4pam.genericmodel.DefaultGenericParams;
import org.jamdev.jdl4pam.genericmodel.DefaultGenericParams.GenericModel;
import org.jamdev.jdl4pam.genericmodel.GenericModelParams;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
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
	
	
	/**
	 * Write a JSON object which 
	 * @param genericParams
	 * @return
	 */
	public static JSONObject writeJSONParams(GenericModelParams genericParams) {
		
		JSONObject mainObject = new JSONObject();
		
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

		return mainObject;
	}

	/**
	 * Add model information to the JSON object.
	 * 
	 * @param inputshape  - the input shape for the model
	 * @param outputshape - the output shape for the model
	 * @param -           the main JSON object to write to.
	 * @return the updated JSON object.
	 */
	public static JSONObject writeJSONShape(Shape inputshape, Shape outputShape, JSONObject mainObject) {

		JSONObject shapeObject = new JSONObject();

		writeJSONShapeObject("input_shape", inputshape, shapeObject);
		writeJSONShapeObject("output_shape", outputShape, shapeObject);

		mainObject.put("model_info", shapeObject);

		return mainObject;
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

			object.put("params", DLTransformsParser.writeJSONParamsObject(dlTransforms.get(i)).toString());

			jsonArray.put(object);
		}

		mainObject.put("transforms", jsonArray);

		return mainObject;
	}

	public static void main(String[] args) {
		
		GenericModelParams params =  DefaultGenericParams.getDefaultParams(GenericModel.RIGTH_WHALE_SHUI); 
		
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

	}

}
