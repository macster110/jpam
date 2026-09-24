package org.jamdev.jdl4pam.deepAcoustics;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import org.jamdev.jdl4pam.deepAcoustics.Pred2BoxDJL3.DeepAcousticsNetwork;
import org.jamdev.jdl4pam.deepAcoustics.Pred2BoxDJL3.YoloPostProcessorResult;
import org.junit.jupiter.api.Test;

import ai.djl.ndarray.NDList;
import ai.djl.ndarray.NDManager;
import ai.djl.ndarray.types.Shape;

/**
 * Test the YOLO v4 decoder.
 *
 * @author Jamie Macaulay
 */
public class YoloV4DecoderTest {

	private static final int BATCH = 2;

	private static final int N_CLASSES = 4;

	private static final int IM_HEIGHT = 48;

	private static final int IM_WIDTH = 64;

	/**
	 * Detection head sizes [height, width].
	 */
	private static final int[][] HEADS = { { 6, 8 }, { 3, 4 } };

	private static List<double[][]> anchorBoxes() {
		List<double[][]> anchors = new ArrayList<double[][]>();
		anchors.add(new double[][] { { 10, 12 }, { 20, 8 }, { 30, 40 } });
		anchors.add(new double[][] { { 40, 30 }, { 25, 60 }, { 48, 20 } });
		return anchors;
	}

	/**
	 * Create random channels last detection heads.
	 */
	private static float[][] randomHeads(long[][] shapes) {
		Random random = new Random(42);
		float[][] heads = new float[shapes.length][];
		for (int i = 0; i < shapes.length; i++) {
			int n = (int) (shapes[i][0] * shapes[i][1] * shapes[i][2] * shapes[i][3]);
			heads[i] = new float[n];
			for (int j = 0; j < n; j++) {
				heads[i][j] = (float) (random.nextGaussian() * 2.0);
			}
		}
		return heads;
	}

	private static long[][] channelsLastShapes(int nClasses) {
		int nChannels = 3 * (5 + nClasses);
		long[][] shapes = new long[HEADS.length][];
		for (int i = 0; i < HEADS.length; i++) {
			shapes[i] = new long[] { BATCH, HEADS[i][0], HEADS[i][1], nChannels };
		}
		return shapes;
	}

	/**
	 * The fast decoder should give the same result as the original NDArray based
	 * decoder. Note this is only tested for a single class because
	 * Pred2BoxDJL3 does not select the correct class channels for each anchor when
	 * there is more than one class.
	 */
	@Test
	public void decoderMatchesPred2BoxTest() {
		long[][] shapes = channelsLastShapes(1);
		float[][] heads = randomHeads(shapes);

		DeepAcousticsNetwork network = new DeepAcousticsNetwork(new Shape(-1, IM_HEIGHT, IM_WIDTH, 3), anchorBoxes());

		try (NDManager manager = NDManager.newBaseManager()) {
			NDList list = new NDList();
			for (int i = 0; i < heads.length; i++) {
				list.add(manager.create(heads[i], new Shape(shapes[i])));
			}

			int nDetections = 0;
			for (int b = 0; b < BATCH; b++) {
				YoloPostProcessorResult expected = Pred2BoxDJL3.yoloPostProcess(manager, list, network, 0.5f, b);
				YoloPostProcessorResult result = YoloV4Decoder.decode(heads, shapes, network, 0.5f, b);

				assertEquals(expected.scores.length, result.scores.length);
				for (int i = 0; i < expected.scores.length; i++) {
					assertEquals(expected.scores[i], result.scores[i], 1e-5);
					assertArrayEquals(expected.bboxes[i], result.bboxes[i], 1e-3);
					assertArrayEquals(expected.classProbs[i], result.classProbs[i], 1e-5f);
				}
				nDetections += result.scores.length;
			}
			//make sure the test actually tests something.
			assertTrue(nDetections > 10);
		}
	}

