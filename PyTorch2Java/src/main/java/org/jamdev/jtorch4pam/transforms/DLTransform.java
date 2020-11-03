package org.jamdev.jtorch4pam.transforms;


/**
 * Any transform of data. 
 * @author Jamie Macaulay 
 *
 */
public interface DLTransform {
	
	/**
	 * Transform the data to transform the data it holds. The data returns a reference to itself (which will now contains the transformed data)
	 */
	public DLTransform transformData(DLTransform transfrom); 

}
