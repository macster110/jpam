package org.jamdev.jdl4pam.deepAcoustics;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

import org.jamdev.jdl4pam.deepAcoustics.YoloV8Decoder.YoloV8Box;
import org.jamdev.jpamutils.spectrogram.SpecTransform;
import org.jamdev.jpamutils.spectrogram.Spectrogram;
import org.jamdev.jpamutils.spectrogram.WindowFunction;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.junit.jupiter.api.Test;

/**
 * Test the decoding and pre processing for Ultralytics YOLO models (YOLOv8,
 * YOLO11). Reference values are from Ultralytics, scipy and numpy.
 *
 * @author Jamie Macaulay
 */
public class YoloV8DecoderTest {

	/**
	 * Make an output [1, 4 + nClasses, nAnchors] from boxes [x, y, w, h, scores...].
	 */
	private static float[] makeOutput(float[][] boxes, int nClasses) {
		int nAnchors = boxes.length;
		float[] out = new float[(4 + nClasses) * nAnchors];
		for (int a = 0; a < nAnchors; a++) {
			for (int c = 0; c < 4 + nClasses; c++) {
				out[c * nAnchors + a] = boxes[a][c];
			}
		}
		return out;
	}

	@Test
	public void decodeTest() {
		float[][] boxes = {
				{100, 100, 40, 20, 0.9f, 0.1f},
				{102, 101, 40, 20, 0.2f, 0.8f}, //overlaps the first box but a different class
				{300, 200, 10, 10, 0.05f, 0.05f}, //below the threshold
				{301, 200, 10, 10, 0.3f, 0.0f},
				{300.5f, 200.5f, 10, 10, 0.4f, 0.0f}, //overlaps the box above (IoU 0.82) with the same class
		};
		//pad with empty anchors - the layout is decided by the larger dimension and real models have many more anchors than channels.
		int nAnchors = 10;
		float[][] padded = new float[nAnchors][6];
		System.arraycopy(boxes, 0, padded, 0, boxes.length);
		float[] out = makeOutput(padded, 2);
		long[] shape = {1, 6, nAnchors};

		//class aware NMS keeps the overlapping boxes of different classes
		List<YoloV8Box> result = YoloV8Decoder.decode(out, shape, 0, 0.1f, 0.7, false, 300);
		assertEquals(3, result.size());
		assertEquals(0.9f, result.get(0).score, 1e-6);
		assertEquals(0, result.get(0).classIndex);
		assertEquals(0.8f, result.get(1).score, 1e-6);
		assertEquals(1, result.get(1).classIndex);
		assertEquals(0.4f, result.get(2).score, 1e-6);
		assertArrayEquals(new double[] {80, 90, 120, 110}, result.get(0).xyxy, 1e-6);

		//class agnostic NMS removes the overlapping box of a different class
		result = YoloV8Decoder.decode(out, shape, 0, 0.1f, 0.7, true, 300);
		assertEquals(2, result.size());

		//the maximum number of detections
		result = YoloV8Decoder.decode(out, shape, 0, 0.1f, 0.7, false, 1);
		assertEquals(1, result.size());

		//the transposed layout [batch, nAnchors, 4 + nClasses] gives the same boxes.
		float[] outT = new float[nAnchors * 6];
		for (int a = 0; a < boxes.length; a++) {
			System.arraycopy(boxes[a], 0, outT, a * 6, 6);
		}
		List<YoloV8Box> resultT = YoloV8Decoder.decode(outT, new long[] {1, nAnchors, 6}, 0, 0.1f, 0.7, false, 300);
		assertEquals(3, resultT.size());
		for (int i = 0; i < resultT.size(); i++) {
			assertArrayEquals(YoloV8Decoder.decode(out, shape, 0, 0.1f, 0.7, false, 300).get(i).xyxy, resultT.get(i).xyxy, 1e-6);
		}
	}

