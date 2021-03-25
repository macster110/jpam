package org.jamdev.jdl4pam.Ketos;

import java.io.IOException;

import org.jamdev.jdl4pam.utils.DLMatFile;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.spectrogram.SpecTransform;
import org.jamdev.jpamutils.spectrogram.Spectrogram;
import org.jamdev.jpamutils.wavFiles.AudioData;

import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;

public class KetosTransformsTest {
	
	public static void main( String[] args ) {
		
		String wavFilePath = "/Users/au671271/Google Drive/PAMGuard_dev/Deep_Learning/Meridian/right_whales/for_pamguard/input.wav";

//		{
//		    "spectrogram": {
//		"rate": "1000 Hz", 
//		        "window": "0.256 s",
//		        "step": "0.032 s",
//		        "freq_min": "0 Hz",
//		        "freq_max": "500 Hz",
//		        "window_func": "hamming",
//		        "type": "MagSpectrogram",
//		        "duration": "3.0 s",
//		"transforms": [{"name": "reduce_tonal_noise"},
//		                       {"name": "enhance_signal"},
//		                       {"name": "normalize", "mean": 0.0, "std": 1.0}],
//		        "dtype": "float32",
//		        "input_ndims": 4,
//		        "input_shape": [1, 94, 129, 1]
//		    }
//		}
		
		//output file path to test what the java spectrgram transforms look like. 
		String outputMatfile = "/Users/au671271/Google Drive/Programming/MATLAB/PAMGUARD/deep_learning/ketos_classifier/javaspec.mat"; 

		//wav file 
		try {
			//Open wav files. 
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);
			System.out.println( "Open sound file: No. samples: "+ soundData.samples.length + " sample rate: " + soundData.sampleRate);

			int n_fft = (int) (0.256*soundData.sampleRate);
			int hop_length = (int) (0.32*soundData.sampleRate);
					
			//make a spectrogram 
			Spectrogram spectrogram = new Spectrogram(soundData, n_fft, hop_length); 

			double[][] spec = spectrogram.getAbsoluteSpectrogram(); 

			//apply transforms to the spectrogram 
			
			// interpolate the spectrogram
			SpecTransform spectransform = new SpecTransform(spectrogram)
					.interpolate(0, 500, 129);

			double[][] transformInterp = spectransform.getTransformedData(); 
			
			//convert the spectrogram to dB
			spectransform = spectransform.reduceTonalNoiseMean(hop_length); 
			
			
			//print out some information on each transform. 
			int[] shape;
			
			shape = DLUtils.arrayShape(spec); 
			System.out.println("Spectrogram        size: [" + shape[0] + "  " + shape[1]+ "] First 3 data points:  " + 
					spec[0][0] + ", " + spec[0][1] + "," + spec[0][2]);
			
			shape = DLUtils.arrayShape(transformInterp); 
			System.out.println("Spectrogram interp size: [" + shape[0] + "  " + shape[1]+ "] First 3 data points:  " + 
					transformInterp[0][0] + ", " + transformInterp[0][1] + "," + transformInterp[0][2]);
			
	
					
			//export to MATLAB
			Matrix matrixSpec=  DLMatFile.array2Matrix(spectrogram.getAbsoluteSpectrogram());
			Matrix matrixTransformInterp =  DLMatFile.array2Matrix(transformInterp);

			
			//save the sound file
			System.out.println("Sound data length: " + soundData.getScaledSampleAmpliudes().length);
			Matrix rawSoundData =  DLMatFile.array2Matrix(soundData.getScaledSampleAmpliudes());


			MatFile matFile = Mat5.newMatFile()
					.addArray("spectrogram", matrixSpec)
					.addArray("spectrogram_transform_interp", matrixTransformInterp)
					.addArray("sample_rate", Mat5.newScalar(spectrogram.getSampleRate()))
					.addArray("y", rawSoundData); 
			

			try {
				Mat5.writeToFile(matFile, outputMatfile);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}


		}
		catch (Exception e) {
			e.printStackTrace();
		}

	}

}
