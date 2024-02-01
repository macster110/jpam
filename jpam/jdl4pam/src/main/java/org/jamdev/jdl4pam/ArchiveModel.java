package org.jamdev.jdl4pam;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import org.jamdev.jdl4pam.genericmodel.GenericModel;
import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.util.ZipUtils;

/**
 * A model loaded from an archive file that contains transformed settings.
 * <p>
 * This will unzip a file and then check for a model file (currently
 * saved_model.pb). The model file will be loaded and a path to the settings
 * file set which can then be used to set up external processes - such as
 * transforms for input data.
 * 
 * @author Jamie Macaulay
 */
public abstract class ArchiveModel extends GenericModel {


	
	/**
	 * File with transform settings.
	 */
	private String audReprFile;;

	/**
	 * The model file.
	 */
	private String modelPath;
	
	/**
	 * ^
	 * ^
	 * ^
	 * Note: These ^^^ fields are called in the super constructed from an overridden
	 * function. They must NOT be set to null because, after the super constructor
	 * the audReprFile= null is called by the compiler and they are reset.
	 */


	/**
	 * Create an archiverl model. This unzips an archivel file to a temporary location and looks for the model and json metadata data within. 
	 * @param file
	 * @throws MalformedModelException
	 * @throws IOException
	 */
	public ArchiveModel(File file) throws MalformedModelException, IOException  {
		super(file.getPath(), null);
	}
	
	@Override
	public Model loadModel(String path) throws IOException, MalformedModelException {
		
		File file = new File(path);
		
		FileInputStream fileInputStream = new FileInputStream(file);

		String zipFolder = System.getProperty("user.home") +  File.separator + getModelFolderName() + File.separator + getFileNameWithoutExtension(file);
		
;
		File outFile = new File(zipFolder);
		
		// Creating the directory
		boolean bool = outFile.mkdir();
		// if(bool){
		// System.out.println("Directory created successfully");
		// }else{
		// System.out.println("Sorry couldn’t create specified directory: " +outFile);
		// }

		// unzip the model into the temporary directory....
		ZipUtils.unzip(fileInputStream, outFile.toPath());

		
		System.out.println("zip folder: " + zipFolder);


		// tnhe file that contains the model meta data
		 audReprFile = zipFolder + File.separator + getAudioReprRelPath();
	
		// the model path.
		 modelPath = zipFolder +  File.separator + getModelRelPath();
		
		//make sure you reference super here or things get weird...
		Model model = super.loadModel(modelPath);
		
		
		return model;

//		Path modelDir = Paths.get(new File(modelPath).getParent()); // the directory of the file (in case the file is
//																	// local this should also return absolute directory)
//		Model model = Model.newInstance(modelPath, "TensorFlow");
//		model.load(modelDir, "saved_model.pb");
//		
//		return model;
		
	}

	/**
	 * Get the relative path (within the unzipped folder) to the settings file that
	 * contains metadata about the model. For example "audio_repr_pg.json" if the
	 * settings are in the pqrent directory.
	 * 
	 * @return the relative path to the audiofile.
	 */
	public abstract String getAudioReprRelPath();

	/**
	 * Get the relative path (within the unzipped folder) to the model file that
	 * contains metadata about the model. For example "audio_repr_pg.json" if the
	 * settings are in the pqrent directory.
	 * 
	 * @return the relative path to the audiofile.
	 */
	public abstract String getModelRelPath();

	/**
	 * Get a name for the model - this is used to create temporary folders etc. e.g.
	 * "ketos_models"
	 */
	public abstract String getModelFolderName();


	/**
	 * Get the audio representation file full path. This holds the information for
	 * transforming the raw sound data to an image to pass the model.
	 * 
	 * @return the audio file.
	 */
	public String getAudioReprFile() {
		return audReprFile;
	}

	/**
	 * Get the filename without an extension.
	 * 
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

	

}
