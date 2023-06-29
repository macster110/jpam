package org.jamdev.jdl4pam.genericmodel;

import java.util.ArrayList;
import ai.djl.ndarray.types.Shape;

import org.jamdev.jdl4pam.transforms.DLTransfromParams;
import org.jamdev.jdl4pam.transforms.SimpleTransformParams;
import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;

/**
 * Create default parameter objects for different models published in
 * literature.
 * 
 * @author Jamie Macaulay
 *
 */
public class DefaultGenericParams {

	public enum GenericModel {

		/**
		 * A right whale call classifier by Shui et al.2019 Shiu, Y., Palmer, K.J.,
		 * Roch, M.A. et al. Deep neural networks for automated detection of marine
		 * mammal species. Sci Rep 10, 607 (2020).
		 * <p>
		 * https://doi.org/10.1038/s41598-020-57549-y
		 * 
		 */
		RIGTH_WHALE_SHUI,

		/**
		 * Google's first humpback whale classifier.
		 * <p>
		 * Allen, A.N., Harvey, M., Harrell, L., Jansen, A., Merkens, K.P., Wall, C.C.,
		 * Cattiau, J., Oleson, E.M., 2021. A Convolutional Neural Network for Automated
		 * Detection of Humpback Whale Song in a Diverse, Long-Term Passive Acoustic
		 * Dataset. Front. Mar. Sci. 8, 607321.
		 * <p>
		 * https://doi.org/10.3389/fmars.2021.607321
		 * 
		 */
		GOOGLE_HUMPBACK_1

	}

	public static GenericModelParams getDefaultParams(GenericModel model) {

		switch (model) {
		case GOOGLE_HUMPBACK_1:
			return googleHumpBack1();
		case RIGTH_WHALE_SHUI:
			return rightWhaleShui();
		default:

			return null;
		}

	}

	/**
	 * Create the generic model parameters for running Google's first HumpbackwHALE
	 * whale classifier.
	 * <p>
	 * Allen, A.N., Harvey, M., Harrell, L., Jansen, A., Merkens, K.P., Wall, C.C.,
	 * Cattiau, J., Oleson, E.M., 2021. A Convolutional Neural Network for Automated
	 * Detection of Humpback Whale Song in a Diverse, Long-Term Passive Acoustic
	 * Dataset. Front. Mar. Sci. 8, 607321.
	 * <p>
	 * https://doi.org/10.3389/fmars.2021.607321
	 * 
	 * @return the parameters to run Google's TensorFlow model.
	 */
	protected static GenericModelParams googleHumpBack1() {

		GenericModelParams params = new GenericModelParams();

		params.defaultInputShape = new Shape(-1, -1, -1, 1);
		params.defaultOutputShape = new Shape(-1, 1);

		params.segLen = 2000.;

		params.classNames = new String[] { "Humback Whale" };

		// create the transforms.
		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		// waveform transforms.
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, 10000));

		params.dlTransforms = dlTransformParamsArr;

		return params;
	}

	/**
	 * Get the paramters for Shiu et al. 2019 right whale model.
	 * <p>
	 * Shiu, Y., Palmer, K.J., Roch, M.A. et al. Deep neural networks for automated
	 * detection of marine mammal species. Sci Rep 10, 607 (2020).
	 * <p>
	 * https://doi.org/10.1038/s41598-020-57549-y
	 * 
	 * @return the parameters to run Shiu et al. 2019 TensorFlow model.
	 */
	protected static GenericModelParams rightWhaleShui() {

		GenericModelParams params = new GenericModelParams();

		params.defaultInputShape = new Shape(-1, 40, 40, 1);
		params.defaultOutputShape = new Shape(-1, 2);

		params.segLen = 2000.;

		params.classNames = new String[] { "Noise", "Right Whale" };

		// create the transforms.
		ArrayList<DLTransfromParams> dlTransformParamsArr = new ArrayList<DLTransfromParams>();

		// waveform transforms.
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.DECIMATE, 2000));
		// dlTransformParamsArr.add(new
		// SimpleTransformParams(DLTransformType.PREEMPHSIS, preemphases));
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECTROGRAM, 256, 100));
		// in the python code they have an sfft of 129xN where N is the number of
		// chunks. They then
		// choose fft data between bin 5 and 45 in the FFT. This roughly between 40 and
		// 350 Hz.
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECCROPINTERP, 47.0, 357.0, 40));
		dlTransformParamsArr.add(new SimpleTransformParams(DLTransformType.SPECNORMALISEROWSUM));

		params.dlTransforms = dlTransformParamsArr;

		return params;

	}

}
