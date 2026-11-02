package org.jamdev.jdl4pam.generic;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.nio.file.Paths;

import org.jamdev.jdl4pam.genericmodel.GenericModel;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jdl4pam.utils.InputShapeException;
import org.junit.jupiter.api.Test;

import ai.djl.ndarray.types.Shape;
import ai.djl.translate.TranslateException;

/**
 * Test that the input data are checked against the model input shape and that
 * TorchScript models, which do not describe their inputs, use the input shape
 * from the model metadata.
 * <p>
 * The models are tiny TorchScript models. tiny_waveform takes [batch, samples]
 * and returns [mean, first sample] for each waveform. tiny_spectrogram takes
 * [batch, time, freq] and returns [mean, value at time 0 and frequency 1].
 *
 * @author Jamie Macaulay
 */
public class InputShapeTest {

	private static final String RESOURCE_FOLDER = "./src/test/java/org/jamdev/jdl4pam/resources/torchscript/";

	private static String modelPath(String name) {
		return Paths.get(RESOURCE_FOLDER + name).toAbsolutePath().normalize().toString();
	}

	@Test
	public void batchShapeTest() {
		//the data fit the shape
		assertEquals(new Shape(8, 363, 129, 1), DLUtils.batchShape(new Shape(-1, 363, 129, 1), 8, new long[] {363, 129}, 8*363*129));

		//an unknown dimension is calculated from the number of values
		assertEquals(new Shape(2, 375, 128), DLUtils.batchShape(new Shape(-1, -1, 128), 2, new long[] {375, 128}, 2*375*128));

		//a 30 s spectrogram with fft 256 and hop 20 at 250 Hz is 375 x 128, not the declared 363 x 129. This was
		//previously reshaped without an error so the model ran on a sheared image.
		assertThrows(InputShapeException.class, () -> DLUtils.batchShape(new Shape(-1, 363, 129, 1), 1, new long[] {375, 128}, 375*128));

		//more than one unknown dimension
		assertThrows(InputShapeException.class, () -> DLUtils.batchShape(new Shape(-1, -1, -1), 1, new long[] {375, 128}, 375*128));

		assertTrue(DLUtils.sameNonUnitDims(new Shape(8, 363, 129, 1), new long[] {363, 129}));
		assertTrue(DLUtils.sameNonUnitDims(new Shape(8, 1, 363, 129), new long[] {363, 129}));
		assertFalse(DLUtils.sameNonUnitDims(new Shape(8, 129, 363), new long[] {363, 129}));
	}

	@Test
	public void spectrogramShapeTest() throws Exception {
		GenericModel model = new GenericModel(modelPath("tiny_spectrogram.py"));

		//TorchScript models do not describe their input shape so it comes from the metadata
		model.setInputShape(new Shape(-1, 363, 129));

		float[][][] spec = new float[2][363][129];
		spec[0][0][1] = 7;
		spec[1][0][1] = 3;
		float[] result = model.runModel(spec);
		assertNotNull(result);
		assertEquals(4, result.length);
		assertEquals(7, result[1], 1e-6);
		assertEquals(3, result[3], 1e-6);

		//a spectrogram with the wrong shape is an error rather than being reshaped into the input
		TranslateException e = assertThrows(TranslateException.class, () -> model.getSpecPredictor().predict(new float[1][375][128]));
		assertNotNull(InputShapeException.find(e));
		assertNull(model.runModel(new float[1][375][128]));

		model.getModel().close();
	}

	@Test
	public void waveformShapeTest() throws Exception {
		GenericModel model = new GenericModel(modelPath("tiny_waveform.py"));

		//without metadata the input is assumed to be a batch of waveforms. Previously this failed with
		//"this.shapes is null" because TorchScript models do not describe their inputs.
		float[][] wave = new float[3][7500];
		for (int i = 0; i < wave.length; i++) {
			wave[i][0] = i + 1;
		}
		float[] result = model.runModel(wave);
		assertNotNull(result);
		assertArrayEquals(new float[] {1/7500f, 1, 2/7500f, 2, 3/7500f, 3}, result, 1e-6f);

		//the shape from the metadata is used by the waveform translator
		model.setInputShape(new Shape(-1, 7500));
		result = model.runModel(wave);
		assertNotNull(result);
		assertEquals(6, result.length);

		//and waveforms of the wrong length are an error
		TranslateException e = assertThrows(TranslateException.class, () -> model.getWavePredictor().predict(new float[1][7000]));
		assertNotNull(InputShapeException.find(e));

		model.getModel().close();
	}

}
