package org.jamdev.jpamutils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.TreeMap;

public class JamArr {


	/**
	 * Calculate the mean of one dimension within a list of points. <i>e.g.</i> the points might be a list of [x y z] co-ordinates in 
	 * which case the dim=0 would return the mean of all x points. 
	 * @param array - a list of points
	 * @param InitialtoIgnorePercentage: ignore the first percentage of results
	 * @param dim - the dimension of the point to calculate the average for
	 * @return the mean of one dimension of the list of the points. 
	 */
	public static double mean(ArrayList<double[]> array, double InitialtoIgnorePercentage, int dim){

		double meanTotal=0;
		int n=0;
		int forStart=(int) Math.round((InitialtoIgnorePercentage)*array.size());

		for (int i=forStart; i<array.size();i++){
			meanTotal+= array.get(i)[dim];
			n++;
		}

		//		 System.out.println("Array size: "+array.size()+ "  n size: "+ n);
		double mean=meanTotal/n;
		return mean;
	}

	/**
	 * Calculate the standard deviation of an array of doubles, ignoring an 'initialtoIgnorePercentage' percentage of jumps
	 * @param array
	 * @param initialtoIgnorePercentage- percentage of initial values to ignore.
	 * @return standard deviation of array. 
	 */
	public static double std(ArrayList<double[]> array, double initialtoIgnorePercentage, int dim){
		double std=0.0;

		int n=0;
		int forStart=(int) Math.round((initialtoIgnorePercentage)*array.size());

		double meanTotal= mean(array,  initialtoIgnorePercentage,  dim);

		//calculate standard deviation
		for (int k=forStart;k<array.size(); k++){
			std+=Math.pow((array.get(k)[dim]-meanTotal),2);
		}

		//standard deviation
		std=Math.sqrt(std/(n-1));

		return std;
	}

	/**
	 * Calculate the mean of an array of double values, ignoring an 'initialtoIgnorePercentage' percentage of jumps
	 * @param array of float values.
	 * @param InitialtoIgnorePercentage - the percentahe of results to ignore.
	 * @return mean of the array values
	 */
	public static Double mean(ArrayList<? extends Number> array, double InitialtoIgnorePercentage){

		double meanTotal=0;
		int n=0;
		int forStart=(int) Math.round((InitialtoIgnorePercentage)*array.size());

		for (int i=forStart; i<array.size();i++){
			meanTotal+= array.get(i).doubleValue();
			n++;
		}

		//		 System.out.println("Array size: "+array.size()+ "  n size: "+ n);
		double mean=meanTotal/n;
		return mean;
	}
	
	

	/**
	 * Calculate the standard deviation of an array of numbers, ignoring an 'initialtoIgnorePercentage' percentage of jumps
	 * @param array
	 * @param initialtoIgnorePercentage- percentage of initial values to ignore.
	 * @return standard deviation of array. 
	 */
	public static double std(ArrayList<? extends Number> array, double initialtoIgnorePercentage){
		double Std=0.0;
		double meanTotal=0.0;

		double stndDev;
		int n=0;
		int forStart=(int) Math.round((initialtoIgnorePercentage)*array.size());

		//work out the mean
		for (int i=forStart; i<array.size();i++){
			meanTotal+=array.get(i).doubleValue();
			n++;
		}
		meanTotal=meanTotal/n;

		//calculate standard deviation
		for (int k=forStart;k<array.size(); k++){
			Std+=Math.pow((array.get(k).doubleValue()-meanTotal),2);
		}

		//standard deviation
		stndDev=Math.sqrt(Std/(n-1));

		return stndDev;
	}

	/**
	 * Calculate the standard deviation of an array of float values, ignoring an 'initialtoIgnorePercentage' percentage of jumps
	 * @param array of float values.
	 * @return standard deviation of the array values. 
	 */
	public static double std(ArrayList<? extends Number> array){
		return std(array, 0);
	}

	/**
	 * Find the median of an ArrayList of doubles
	 * @param array the array to calculate the median for
	 * @param ignorePercentage the percentage of initial results on the array to ignore
	 * @return the median of the results whihc are not included in the ignorePercentage
	 */
	public static  double median(ArrayList<? extends Number> array, double ignorePercentage){
		ArrayList<Double> arrayMedian=new ArrayList<Double>();
		int forStart=(int) Math.round((ignorePercentage)*array.size());
		for (int i=forStart; i<array.size();i++){
			arrayMedian.add(array.get(i).doubleValue()); 
		}
		return median(arrayMedian); 
	}


	/**
	 * Find the median of an ArrayList of doubles
	 * @param array
	 * @return median of the array. 
	 */
	public static double median(ArrayList<? extends Number> array){
		int size=array.size();

		//this round about way of sorting is to stop 'sort' from sorting the matrices in the PreMarkovChain part.
		ArrayList<Double> zSort=new ArrayList<Double>();
		for (int i=0; i<array.size(); i++){
			zSort.add(array.get(i).doubleValue());
		}
		Collections.sort(zSort);

		double median=0;
		if (size%2==0){
			double n1=zSort.get(size/2);		
			double n2=zSort.get((size/2)-1);
			median=(n1+n2)/2;
		}
		else{
			median=zSort.get((int) ((size/2)-0.5));
		}
		return median;
	}

	/**
	 * Calculate the median value of an array 
	 * @param numArray - the number array 
	 * @return the median value. 
	 */
	public static double median(double[] numArray) {
		Arrays.sort(numArray);
		double median;
		if (numArray.length % 2 == 0)
			median = ((double)numArray[numArray.length/2] + (double) numArray[numArray.length/2 - 1])/2;
		else
			median = (double) numArray[numArray.length/2];

		return median;
	}


