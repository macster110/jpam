package org.jamdev.jtorch4pam.SoundSpot;

import java.io.File;

import java.io.IOException;
import java.util.Arrays;
import java.util.Random;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jtorch4pam.spectrogram.SpecTransform;
import org.jamdev.jtorch4pam.spectrogram.Spectrogram;
import org.jamdev.jtorch4pam.utils.DLUtils;
import org.jamdev.jtorch4pam.wavFiles.AudioData;
import org.jamdev.jtorch4pam.wavFiles.WavFile;
import org.pytorch.IValue;
import org.pytorch.Module;
import org.pytorch.Tensor;

/**
 * 
 * Run a bat deep learning algorithm. 
 * <p> Note that this requires that the jvm points to the PyTorch library. 
 *
 */
public class BatDL {


	/**
	 * Make a dummy spectrogram for testing. Filled with random values.  
	 * @return a dummy spectrogram with random values. 
	 */
	private static float[][] makeDummySpectrogram(){
		
		int len = 256; 
		int len2 = 128; 
		
		float[][] specDummy = new float[len][len2]; 

		Random rand = new Random(); 
		for (int i=0; i<len; i++){
			for (int j=0; j<len2; j++) {
				specDummy[i][j] = 2F*(rand.nextFloat()-0.5F);
				
				if (specDummy[i][j]>1) {
					specDummy[i][j]=1F;
				}
				if (specDummy[i][j]<0) {
					specDummy[i][j]=0F;
				}
			}
		}
		return specDummy; 
	}

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
			
//			//export to a file for checking
//			DLMatFile.exportSpecSurface(spectransform, new File(outputMatfile)); 
//			//export to a file for checking
//			DLMatFile.exportSpecArray(spectrogram.getAbsoluteSpectrogram(), spectrogram.getSampleRate(), new File(outputMatfile)); 

			//now must flatten the spectrogram and create a tensor.			
			float[] specgramFlat = DLUtils.flattenDoubleArrayF(DLUtils.toFloatArray(spectransform.getTransformedData())); 
			int[] arrayShape = 	DLUtils.arrayShape(spectransform.getTransformedData());
			
			//convert the array shape to a long instead of int. 
			long[] arrayShaleL = new long[arrayShape.length]; 
			for (int i=0; i<arrayShaleL.length; i++) {
				arrayShaleL[i] = arrayShape[i]; 
//				System.out.println(arrayShaleL[i]); 
			}
			
			//create the shape for the tensor.
			long[] shape = {1L, 1L, arrayShaleL[0], arrayShaleL[1]}; 
			
//			DLUtils.printArray(specGram); 
			
			//create the tensor 
			Tensor data = Tensor.fromBlob(specgramFlat, shape); 
			
		    System.out.println("Input shape: " + Arrays.toString(data.shape()));
		    System.out.println("Input data [0]: " +data.getDataAsFloatArray()[0]);

			//load the model. 
			Module mod = Module.load(modelPath);
		
//			IValue getClassesOutput =mod.runMethod("get_classes"); 
//			HashMap<String, IValue> hashMap = new HashMap<String, IValue>();
//			hashMap.put("datpts", null); 
//			mod.forward(IValue.dictStringKeyFrom(hashMap)); 
//			IValue resultS = mod.forward(IValue.dictStringKeyFrom(new HashMap<String, IValue>()));

			//run the model on the acoustic data. 
			IValue result = mod.forward(IValue.from(data));
			
			
			//convert the output to a tensor
			Tensor output = result.toTensor();
			
			
		    System.out.println("Output shape: " + Arrays.toString(output.shape()));
		    System.out.println("Output data: " + Arrays.toString(output.getDataAsFloatArray()));
			
			//grab the results. 
		    double[] prob = new double[(int) output.shape()[1]]; 
		    
		    
		    for (int j=0; j<output.shape()[1]; j++) {
		    	//python code for this. 
//		    	prob = torch.nn.functional.softmax(out).numpy()[n, 1]
//	                    pred = int(prob >= ARGS.threshold)		    	
		    	//softmax function
		    	prob[j] = DLUtils.softmax(output.getDataAsFloatArray()[j], output.getDataAsFloatArray()); 
		    	System.out.println("The probability is: " + prob[j]); 
		    }

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
		
	}



}
