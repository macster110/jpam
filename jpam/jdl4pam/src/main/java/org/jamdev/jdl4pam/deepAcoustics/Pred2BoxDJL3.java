package org.jamdev.jdl4pam.deepAcoustics;

import ai.djl.ndarray.*;
import ai.djl.ndarray.index.NDIndex;
import ai.djl.ndarray.types.*;
import ai.djl.nn.Activation;
import java.util.*;

import org.jamdev.jpamutils.JamArr;

public class Pred2BoxDJL3  {
	

	public static class YoloPostProcessorResult {
		
		
		/**
		 * Bounding boxes in the format [x, y, width, height]
		 * where (x, y) is the left corner of the box.
		 */
		public double[][] bboxes; // [N,4]
		
		/**
		 * Scores for each bounding box.
		 * This is the confidence score of the object being present in the box.
		 */
		public float[] scores;   // [N]
		
		/**
		 * Class indices for each bounding box.
		 * This indicates the class of the detected object.
		 */
		public float[][] classes;     // [N]
	}

	/**
	 * Post-process the output of a YOLO model to extract bounding boxes, scores, and classes.
	 * 
	 * @param manager the NDManager to create NDArray objects
	 * @param scoreTf List of NDArray, each [1, H, W, C] representing the output of detection heads
	 * @param network the Network object containing anchor boxes and image shape
	 * @param index the index of the detection head to process
	 * @return YoloPostProcessorResult containing bounding boxes, scores, and classes
	 */
	public static YoloPostProcessorResult yoloPostProcess(
			NDManager manager,
			NDList scoreTf, // List of NDArray, each [1, H, W, C]
			DeepAcousticsNetwork network,
			float thresh,
			int index
			) {
		int nDetHeads = scoreTf.size();
		List<List<NDArray>> output = new ArrayList<>(nDetHeads);

	    // 1. Process predictions
	    for (int idx = 0; idx < nDetHeads; idx++) {
	        NDArray head = scoreTf.get(idx);
	        long numTilesD1 = head.getShape().get(1);
	        long numTilesD2 = head.getShape().get(2);
	        long numChannelsPred = head.getShape().get(3);
	        int numAnchors = network.anchorBoxes.get(idx).length;
	        int numPredElemsPerAnchors = (int) (numChannelsPred / numAnchors);

	        int stride = numPredElemsPerAnchors;
	        int endIdx = (int) numChannelsPred;

	        int[] xIds = range(0, endIdx, stride);
	        int[] yIds = range(1, endIdx, stride);
	        int[] wIds = range(2, endIdx, stride);
	        int[] hIds = range(3, endIdx, stride);
	        int[] cIds = range(4, endIdx, stride);

	        int[] channelsPredIdx = range(0, (int) numChannelsPred, 1);
	        int[] nonClassIds = concatAll(xIds, yIds, wIds, hIds, cIds);
	        int[] classIds = setdiff(channelsPredIdx, nonClassIds);
	        int numClasses = classIds.length / numAnchors;

	        // Use Java arrays for predictions
	        float[][][] objArr = new float[(int)numTilesD1][(int)numTilesD2][numAnchors];
	        float[][][] xArr = new float[(int)numTilesD1][(int)numTilesD2][numAnchors];
	        float[][][] yArr = new float[(int)numTilesD1][(int)numTilesD2][numAnchors];
	        float[][][] wArr = new float[(int)numTilesD1][(int)numTilesD2][numAnchors];
	        float[][][] hArr = new float[(int)numTilesD1][(int)numTilesD2][numAnchors];
	        float[][][] classArr = new float[(int)numTilesD1][(int)numTilesD2][numAnchors * numClasses];

	        for (int dim1 = 0; dim1 < numTilesD1; dim1++) {
	            for (int dim2 = 0; dim2 < numTilesD2; dim2++) {
	                int nNewInd;
	                // x
	                nNewInd = 0;
	                for (int iAnch : xIds) {
	                    float v = head.get(new NDIndex(index + "," + dim1 + "," + dim2 + "," + iAnch)).toFloatArray()[0];
	                    xArr[dim1][dim2][nNewInd] = (float) Activation.sigmoid(manager.create(new float[]{v})).toFloatArray()[0];
	                    nNewInd++;
	                }
	                // y
	                nNewInd = 0;
	                for (int iAnch : yIds) {
	                    float v = head.get(new NDIndex(index + "," + dim1 + "," + dim2 + "," + iAnch)).toFloatArray()[0];
	                    yArr[dim1][dim2][nNewInd] = (float) Activation.sigmoid(manager.create(new float[]{v})).toFloatArray()[0];
	                    nNewInd++;
	                }
	                // w
	                nNewInd = 0;
	                for (int iAnch : wIds) {
	                    float v = head.get(new NDIndex(index + "," + dim1 + "," + dim2 + "," + iAnch)).toFloatArray()[0];
	                    wArr[dim1][dim2][nNewInd] = (float) Math.exp(v);
	                    nNewInd++;
	                }
	                // h
	                nNewInd = 0;
	                for (int iAnch : hIds) {
	                    float v = head.get(new NDIndex(index + "," + dim1 + "," + dim2 + "," + iAnch)).toFloatArray()[0];
	                    hArr[dim1][dim2][nNewInd] = (float) Math.exp(v);
	                    nNewInd++;
	                }
	                // obj
	                nNewInd = 0;
	                for (int iAnch : cIds) {
	                    float v = head.get(new NDIndex(index + "," + dim1 + "," + dim2 + "," + iAnch)).toFloatArray()[0];
	                    objArr[dim1][dim2][nNewInd] = (float) Activation.sigmoid(manager.create(new float[]{v})).toFloatArray()[0];
	                    nNewInd++;
	                }
	                // class
	                nNewInd = 0;
	                for (int iAnch : classIds) {
	                    float v = head.get(new NDIndex(index + "," + dim1 + "," + dim2 + "," + iAnch)).toFloatArray()[0];
	                    classArr[dim1][dim2][nNewInd] = (float) Activation.sigmoid(manager.create(new float[]{v})).toFloatArray()[0];
	                    nNewInd++;
	                }
	            }
	        }
	        List<NDArray> predictions = new ArrayList<>(6);
	        predictions.add(createFrom3DFloatArray(manager, objArr));
	        predictions.add(createFrom3DFloatArray(manager,xArr));
	        predictions.add(createFrom3DFloatArray(manager,yArr));
	        predictions.add(createFrom3DFloatArray(manager,wArr));
	        predictions.add(createFrom3DFloatArray(manager,hArr));
	        predictions.add(createFrom3DFloatArray(manager,classArr));
	        output.add(predictions);
	    }

	    // 2. Tile anchors and compute box coordinates and adjust  anchors with predictions
	    List<NDArray[]> tiledAnchors = new ArrayList<>(nDetHeads);
	    for (int idx = 0; idx < nDetHeads; idx++) {
	        int h = (int) output.get(idx).get(0).getShape().get(0);
	        int w = (int) output.get(idx).get(0).getShape().get(1);
	        int n = network.anchorBoxes.get(idx).length;
	        double[][] anchors = network.anchorBoxes.get(idx);

	        float[][][] gridX = new float[h][w][n];
	        float[][][] gridY = new float[h][w][n];
	        float[][][] anchorW = new float[h][w][n];
	        float[][][] anchorH = new float[h][w][n];

	        for (int dim1 = 0; dim1 < h; dim1++) {
	            for (int dim2 = 0; dim2 < w; dim2++) {
	                for (int iAnch = 0; iAnch < n; iAnch++) {
	                    double gx = dim2;
	                    double px = output.get(idx).get(1).getFloat(dim1, dim2, iAnch);
	                    gridX[dim1][dim2][iAnch] = (float) ((gx + px) / w);

	                    double gy = dim1;
	                    double py = output.get(idx).get(2).getFloat(dim1, dim2, iAnch);
	                    gridY[dim1][dim2][iAnch] = (float) ((gy + py) / h);

	                    double aw = anchors[iAnch][1];
	                    double pw = output.get(idx).get(3).getFloat(dim1, dim2, iAnch);
	                    anchorW[dim1][dim2][iAnch] = (float) ((aw * pw) / network.imShape.get(2));

	                    double ah = anchors[iAnch][0];
	                    double ph = output.get(idx).get(4).getFloat(dim1, dim2, iAnch);
	                    anchorH[dim1][dim2][iAnch] = (float) ((ah * ph) / network.imShape.get(1));
	                }
	            }
	        }

	        NDArray gridXNd = createFrom3DFloatArray(manager, gridX);
	        NDArray gridYNd = createFrom3DFloatArray(manager, gridY);
	        NDArray anchorWNd = createFrom3DFloatArray(manager, anchorW);
	        NDArray anchorHNd = createFrom3DFloatArray(manager, anchorH);

	        tiledAnchors.add(new NDArray[]{gridXNd, gridYNd, anchorWNd, anchorHNd});
	    }

		// 3. Flatten detections
		List<NDArray[]> detections = new ArrayList<>(nDetHeads);
		for (int idx = 0; idx < nDetHeads; idx++) {
			int h = (int) output.get(idx).get(0).getShape().get(0);
			int w = (int) output.get(idx).get(0).getShape().get(1);
			int n = network.anchorBoxes.get(idx).length;
			int numClasses = (int) (output.get(idx).get(5).getShape().get(2) / n);

			NDArray[] thisDet = new NDArray[6];
			thisDet[0] = output.get(idx).get(0).reshape(h * w * n); // obj
			thisDet[1] = tiledAnchors.get(idx)[0].reshape(h * w * n); // x
			thisDet[2] = tiledAnchors.get(idx)[1].reshape(h * w * n); // y
			thisDet[3] = tiledAnchors.get(idx)[2].reshape(h * w * n); // w
			thisDet[4] = tiledAnchors.get(idx)[3].reshape(h * w * n); // h

			if (numClasses > 1) {
				NDArray classPred = output.get(idx).get(5).reshape(h * w, numClasses, n).transpose(0, 2, 1);
				int h2 = (int) classPred.getShape().get(0);
				int w2 = (int) classPred.getShape().get(1);
				int n2 = (int) classPred.getShape().get(2);
				thisDet[5] = classPred.reshape(h2 * w2, n2);
			} else {
				thisDet[5] = output.get(idx).get(5).reshape(h * w * n);
			}
			detections.add(thisDet);
		}

		// 4. Concatenate detections from all heads
		NDArray[] ccdets = new NDArray[6];
		for (int i = 0; i < 6; i++) {
			List<NDArray> toConcat = new ArrayList<>();
			for (NDArray[] det : detections) toConcat.add(det[i]);
			ccdets[i] = NDArrays.concat(new NDList(toConcat), 0);
		}

		// 5. Class probabilities and indices
		NDArray classProbs, classIdx;
		if (ccdets[5].getShape().dimension() == 2) {
			classProbs = ccdets[5].max(new int[]{1});
			classIdx = ccdets[5].argMax(1);
		} else {
			classProbs = ccdets[5];
			classIdx = manager.zeros(classProbs.getShape());
		}
		ccdets[0] = ccdets[0].mul(classProbs);
		ccdets[5] = classIdx;

		// 7. Filter by score >= 0.5
		NDArray indKeep = ccdets[0].gte(thresh);
		float[] scorePred = ccdets[0].get(indKeep).toFloatArray();
		int nKeep = scorePred.length;
		
		
		if (nKeep==0) {
			// No detections above threshold
			YoloPostProcessorResult result = new YoloPostProcessorResult();
			result.bboxes = new double[0][0];
			result.scores = new float[0];
			result.classes = new float[0][0];
			return result;
		}	

		float[] xArr = ccdets[1].get(indKeep).toFloatArray();
		float[] yArr = ccdets[2].get(indKeep).toFloatArray();
		float[] wArr = ccdets[3].get(indKeep).toFloatArray();
		float[] hArr = ccdets[4].get(indKeep).toFloatArray();

		double[][] bboxesTmp = new double[nKeep][4];
		for (int i = 0; i < nKeep; i++) {
		    bboxesTmp[i][0] = xArr[i];
		    bboxesTmp[i][1] = yArr[i];
		    bboxesTmp[i][2] = wArr[i];
		    bboxesTmp[i][3] = hArr[i];
		}
		
		// iterate thorugh class array - the classes are in the last element of ccdets
		System.out.println("Number of boxes kept after thresholding: " + nKeep);
		float[][] classPredAll = new float[ccdets.length-5][];
		int n=0; 
		for (int i = 5; i< ccdets.length; i++) {
			classPredAll[n] = JamArr.longToFloat(ccdets[i].get(indKeep).toLongArray());
										
			n++;
		}
		
		
		//now we have the class prediction where each row in the array is all the prediction of a particular class for all boxes. 
		//Easier to have this as each row is all the class predicitons for a particular box so trnaspose the array.
		classPredAll = JamArr.transposeMatrix(classPredAll);

		
		// 8. Scale boxes to input image size
		double[] scale = new double[]{ network.imShape.get(2),  network.imShape.get(1),  network.imShape.get(2), network.imShape.get(1)};
		double[][] bboxTmpSc = new double[nKeep][4];
		for (int i = 0; i < nKeep; i++) {
			for (int j = 0; j < 4; j++) {
				bboxTmpSc[i][j] = bboxesTmp[i][j] * scale[j];
			}
			bboxTmpSc[i][0] = bboxTmpSc[i][0] - bboxTmpSc[i][2] / 2.0 + 0.5;
			bboxTmpSc[i][1] = bboxTmpSc[i][1] - bboxTmpSc[i][3] / 2.0 + 0.5;
			for (int j = 0; j < 4; j++) {
				if (bboxTmpSc[i][j] < 1) bboxTmpSc[i][j] = 1;
			}
		}

		// 9. Return result
		YoloPostProcessorResult result = new YoloPostProcessorResult();
		result.bboxes = bboxTmpSc;
		result.scores =  Arrays.copyOf(scorePred, nKeep);
		result.classes = classPredAll; 
		return result;
	}