	@Test
	public void letterboxTest() {
		//the BioDCASE image, 257 x 363, letterboxed to 480 x 640 as Ultralytics does.
		YoloLetterbox letterbox = new YoloLetterbox(257, 363, 480, 640);
		assertEquals(640. / 363., letterbox.getGain(), 1e-12);
		assertEquals(13, letterbox.getPadTop());
		assertEquals(0, letterbox.getPadLeft());

		float[][][] image = new float[1][257][363];
		for (int i = 0; i < 257; i++) {
			for (int j = 0; j < 363; j++) {
				image[0][i][j] = 0.5f;
			}
		}
		float[][][] out = letterbox.letterbox(image, YoloLetterbox.DEFAULT_PAD_VALUE, true);
		assertEquals(480, out[0].length);
		assertEquals(640, out[0][0].length);
		assertEquals(114f / 255f, out[0][0][0], 1e-6);
		assertEquals(114f / 255f, out[0][479][0], 1e-6);
		assertEquals(127f / 255f, out[0][240][320], 1e-6);

		//a box covering the image maps back to the whole original image
		double[] src = letterbox.toSource(-5, 13, 650, 13 + 460);
		assertArrayEquals(new double[] {0, 0, 363, 257}, src, 1e-9);
	}

	@Test
	public void resamplePolyTest() {
		double[] x = new double[40];
		for (int i = 0; i < x.length; i++) {
			x[i] = Math.sin(0.3 * i) + 0.5 * Math.cos(1.7 * i);
		}

		//scipy.signal.resample_poly(x, 1, 4)
		double[] down4 = {0.18519191662830728, 0.8999353071420247, 0.6912375096168293, -0.4530154606260837, -0.9880841326022406,
				-0.2887541485928071, 0.8054328658567496, 0.8397848726080037, -0.1517319818451778, -1.0188653014335718};
		assertArrayEquals(down4, AudioData.resamplePoly(x, 1, 4), 1e-12);

		//scipy.signal.resample_poly(x, 3, 2)[:12]
		double[] up3down2 = {0.5003030867768886, 0.4172392820713865, 0.06141979464494877, 0.08129262469192562, 0.6347398427812929,
				1.2463815136898697, 1.3675663114703243, 0.9485933599616649, 0.5307456908179812, 0.617088641069527, 1.076991927889791,
				1.3066978789334627};
		double[] y = AudioData.resamplePoly(x, 3, 2);
		assertEquals(60, y.length);
		for (int i = 0; i < up3down2.length; i++) {
			assertEquals(up3down2[i], y[i], 1e-12);
		}
	}

	@Test
	public void spectrogramScipyTest() {
		//scipy.signal.get_window('hann', 8)
		assertArrayEquals(new double[] {0.0, 0.14644660940672627, 0.5, 0.8535533905932737, 1.0, 0.8535533905932737, 0.5,
				0.14644660940672627}, Spectrogram.periodicWindow(8, WindowFunction.HANNING), 1e-12);

		//the number of frames and bins are the same as scipy.signal.spectrogram(x, nperseg=256, noverlap=236, nfft=512)
		AudioData audio = new AudioData(new double[7500], 250f);
		Spectrogram spec = Spectrogram.scipySpectrogram(audio, 256, 20, 512, WindowFunction.HANNING);
		double[][] mag = Spectrogram.scipyMagnitude(spec, 256, WindowFunction.HANNING);
		assertEquals(363, mag.length);
		assertEquals(257, mag[0].length);

		//numpy.percentile([3, 1, 4, 1, 5, 9, 2, 6, 5], 98) = 8.52
		double[][] norm = SpecTransform.normalisePercentile(new double[][] {{3, 1, 4}, {1, 5, 9}, {2, 6, 5}}, 98);
		assertEquals((3 - 1) / 7.52, norm[0][0], 1e-12);
		assertEquals(1.0, norm[1][2], 1e-12);
		assertEquals(0.0, norm[0][1], 1e-12);
	}

}
