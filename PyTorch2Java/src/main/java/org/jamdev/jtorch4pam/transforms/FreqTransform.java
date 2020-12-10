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
public class FreqTransform extends SimpleTransform {


	/**
	 * The spectrogram transform which holds the transformed data. 
	 */
	private SpecTransform specTransfrom;

	
	/**
	 * The frequency transform type flag
	 */
	private DLTransformType flag;
	
	/**
	 * The minimum and maximum frequency of the transform. 
	 */
	private double[] freqlims = new double[2]; 
	
	
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
	public FreqTransform(Spectrogram spectrogram, DLTransformType flag, Number... params) {
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
	public FreqTransform(DLTransformType flag, Number... params) {
		this.flag = flag; 
		this.params = params; 
	}

	@Override
	public DLTransform transformData(DLTransform transform) {

		switch (flag) {
		case SPECCROPINTERP:
			specTransfrom = ((FreqTransform) transform).getSpecTransfrom().interpolate(params[0].doubleValue(),  params[1].doubleValue(), params[2].intValue()); 
			//frquency limits change for this transform.  
			freqlims[0] = params[0].doubleValue(); 
			freqlims[1] = params[1].doubleValue(); 

			break;
		case SPEC2DB:
			specTransfrom = ((FreqTransform) transform).getSpecTransfrom().dBSpec();
			freqlims = ((FreqTransform) transform).freqlims; 
			break; 
		case SPECNORMALISE:
			specTransfrom = ((FreqTransform) transform).getSpecTransfrom().normalise(params[0].doubleValue(),  params[1].doubleValue()); 
			freqlims = ((FreqTransform) transform).freqlims; 
			break;
		case SPECTROGRAM:
			//make a spectrogram 
			Spectrogram spectrogram = new Spectrogram(((WaveTransform) transform).getWaveData(), (int) params[0], (int) params[1]); 
			specTransfrom = new SpecTransform(spectrogram); 
			specTransfrom.setTransformedData(this.specTransfrom.getSpectrgram().getAbsoluteSpectrogram()); 
			//initialise freq
			freqlims[0] = 0.0; 
			freqlims[1] = ((WaveTransform) transform).getWaveData().getSampleRate()/2.0; 
			break;
		case SPECCLAMP:
			specTransfrom = ((FreqTransform) transform).getSpecTransfrom().clamp(params[0].doubleValue(),  params[1].doubleValue()); 
			freqlims = ((FreqTransform) transform).freqlims; 
			break;
		default:
			break;
		}

		return this;
	}

	/**
	 * Get the minimum and maximum frequency limits in Hz. This defines the minimum and maximum frequency of the 
	 * double[][] transformed data. 
	 * @return - the minimum and maximum frequency limits in Hz. 
	 */
	public double[] getFreqlims() {
		return freqlims;
	}

	/**
	 * Set the minimum and maximum frequency limits in Hz. This defines the minimum and maximum frequency of the 
	 * double[][] transformed data. 
	 *@param freqlims - the minimum and maximum frequency limits in Hz. 
	 */
	public void setFreqlims(double[] freqlims) {
		this.freqlims = freqlims;
	}


	/**
	 * Get the spectrogram transform. This holds the transformed spectrogram data 
	 * @return the spectrogram transform. 
	 */
	public SpecTransform getSpecTransfrom() {
		return specTransfrom;
	}


	@Override
	public DLTransformType getDLTransformType() {
		return flag;
	}



}