	/**
	 * Calculate the mean of an array of float values, ignoring an 'initialtoIgnorePercentage' percentage of jumps
	 * @param array of float values.
	 * @param InitialtoIgnorePercentage.
	 * @return mean of the array values.
	 */
	public static double meanf(ArrayList<Float> array, double initialtoIgnorePercentage){
		return mean(array, initialtoIgnorePercentage); 

		//		float MeanTotal=0;
		//		int n=0;
		//		int forStart=(int) Math.round((initialtoIgnorePercentage)*array.size());
		//
		//		for (int i=forStart; i<array.size();i++){
		//			MeanTotal+= array.get(i);
		//			n++;
		//		}
		//		double mean=MeanTotal/n;
		//
		//		return mean;
	}

	/**
	 * Calculate the standard deviation of an array of float values, ignoring an 'initialtoIgnorePercentage' percentage of jumps
	 * @param array of float values.
	 * @return standard deviation of the array values. 
	 */
	public static double stdf(ArrayList<Float> array){
		return stdf(array, 0);
	}


	/**
	 * Calculate the standard deviation of an array of float values, ignoring an 'initialtoIgnorePercentage' percentage of jumps
	 * @param array of float values.
	 * @param initialtoIgnorePercentage- percentage of initial values to ignore.
	 * @return standard deviation of the array values. 
	 */
	public static double stdf(ArrayList<Float> array, double initialToIgnorePercentage){
		return std(array, initialToIgnorePercentage); 
		//		double Std=0.0;
		//		float meanTotal=(float) 0.0;
		//		int forStart=(int) Math.round((initialToIgnorePercentage)*array.size());
		//
		//		double StandardDeviation;
		//		int n=0;
		//
		//		for (int i=forStart; i<array.size();i++){
		//			meanTotal+=array.get(i);
		//			n++;
		//		}
		//		meanTotal=meanTotal/n;
		//
		//		for (int k=forStart;k<array.size(); k++){
		//			Std+=Math.pow((array.get(k)-meanTotal),2);
		//		}
		//		StandardDeviation=Math.sqrt(Std/(n-1));
		//		return StandardDeviation;
	}

	/**
	 * Calculate the mean for a double[] array
	 * @param data array of doubles
	 * @return the mean of the array
	 */
	public static double mean(double[] data){
		double sum = 0.0;
		for(double a : data)
			sum += a;
		return  sum/data.length;
	}


	/**
	 * Calculate the mean for a int[] array
	 * @param data array of integers
	 * @return the mean of the array
	 */
	public static double mean(int[] data) {
		double sum = 0.0;
		for(int a : data)
			sum += a;
		return ((double) sum) /data.length;
	}


	/**
	 * Calculate the mean over all elements of a double[][] array. 
	 * @param data - 2D array of double
	 * @return the mean over all elements. 
	 */
	public static double mean(double[][] data) {
		return mean(data, -1)[0];
	}

	/**
	 * Calculate the mean of all rows or columns in a double[][] array.
	 * 
	 * @param data - 2D array of double - must not be a ragged array.
	 * @param dim  - which dimensions to average over. -1 averages across all
	 *             elements in the array. 0 averages rows and 1 averages columns.
	 * @return the mean values, a single value or the mean of all rows/columns
	 */
	public static double[] mean(double[][] data, int dim) {
		double[]  mean; 
		if (dim==0) {
			mean = new double[data.length]; 
			for (int i=0; i<data.length; i++) {
				mean[i] = mean(data[i]); 
			}
		}
		else if (dim==1) {

			mean = new double[data[0].length]; 

			double[] meanTemp; 
			for (int i=0; i<data[0].length; i++) {
				meanTemp = new double[data.length]; 
				for (int j=0; j<data.length; j++) {
					meanTemp[i] = data[j][i]; 
				}
				mean[i] = mean(meanTemp);
			}
		}
		else {
			double sum = 0.0;
			int count=0; 
			//average over whole array. 
			for (int i=0; i<data.length; i++) {
				for (int j=0; j<data[i].length; j++) {
					sum += data[i][j];
					count++; 
				}
			}
			mean = new double[1]; 
			mean[0]= sum/count; 
		}

		return mean;
	}

	/**
	 * Calculate the median of a double[][] array. Flattens the array and then takes the median 
	 * value of all elements. 
	 * 
	 * @param data - 2D array of double;
	 * @return the median value of all elements in the array, 
	 */
	public static double median(double[][] data) {
		return median(data, -1)[0]; 
	}


	/**
	 * Calculate the median of all rows or columns in a double[][] array.
	 * 
	 * @param data - 2D array of double - must not be a ragged array.
	 * @param dim  - which dimensions to average over. -1 calculates the median for
	 *             a flattened version of all elements in the array. 0 calculates
	 *             the median of rows and 1 calculates the median of columns.
	 * @return the mean values, a single value or the mean of all rows/columns
	 */
	public static double[] median(double[][] data, int dim) {
		double[]  median; 
		if (dim==0) {
			median = new double[data.length]; 
			for (int i=0; i<data.length; i++) {
				median[i] = median(data[i]); 
			}
		}
		else if (dim==1) {

			median = new double[data[0].length]; 

			double[] medianTemp; 
			for (int i=0; i<data[0].length; i++) {
				medianTemp = new double[data.length]; 
				for (int j=0; j<data.length; j++) {
					medianTemp[j] = data[j][i]; 
				}
				median[i] = median(medianTemp);
			}
		}
		else {
			//calculate median form flattened array 
			int count=0; 
			//average over whole array. 
			for (int i=0; i<data.length; i++) {
				count = count + data[i].length; 
			}

			double[] flatarray = new double[count]; 

			count =0; 

			for (int i=0; i<data.length; i++) {
				for (int j=0; j<data[i].length; j++) {
					flatarray[count]= data[i][j];
					count++; 
				}
			}

			median = new double[1]; 
			median[0]= median(flatarray); 
		}

		return median; 	
	}

	/**
	 * Calculate the standard deviation of an array, The standard deviaiton is computed for the flattened array. 
	 * @param data - the input array. 
	 * @return - the standard deviation. 
	 */
	public static double std(double[][] data) {
		return std(data, -1)[0]; 
	}


