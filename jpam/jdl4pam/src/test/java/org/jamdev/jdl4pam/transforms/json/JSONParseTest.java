package org.jamdev.jdl4pam.transforms.json;

import static org.junit.Assert.assertTrue;

import org.jamdev.jdl4pam.genericmodel.DefaultGenericParams;
import org.jamdev.jdl4pam.genericmodel.DefaultGenericParams.GenericModel;
import org.jamdev.jdl4pam.genericmodel.GenericModelParams;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformParser2;
import org.json.JSONObject;
import org.junit.Test;

/**
 *	
 *Test parsing JSON data.  
 *
 */
public class JSONParseTest {

	/**
	 * Test a right whale classifier from Marie Roch's group. 
	 */
	@Test
	public void jsonRightWhaleTest()
	{
		GenericModelParams inputParams = DefaultGenericParams.getDefaultParams(GenericModel.RIGTH_WHALE_SHUI);
		
		GenericModelParams params = jsonParseTest(inputParams);
		
		assertTrue(inputParams.equals(params) ); 
	}
	
	
	/**
	 * Test JSON parsing for Google's humpback whale classifier. 
	 */
	@Test
	public void jsonHumpbackWhaleTest()
	{
		GenericModelParams inputParams = DefaultGenericParams.getDefaultParams(GenericModel.GOOGLE_HUMPBACK_1);
		
		GenericModelParams params = jsonParseTest(inputParams);
		
		assertTrue(inputParams.equals(params) ); 
	}
	
	
	
	/**
	 * Creates a JSON file from params and then converts the JSON file back into a new params object. 
	 * @param params - the input paramters. The returned object should be equal to the input params. 
	 * @return a new params object after converting from params -> JSON -> params. 
	 */
	public static GenericModelParams jsonParseTest(GenericModelParams params) {
		
		/****Write the JSON Object****/
		
		/**
		 * Write the JSON object. 
		 */
		JSONObject mainObject = DLTransformParser2.writeJSONParams(params); 
		/**
		 * Write the target species.
		 */
		String[] targetSpecies = new String[] { "Noise", "Eubalaena glacialis" };

		DLTransformParser2.writeJSONTargetSpecies(targetSpecies, mainObject);

		System.out.println(mainObject.toString(2));
		
		/****Read the JSON Object****/

		GenericModelParams params2 =  DLTransformParser2.readJSONParams( mainObject); 
		
		double version = DLTransformParser2.readJSONVersionInfo(mainObject); 
		
		String[] targetNames = DLTransformParser2.readJSONTargetSpecies(mainObject); 
		
		return params2; 
	}

}