package org.jamdev.jtorch4pam.transforms;


/**
 * Any transform of data. 
 * @author Jamie Macaulay 
 *
 */
public interface DLTransform {
	
	
	/**
	 * Type of waveform transform that are available. 
	 *  {@link #PREEMPHSIS}
	 *  {@link #DECIMATE}
	 *  {@link #TRIM}	 
	 *  
	 * Type of frequency transform that are available. 
	 * {@link #SPECTROGRAM}
	 * {@link #SPECCROPINTERP}
	 * {@link #SPECNORMALISE}
	 * {@link #SPEC2DB}
	 * 
	 * @author Jamie Macaulay
	 *
	 */
	public enum DLTransformType {
		
		/**
		 * Basic filter which reduces lower frequencies.
		 */
		PREEMPHSIS, 
		
		/**
		 * Decimates the signal to a high or lower amplitude including anti-aliasing filters. 
		 */
		DECIMATE, 
		
		/**
		 * Trims the acoustic data to new length.
		 */
		TRIM,
		

		/**
		 * Converts a waveform to a spectrogram
		 */
		SPECTROGRAM, 

		/**
		 * Crops a spectrogram image between two frequency values and interpolates the image to be
		 * a specified pixel size. 
		 */
		SPECCROPINTERP, 

		/**
		 * Normalises the spectrogram
		 */
		SPECNORMALISE, 

		/**
		 * Converts a spectrogram from linear to log10 units. 
		 */
		SPEC2DB,
		
		/**
		 * Clamps the spectrogram between two values.
		 */
		SPECCLAMP
	}	
	
	/**
	 * Transform the data to transform the data it holds. The data returns a reference to itself (which will now contains the transformed data)
	 */
	public DLTransform transformData(DLTransform transfrom); 
	
	
	/**
	 * Get the type of transform
	 * @return
	 */
	public DLTransformType getDLTransformType(); 

}