	/**
	 * Calculate the standard deviation of all rows or columns in a double[][] array.
	 * 
	 * @param data - 2D array of double - must not be a ragged array.
	 * @param dim  - which dimensions to average over. -1 calculates the standard deviation for
	 *             a flattened array. 0 calculates
	 *             the standard deviation of rows and 1 calculates the standard deviation of columns.
	 * @return the mean values, a single value or the mean of all rows/columns
	 */
	public static double[] std(double[][] data, int dim) {
		double[]  std; 
		if (dim==0) {
			std = new double[data.length]; 
			for (int i=0; i<data.length; i++) {
				std[i] = std(data[i]); 
			}
		}
		else if (dim==1) {

			std = new double[data[0].length]; 

			double[] stdTemp; 
			for (int i=0; i<data[0].length; i++) {
				stdTemp = new double[data.length]; 
				for (int j=0; j<data.length; j++) {
					stdTemp[i] = data[j][i]; 
				}
				std[i] = std(stdTemp);
			}
		}
		else {
			//calculate median form flattened array 
			int count=0; 
			//average over whole array. 
			for (int i=0; i<data.length; i++) {
				count = count + data[i].length; 
			}

			double[] flatarray = new double[count]; 

			count =0; 

			for (int i=0; i<data.length; i++) {
				for (int j=0; j<data[i].length; j++) {
					flatarray[count]= data[i][j];
					count++; 
				}
			}

			std = new double[1]; 
			std[0]= std(flatarray); 
		}

		return std; 	
	}

	/**
	 * Calculate the variance for a double[] array
	 * @param data array of doubles
	 * @return the variance
	 */
	public static double variance(double[] data)
	{
		double mean = mean(data);
		double temp = 0;
		for(double a :data)
			temp += (mean-a)*(mean-a);
		return temp/data.length;
	}

	/**
	 * Calculate the standard deviation for a double[] array
	 * @param data array of doubles
	 * @return the standard deviation
	 */
	public static double std(double[] data)
	{
		return Math.sqrt(variance(data));
	}
	
	/**
	 * Calculate the standard deviation for a double[] array
	 * @param data array of ints
	 * @return the standard deviation
	 */
	public static double std(int[] data){
		double[] arr = int2doubleArray(data); 
		return std(arr); 
	}
	
	/**
	 * Convert an integer array to a double array
	 * @param data - the int array to convert
	 * @return the same array but with doubles. 
	 */
	public static double[] int2doubleArray(int[] data) {
		double[] arr = new double[data.length];
		for (int i=0; i<data.length; i++) {
			arr[i] = data[i]; 
		}
		return arr;
	}

	//	/**
	//	 * Get the standard deviation for a 2D double array
	//	 * @param data - a 2D array of doubles
	//	 * @return std for each COLUMN
	//	 */
	//	public static double[] std(double[][] data){
	//		if (data.length<1) return null;
	//		double[] stdResults=new double[data[0].length]; 
	//		RealMatrix rm = new Array2DRowRealMatrix(data);	
	//		for (int i=0; i<data[0].length; i++){
	//			stdResults[i]=std(rm.getColumn(i)); 
	//		}
	//		return stdResults; 
	//	}


	/**
	 * Transpose a double[][] matrix
	 * @param m - the matrix transpose
	 * @return the transposed matrix
	 */
	public static double[][] transposeMatrix(double [][] m){
		double[][] temp = new double[m[0].length][m.length];
		for (int i = 0; i < m.length; i++)
			for (int j = 0; j < m[i].length; j++)
				temp[j][i] = m[i][j];
		return temp;
	}
	
	
	/**
	 * Transpose a float[][] matrix
	 * @param m - the matrix transpose
	 * @return the transposed matrix
	 */
	public static float[][] transposeMatrix(float [][] m){
		float[][] temp = new float[m[0].length][m.length];
		for (int i = 0; i < m.length; i++)
			for (int j = 0; j < m[i].length; j++)
				temp[j][i] = m[i][j];
		return temp;
	}



	/**
	 * Sorts and array and returns the index of the sorted elements of the array. 
	 * Handles duplicate values. 
	 * @param array - the array to sort
	 * @return an integer array showing the index of sorted elements from the original input array
	 */
	public static List<Integer> sort(ArrayList<? extends Number> array) {
		TreeMap<Object, List<Integer>> map = new TreeMap<Object, List<Integer>>();
		for(int i = 0; i < array.size(); i++) {
			List<Integer> ind = map.get(array.get(i));
			if(ind == null){
				ind = new ArrayList<Integer>();
				map.put(array.get(i), ind);
			}
			ind.add(i);
		}

		// Now flatten the list
		List<Integer> indices = new ArrayList<Integer>();
		for(List<Integer> arr : map.values()) {
			indices.addAll(arr);
		}

		return indices; 
	}

	/**
	 * Sort one array by the ordering of another array. This is a convenience function which sorts one array and then 
	 * uses the index of that sort to sort another array. The returned array is the sorted arrayToSort. Useful if sorting
	 * one ArrayList by another ArrayList 
	 * @param arrayOrdered - the array to sort by
	 * @param arrayToSort - the array to sort. Must be same size as arrayOrdered.
	 * @return the arrayToSort with elements sorted by the arrayOrdered. 
	 */
	public static <T> ArrayList<T> sort(ArrayList<? extends Number> arrayOrdered, ArrayList<T> arrayToSort) {
		List<Integer> indexSort = sort(arrayOrdered); 

		ArrayList<T> arraySorted = new ArrayList<T>(indexSort.size()); 
		//have to preallocate
		for (int i=0; i<indexSort.size(); i++) {
			arraySorted.add(arrayToSort.get(indexSort.get(i))); 
		}
		return arraySorted;
	}

	/**
	 * Calculate the difference between the minimum and maximum value of an array. 
	 * @param arr - the array to find the maximum value of. 
	 * @return the maximum value in the array
	 */
	public static double minmaxdiff(double[] arr) {
		double max = Double.NEGATIVE_INFINITY;
		double min = Double.POSITIVE_INFINITY;

		for(double cur: arr) {
			max = Math.max(max, cur);
			min = Math.min(min, cur);
		}

		return max-min;
	}

