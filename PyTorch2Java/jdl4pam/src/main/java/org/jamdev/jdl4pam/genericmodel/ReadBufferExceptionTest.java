package org.jamdev.jdl4pam.genericmodel;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.Random;

import ai.djl.Model;
import ai.djl.engine.Engine;
import ai.djl.inference.Predictor;
import ai.djl.ndarray.NDArray;
import ai.djl.ndarray.NDList;
import ai.djl.ndarray.NDManager;
import ai.djl.ndarray.types.DataType;
import ai.djl.ndarray.types.Shape;
import ai.djl.translate.Batchifier;
import ai.djl.translate.Translator;
import ai.djl.translate.TranslatorContext;


/**
 * A minimal reproducible example of a java.nio.ReadOnlyBufferException when trying to call a tensorflow classifier. 
 * 
 * @author Jamie Macaulay 
 */
public class ReadBufferExceptionTest {


	public static void main(String[] args) {

		String modelPath = "/Users/au671271/Desktop/model_lenet_dropout_input_conv_all/saved_model.pb";

		try {

			//load the Tensorflow model. 
			File file = new File(modelPath); 

			
			Model model = Model.newInstance(modelPath, "TensorFlow"); 

			Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)

			System.out.println(Engine.getAllEngines()); 

			System.out.println("Engine name before model load: " + Engine.getInstance().getEngineName());

			model.load(modelDir, "saved_model.pb");

			System.out.println("Engine name after model load: " + Engine.getInstance().getEngineName());
			System.out.println("Input: " + model.describeInput().values()); 
			System.out.println("Output: " + model.describeOutput().values()); 

			//create the predictor
			Translator<double[][], float[]>  translator = new Translator<double[][], float[]>() {   
				

				@Override
				public NDList processInput(TranslatorContext ctx, double[][] data) {
					//System.out.println("Hello: 1 " ); 
					NDManager manager = ctx.getNDManager();

					Shape shape = new Shape(1L, data.length, data[0].length, 1L); 

					System.out.println("NDArray shape: " + shape); 

					double[] specgramFlat = flattenDoubleArray(data); 

					NDArray array = manager.create(specgramFlat, shape).toType(DataType.FLOAT32, false); 
					//		NDArray array = manager.create(data); 

					System.out.println("NDArray size: " + array.size()); 

					return new NDList (array);
				}

				@Override
				public float[]  processOutput(TranslatorContext ctx, NDList list) {
					System.out.println("Predict " + list); 

					NDArray temp_arr = list.get(0);

					Number[] number = temp_arr.toArray(); 

					float[] results = new float[number.length]; 
					for (int i=0; i<number.length; i++) {
						results[i] = number[i].floatValue(); 
					}

					return results; 
				}

				@Override
				public Batchifier getBatchifier() {
					// The Batchifier describes how to combine a batch together
					// Stacking, the most common batchifier, takes N [X1, X2, ...] arrays to a single [N, X1, X2, ...] array
					return null;
				}
			};
			
            System.out.println("Engine name before prediciton: " + Engine.getInstance().getEngineName());
            
			Predictor<double[][], float[]> predictor = model.newPredictor(translator);
			
			
			//make some fake data for input
			double[][] data = makeDummySpectrogramd(40, 40); 

			Shape shape = new Shape(1L, 40, 40, 1L); 

			System.out.println("NDArray shape: " + shape); 
			
			//			NDArray array = manager.create(specgramFlat, shape); 
			model.getNDManager().create(data); 

			float[] output = predictor.predict(data); 

		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	
	/**
	 * Make a dummy spectrogram for testing. Filled with random values.  
	 * @param len - the length of the spectrogram in bins. 
	 * @param height - the height of the spectrgram in bins. 
	 * @return a dummy spectrogram with random values. 
	 */
	public static double[][] makeDummySpectrogramd(int len, int len2){

		//		int len = 256; 
		//		int len2 = 128; 

		double[][] specDummy = new double[len][len2]; 

		Random rand = new Random(); 
		for (int i=0; i<len; i++){
			for (int j=0; j<len2; j++) {
				specDummy[i][j] = 2F*(rand.nextFloat()-0.5F);

				if (specDummy[i][j]>1) {
					specDummy[i][j]=1F;
				}
				if (specDummy[i][j]<0) {
					specDummy[i][j]=0F;
				}
			}
		}
		return specDummy; 
	}
	

	/** 
	 * Convert an arbitrary-dimensional rectangular double array to flat vector.<br>
	 * Can pass double[], double[][], double[][][], etc.
	 */
	public static double[] flattenDoubleArray(Object doubleArray) {
		if (doubleArray instanceof double[])
			return (double[]) doubleArray;

		LinkedList<Object> stack = new LinkedList<>();
		stack.push(doubleArray);

		int[] shape = arrayShape(doubleArray);
		int length = prod(shape);
		double[] flat = new double[length];
		int count = 0;

		while (!stack.isEmpty()) {
			Object current = stack.pop();
			if (current instanceof double[]) {
				double[] arr = (double[]) current;
				for (int i = 0; i < arr.length; i++)
					flat[count++] = arr[i];
			} else if (current instanceof Object[]) {
				Object[] o = (Object[]) current;
				for (int i = o.length - 1; i >= 0; i--)
					stack.push(o[i]);
			} else
				throw new IllegalArgumentException("Base array is not double[]");
		}

		if (count != flat.length)
			throw new IllegalArgumentException("Fewer elements than expected. Array is ragged?");
		return flat;
	}
	
	/** Calculate the shape of an arbitrary multi-dimensional array. Assumes:<br>
	 * (a) array is rectangular (not ragged) and first elements (i.e., array[0][0][0]...) are non-null <br>
	 * (b) First elements have > 0 length. So array[0].length > 0, array[0][0].length > 0, etc.<br>
	 * Can pass any Java array opType: double[], Object[][][], float[][], etc.<br>
	 * Length of returned array is number of dimensions; returned[i] is size of ith dimension.
	 */
	public static int[] arrayShape(Object array) {
		int nDimensions = 0;
		Class<?> c = array.getClass().getComponentType();
		while (c != null) {
			nDimensions++;
			c = c.getComponentType();
		}


		int[] shape = new int[nDimensions];
		Object current = array;
		for (int i = 0; i < shape.length - 1; i++) {
			shape[i] = ((Object[]) current).length;
			current = ((Object[]) current)[0];
		}

		if (current instanceof Object[]) {
			shape[shape.length - 1] = ((Object[]) current).length;
		} else if (current instanceof double[]) {
			shape[shape.length - 1] = ((double[]) current).length;
		} else if (current instanceof float[]) {
			shape[shape.length - 1] = ((float[]) current).length;
		} else if (current instanceof long[]) {
			shape[shape.length - 1] = ((long[]) current).length;
		} else if (current instanceof int[]) {
			shape[shape.length - 1] = ((int[]) current).length;
		} else if (current instanceof byte[]) {
			shape[shape.length - 1] = ((byte[]) current).length;
		} else if (current instanceof char[]) {
			shape[shape.length - 1] = ((char[]) current).length;
		} else if (current instanceof boolean[]) {
			shape[shape.length - 1] = ((boolean[]) current).length;
		} else if (current instanceof short[]) {
			shape[shape.length - 1] = ((short[]) current).length;
		} else
			throw new IllegalStateException("Unknown array opType"); //Should never happen
		return shape;
	}

	

	/**
	 * Product of an int array
	 * @param mult the elements
	 *            to calculate the sum for
	 * @return the product of this array
	 */
	public static int prod(int... mult) {
		if (mult.length < 1)
			return 0;
		int ret = 1;
		for (int i = 0; i < mult.length; i++)
			ret *= mult[i];
		return ret;
	}


	
}
