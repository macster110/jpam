package org.jamdev.jtorch4pam.SoundSpot;

import org.json.JSONObject;

/**
 * Parameters for running the deep learning algorithm
 * <p>
 * Note that parameter names are in python format to keep them 
 * consistant with the Python code. 

 * 
 * @author Jamne Macaulay 
 *
 */
public class SoundSpotParams {

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
	 * Create a default set of Sound Spot params. 
	 */
	public SoundSpotParams() {

	}

	/**
	 * Constructor for SoundSpotParams which parses a raw string extracted from a Sound Spot model. 
	 * @param rawString - the raw parameters string from the model. 
	 */
	public SoundSpotParams(String rawString) {
		parseRawString(rawString); 
	}

	/**
	 * The FFT length for the spectrogram in bins
	 */
	public int n_fft = 256; 

	/**
	 * The FFT hop in sample bins. 
	 */
	public int hop_length = 8; 

	/**
	 * The sample rate to interpolate or decimate to in samples per second. i.e. this is the sample rate of the 
	 * training data. 
	 */
	public float sR = 256000; 

	/**
	 * The pore emphasis factor. This dictates how much the lower frequences in 
	 * the wave data are attenuated. 
	 */
	public double preemphases = 0.98; 

	/**
	 * The minimum dB level for normalising the dB spectral amplitudes. 
	 */
	public double min_level_dB = -100; 

	/**
	 * The reference dB level for normalising the dB spectral amplitudes. 
	 */
	public double ref_level_dB = 0;

	/**
	 * Minimum value to clamp spectrogram to after normalisation. 
	 */
	public double clampMin = 0;

	/**
	 * Maximum value to clamp spectrogram to after normalisation. 
	 */
	public double clampMax = 1;

	/**
	 * The minimum frequency to interpolate the spectrogram image from.
	 */
	public double fmax = 100000; 

	/**
	 * The maximum frequency to interpolate the spectrogram image from.
	 */
	public double fmin = 40000;

	/**
	 * The number of vertical bins to interpolate the spectrogram image to. 
	 */
	public int n_freq_bins = 256; 

	/**
	 * The type of frequency compression ot nuse. 
	 */
	public String freq_compression =  "linear"; 

	/**
	 * Parse a parameters string from the SoundSpotModel. 
	 * @param rawString - the raw string. 
	 */ 
	private void parseRawString(String rawString) {
		//System.out.println(rawString); 

		JSONObject jsonObject = new JSONObject(rawString);

		String[] jsonstrings = JSONObject.getNames(jsonObject); 


		for (int i=0; i<jsonstrings.length; i++) {
			//System.out.println(jsonstrings[i]);


			switch (jsonstrings[i]) {
			case "min_level_db":
				this.min_level_dB = jsonObject.getDouble("min_level_db"); 
				break;
			case "n_freq_bins":
				this.n_freq_bins = jsonObject.getInt("n_freq_bins");
				break;
			case "preemphases":
				this.preemphases = jsonObject.getDouble("preemphases");
				break;
			case "ref_level_db":
				this.ref_level_dB = jsonObject.getDouble("ref_level_db");
				break;
			case "n_fft":
				this.n_fft = jsonObject.getInt("n_fft");
				break;
			case "fmin":
				this.fmin = jsonObject.getDouble("fmin");
				break;
			case "fmax":
				this.fmax = jsonObject.getDouble("fmax");
				break;
			case "sr":
				this.sR  = jsonObject.getFloat("sr");
				break;
			case "hop_length":
				this.hop_length = jsonObject.getInt("hop_length");
				break;
			case "freq_compression":
				this.freq_compression = jsonObject.getString("freq_compression"); 
				break;
			}

		}

	}




}