	/**
	 * Calculate the minimum and maximum value of an array. 
	 * @param arr - the array to find the maximum value of. 
	 * @return the minimum and maximum value in the array
	 */
	public static double[] minmax(double[] arr) {
		double max = Double.NEGATIVE_INFINITY;
		double min = Double.POSITIVE_INFINITY;

		for(double cur: arr) {
			if (!Double.isNaN(cur)) {
				max = Math.max(max, cur);
				min = Math.min(min, cur);
			}
		}

		return new double[] {min, max};
	}


	/**
	 * Calculate the minimum and maximum value of a 2D array. 
	 * @param arr - the array to find the maximum value of. 
	 * @return the minimum and maximum value in the array
	 */
	public static double[] minmax(double[][] arr) {
		double max = Double.NEGATIVE_INFINITY;
		double min = Double.POSITIVE_INFINITY;

		for(int i=0; i<arr.length; i++) {
			for(int j=0; j<arr[i].length; j++) {
				if (!Double.isNaN(arr[i][j])) {
					max = Math.max(max, arr[i][j]);
					min = Math.min(min, arr[i][j]);
				}
			}
		}

		return new double[] {min, max};
	}

	/**
	 * Calculate the minimum and maximum value of a 2D array. 
	 * @param arr - the array to find the maximum value of. 
	 * @return the minimum and maximum value in the array
	 */
	public static int[] minmax(int[][] arr) {
		int max = Integer.MAX_VALUE;
		int min = Integer.MIN_VALUE;
		for(int i=0; i<arr.length; i++) {
			for(int j=0; j<arr[i].length; j++) {
				max = Math.max(max, arr[i][j]);
				min = Math.min(min, arr[i][j]);
			}
		}

		return new int[] {min, max};
	}

	/**
	 * Calculate the maximum value in an array 
	 * @param arr - the array to find the maximum value of. 
	 * @return the maximum value in the array
	 */
	public static double max(double[] arr) {
		double max = Double.NEGATIVE_INFINITY;

		for(double cur: arr) {
			if (!Double.isNaN(cur)) {
				max = Math.max(max, cur);
			}
		}

		return max;
	}


	/**
	 * Calculate the maximum int value of a 2D int array. 
	 * @param arr - the array to find the maximum value of. 
	 * @return the minimum and maximum value in the array
	 */
	public static int max(int[][] arr) {
		int max = Integer.MIN_VALUE;

		for(int i=0; i<arr.length; i++) {
			for(int j=0; j<arr[i].length; j++) {
				max = Math.max(max, arr[i][j]);
			}
		}

		return max;
	}

	/**
	 * Calculate the  maximum double value of a 2D double array. 
	 * @param arr - the array to find the maximum value of. 
	 * @return the minimum and maximum value in the array
	 */
	public static double max(double[][] arr) {
		double max = Double.NEGATIVE_INFINITY;

		for(int i=0; i<arr.length; i++) {
			for(int j=0; j<arr[i].length; j++) {
				if (!Double.isNaN(arr[i][j])) {
					max = Math.max(max, arr[i][j]);
				}
			}
		}
		return max;
	}

	/**
	 * Calculate the maximum value in an array 
	 * @param arr - the array to find the maximum value of. 
	 * @return the maximum value in the array
	 */
	public static float max(float[] arr) {
		float max = Float.NEGATIVE_INFINITY;

		for(float cur: arr)
			max = Math.max(max, cur);

		return max;
	}

	/**
	 * Calculate the maximum value in an array 
	 * @param arr - the array to find the maximum value of. 
	 * @return the maximum value in the array
	 */
	public static int max(int[] arr) {
		int max = Integer.MIN_VALUE;

		for(int cur: arr)
			max = Math.max(max, cur);

		return max;
	}
	
	/**
	 * Calculate the index of the maximum value within an array
	 * @param arr - the array to find the maximum index of. 
	 * @return the position of the maximum value in the array. 
	 */
	public static int maxIndex(int[] arr) {
		int max = Integer.MIN_VALUE;
		int index =-1;
		for (int i=0; i<arr.length; i++) {
			if (max<arr[i]) {
				max=arr[i];
				index =i;
			}
		}

		return index;
	}
	
	
	
	/**
	 * Calculate the index of the minimum value within an array
	 * @param arr - the array to find the maximum index of. 
	 * @return the position of the maximum value in the array. 
	 */
	public static int minIndex(int[] arr) {
		int min = Integer.MAX_VALUE;
		int index =-1;
		for (int i=0; i<arr.length; i++) {
			if (min>arr[i]) {
				min=arr[i];
				index =i;
			}
		}

		return index;
	}
	
	
	/**
	 * Calculate the index of the maximum value within an array
	 * @param arr - the array to find the maximum index of. 
	 * @return the position of the maximum value in the array. 
	 */
	public static int maxIndex(double[] arr) {
		double max = Double.POSITIVE_INFINITY;
		int index =-1;
		for (int i=0; i<arr.length; i++) {
			if (max<arr[i]) {
				max=arr[i];
				index =i;
			}
		}

		return index;
	}
	
	
	
	
	/**
	 * Calculate the index of the minimum value within an array
	 * @param arr - the array to find the maximum index of. 
	 * @return the position of the maximum value in the array. 
	 */
	public static int minIndex(double[] arr) {
		double min = Double.NEGATIVE_INFINITY;
		int index =-1;
		for (int i=0; i<arr.length; i++) {
			if (min>arr[i]) {
				min=arr[i];
				index =i;
			}
		}

		return index;
	}
	