	// --- Helper functions ---
	
	/**
	 * Create a range of integers from start to end with a specified step.
	 * 
	 * @param start the starting integer (inclusive)
	 * @param end   the ending integer (exclusive)
	 * @param step  the step size
	 * @return an array of integers in the specified range
	 */
	private static int[] range(int start, int end, int step) {
		List<Integer> list = new ArrayList<>();
		for (int i = start; i < end; i += step) list.add(i);
		return list.stream().mapToInt(i -> i).toArray();
	}
	
	/**
	 * Concatenate multiple integer arrays into a single array.
	 * 
	 * @param arrays the integer arrays to concatenate
	 * @return a single array containing all elements from the input arrays
	 */
	private static int[] concatAll(int[]... arrays) {
		return Arrays.stream(arrays).flatMapToInt(Arrays::stream).toArray();
	}
	
	/**
	 * Compute the set difference between two integer arrays.
	 * 
	 * @param a the first array
	 * @param b the second array
	 * @return an array containing elements in 'a' that are not in 'b'
	 */
	private static int[] setdiff(int[] a, int[] b) {
		Set<Integer> setB = new HashSet<>();
		for (int v : b) setB.add(v);
		return Arrays.stream(a).filter(v -> !setB.contains(v)).toArray();
	}

	/**
	 * Create an NDArray from a 3D float array.
	 * 
	 * @param manager the NDManager to create the NDArray
	 * @param arr     the 3D float array
	 * @return the created NDArray
	 */
	public static NDArray createFrom3DFloatArray(NDManager manager, float[][][] arr) {
	    int dim0 = arr.length;
	    int dim1 = arr[0].length;
	    int dim2 = arr[0][0].length;
	    float[] flat = new float[dim0 * dim1 * dim2];
	    int idx = 0;
	    for (int i = 0; i < dim0; i++) {
	        for (int j = 0; j < dim1; j++) {
	            for (int k = 0; k < dim2; k++) {
	                flat[idx++] = arr[i][j][k];
	            }
	        }
	    }
	    return manager.create(flat, new Shape(dim0, dim1, dim2));
	}
	
	
	/**
	 *  Network class (remains the same as defined in the previous response)
	 */
	public static class DeepAcousticsNetwork {
//	    int imLength;
//	    int[] inputImageSize; // [height, width, channels]
//	    int[] InputSize;      // [height, width, channels]
	    List<double[][]> anchorBoxes; // Each double[][] is numAnchors x 2 (e.g., [height, width])
	    Shape imShape;

//	    public Network(int imLength, int[] inputImageSize, int[] inputSize, List<double[][]> anchorBoxes) {
//	        this.imLength = imLength;
//	        this.inputImageSize = inputImageSize;
//	        this.InputSize = inputSize;
//	        this.anchorBoxes = anchorBoxes;
//	    }

		public DeepAcousticsNetwork(Shape imShape, List<double[][]> anchorBoxes) {
			this.anchorBoxes = anchorBoxes;
			this.imShape = imShape;
		}
	}


}
