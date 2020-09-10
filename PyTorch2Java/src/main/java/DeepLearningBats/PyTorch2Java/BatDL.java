package DeepLearningBats.PyTorch2Java;

import java.io.File;
import java.io.IOException;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.UnsupportedAudioFileException;

import org.pytorch.IValue;
import org.pytorch.Module;
import org.pytorch.Tensor;

import spectrogram.Spectrogram;
import wavFiles.WavFile;
import wavFiles.WavFileData;
/**
 * Run a bat deep learning algorithm. 
 *
 */
public class BatDL 
{


	/*
	 * Load a wav file. 
	 */
	public static WavFileData loadWavFile(String path) throws IOException, UnsupportedAudioFileException {
		// reads the first 44 bytes for header
		WavFile wavFile = new  WavFile(new File(path));
		AudioFormat format = wavFile.getAudioFileFormat().getFormat(); 

		int channels = format.getChannels(); 

		// load data
		AudioInputStream inputStream  = wavFile.getAudioInputStream(); 

		//first downsample
		//now downsample the data if need bed 
		byte[] data;

		data = new byte[inputStream.available()];
		inputStream.read(data);	  
		//		}

		if (channels==1) {
			//no need to do anything else. 

		}
		else {
			//extract single channel data 
			data = WavFile.getSingleChannelByte(format, data,  0); 
		}

		int[] samples = WavFile.getSampleAmplitudes(format, data);

		int sampleRate = (int) format.getSampleRate();

		return new WavFileData(samples, sampleRate); 

	}




	public static void main( String[] args )
	{
		//Path to the wav file 
		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/SKOVSOE_20200817_011402.wav"; 

		//Path to the model
		String modelPath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000.pk";

		//wav file 
		try {
			WavFileData soundData = loadWavFile(wavFilePath) ;
			System.out.println( "Open wav file: No. samples:"+ soundData.samples.length + " sample rate: " + soundData.sampleRate);

			//create the DL params. 
			DLParams dlParams = new DLParams();

			//make a spectrogram 
			Spectrogram spectrgram = new Spectrogram(soundData, dlParams.n_fft, dlParams.hop_length); 

			spectrgram.dBSpec().normalise(dlParams.min_level_dB, dlParams.ref_level_dB).clamp(dlParams.clampMin, dlParams.clampMax);; 

			//now must flatten the spectrogram and create a tensor. 
			flatten
			
			//create the tensor 
			Tensor data = Tensor.fromBlob(data, shape); 

			//load the model. 
			Module mod = Module.load(modelPath);

			//IValue result = mod.forward(IValue.from(data), IValue.from(3.0));



			//create a spectrogram


		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
	}



}