	/**
	 * Calculate the index of the maximum value within an array
	 * @param arr - the array to find the maximum index of. 
	 * @return the position of the maximum value in the array. 
	 */
	public static int maxIndex(float[] arr) {
		float max = Float.POSITIVE_INFINITY;
		int index =-1;
		for (int i=0; i<arr.length; i++) {
			if (max<arr[i]) {
				max=arr[i];
				index =i;
			}
		}

		return index;
	}
	
	
	
	
	/**
	 * Calculate the index of the minimum value within an array
	 * @param arr - the array to find the maximum index of. 
	 * @return the position of the maximum value in the array. 
	 */
	public static int minIndex(float[] arr) {
		float min = Float.NEGATIVE_INFINITY;
		int index =-1;
		for (int i=0; i<arr.length; i++) {
			if (min>arr[i]) {
				min=arr[i];
				index =i;
			}
		}

		return index;
	}


	/**
	 * Get the minimum value in an array 
	 * @param arr  - the array to find the minimu
	 * m value of. 
	 * @return the  minimum value in the array. 
	 */
	public static double min(double[] arr) {
		double min = Double.POSITIVE_INFINITY;

		for(double cur: arr) {
			if (!Double.isNaN(cur)) {
				min = Math.min(min, cur);
			}
		}

		return min;
	}
	
	

	/**
	 * Get the minimum value in an array 
	 * @param arr  - the array to find the minimum value of. 
	 * @return the  minimum value in the array. 
	 */
	public static int min(int[] arr) {
		int min = Integer.MAX_VALUE;

		for(int cur: arr) {
			min = Math.min(min, cur);
		}

		return min;
	}


	/**
	 * Calculate the minimum int value of a 2D int array. 
	 * @param arr - the array to find the maximum value of. 
	 * @return the minimum and maximum value in the array
	 */
	public static int min(int[][] arr) {
		int min = Integer.MAX_VALUE;

		for(int i=0; i<arr.length; i++) {
			for(int j=0; j<arr[i].length; j++) {
				min = Math.min(min, arr[i][j]);
			}
		}

		return min; 
	}


	/**
	 * Calculate the minimum double value of a 2D double array. 
	 * @param arr - the array to find the maximum value of. 
	 * @return the minimum and maximum value in the array
	 */
	public static double min(double[][] arr) {
		double min = Double.POSITIVE_INFINITY;

		for(int i=0; i<arr.length; i++) {
			for(int j=0; j<arr[i].length; j++) {
				if (!Double.isNaN(arr[i][j])) {
					min = Math.min(min, arr[i][j]);
				}
			}
		}

		return min; 
	}

	/**
	 * Normalise an array
	 * @param arr  - the array to normalise
	 * @return normalised copy of the array
	 */
	public static double[] normalise(double[] arr) {
		return normalise(arr, 1); 
	}


	/**
	 * Normalise an array
	 * @param arr  - the array to normalise
	 * @param scaleFactor - multiply the resulting array by a scale factor. 
	 * @return normalised copy of the array
	 */
	public static double[] normalise(double[] arr, double scaleFactor) {
		//		//first find the sum of the square of the wave
		if (arr != null) { 
			int n = arr.length; 
			double sum = 0.0; 

			for (int i = 0; i < n; i++) { 
				sum += arr[i] * arr[i]; 
			} 
			sum = Math.pow(sum, 0.5); 


			double[] normArr=new double[arr.length]; 
			for (int i=0; i<normArr.length; i++) {
				normArr[i]=scaleFactor*arr[i]/sum; 
			}
			return normArr; 
		}
		else return null; 


		//inp/((sum(inp.^2))^0.5);		

		//				double max=PamArrayUtils.max(arr);
		//				double[] normArr = new double[arr.length];
		//				for (int i=0; i<normArr.length; i++) {
		//					normArr[i]=arr[i]/max;
		//				}
		//				return normArr;		

	}

	//	/**
	//	 * Flip an array so that it is in the reverse order. Note the array is 
	//	 * cloned. 
	//	 * @param flipArray - the waveform to flip
	//	 * @return the array with elements reversed.
	//	 */
	//	public static double[] flip(double[] flipArray) {
	//		double[] clone=ArrayUtils.clone(flipArray); 
	//		ArrayUtils.reverse(clone);
	//		return clone; 
	//	}

	/**
	 * Square or raise the power all elements in an array 
	 * @param  array - the array 
	 * @param -exp - the exponent - set to 2 to take square of all elements. 
	 * @return array with all elements raised to the power of exp. 
	 */
	public static double[] pow(double[] array, double exp) {
		double[] arrExp = new double[array.length]; 
		for (int i=0; i<arrExp.length; i++) {
			arrExp[i]=Math.pow(array[i], exp); 
		}
		return arrExp;
	}


	/**
	 * Sum the elements in an array 
	 * @param  array - the array to sum.
	 * @return the summation of all the elements in the array.
	 */
	public static int sum(int[] array) {
		int sum=0; 
		for (int val:array) {
			sum+=val;
		}
		return sum;
	}


	/**
	 * Sum the elements in an array 
	 * @param  array - the array to sum.
	 * @return the summation of all the elements in the array.
	 */
	public static double sum(double[] array) {
		double sum=0; 
		for (double val:array) {
			sum+=val;
		}
		return sum;
	}


	/**
	 * Sum the elements in a 2D array.
	 * @param  array2 - the array to sum.
	 * @return the summation of all the elements in the array.
	 */
	public static double sum(double[][] array2) {
		double sum=0; 
		double[] array; 
		for (int i=0; i<array2.length; i++) {
			array = array2[i]; 
			for (double val:array) {
				sum+=val;
			}
		}
		return sum;
	}

	/**
	 * Print a double array to the console. 
	 * @param array to print
	 */
	public static void printArray(double[] array) {
		for (int i=0; i<array.length; i++) {
			System.out.println(i + ": " + array[i]);
		}
	}

	/**
	 * Print an int array to the console. 
	 * @param array to print
	 */
	public static void printArray(int[] array) {
		for (int i=0; i<array.length; i++) {
			System.out.println(i + ": " + array[i]);
		}
	}
	
	/**
	 * Print a float array to the console. 
	 * @param array to print
	 */
	public static void printArray(float[] array) {
		for (int i=0; i<array.length; i++) {
			System.out.println(i + ": " + array[i]);
		}
	}

