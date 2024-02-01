package org.jamdev.jdl4pam.koogu;

import java.io.File;
import java.io.IOException;
import org.jamdev.jdl4pam.ArchiveModel;
import ai.djl.MalformedModelException;

/**
 * Load a model from Koogu framework. 
 * <p>
 * https://meridian.cs.dal.ca/2015/04/12/ketos/
 * 
 * @author Jamie Macaulay 
 *
 */
public class KooguModel extends ArchiveModel {

	public KooguModel(File file) throws IOException, MalformedModelException {
		super(file);
	}

	@Override
	public String getAudioReprRelPath() {
		// settings are in parent direcotry
		return "audio_repr_pg.json";
	}

	@Override
	public String getModelRelPath() {
		// model is in parent directory
		return "saved_model.pb";
	}

	@Override
	public String getModelFolderName() {
		return "koogu";
	}
	
}
