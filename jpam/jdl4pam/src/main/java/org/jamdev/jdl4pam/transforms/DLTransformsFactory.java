package org.jamdev.jdl4pam.transforms;

import java.util.ArrayList;

import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.jamdev.jpamutils.wavFiles.FilterParams;

/**
 * Generates a transform class from Enum and default parameters. 
 * 
 * @author Jamie Macaulay
 *
 */
public class DLTransformsFactory {

	/**
	 * Generate a default DLTransfrom object from a DLtransforms type. The transforms will have default parameters. 
	 * @param dlTransformType - the transform type
	 * @param sR- THE sample rate in samples per seconds.
	 */
	public static DLTransform makeDLTransform(DLTransformType dlTransformType, float sR) {

		DLTransform dlTransform = null; 

		switch (dlTransformType) {
			//-----Wave Transforms----

		case DECIMATE:
			dlTransform = new WaveTransform(dlTransformType, new Number[] {sR}); 
			break;
		case DECIMATE_SCIPY:
			dlTransform = new WaveTransform(dlTransformType, new Number[] {sR}); 
			break;
		case PREEMPHSIS:
			dlTransform = new WaveTransform(dlTransformType, new Number[] {0.98}); 
			break;
		case NORMALISE_WAV:
			dlTransform = new WaveTransform(dlTransformType, null); 
			break;
		case PEAK_TRIM:
			dlTransform = new WaveTransform(dlTransformType,  new Number[] {128, AudioData.PEAK_MAX}); 
			break;
		case FILTER:
			FilterParams filtParams = new FilterParams(); //default params
			dlTransform = new WaveTransform(dlTransformType, WaveTransform.filterParams2transform(filtParams)); 
			break;
			
			//-----Spectrogram Transforms----

		case SPEC2DB:
			dlTransform = new FreqTransform(dlTransformType, null); 
			break;
		case SPECCLAMP:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {0.0, 1.0}); 
			break;
		case SPECCROPINTERP:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {0.0, (double) sR/2 , 256}); 
			break;
		case SPECNORMALISE:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {-100.0, 0.0}); 
			break;
		case SPECNORMALISEROWSUM:
			dlTransform = new FreqTransform(dlTransformType, null); 
			break;
		case SPECTROGRAM:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {1024, 8}); 
			break;
		case SPECRESIZE:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {160, 160}); 
			break;
		case SPECTROGRAMKETOS:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {1024, 8, 0.2}); 
			break;
		case TRIM:
			dlTransform = new WaveTransform(dlTransformType, new Number[] {0, 2048}); 
			break;
		case ENHANCE:
			dlTransform = new FreqTransform(dlTransformType, new Number[] {1.0}); 
			break;
		case FILTER_ISOLATED_SPOTS:
			dlTransform = new FreqTransform(dlTransformType, null); //TODO 
			break;
		case GAUSSIAN_FILTER:
			dlTransform = new FreqTransform(dlTransformType,  new Number[] {0.5}); //sigma
			break;
		case MEDIANFILTER:
			dlTransform = new FreqTransform(dlTransformType, null); 
			break;
		case REDUCETONALNOISE_MEAN:
			dlTransform = new FreqTransform(dlTransformType, 30); 
			break;
		case REDUCETONALNOISE_MEDIAN:
			dlTransform = new FreqTransform(dlTransformType, null);
			break;
		case SPECNORMALISESTD:
			dlTransform = new FreqTransform(dlTransformType,  new Number[] {0.0, 1.0}); 
			break;
		case SPECNORMALISE_MINIMAX:
			dlTransform = new FreqTransform(dlTransformType, null); 
			break;
		case SPECFLIP:
			dlTransform = new FreqTransform(dlTransformType, null); 
			break;
		case CLAHE:
			dlTransform = new FreqTransform(dlTransformType,  new Number[] {12, 255, 2f}); 
			break;
			//-----Spectrum Transforms----
		case FFT:
			dlTransform = new SpectrumTransform(dlTransformType, new Number[] {2048}); 
			break;
		case SPECTRUM_NORMALISE_SUM:
			dlTransform = new SpectrumTransform(dlTransformType, null); 
			break;
		case SPECTRUM_DOWNSAMPLE_MEAN:
			dlTransform = new SpectrumTransform(dlTransformType, new Number[] {2}); 
			break;
		case SPECTRUM_TRIM_FREQ:
			dlTransform = new SpectrumTransform(dlTransformType, new Number[] {0., sR/2}); 
			break;
		case SPECTRUM_dB:
			dlTransform = new SpectrumTransform(dlTransformType, new Number[] {1}); 
			break;
		case SPECTRUM_SMOOTH:
			dlTransform = new SpectrumTransform(dlTransformType, new Number[] {3}); 
			break;
		
		default:
			break;

		}
		return dlTransform;
	}


	/**
	 * Generate a DLTransfrom object from DL transform from parameters. 
	 * @param dlTransfromParams - paramters object. 
	 * @return DL transform. 
	 */
	public static DLTransform makeDLTransform(DLTransfromParams dlTransfromParams) {

		DLTransform dlTransform; 

		switch (dlTransfromParams.dltransfromType) {
		case DECIMATE:
		case DECIMATE_SCIPY:
		case PREEMPHSIS:
		case FILTER:
		case TRIM:
		case NORMALISE_WAV:
		case PEAK_TRIM:
			dlTransform = new WaveTransform(dlTransfromParams.dltransfromType, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		case FFT:
		case SPECTRUM_NORMALISE_SUM:
		case SPECTRUM_DOWNSAMPLE_MEAN:
		case SPECTRUM_TRIM_FREQ:
		case SPECTRUM_dB:
		case SPECTRUM_SMOOTH:
			dlTransform = new SpectrumTransform(dlTransfromParams.dltransfromType, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		default:
			dlTransform = new FreqTransform(dlTransfromParams.dltransfromType, ((SimpleTransformParams) dlTransfromParams).params); 
			break;
		}
		return dlTransform;
	}

	/**
	 * Generate a list of transform objects from an array  of transform parameters. 
	 * @param dlTransfromParams - the DL transform parameters. 
	 * @return - list of corresponding transform objects 
	 */
	public static ArrayList<DLTransform> makeDLTransforms(ArrayList<DLTransfromParams> dlTransfromParams) {
		ArrayList<DLTransform>  transforms = new  ArrayList<DLTransform>(); 
		for (int i=0; i<dlTransfromParams.size(); i++) {
			transforms.add(makeDLTransform(dlTransfromParams.get(i))); 
			//System.out.println("dlTransfromParams.get(i): " + dlTransfromParams.get(i)); 
		}
		return transforms; 
	}


}