	/**
	 * Print a 2D double array
	 * @param array - the array 
	 */
	public static void printArray(double[][] array) {
		for (int j=0; j<array.length; j++) {
			System.out.println("");
			for (int i=0; i<array[j].length; i++) {
				System.out.print(array[j][i] + " : ");
			}
		}
		System.out.println("");
	}



	/**
	 * Print a 2D int array
	 * @param array - the array 
	 */
	public static void printArray(int[][] array) {
		for (int j=0; j<array.length; j++) {
			System.out.println("");
			for (int i=0; i<array[j].length; i++) {
				System.out.print(array[j][i] + " : ");
			}
		}
		System.out.println("");
	}


	/**
	 * Convert a list to a primitive double array. 
	 * @param listArray - the list. 
	 * @return the primitive double. 
	 */
	public static double[] list2ArrayD(List<Double> listArray)  {
		double[] array = new double[listArray.size()];
		for (int i=0; i<listArray.size() ;i++) {
			array[i]=listArray.get(i).doubleValue(); 
		}
		return array;
	}

	/**
	 * Check whether there are duplicates within an array
	 * @param the array.
	 * @return true if there are duplicates. 
	 */
	public static boolean unique(double[] array) {
		boolean duplicates=false;
		for (int j=0;j<array.length;j++)
			for (int k=j+1;k<array.length;k++)
				if (k!=j && array[k] == array[j])
					duplicates=true;
		return duplicates;
	}

	/**
	 * Divide each element in an array by a number. 
	 * @param array - the array to divide. 
	 * @param divisor - the number to divide by. 
	 * @return an array with all elements divided by divisor.
	 */
	public static double[] divide(double[] array, double divisor) {
		double[] arrayD = new double[array.length]; 
		for (int j=0;j<array.length;j++) {
			arrayD[j]=array[j]/divisor; 
		}
		return arrayD;
	}


	/**
	 * Create a new array where a constant is divided by each element in an array 
	 * @param array - the array to divide. 
	 * @param b - the number that is divided
	 * @return an array were b is divided by all elements in the array. 
	 */
	public static double[] divide(double b, double[] array) {
		double[] arrayD = new double[array.length]; 
		for (int j=0;j<array.length;j++) {
			arrayD[j]=b/array[j]; 
		}
		return arrayD;
	}
	
	public static double[] divide(int[] array, int divisor) {
		double[] arrayD = new double[array.length]; 
		for (int j=0;j<array.length;j++) {
			arrayD[j]=(double) array[j]/(double) divisor; 
		}
		return arrayD;
	}


	/**
	 * Divide each element in a 2D array by a number
	   @param array - the array to divide. 
	 * @param divisor - the number to divide by. 
	 * @return a new array with all elements divided by divisor.
	 */
	public static double[][] divide(double[][] array, double divisor) {
		double[][] arrayD = new double[array.length][]; 
		//this method works on ragged arrays 
		for (int j=0;j<array.length;j++) {
			arrayD[j]=divide(array[j], divisor); 
		}
		return arrayD;
	}

	/**
	 * Divide each element in a 2D array by a number
	   @param array - the array to divide. 
	 * @param divisor - the number to divide by. 
	 * @return a new array with all elements divided by divisor.
	 */
	public static double[][] divide(double divisor, double[][] array) {
		double[][] arrayD = new double[array.length][]; 
		//this method works on ragged arrays 
		for (int j=0;j<array.length;j++) {
			arrayD[j]=divide(divisor, array[j]); 
		}
		return arrayD;
	}

	/**
	 * Convert an array to a  delimited string. 
	 * @param array - the input array to convert to a string
	 * @param decimalplaces - the number of decimal places to save as characters. More means a longer string. 
	 * @param delimitter - the delimiter e.g. ",". 
	 * @return the input array. 
	 */
	public static String array2String(float[] array, int decimalPlaces, String delimiter) {
		String outArray = ""; 
		for (int i=0; i<array.length; i++) {
			outArray+=String.format("%.2" + decimalPlaces + "f", array[i]) ;
			if (i<array.length-1) outArray+=","; 
		}
		return outArray;
	}

	/**
	 * Convert an array to a  delimited string. 
	 * @param array - the input array to convert to a string
	 * @param decimalplaces - the number of decimal places to save as characters. More means a longer string. 
	 * @param delimitter - the delimiter e.g. ",". 
	 * @return the input array. 
	 */
	public static String array2String(double[] array, int decimalPlaces, String delimiter) {
		String outArray = ""; 
		for (int i=0; i<array.length; i++) {
			outArray+=String.format("%.2" + decimalPlaces + "f", array[i]) ;
			if (i<array.length-1) outArray+=","; 
		}
		return outArray;
	}

	/**
	 * Convert an array to a  delimited string. 
	 * @param array - the input array to convert to a string
	 * @param decimalplaces - the number of decimal places to save as characters. More means a longer string. 
	 * @param delimitter - the delimiter e.g. ",". 
	 * @return the input array. 
	 */
	public static String array2String(Number[] array, int decimalPlaces, String delimiter) {
		String outArray = ""; 
		for (int i=0; i<array.length; i++) {
			outArray+=String.format("%.2" + decimalPlaces + "f", array[i]) ;
			if (i<array.length-1) outArray+=","; 
		}
		return outArray;
	}


	/**
	 * Convert a delimited string array to a double array. 
	 * @param array - the input string containing the number array. 
	 * @param delimitter - the delimiter e.g. ",". 
	 * @return the input array.
	 */
	public static double[] string2array(String array, String delimitter) {
		String[] strArray = array.split(delimitter); 
		double[] outArray = new double[strArray.length]; 
		for (int i=0; i<strArray.length; i++) {
			outArray[i]=Double.valueOf(strArray[i]);
		}
		return outArray;
	}

	/**
	 * Convert an array to a comma delimited string. 
	 * @param array - the input array to convert to a string
	 * @param decimalplaces - the number of decimal places to save as characters. More means a longer string. 
	 * @return the input array. 
	 */
	public static String array2String(double[] array, int decimalPlaces) {
		return array2String(array,  decimalPlaces, ","); 
	}

