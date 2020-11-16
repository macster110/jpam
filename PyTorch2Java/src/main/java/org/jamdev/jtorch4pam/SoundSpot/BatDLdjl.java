package org.jamdev.jtorch4pam.SoundSpot;

import org.jamdev.jtorch4pam.spectrogram.SpecTransform;
import org.jamdev.jtorch4pam.spectrogram.Spectrogram;
import org.jamdev.jtorch4pam.utils.DLUtils;
import org.jamdev.jtorch4pam.wavFiles.AudioData;

/**
 * 
 * Run a bat deep learning algorithm. 
 * <p> Note that this requires that the jvm points to the PyTorch library. 
 *
 */
public class BatDLdjl {

	public static void main( String[] args ) {
		
		//create the DL params. 
		DLParams dlParams = new DLParams();
		
		//Path to the wav file 
//		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/SKOVSOE_20200817_011402.wav"; 

		//High...ish SNR bat click
//		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/training_clips__Troldekær_deployment_3/DUB_20200623_000152_885.wav";
//		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/training_clips/noise/NOISE_20180816_205841_000.wav";
//		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/training_clips__Troldekær_deployment_3/DUB_20200623_003257_654.wav";
//		int[] samplesChunk = new int[] {1536, 2810}; // the sample chunk to use. 
//		int[] samplesChunk = new int[] {1024, 2298}; // the sample chunk to use. 
		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/call_393_2019_S4U05619MOL2-20180917-051012_2525_2534.wav";
		int[] samplesChunk = new int[] {0, 1274}; // the sample chunk to use. 

		//Path to the model
//		String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/bats_dummy/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000.pk";
		String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/bats_denmark/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000_JAMIE.pk"; 
//		//output file path to test what the java spectrgram transforms look like. 
//		String outputMatfile = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/javaspec.mat"; 

		//wav file 
		try {
			//Open wav files. 
			AudioData soundData = DLUtils.loadWavFile(wavFilePath);
			
			soundData = soundData.interpolate(dlParams.sR).preEmphasis(dlParams.preemphases); 
			soundData = soundData.trim(samplesChunk[0], samplesChunk[1]); 

			System.out.println( "Open wav file: No. samples:"+ soundData.samples.length + " sample rate: " + soundData.sampleRate);

			//make a spectrogram 
			Spectrogram spectrogram = new Spectrogram(soundData, dlParams.n_fft, dlParams.hop_length); 
			
			//apply transforms to the spectrogram 
			SpecTransform spectransform = new SpecTransform(spectrogram)
					.interpolate(dlParams.fmin, dlParams.fmax, dlParams.n_freq_bins)
					.dBSpec()
					.normalise(dlParams.min_level_dB, dlParams.ref_level_dB)
					.clamp(dlParams.clampMin, dlParams.clampMax);
			


			SoundSpotModel soundSpotModel = new SoundSpotModel(modelPath); 
			
			float[] output = null; 
			for (int i=0; i<10; i++) {
				long time1 = System.currentTimeMillis();
				output = soundSpotModel.runModel(DLUtils.toFloatArray(spectransform.getTransformedData())); 
				long time2 = System.currentTimeMillis();
				System.out.println("Time to run model: " + (time2-time1) + " ms"); 
			}
		    
			double[] prob = new double[output.length]; 
		    for (int j=0; j<output.length; j++) {
		    	//python code for this. 
//		    	prob = torch.nn.functional.softmax(out).numpy()[n, 1]
//	                    pred = int(prob >= ARGS.threshold)		    	
		    	//softmax function
		    	prob[j] = DLUtils.softmax(output[j], output); 
		    	System.out.println("The probability is: " + prob[j]); 
		    }

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
		
	}



}
