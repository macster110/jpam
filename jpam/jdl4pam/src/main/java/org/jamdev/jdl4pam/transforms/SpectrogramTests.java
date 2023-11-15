package org.jamdev.jdl4pam.transforms;

import java.io.IOException;

import org.jamdev.jpamutils.spectrogram.SpecTransform;
import org.jamdev.jpamutils.spectrogram.Spectrogram;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.jamdev.jdl4pam.animalSpot.AnimalSpotParams;
import org.jamdev.jdl4pam.animalSpot.LegacySoundSpotParams;
import org.jamdev.jdl4pam.utils.DLMatFile;
import org.jamdev.jdl4pam.utils.DLUtils;

import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;

public class SpectrogramTests {


	public static void main( String[] args ) {

		//create the DL params. 
		LegacySoundSpotParams dlParams = new LegacySoundSpotParams();
		

		//Path to the wav file 
		//		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/SKOVSOE_20200817_011402.wav"; 

		//High...ish SNR bat click
//		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/training_clips__Troldekær_deployment_3/DUB_20200623_000152_885.wav";
//		int[] samplesChunk = new int[] {3072, 4346}; // the sample chunk to use. 

//		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/training_clips__Troldekær_deployment_3/DUB_20200623_003257_654.wav";
		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/call_393_2019_S4U05619MOL2-20180917-051012_2525_2534.wav";

		
		//		int[] samplesChunk = new int[] {1536, 2810}; // the sample chunk to use. 
//		int[] samplesChunk = new int[] {1024, 2298}; // the sample chunk to use. 
		int[] samplesChunk = new int[] {0, 1274}; // the sample chunk to use. 


		//output file path to test what the java spectrgram transforms look like. 
		String outputMatfile = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/javaspec.mat"; 

		//wav file 
		try {
			//Open wav files. 
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);
			System.out.println( "Open sound file: No. samples: "+ soundData.samples.length + " sample rate: " + soundData.sampleRate);


			soundData = soundData.interpolate(dlParams.sR).preEmphasis(dlParams.preemphases); 
			System.out.println( "Decimate sound file: No. samples: "+ soundData.samples.length + " sample rate: " + soundData.sampleRate);

			
			soundData = soundData.trim(samplesChunk[0], samplesChunk[1]); 
			System.out.println( "Trim wav file: No. samples: "+ soundData.samples.length + " sample rate: " + soundData.sampleRate);

			//make a spectrogram 
			Spectrogram spectrogram = new Spectrogram(soundData, dlParams.n_fft, dlParams.hop_length); 

			double[][] spec = spectrogram.getAbsoluteSpectrogram(); 

			//apply transforms to the spectrogram 
			
			// interpolate the spectrogram
			SpecTransform spectransform = new SpecTransform(spectrogram)
					.interpolate(dlParams.fmin, dlParams.fmax, dlParams.n_freq_bins);

			double[][] transformInterp = spectransform.getTransformedData(); 
			
			//convert the spectrogram to dB
			spectransform = spectransform.dBSpec(); 
			
			double[][] transformdB = spectransform.getTransformedData(); 
			
			//normalise the spectrogram
			spectransform = spectransform.normalise(dlParams.min_level_dB, dlParams.ref_level_dB);
			
			double[][] transfromNorm = spectransform.getTransformedData(); 
			
			//clamp the spectrogram between 0 and 1.
			spectransform = spectransform.clamp(0, 1); 
			
			double[][] transfromClamp = spectransform.getTransformedData(); 
			
			
			//print out some information on each transform. 
			int[] shape;
			
			shape = DLUtils.arrayShape(spec); 
			System.out.println("Spectrogram        size: [" + shape[0] + "  " + shape[1]+ "] First 3 data points:  " + 
					spec[0][0] + ", " + spec[0][1] + "," + spec[0][2]);
			
			shape = DLUtils.arrayShape(transformInterp); 
			System.out.println("Spectrogram interp size: [" + shape[0] + "  " + shape[1]+ "] First 3 data points:  " + 
					transformInterp[0][0] + ", " + transformInterp[0][1] + "," + transformInterp[0][2]);
			
			shape = DLUtils.arrayShape(transformdB); 
			System.out.println("Spectrogram dB     size: [" + shape[0] + "  " + shape[1]+ "] First 3 data points:  " + 
					transformdB[0][0] + ", " + transformdB[0][1] + "," + transformdB[0][2]);
			
			shape = DLUtils.arrayShape(transfromNorm); 
			System.out.println("Spectrogram norm   size: [" + shape[0] + "  " + shape[1]+ "] First 3 data points:  " + 
					transfromNorm[0][0] + ", " + transfromNorm[0][1] + "," + transfromNorm[0][2]);
			
			shape = DLUtils.arrayShape(transfromClamp); 
			System.out.println("Spectrogram clamp  size: [" + shape[0] + "  " + shape[1]+ "] First 3 data points:  " + 
					transfromClamp[0][0] + ", " + transfromClamp[0][1] + "," + transfromClamp[0][2]);
			
					
			//export to MATLAB
			Matrix matrixSpec=  DLMatFile.array2Matrix(spectrogram.getAbsoluteSpectrogram());
			Matrix matrixTransformInterp =  DLMatFile.array2Matrix(transformInterp);
			Matrix matrixTransformdB =  DLMatFile.array2Matrix(transformdB);
			Matrix matrixTransformNorm =  DLMatFile.array2Matrix(transfromNorm);
			Matrix matrixTransformClamp=  DLMatFile.array2Matrix(transfromClamp);
			
			
			//save the sound file
			System.out.println("Sound data length: " + soundData.getScaledSampleAmplitudes().length);
			Matrix rawSoundData =  DLMatFile.array2Matrix(soundData.getScaledSampleAmplitudes());
			Matrix sampleschnk =  DLMatFile.array2Matrix(samplesChunk);


			MatFile matFile = Mat5.newMatFile()
					.addArray("spectrogram", matrixSpec)
					.addArray("spectrogram_transform_interp", matrixTransformInterp)
					.addArray("spectrogram_transform_dB", matrixTransformdB)
					.addArray("spectrogram_transform_norm", matrixTransformNorm)
					.addArray("spectrogram_transform_clamp", matrixTransformClamp)
					.addArray("sample_rate", Mat5.newScalar(spectrogram.getSampleRate()))
					.addArray("y", rawSoundData)
					.addArray("sampleschnk", sampleschnk); 
			

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