	/**
	 * Convert a comma delimited string array to a double array. 
	 * @param array - the input string containing the number array. 
	 * @return the input array.
	 */
	public static double[] string2array(String array) {
		return string2array(array, ",");
	}

	/**
	 * Check whether there is a single true value in a boolean array. 
	 * @param boolArray - any array of booleans. 
	 * @return true if there is at least one true in the array. 
	 */
	public static boolean isATrue(boolean[] boolArray) {
		for (int i=0; i<boolArray.length; i++) {
			if (boolArray[i]) return true; 
		}
		return false;
	}

	/**
	 * Check whether an array contains a number. 
	 * @param arr - the array. 
	 * @param num - the number to check. 
	 * @return true if the number is contained within the array, 
	 */
	public static boolean contains(int[] arr, int num) {
		for (int i=0; i<arr.length; i++) {
			if (arr[i]== num) return true; 
		}

		return false;
	}


	/**
	 * Subtract two array from each other. 
	 * @param a - the first array. 
	 * @param b - the second array. Must be the same length as a
	 * @return elements in a minus elements in b. 
	 */
	public static double[] subtract(double[] a, double[] b) {
		double[] output = new double[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] - b[i]; 
		}
		return output;
	}

	/**
	 * Subtract a number from an array. 
	 * @param a - the first array. 
	 * @param b - the number to subtract from all elements in a.
	 * @return elements in a minus b. 
	 */
	public static double[] subtract(double[] a, double b) {
		double[] output = new double[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] - b; 
		}
		return output;
	}

	/**
	 * Subtract a number from a 2D array. 
	 * @param img - the array. 
	 * @param b - the number to subtract from all elements in a.
	 * @return elements in img minus b. 
	 */
	public static double[][] subtract(double[][] img, double b) {
		double[][] output = new double[img.length][]; 

		double[] temp; 
		for (int i=0; i<img.length; i++) {
			temp = new double[img[i].length]; 
			for (int j=0; j<img[i].length; j++) {
				temp[j] = img[i][j]-b; 
			}
			output[i]=temp; 
		}
		return output;
	}


	/**
	 * Add two arrays together
	 * @param a - the first array. 
	 * @param b - the second array. Must be the same length as a
	 * @return elements in a plus elements in b. 
	 */
	public static double[] add(double[] a, double[] b) {
		double[] output = new double[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] + b[i]; 
		}
		return output;
	}

	/**
	 * Subtract a number from an array. 
	 * @param a - the first array. 
	 * @param b - the number to add to all elements in a.
	 * @return elements in a plus b. 
	 */
	public static double[] add(double[] a, double b) {
		double[] output = new double[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] + b; 
		}
		return output;
	}


	/**
	 * Add a number to a 2D array. 
	 * @param img - the array. 
	 * @param b - the number to add to elements.
	 * @return elements in  img plus b. 
	 */
	public static double[][] add(double[][] img, double b) {
		double[][] output = new double[img.length][]; 

		double[] temp; 
		for (int i=0; i<img.length; i++) {
			temp = new double[img[i].length]; 
			for (int j=0; j<img[i].length; j++) {
				temp[j] = img[i][j]+b; 
			}
			output[i]=temp; 
		}
		return output;
	}

	/**
	/**
	 * Multiply two arrays together
	 * @param a - the first array. 
	 * @param b - the second array. Must be the same length as a
	 * @return elements in a multiplied by elements in b. 
	 */
	public static double[] product(double[] a, double[] b) {
		double[] output = new double[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] * b[i]; 
		}
		return output;
	}

	/**
	 * Multiply an array by a number. 
	 * @param a - the first array. 
	 * @param b - the number to add to all elements in a.
	 * @return elements in a multiplied by b. 
	 */
	public static double[] product(double[] a, double b) {
		double[] output = new double[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] * b; 
		}
		return output;
	}


	/**
	 * Subtract two array from each other. 
	 * @param a - the first array. 
	 * @param b - the second array. Must be the same length as a
	 * @return elements in a minus elements in b. 
	 */
	public static int[] subtract(int[] a, int[] b) {
		int[] output = new int[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] - b[i]; 
		}
		return output;
	}

	/**
	 * Subtract a number from an array. 
	 * @param a - the first array. 
	 * @param b - the number to subtract from all elements in a.
	 * @return elements in a minus b. 
	 */
	public static int[] subtract(int[] a, int b) {
		int[] output = new int[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] - b; 
		}
		return output;
	}



	/**
	 * Add two arrays together
	 * @param a - the first array. 
	 * @param b - the second array. Must be the same length as a
	 * @return elements in a plus elements in b. 
	 */
	public static int[] add(int[] a, int[] b) {
		int[] output = new int[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] + b[i]; 
		}
		return output;
	}

	/**
	 * Subtract a number from an array. 
	 * @param a - the first array. 
	 * @param b - the number to add to all elements in a.
	 * @return elements in a plus b. 
	 */
	public static int[] add(int[] a, int b) {
		int[] output = new int[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] + b; 
		}
		return output;
	}



	/**
	 * Multiply two arrays together
	 * @param a - the first array. 
	 * @param b - the second array. Must be the same length as a
	 * @return elements in a multiplied by elements in b. 
	 */
	public static int[] product(int[] a, int[] b) {
		int[] output = new int[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] * b[i]; 
		}
		return output;
	}

	/**
	 * Multiply an array by a number. 
	 * @param a - the first array. 
	 * @param b - the number to add to all elements in a.
	 * @return elements in a multiplied by b. 
	 */
	public static int[] product(int[] a, int b) {
		int[] output = new int[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] * b; 
		}
		return output;
	}

	/**
	 * Multiply an array by a number. 
	 * @param a - the first array. 
	 * @param b - the number to add to all elements in a.
	 * @return elements in a multiplied by b. 
	 */
	public static double[] product(int[] a, double b) {
		double[] output = new double[a.length]; 
		for (int i=0; i<a.length; i++) {
			output[i] = a[i] * b; 
		}
		return output;
	}

	/**
	 * Multiple a 2D array by a number;  
	 * @param a - the array. 
	 * @param b - the number to multiply all elements by.
	 * @return the array multiplied by b. 
	 */
	public static double[][] product(double[][] img, double b) {
		double[][] output = new double[img.length][]; 

		double[] temp; 
		for (int i=0; i<img.length; i++) {
			temp = new double[img[i].length]; 
			for (int j=0; j<img[i].length; j++) {
				temp[j] = img[i][j]*b; 
			}
			output[i]=temp; 
		}
		return output;
	}


	/**
	 * Take the exponential of every element in a 2D array
	 * @param img - the array 
	 * @return a new array with the exponent of every element
	 */
	public static double[][] exp(double[][] img) {
		double[][] output = new double[img.length][]; 

		double[] temp; 
		for (int i=0; i<img.length; i++) {
			temp = new double[img[i].length]; 
			for (int j=0; j<img[i].length; j++) {
				temp[j] = Math.exp(img[i][j]); 
			}
			output[i]=temp; 
		}
		return output;

	}

	/**
	 * Multiply two images together, 
	 * @param img1 - the img.
	 * @param img2 - the scaling.
	 * @return - the product of the two matrices. 
	 */
	public static double[][] product(double[][] img1, double[][] img2) {
		double[][] output = new double[img1.length][]; 

		double[] temp; 
		for (int i=0; i<img1.length; i++) {
			temp = new double[img1[i].length]; 
			for (int j=0; j<img1[i].length; j++) {
				temp[j] = img1[i][j]*img2[i][j]; 
			}
			output[i]=temp; 
		}

		return output; 
	}


	/**
	 *  Shuffle an array according to the given order of elements
	 * @param arr - the input array to shuffle 
	 * @param pos - the index array. 
	 */
	public static int[] rearrange(int[] arr, int[] pos){
		// create an auxiliary array of size `n`
		int[] aux = new int[arr.length];

		// fill the auxiliary array with the correct order of elements
		for (int i = 0; i < arr.length; i++) {
			aux[pos[i]] = arr[i];
		}
		return aux; 
	}



	/**
	 *  Shuffle an array according to the given order of elements
	 * @param arr - the input array to shuffle 
	 * @param pos - the index array. 
	 */    
	public static double[] rearrange(double[] arr, int[] pos){
		// create an auxiliary array of size `n`
		double[] aux = new double[arr.length];

		// fill the auxiliary array with the correct order of elements
		for (int i = 0; i < arr.length; i++) {
			aux[pos[i]] = arr[i];
		}
		return aux; 
	}


	/**
	 *  Shuffle an array according to the given order of elements
	 * @param arr - the input array to shuffle 
	 * @param pos - the index array. 
	 */    
	public static float[] rearrange(float[] arr, int[] pos){
		// create an auxiliary array of size `n`
		float[] aux = new float[arr.length];

		// fill the auxiliary array with the correct order of elements
		for (int i = 0; i < arr.length; i++) {
			aux[pos[i]] = arr[i];
		}
		return aux; 
	}


	/**
	 *  Shuffle a string array according to the given order of elements
	 * @param arr - the input array to shuffle 
	 * @param pos - the index array. 
	 */    
	public static String[] rearrange(String[] arr, int[] pos){
		// create an auxiliary array of size `n`
		String[] aux = new String[arr.length];

		// fill the auxiliary array with the correct order of elements
		for (int i = 0; i < arr.length; i++) {
			aux[pos[i]] = arr[i];
		}
		return aux; 
	}

	/**
	 * Convert a 2D double array to a float array. 
	 * @param arrayd - the double array to convert. 
	 * @return the float array equivalent. 
	 */
	public static float[][] doubleToFloat(double[][] arrayd) {
		float[][] outF = new float[arrayd.length][]; 
		float[] temp;
		for (int i=0; i<arrayd.length; i++) {
			temp = new float[arrayd[i].length]; 
			for (int j=0; j<arrayd[i].length; j++) {
				temp[j] = (float) arrayd[i][j]; 
			}
			outF[i]=temp;
		}
		return outF;
	}
	


	
	/**
	 * Convert a 2D float array to a double array. 
	 * @param arrayd - the float array to convert. 
	 * @return the double array equivalent. 
	 */
	public static double[][] floatToDouble(float[][] arrayd) {
		double[][] outD = new double[arrayd.length][]; 
		double[] temp;
		for (int i=0; i<arrayd.length; i++) {
			temp = new double[arrayd[i].length]; 
			for (int j=0; j<arrayd[i].length; j++) {
				temp[j] = (double) arrayd[i][j]; 
			}
			outD[i]=temp;
		}
		return outD;
	}
	
	/**
	 * Cast all values in a double array to an integer. 
	 * @param arrayd - the array cast to integers. 
	 * @return an array of integers. 
	 */
	public static int[] double2Int(double[] arrayd) {
		int[] outInt = new int[arrayd.length]; 
		for (int i=0; i<arrayd.length; i++) {
			outInt[i]=(int) arrayd[i];
		}
		return outInt;
	}
	
	
	/**
	 * Convert a float array to a double array. 
	 * @param arrd - the double array
	 * @return a double array containing the same numbers as arrf. 
	 */
	public static float[] doubleToFloat(double[] arrd) {
		float[] arr = new float[arrd.length]; 
		for (int i=0; i<arr.length; i++) {
			arr[i] = (float) arrd[i]; 
		}
		return arr;
	}
	
	
	/**
	 * Convert a long array to a float array. 
	 * @param arrd - the long array
	 * @return a double array containing the same numbers as arrf. 
	 */
	public static float[] longToFloat(long[] arrd) {
		float[] arr = new float[arrd.length]; 
		for (int i=0; i<arr.length; i++) {
			arr[i] = (float) arrd[i]; 
		}
		return arr;
	}
	


	




}
