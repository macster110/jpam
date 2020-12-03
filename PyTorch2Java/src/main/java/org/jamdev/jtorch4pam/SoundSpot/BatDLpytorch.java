package org.jamdev.jtorch4pam.SoundSpot;

import java.util.ArrayList;
import java.util.Arrays;

import org.jamdev.jtorch4pam.spectrogram.SpecTransform;
import org.jamdev.jtorch4pam.spectrogram.Spectrogram;
import org.jamdev.jtorch4pam.transforms.DLTransform;
import org.jamdev.jtorch4pam.transforms.DLTransformsFactory;
import org.jamdev.jtorch4pam.transforms.FreqTransform;
import org.jamdev.jtorch4pam.transforms.WaveTransform;
import org.jamdev.jtorch4pam.utils.DLUtils;
import org.jamdev.jtorch4pam.wavFiles.AudioData;
import org.pytorch.IValue;
import org.pytorch.Module;
import org.pytorch.Tensor;

/**
 * 
 * Run a bat deep learning algorithm based on official PyTorch java bindings library. 
 * <p> 
 * Note that this requires that the jvm points to the PyTorch library. e.g. 
 * -Djava.library.path=/Users/au671271/libtorch/lib
 * <p>
 *  It also does not currently support the ExtraFiles object being loaded from the model.
 *
 */
public class BatDLpytorch {



	public static void main( String[] args ) {
		
		//create the DL params. 
		SoundSpotParams dlParams = new SoundSpotParams();
		
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
			
			//generate the transforms. 
			ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlParams.dlTransforms); 
			
			
			((WaveTransform) transforms.get(0)).setWaveData(soundData); 

			DLTransform transform = transforms.get(0); 
			for (int i=0; i<transforms.size(); i++) {
				transform = transforms.get(i).transformData(transform); 
			}
			
			SpecTransform spectransform = ((FreqTransform) transform).getSpecTransfrom(); 
			
//			//export to a file for checking
//			DLMatFile.exportSpecSurface(spectransform, new File(outputMatfile)); 
//			//export to a file for checking
//			DLMatFile.exportSpecArray(spectrogram.getAbsoluteSpectrogram(), spectrogram.getSampleRate(), new File(outputMatfile)); 

			//load the model. 
			Module mod = Module.load(modelPath);
			
		    long time1 = System.currentTimeMillis();

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
		    
		    long time2 = System.currentTimeMillis();
		    System.out.println("Time to run model: " + (time2-time1) + " ms"); 

		    
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
