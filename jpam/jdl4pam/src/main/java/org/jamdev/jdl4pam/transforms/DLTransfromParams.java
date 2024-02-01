package org.jamdev.jdl4pam.transforms;

import java.io.Serializable;

import org.jamdev.jdl4pam.transforms.DLTransform.DLTransformType;

/**
 * Parameters that can be saved for a transform.
 * @author Jamie Macaulay 
 *
 */
public class DLTransfromParams implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	/**
	 * The type of the transfrom; 
	 */
	public DLTransformType dltransfromType; 
	
	/**
	 * Basic params.
	 */
	public Number[] params; 
	
	@Override
	public boolean equals(Object o) {
		
		if (o==null) {
//			System.out.println("Simple transform not equal null ");
			return false; 
		}

		DLTransfromParams transform = (DLTransfromParams) o; 

		
		if (params ==null && transform.params!=null) {
			return false;
		}
		if (transform.params ==null && params!=null) {
			System.err.println(transform.params + "  " + params);

			return false;
		}

		if (params!=null) {

			if (params.length != transform.params.length) {
//				System.err.println("Simple transform not same length ");
				return false; 
			}

			for (int i=0; i<params.length; i++) {
				if (!params[i].equals(transform.params[i])) {
//					System.err.println("Simple transform not equal: " + i + "  " +  params[i] + "  " + transform.params[i]);
					return false;  
				}
			}
		}
		
		return dltransfromType.equals(transform.dltransfromType); 
	}
	
	

}
