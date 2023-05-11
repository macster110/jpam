package org.jamdev.jdl4pam.ketos;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import org.jamdev.jdl4pam.transforms.DLTransform;
import org.jamdev.jdl4pam.transforms.DLTransformsFactory;
import org.jamdev.jdl4pam.transforms.FreqTransform;
import org.jamdev.jdl4pam.transforms.WaveTransform;
import org.jamdev.jdl4pam.transforms.jsonfile.DLTransformsParser;
import org.jamdev.jdl4pam.utils.DLMatFile;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;

import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;

public class KetosModelTest  {


	public static void main(String[] args) {
		

		//test on a right whale. 
		//File file = new File("/Volumes/GoogleDrive/My Drive/PAMGuard_dev/Deep_Learning/Meridian/right_whales/for_pamguard/narw.ktpb"); 
//		File file = new File("/Volumes/GoogleDrive-108005893101854397430/My Drive/PAMGuard_dev/Deep_Learning/Meridian/humpback_whales/SOCAL_Mn_Network.ktpb");
		
		//classic right whale detector from ketos
//		File file = new File("/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/narw_2/kw_detector_v11_5s_test/kw_detector_v11_5s.ktpb");

		//a new classifier based on a different architecture
		File file = new File("/home/postdoc/PycharmProjects/ActiveLearning/EastPtHydro/hallo-kw-det_v1_test/hallo-kw-det_v1.ktpb");

		/****Wav files*****/

		//the wav file to test.
//		String wavFilePath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/right_whales/for_pamguard/input.wav"; 
//		double timelims = new double[] {0, 3.0}; 

		//JASCO_resampled_20k - use for right whales
//		String wavFilePath = "/Users/au671271/Library/CloudStorage/GoogleDrive-macster110@gmail.com/My Drive/PAMGuard_dev/Deep_Learning/Ketos/narw_2/JASCO_resampled_20k.wav";
		
		//jasco_reduced - use for right whales hallo-kw-det_v1
		String wavFilePath = "/home/postdoc/PycharmProjects/ActiveLearning/EastPtHydro/hallo-kw-det_v1_test/audio/jasco_reduced.wav";

		try {
			double audioDuration = DLUtils.loadWavFile(wavFilePath).getLengthInSeconds();
			// seglen in ketosParams
			double segLength = 5.; // [s]
			// Step between time windows. Not the step size in the FFT for spectro computation
			double stepSeg = 5.; // [s]
			// class FrameStepper(SelectionGenerator) __init__ method in audio_loader.py
			// Always consider padding at the end if needed to get the whole audio processed. If pad: else: in __init__
			int numTimeSegs = (int) Math.ceil((audioDuration - segLength) / stepSeg) + 1;

			for (int timewind= 0; timewind<numTimeSegs; timewind++) {

				/****Output MAT file for diagnosis****/
				String outputMatfile = "/home/postdoc/PycharmProjects/ActiveLearning/EastPtHydro/hallo-kw-det_v1_test/output_spectro/java_transformed_dell" + timewind + ".mat";

//				if (timewind != 18){
//					continue;
//				}
				//the ketos model.
				KetosModel ketosModel = new KetosModel(file);

				//read the JSOn string from the file.
				String jsonString = DLTransformsParser.readJSONString(new File(ketosModel.getAudioReprFile()));

				//get the audio representation file.
				KetosParams ketosParams = new KetosParams(jsonString, timewind * segLength);

				double startTime = 0.;
				if (ketosParams.offsetExt < 0){
					startTime = 0.;
				}
				else {
					startTime = ketosParams.offsetExt;
				}

				// Time limits of the audio would be after the new duration computed in the KetosParams function
				double[] timelims = new double[]{startTime, timewind * segLength + ketosParams.seglen}; //5 second window

				System.out.println(ketosParams.toString());

				//Open wav files.
				AudioData soundDataWind = DLUtils.loadWavFile(wavFilePath);
				soundDataWind = soundDataWind.trim((int) (DLUtils.numSamplesKetos(startTime,
						soundDataWind.sampleRate, Boolean.FALSE)), (int) (DLUtils.numSamplesKetos(timelims[1], soundDataWind.sampleRate, Boolean.FALSE)));

				//generate the transforms.
				ArrayList<DLTransform> transforms = DLTransformsFactory.makeDLTransforms(ketosParams.dlTransforms);

				ketosModel.setInputShape(ketosParams.defaultInputShape);
				//			FreqTransform a = new FreqTransform(new DLTransform.DLTransformType("SPECTROGRAMKETOS"), transforms.get(2).getDLTransformType())

				((WaveTransform) transforms.get(0)).setWaveData(soundDataWind);

				Matrix transfromedDataM = null;

				DLTransform transform = transforms.get(0);
				for (int i = 0; i < transforms.size(); i++) {
					System.out.println(transforms.get(i).getDLTransformType());
					//				transform = transforms.get(i).transformData(transform);
					if (transforms.get(i).getDLTransformType().name().equals("SPECTROGRAMKETOS")) {
						transform = transforms.get(i).transformData(transform);
					} else {
						transform = transforms.get(i).transformData(transform);
						int num_pad_right = 0;
						if (transforms.get(i).getDLTransformType().name().equals("DECIMATE")) {
							// Apply padding after resampling cf Ketos
							num_pad_right = Math.max(0, (int) (((timelims[1] - startTime) * soundDataWind.sampleRate - soundDataWind.samples_double.length)));
							soundDataWind.appendLeftRight(ketosParams.num_pad_left, num_pad_right);
						}
					}
				}

				double[][] transformedData = ((FreqTransform) transform).getSpecTransfrom().getTransformedData();

				System.out.println("Image size: " + transformedData.length + " x " + transformedData[0].length);

				transfromedDataM = DLMatFile.array2Matrix(transformedData);
				MatFile matFile = Mat5.newMatFile()
						.addArray("transformed_data_j", transfromedDataM);
				try {
					Mat5.writeToFile(matFile, outputMatfile);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}


		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.exit(0);
	}


}
