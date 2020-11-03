package org.jamdev.jtorch4pam.transforms;

import org.jamdev.jtorch4pam.spectrogram.SpecTransform;
import org.jamdev.jtorch4pam.spectrogram.Spectrogram;

/**
 * Creates a spectrogram transform which can be used to 
 * apply various transforms (see {@link FreqTransform.FreqTransformType})
 * to spectrogram data.  
 * 
 * @author Jamie Macaulay
 *
 */
public class FreqTransform implements DLTransform {

	/**
	 * Type of frequency transform that are available. 
	 * {@link #SPECTROGRAM}
	 * {@link #SPECCROPINTERP}
	 * {@link #SPECNORMALISE}
	 * {@link #SPEC2DB}
	 * 
	 * @author Jamie Macaulay
	 *
	 */
	public enum FreqTransformType {
		/**
		 * Converts a waveform to a spectrogram
		 */
		SPECTROGRAM, 

		/**
		 * Crops a spectrogram image between two frequency values and interpolates the image to be
		 * a specified pixel size. 
		 */
		SPECCROPINTERP, 

		/**
		 * Normalises the spectrogram
		 */
		SPECNORMALISE, 

		/**
		 * Converts a spectrogram from linear to log10 units. 
		 */
		SPEC2DB,
		
		/**
		 * Clamps the spectrogram between two values.
		 */
		SPECCLAMP
	}	

	/**
	 * The spec transform which holds the transformed data. 
	 */
	SpecTransform specTransfrom;

	/**
	 * The frequency transform type flag
	 */
	private FreqTransformType flag;

	/**
	 * The parameters. 
	 */
	private Number[] params;
	
	/**
	 * Create a frequency transform.
	 * <p>
	 * See {@link FreqTransform.FreqTransformType} for a description of each transform. 
	 * <p>
	 * Each transform type has a unique set of parameters. These are
	 * <ul>
	 *<li>SPECTROGRAM: FFT length (samples), FFT hop size (samples)</li>
	 *<li>SPECCROPINTERP: minimum frequency (Hz), maximum frequency (Hz), Number of frequency (int)</li>
	 *<li>SPEC2DB: -no params</li>
	 *<li>SPECNORMALISE: the minimum dB level, the reference dB value to normalise to</li>
	 *<li>SPECCLAMP: the minimum value, the maximum value </li>

	 *</ul>
	 * 
	 * @param SPECTROGRAM - the initial spectrogram to transform. 
	 * @param flag - the type flag for the transform
	 * @param params - the parameters associated with the transform type. 
	 */
	public FreqTransform(Spectrogram spectrogram, FreqTransformType flag, Number... params) {
		this.flag = flag; 
		this.params = params; 
		this.specTransfrom = new SpecTransform(spectrogram); 
	}


	/**
	 * Create a frequency transform.
	 * <p>
	 * See {@link FreqTransform.FreqTransformType} for a description of each transform. 
	 * <p>
	 * Each transform type has a unique set of parameters. These are
	 * <ul>
	 *<li>SPECTROGRAM: FFT length (samples), FFT hop size (samples)</li>
	 *<li>SPECCROPINTERP: minimum frequency (Hz), maximum frequency (Hz), Number of frequency (int)</li>
	 *<li>SPEC2DB: -no params</li>
	 *<li>SPECNORMALISE: the minimum dB level, the reference dB value to normalise to</li>
	 *<li>SPECCLAMP: the minimum value, the maximum value </li>
	 *</ul>
	 * 
	 * @param flag - the type flag for the transform
	 * @param params - the parameters associated with thetransform type. 
	 */
	public FreqTransform(FreqTransformType flag, Number... params) {
		this.flag = flag; 
		this.params = params; 
	}

	@Override
	public DLTransform transformData(DLTransform transform) {

		switch (flag) {
		case SPECCROPINTERP:
			specTransfrom = ((FreqTransform) transform).getSpecTransfrom().interpolate(params[0].doubleValue(),  params[1].doubleValue(), params[2].intValue()); 
			break;
		case SPEC2DB:
			specTransfrom = ((FreqTransform) transform).getSpecTransfrom().dBSpec();
			break; 
		case SPECNORMALISE:
			specTransfrom = ((FreqTransform) transform).getSpecTransfrom().normalise(params[0].doubleValue(),  params[1].doubleValue()); 
			break;
		case SPECTROGRAM:
			//make a spectrogram 
			Spectrogram spectrogram = new Spectrogram(((WaveTransform) transform).getWaveData(), (int) params[0], (int) params[1]); 
			specTransfrom = new SpecTransform(spectrogram); 
			break;
		default:
			break;
		}

		return this;
	}

	/**
	 * Get the spectrogram transform. This holds the transformed spectrogram data 
	 * @return the spectrogram transform. 
	 */
	public SpecTransform getSpecTransfrom() {
		return specTransfrom;
	}



}
