package org.jamdev.jdl4pam.transforms.jsonfile;

import java.io.File;

import org.jamdev.jdl4pam.genericmodel.GenericModelParams;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.SimpleTransform;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Test to see that a file can be read!
 */
public class DLTransformImportTest {

	public static void main(String[] args) {

		transformJSONExamples();

	}

	/**
	 * Print out examples of all JSON transforms. 
	 */
	public static void transformJSONExamples() {
		DLTransformType[] transfroms = DLTransformType.values();
		float sR = 48000;

		JSONObject mainObject = new JSONObject();

		JSONArray jsonArray = new JSONArray();
		JSONObject object;
		for (int i=0; i< transfroms.length; i++) {

			System.out.println("Transform: " + transfroms[i] + "  " + transfroms[i].name());
			SimpleTransform transform = (SimpleTransform) DLTransformsFactory.makeDLTransform(transfroms[i],  sR); 

			object = new JSONObject();
			object.put("name", DLTransformsParser.getJSONDLTransformName(transform.getDLTransformType()));

			//			JSONArray array = new JSONArray();

			SimpleTransformParams params = new SimpleTransformParams(transform.getDLTransformType(), transform.getParams()); 

			object.put("params", DLTransformsParser.writeJSONParamsObject(params));
			
			
			jsonArray.put(i, object);

		}

		mainObject.put("transforms", jsonArray);
		
		System.out.println(mainObject.toString(1));
	}


	public static void importTest() {
		//		String file = "D:/Dropbox/PAMGuard_dev/Deep_Learning/delphinID/testencounter415/delphinID.pdtf";

		String file = "/Users/au671271/Library/CloudStorage/Dropbox/PAMGuard_dev/Deep_Learning/delphinID/delphinIDmodels/Ggr242/whistleclassifier/delphinID.pdtf";

		String jsonString = DLTransformsParser.readJSONString(new File(file));

		//Need to figure out if this is the new or old format. 
		JSONObject jsonObject = new JSONObject(jsonString);

		GenericModelParams params = DLTransformParser2.readJSONParams(jsonObject);

		System.out.println(params.dlTransforms);

		for (int i=0; i<params.dlTransforms.size(); i++) {
			System.out.println(params.dlTransforms.get(i).dltransfromType + " params: " + (params.dlTransforms.get(i).params == null ? "null" : params.dlTransforms.get(i).params.length));
		}

	}
}
