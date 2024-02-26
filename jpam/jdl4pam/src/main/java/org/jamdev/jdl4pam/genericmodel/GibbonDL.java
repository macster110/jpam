package org.jamdev.jdl4pam.genericmodel;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.engine.Engine;

/**
 * Run a gibbon classifier. This imports a tflite model. 
 * @author Jamie Macaulay
 *
 */
public class GibbonDL {


	public static void runGubbon() {

		String modelPath = "D:/Dropbox/PAMGuard_dev/Deep_Learning/Gibbons/gibbon_model_shared/model.tflite";

		File file = new File(modelPath); 

		Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
		String modelName = file.getName(); 

		System.out.println(Engine.getAllEngines()); 

		Model model = Model.newInstance(modelPath, "TFLite"); 

		try {
			model.load(modelDir, modelName);
			System.out.println("Input: " + model.describeInput().values()); 
			System.out.println("Output: " + model.describeOutput().values()); 
		} catch (MalformedModelException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	


	}

	public static void main(String[] args) {
		runGubbon();
	}

}
