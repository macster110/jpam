package org.jamdev.jtorch4pam.DeepLearningBats;

import java.io.IOException;

import org.jamdev.jtorch4pam.spectrogram.SpecTransform;
import org.jamdev.jtorch4pam.spectrogram.Spectrogram;
import org.jamdev.jtorch4pam.utils.DLMatFile;
import org.jamdev.jtorch4pam.wavFiles.AudioData;

import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;

public class SpectrogramTests {


	public static void main( String[] args ) {

		//create the DL params. 
		DLParams dlParams = new DLParams();

		//Path to the wav file 
		//		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/SKOVSOE_20200817_011402.wav"; 

		//High...ish SNR bat click
		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/training_clips__Troldekær_deployment_3/DUB_20200623_000152_885.wav";

		//Path to the model
		String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000.pk";

		//output file path to test what the java spectrgram transforms look like. 
		String outputMatfile = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/javaspec.mat"; 

		//wav file 
		try {
			//Open wav files. 
			AudioData soundData = BatDL.loadWavFile(wavFilePath);

			soundData = soundData.interpolate(dlParams.sR).preEmphasis(dlParams.preemphases); 
			soundData = soundData.trim(2*1280, 3*1280); 

			System.out.println( "Open wav file: No. samples:"+ soundData.samples.length + " sample rate: " + soundData.sampleRate);

			//make a spectrogram 
			Spectrogram spectrogram = new Spectrogram(soundData, dlParams.n_fft, dlParams.hop_length); 

			//apply transforms to the spectrogram 
			SpecTransform spectransform = new SpecTransform(spectrogram)
					.interpolate(dlParams.fmin, dlParams.fmax, dlParams.n_freq_bins);

			double[][] transformInterp = spectransform.getTransformedData(); 
			
			spectransform = spectransform.dBSpec(); 
			
			double[][] transformdB = spectransform.getTransformedData(); 
			
			
			spectransform = spectransform.normalise(dlParams.min_level_dB, dlParams.ref_level_dB);
			
			double[][] transfromNorm = spectransform.getTransformedData(); 
			
			spectransform = spectransform.clamp(0, 1); 
			
			double[][] transfromClamp = spectransform.getTransformedData(); 


			Matrix matrixSpec=  DLMatFile.array2Matrix(spectrogram.getAbsoluteSpectrogram());
			Matrix matrixTransformInterp =  DLMatFile.array2Matrix(transformInterp);
			Matrix matrixTransformdB =  DLMatFile.array2Matrix(transformdB);
			Matrix matrixTransformNorm =  DLMatFile.array2Matrix(transfromNorm);
			Matrix matrixTransformClamp=  DLMatFile.array2Matrix(transfromClamp);


			MatFile matFile = Mat5.newMatFile()
					.addArray("spectrogram", matrixSpec)
					.addArray("spectrogram_transform_interp", matrixTransformInterp)
					.addArray("spectrogram_transform_dB", matrixTransformdB)
					.addArray("spectrogram_transform_norm", matrixTransformNorm)
					.addArray("spectrogram_transform_clamp", matrixTransformClamp)
					.addArray("sample_rate", Mat5.newScalar(spectrogram.getSampleRate()));
			

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
