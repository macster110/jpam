package org.jamdev.jdl4pam.transforms;

import org.jamdev.jpamutils.spectrum.Spectrum;

/**
 * Transforms for a 1D spectrum. 
 */
public class SpectrumTransform extends SimpleTransform {

	/**
	 * The spectrum object holding the spectrum
	 */
	private Spectrum spectrum;

	/**
	 * The spectrum transform type flag
	 */
	private DLTransformType flag;


	/**
	 * Create a spectrum transform including the initial raw audiodata. 
	 * 
	 * @param spectrum - the spectrum;
	 * @param flag - the type flag for the transform
	 * @param params - the parameters associated with thetransform type. 
	 */
	public  SpectrumTransform(Spectrum spectrum, DLTransformType flag, Number... params) {
		this.spectrum = spectrum;
		this.flag=flag;
		this.params = params;
	}


	/**
	 * Create a spectrum transform including the initial raw audiodata. 
	 * 
	 * @param flag - the type flag for the transform
	 * @param params - the parameters associated with thetransform type. 
	 */
	public  SpectrumTransform(DLTransformType flag, Number... params) {
		this.flag=flag;
		this.params = params;
	}

	@Override
	public DLTransform transformData(DLTransform transform) {

		switch (flag) {
		case FFT:			
			//make a spectrogram 
			Spectrum spectrum = new Spectrum(((WaveTransform) transform).getWaveData(), (int) params[0]); 
			this.spectrum = spectrum;
			break;
		case SPECTRUM_NORMALISE_SUM:
			this.spectrum = ((SpectrumTransform) transform).getSpectrum().normaliseSpectrumSum();
			break;
		case SPECTRUM_DOWNSAMPLE_MEAN:
			this.spectrum = ((SpectrumTransform) transform).getSpectrum().downSampleSpectrumMean((int) params[0]); 
			break;
		case SPECTRUM_SMOOTH:
			this.spectrum = ((SpectrumTransform) transform).getSpectrum().smoothSpectrum((int) params[0]);
			break;
		case SPECTRUM_dB:
			boolean subtractMin = true;
			if (params!=null && params[0]!=null) {
				subtractMin = params[0].intValue()==0 ? false : true;
			}
			this.spectrum = ((SpectrumTransform) transform).getSpectrum().spectrumdB(subtractMin); 
			break;
		case SPECTRUM_TRIM_FREQ:
			this.spectrum = ((SpectrumTransform) transform).getSpectrum().trimSpectrum(new double[] {(double) params[0], (double) params[1]});
			break;
		default:
			break;
		}

		return this; 
	}

	@Override
	public DLTransformType getDLTransformType() {
		return flag;
	}
	

	public Spectrum getSpectrum() {
		return spectrum;
	}


	public void setSpectrum(Spectrum spectrum) {
		this.spectrum = spectrum;
	}

}
