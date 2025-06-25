package org.jamdev.jdl4pam.deepAcoustics;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.ndarray.NDArray;
import ai.djl.ndarray.NDList;
import ai.djl.translate.Batchifier;
import ai.djl.translate.TranslateException;
import ai.djl.translate.Translator;
import ai.djl.translate.TranslatorContext;

/**
 * Test opening Tensorflow models in .h5 format
 */
public class DeepAcousticsh5Test {
	
	public static void main(String[] args) {
		
		System.out.println("Load model start");
		
//		String path = "/home/jamiemac/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/TensorFlow/TestTFDarkNet/model.py"; 
		String path = "/home/jamiemac/Dropbox/PAMGuard_dev/Deep_Learning/deepAcoustics/TensorFlow/tfdarkmodel.h5"; 
		File file = new File(path); 


		Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
		String modelName = file.getName(); 

		Model model = Model.newInstance("DrkNet");
		
		try {
			model.load(modelDir);
		} catch (MalformedModelException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("Load model end");

		
		System.out.println(model.describeInput());


	}
	
	static class MyTranslator implements Translator<NDArray, NDArray> {

        @Override
        public NDArray processOutput(TranslatorContext ctx, NDList list) throws TranslateException, IOException {
            // Assuming the model is the first element in the returned list.
            return list.get(0); // Adjust index if needed.
        }

        @Override
        public NDList processInput(TranslatorContext ctx, NDArray input) throws TranslateException, IOException {
            return new NDList(input);
        }

        @Override
        public Batchifier getBatchifier() {
            return Batchifier.STACK;
        }
    }

}
