package org.jamdev.jdl4pam.ketos;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.jamdev.jdl4pam.genericmodel.SpectrogramTranslator;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformsParser;

import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.inference.Predictor;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.TranslateException;
import ai.djl.util.ZipUtils;

/**
 * Load a model from Meridian's Ketos framework. 
 * <p>
 * https://meridian.cs.dal.ca/2015/04/12/ketos/
 * 
 * @author Jamie Macaulay 
 *
 */
public class KetosModel {

	/**
	 * The spectrogram translator
	 */
	private SpectrogramTranslator translator;

	/**
	 * File with transform settings. 
	 */
	String audReprFile = null;
	
	/**
	 * The model file. 
	 */
	String modelPath = null;
	
	/**
	 * The model. 
	 */
	private Model model;


	/**
	 * The predictor for the model. 
	 */
	Predictor<float[][][], float[]> predictor;

	/**
	 * The input shape from the loaded model. 
	 */
	private Shape inputShape = null; 

	/**
	 * The output shape from the model. 
	 */
	private Shape outShape = null; 

	
	public KetosModel(File file) throws IOException, MalformedModelException {

		FileInputStream fileInputStream= new FileInputStream(file); 
		
		String zipFolder = System.getProperty("user.home") + "/ketos_models/" + getFileNameWithoutExtension(file);


		File outFile = new File(zipFolder);
		
		//Creating the directory
		boolean bool = outFile.mkdir();
//		if(bool){
//			System.out.println("Directory created successfully");
//		}else{
//			System.out.println("Sorry couldn’t create specified directory: " +outFile);
//		}

		//unzip the model into the temporary directory....
		ZipUtils.unzip(fileInputStream, Paths.get(zipFolder));
		
		//tnhe file that contains the model meta data
		audReprFile = zipFolder + "/audio_repr.json";

		//the model path. 
		modelPath = zipFolder + "/model/saved_model.pb"; 
		
		Path modelDir = Paths.get(new File(modelPath).getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
		model = Model.newInstance(modelPath, "TensorFlow"); 
		model.load(modelDir, "saved_model.pb");
		
		
		if (model == null) {
			System.err.println("Ketos Model: Could not load model: " + modelPath);
		}
		else {
			if (model!=null && model.describeInput()!=null) {
				//System.out.println("Generic Model: Input: " + model.describeInput().get(0).getValue()); 
				inputShape =  model.describeInput().get(0).getValue();
			}
			if (model!=null && model.describeOutput()!=null) {
				//System.out.println("Generic Model: Output: " + model.describeOutput().get(0).getValue()); 
				outShape = model.describeOutput().get(0).getValue();
			}

			//create the predictor for the new shape. 
			translator = new SpectrogramTranslator(inputShape); 

			//predictor for the model
			predictor = model.newPredictor(translator);
		}
		
		//translator = new SpectrogramTranslator(inputShape); 
	}
	
	
	/**
	 * Set the input shape. This will also change the spectrogram translator and predictor. 
	 * @param inputShape - the input shape to set. 
	 */
	public void setInputShape(Shape inputShape) {
		this.inputShape = inputShape;
		translator = new SpectrogramTranslator(inputShape); 
		//predictor for the model
		predictor = model.newPredictor(translator);
	}



	/**
	 * Get the output shape. 
	 * @return the output shape. 
	 */
	public Shape getOutShape() {
		return outShape;
	}


	/**
	 * Get the expect input shape. 
	 * @return the input shape. 
	 */
	public Shape getInputShape() {
		return inputShape;
	}


	/**
	 * Get the audio representation file. This holds the information for transforming the 
	 * raw sound data to an image to pass the model. 
	 * @return the audio file. 
	 */
	public String getAudioReprFile() {
		return audReprFile;
	}

	
	/**
	 * Get the filename without an extension. 
	 * @param file - the input file
	 * @return - the name of the file without an extension. 
	 */
    private static String getFileNameWithoutExtension(File file) {
        String fileName = "";
 
        try {
            if (file != null && file.exists()) {
                String name = file.getName();
                fileName = name.replaceFirst("[.][^.]+$", "");
            }
        } catch (Exception e) {
            e.printStackTrace();
            fileName = "";
        }
 
        return fileName;
 
    }
    
    

	/**
	 * Run the model.
	 * @param specImage - the spectrogram image
	 * @return the results 
	 */
	public float[] runModel(float[][][] specImage) {
		try {
			float[] results  = predictor.predict(specImage);
			//DLUtils.printArray(results);
			return results; 
		} catch (TranslateException e) {
			System.out.println("Error on model: "); 
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * Get the model 
	 * @return the model. 
	 */
	public Model getModel() {
		return model;
	}


	
	public static void main(String[] args) {
		File file = new File("/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Meridian/right_whales/for_pamguard/narw.ktpb"); 

		try {
			//the ketos model. 
			KetosModel  ketosModel = new KetosModel(file);
			
			//read the JSOn string from the the file. 
			String jsonString  = DLTransformsParser.readJSONString(new File(ketosModel.getAudioReprFile()));
	
			//get the audio representation file. 
			KetosParams ketosParams = new KetosParams(jsonString); 
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

	
}
