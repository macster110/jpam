package org.jamdev.jpamutils.wavFiles;

/**
 * Filter for emphasising low frequencies.
 * 
 *  
 * @author Jamie Macaulay 
 *
 */
public class PreEmphasisFilter {
	
	/**
	 * Run a pre-emphasis filter on the data. This attenuates lower frequencies depending on factor. 
	 * @param data - the wave data
	 * @param factor - the attenuation factor between 0 and 1 e.g. 0.97
	 * @return the filtered data
	 */
	public double[] preEmphasis(double[] data, double factor) {
		
		double[] newData = new double[data.length];  
		newData[0] = data[0];
		for (int i =1; i<newData.length; i++) {
			newData[i]=data[i] -factor*data[i-1]; 
		}
		
		return data;
	}; 
	
	
	/**
	 * Run a pre-emphasis filter on the data. This attenuates lower frequencies depending on factor. 
	 * @param data - the wave data
	 * @param factor - the attenuation factor between 0 and 1 e.g. 0.97
	 * @return the filtered data
	 */
	public int[] preEmphasis(int[] data, double factor) {
		
		int[] newData = new int[data.length];  
		newData[0] = data[0];
		for (int i =1; i<newData.length; i++) {
			newData[i]=(int) (data[i] -factor*data[i-1]); 
		}
		
		return newData;
	}; 

}
