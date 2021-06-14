package org.jamdev.jdl4pam.ketos;

import java.io.IOException;

import org.jamdev.jdl4pam.utils.DLMatFile;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.JamArr;
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

			double[] minmax = JamArr.minmax(soundData.getScaledSampleAmpliudes());
			System.out.println("sound amplutude: min " + minmax[0] + " max " + minmax[1]);
			
			
			int n_fft = (int) (0.256*soundData.sampleRate);
			int hop_length = (int) (0.032*soundData.sampleRate);
			
			System.out.println("FFTLen: " +  n_fft + " hop length: " +  hop_length);
					
			//make a spectrogram 
			Spectrogram spectrogram = new Spectrogram(soundData, n_fft, hop_length); 

			double[][] spec = spectrogram.getAbsoluteSpectrogram(); 
			Matrix matrixSpec=  DLMatFile.array2Matrix(spec);

			//apply transforms to the spectrogram 
			
			// interpolate the spectrogram
			SpecTransform specInterp = new SpecTransform(spectrogram).dBSpec(false).interpolate(0, 500, 129);

//			specInterp = specInterp.dBSpec(); 
			
			
			double[][] specMatrix = specInterp.getTransformedData(); 
			Matrix matrixTransformInterp =  DLMatFile.array2Matrix(specMatrix);
			
			//convert the spectrogram to dB
			specInterp = specInterp.reduceTonalNoiseMedian(); 
			
			double[][] reduceTonalMean = specInterp.getTransformedData(); 
			Matrix matrixReduceTonalMean =  DLMatFile.array2Matrix(reduceTonalMean);

			//enahnce the spectrogram. 
			specInterp = specInterp.enhance(1.0); 
			
			double[][] enhance = specInterp.getTransformedData(); 
			Matrix matrixEnhance =  DLMatFile.array2Matrix(enhance);

			specInterp = specInterp.normaliseStd(0,  1.0); 
			
			double[][] normalisestd = specInterp.getTransformedData();
			Matrix matrixNormaliseStd =  DLMatFile.array2Matrix(normalisestd);
			
			specInterp = specInterp.gaussianFilter(0.5);
			
			double[][] gaussian = specInterp.getTransformedData();
			Matrix matrixGaussinaBlur =  DLMatFile.array2Matrix(gaussian);
			
			//print out some information on each transform. 
			int[] shape;
			
			shape = DLUtils.arrayShape(spec); 
			System.out.println("Spectrogram size: [" + shape[0] + "  " + shape[1]+ "] First 3 data points:  " + 
					spec[0][0] + ", " + spec[0][1] + "," + spec[0][2]);
			
			shape = DLUtils.arrayShape(specMatrix); 
			System.out.println("Spectrogram interp size: [" + shape[0] + "  " + shape[1]+ "] First 3 data points:  " + 
					specMatrix[0][0] + ", " + specMatrix[0][1] + "," + specMatrix[0][2]);
			

			//export to MATLAB
			//Matrix matrixSpec=  DLMatFile.array2Matrix(spec);
			//save the sound file
			System.out.println("Sound data length: " + soundData.getScaledSampleAmpliudes().length);
			Matrix rawSoundData =  DLMatFile.array2Matrix(soundData.getScaledSampleAmpliudes());


			MatFile matFile = Mat5.newMatFile()
					.addArray("spectrogram_j", matrixSpec)
					.addArray("transform_interp_j", matrixTransformInterp)
					.addArray("reduce_tonal_noise_j", matrixReduceTonalMean)
					.addArray("enhance_j", matrixEnhance)
					.addArray("normalisestd_j", matrixNormaliseStd)
					.addArray("gaussian_blur_j", matrixGaussinaBlur)
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
