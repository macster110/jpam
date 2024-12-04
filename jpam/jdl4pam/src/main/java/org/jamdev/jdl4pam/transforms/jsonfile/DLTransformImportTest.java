package org.jamdev.jdl4pam.transforms.jsonfile;

import java.io.File;

import org.jamdev.jdl4pam.genericmodel.GenericModelParams;
import org.json.JSONObject;

/**
 * Test to see that a file can be read!
 */
public class DLTransformImportTest {

	public static void main(String[] args) {

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
