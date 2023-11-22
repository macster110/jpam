package org.jamdev.jdl4pam.ketos;

import java.io.File;
import java.util.ArrayList;

import org.jamdev.jdl4pam.genericmodel.GenericModelParams;
import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformsParser;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Parameters for a Ketos model, including parasing json file to transforms. 
 * @author Jamie Macaulay
 *
 */
public class KetosParams extends GenericModelParams {

	//settingss for bats used by christian
	//	17:22:24|D|dataOpts: {
	//    "samplingrate": 256000,
	//    "preemphases": 0.98,
	//    "n_fft": 256,
	//    "hop_length": 8,
	//    "n_freq_bins": 256,
	//    "fmin": 40000,
	//    "fmax": 100000,
	//    "freq_compression": "linear",
	//    "min_level_db": -100,
	//    "ref_level_db": 0
	//}
	
	/**
	 * The duration. Note this is NOT the segment length. It is the 
	 * duration parameter that Ketos uses to coagulate a segment length (which is also
	 * a function of the FFT and hop length). Can be null. 
	 */
	Double duration;


	/**
	 * Create a default set of Sound Spot params. 
	 */
	public KetosParams() {
		defaultParams();
	}
	
	/**
	 * Set all current params. 
	 * @param params - params to set this class to. 
	 */
	public void updateParams(GenericModelParams params) {
		
		this.classNames=params.classNames;
		this.defaultInputShape=params.defaultInputShape;
		this.defaultOutputShape=params.defaultOutputShape;
		this.segLen=params.segLen;
		this.dlTransforms=params.dlTransforms;
	} 


	/**
	 * Constructor for SoundSpotParams which parses a raw string extracted from a Sound Spot model. 
	 * @param rawString - the raw parameters string from the model. 
	 */
	public KetosParams(String rawString) {
		KetosTransformParser parser = new KetosTransformParser(); 
		parser.parseRawString(this,rawString); 
	}


	@Override
	public String toString() {
		String string = ""; 

		string += "***********\n"; 

		string += "Segment length: " + segLen + " milliseconds\n"; 


		if (classNames!=null) {
			string += "***********\n"; 

			string += "No. classes: " + this.classNames.length + "  \n"; 

			for (int i=0; i<this.classNames.length; i++) {
				string += classNames[i] + "\n"; 
			}
		}

		string += "***********\n"; 
		for (int i=0; i<this.dlTransforms.size(); i++) {
			string += dlTransforms.get(i).toString() + "\n"; 
		}

		string += "***********\n"; 

		return string; 
	} 


	public static void main(String[] args) {
		File file = new File("/Users/au671271/ketos_models/narw/audio_repr.json"); 



		try {

			//read the JSOn string from the the file. 
			String jsonString  = DLTransformsParser.readJSONString(file);

			//get the audio representation file. 
			KetosParams ketosParams = new KetosParams(jsonString); 

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}




	/**
	 * Create a default set of paramters. this can be for testing etc. 
	 */
	private void defaultParams() {
		//

		//The FFT length for the spectrogram in bins

		int n_fft = 256;

		/**
		 * The FFT hop in sample bins.
		 */
		int hop_length = 8;

		/**
		 * The sample rate to interpolate or decimate to in samples per second. i.e.
		 * this is the sample rate of the training data.
		 */
		float sR = 256000;

		/**
		 * The pore emphasis factor. This dictates how much the lower frequences in the
		 * wave data are attenuated.
		 */
		double preemphases = 0.98;

		/**
		 * The minimum dB level for normalising the dB spectral amplitudes.
		 */
//		double min_level_dB = -100;
		double min_level_dB = -200;

		/**
		 * The reference dB level for normalising the dB spectral amplitudes.
		 */
		double ref_level_dB = 0;

		/**
		 * Minimum value to clamp spectrogram to after normalisation.
		 */
		double clampMin = 0;

		/**
		 * Maximum value to clamp spectrogram to after normalisation.
		 */
		double clampMax = 1;

		/**
		 * The minimum frequency to interpolate the spectrogram image from.
		 */
		double fmax = 100000;

		/**
		 * The maximum frequency to interpolate the spectrogram image from.
		 */
		double fmin = 40000;

		/**
		 * The number of vertical bins to interpolate the spectrogram image to.
		 */
		int n_freq_bins = 256;

		/**
		 * The type of frequency compression ot nuse.
		 */
		String freq_compression = "linear";


		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		// now generate a;l the parameter class
		SimpleTransformParams dlTransfromParams;

		//waveform transforms. 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, sR)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.PREEMPHSIS, preemphases)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, n_fft, hop_length)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCROPINTERP, fmin, fmax, n_freq_bins)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPEC2DB)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISE, min_level_dB, ref_level_dB)); 
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCLAMP, clampMin, clampMax)); 

		this.dlTransforms = dlTransformParamsArr; 

	}


	/**
	 * Get the duration. Note this is NOT the segment length. It is the 
	 * duration parameter that Ketos uses to coagulate a segment length (which is also
	 * a function of the FFT and hop length). Can be null. 
	 *
	 * @return the duration. 
	 */
	public Double getDuration() {
		return duration;
	}







}