	/**
	 * Channels first detection heads (e.g. PyTorch) should give the same result as
	 * the equivalent channels last heads.
	 */
	@Test
	public void channelsFirstTest() {
		long[][] shapes = channelsLastShapes(N_CLASSES);
		float[][] heads = randomHeads(shapes);

		//transpose [batch, height, width, channels] to [batch, channels, height, width]
		long[][] shapesCF = new long[shapes.length][];
		float[][] headsCF = new float[shapes.length][];
		for (int i = 0; i < shapes.length; i++) {
			int n = (int) shapes[i][0], h = (int) shapes[i][1], w = (int) shapes[i][2], c = (int) shapes[i][3];
			shapesCF[i] = new long[] { n, c, h, w };
			headsCF[i] = new float[heads[i].length];
			for (int b = 0; b < n; b++)
				for (int r = 0; r < h; r++)
					for (int col = 0; col < w; col++)
						for (int ch = 0; ch < c; ch++)
							headsCF[i][((b * c + ch) * h + r) * w + col] = heads[i][((b * h + r) * w + col) * c + ch];
		}

		DeepAcousticsNetwork network = new DeepAcousticsNetwork(new Shape(-1, IM_HEIGHT, IM_WIDTH, 3), anchorBoxes());
		DeepAcousticsNetwork networkCF = new DeepAcousticsNetwork(new Shape(-1, 3, IM_HEIGHT, IM_WIDTH), anchorBoxes());
		networkCF.setChannelsFirst(true);

		assertEquals(IM_HEIGHT, networkCF.getImageHeight());
		assertEquals(IM_WIDTH, networkCF.getImageWidth());

		for (int b = 0; b < BATCH; b++) {
			YoloPostProcessorResult expected = YoloV4Decoder.decode(heads, shapes, network, 0.5f, b);
			YoloPostProcessorResult result = YoloV4Decoder.decode(headsCF, shapesCF, networkCF, 0.5f, b);
			assertEquals(expected.scores.length, result.scores.length);
			for (int i = 0; i < expected.scores.length; i++) {
				assertEquals(expected.scores[i], result.scores[i]);
				assertArrayEquals(expected.bboxes[i], result.bboxes[i]);
			}
		}
	}

	/**
	 * Boxes larger than the image are removed if filterLargeBoxes is true (as in
	 * MATLAB's detect function) and the other boxes are unchanged.
	 */
	@Test
	public void filterLargeBoxesTest() {
		long[][] shapes = channelsLastShapes(N_CLASSES);
		float[][] heads = randomHeads(shapes);

		DeepAcousticsNetwork network = new DeepAcousticsNetwork(new Shape(-1, IM_HEIGHT, IM_WIDTH, 3), anchorBoxes());
		YoloPostProcessorResult all = YoloV4Decoder.decode(heads, shapes, network, 0.5f, 0);

		network.setFilterLargeBoxes(true);
		YoloPostProcessorResult filtered = YoloV4Decoder.decode(heads, shapes, network, 0.5f, 0);

		int nSmall = 0;
		for (int i = 0; i < all.bboxes.length; i++) {
			if (all.bboxes[i][2] <= IM_WIDTH && all.bboxes[i][3] <= IM_HEIGHT) {
				assertArrayEquals(all.bboxes[i], filtered.bboxes[nSmall]);
				nSmall++;
			}
		}
		assertEquals(nSmall, filtered.bboxes.length);
		//make sure some boxes were removed
		assertTrue(nSmall < all.bboxes.length && nSmall > 0);
	}

	/**
	 * Test non maximum suppression. Only boxes of the same class which overlap by
	 * more than the threshold are removed.
	 */
	@Test
	public void nmsTest() {
		List<double[]> boxes = new ArrayList<double[]>();
		boxes.add(new double[] { 10, 10, 10, 10 }); // 0
		boxes.add(new double[] { 11, 10, 10, 10 }); // 1 - overlaps 0 (IoU 0.82), same class, higher score
		boxes.add(new double[] { 12, 10, 10, 10 }); // 2 - overlaps 1, different class
		boxes.add(new double[] { 15, 10, 10, 10 }); // 3 - IoU with 1 is 0.43 - kept
		boxes.add(new double[] { 50, 50, 5, 5 }); // 4 - no overlap
		List<Float> scores = Arrays.asList(0.6f, 0.9f, 0.7f, 0.8f, 0.55f);
		List<Integer> labels = Arrays.asList(0, 0, 1, 0, 0);

		boolean[] keep = YoloV4Decoder.selectStrongestBboxMulticlass(boxes, scores, labels, 0.5);
		assertArrayEquals(new boolean[] { false, true, true, true, true }, keep);

		//a lower threshold removes box 3
		keep = YoloV4Decoder.selectStrongestBboxMulticlass(boxes, scores, labels, 0.4);
		assertArrayEquals(new boolean[] { false, true, true, false, true }, keep);
	}

}
