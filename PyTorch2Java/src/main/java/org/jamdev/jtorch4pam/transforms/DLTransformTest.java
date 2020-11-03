package org.jamdev.jtorch4pam.transforms;

import java.io.IOException;
import java.util.ArrayList;

import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jtorch4pam.SoundSpot.DLParams;
import org.jamdev.jtorch4pam.transforms.FreqTransform.FreqTransformType;
import org.jamdev.jtorch4pam.transforms.WaveTransform.WaveTransformType;
import org.jamdev.jtorch4pam.utils.DLUtils;
import org.jamdev.jtorch4pam.wavFiles.AudioData;

/**
 * Test the DLtransform idea. 
 * @author Jamie Macaulay 
 *
 */
public class DLTransformTest {
	
	
	public static void main(String[] args) {
		
		
		String wavFilePath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/example_wav/call_393_2019_S4U05619MOL2-20180917-051012_2525_2534.wav";
		int[] samplesChunk = new int[] {0, 1274}; // the sample chunk to use. 
		
		//create the DL params. 
		DLParams dlParams = new DLParams();
		
		AudioData soundData = null; 
		//Open wav files. 
		try {
			soundData = DLUtils.loadWavFile(wavFilePath);
		} catch (IOException | UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ArrayList<DLTransform> transforms = new ArrayList<DLTransform>(); 
		
		//waveform transforms. 
		transforms.add(new WaveTransform(soundData, WaveTransformType.DECIMATE, dlParams.sR)); 
		transforms.add(new WaveTransform(soundData, WaveTransformType.PREEMPHSIS, dlParams.preemphases)); 
		transforms.add(new WaveTransform(soundData, WaveTransformType.TRIM, samplesChunk[0], samplesChunk[1])); 
		//frequency transforms. 
		transforms.add(new FreqTransform(FreqTransformType.SPECTROGRAM, dlParams.n_fft, dlParams.hop_length)); 
		transforms.add(new FreqTransform(FreqTransformType.SPECCROPINTERP, dlParams.fmin, dlParams.fmax, dlParams.n_freq_bins)); 
		transforms.add(new FreqTransform(FreqTransformType.SPEC2DB)); 
		transforms.add(new FreqTransform(FreqTransformType.SPECNORMALISE, dlParams.min_level_dB, dlParams.ref_level_dB)); 
		transforms.add(new FreqTransform(FreqTransformType.SPECCLAMP, dlParams.clampMin, dlParams.clampMax)); 

		
		DLTransform transform = transforms.get(0); 
		for (int i=1; i<transforms.size(); i++) {
			transform = transforms.get(i).transformData(transform); 
		}
		
		//now the last transform contains the data we need. 

		
	}

	
}