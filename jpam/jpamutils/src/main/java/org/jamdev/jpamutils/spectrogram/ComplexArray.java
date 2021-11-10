package org.jamdev.jpamutils.spectrogram;

import org.apache.commons.math3.complex.Complex;

public class ComplexArray extends ComplexArrayD implements Cloneable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	public ComplexArray(Complex[] complexArr) {
		super(complexArr);
	}

	public ComplexArray(double[] realData, double[] imagData) {
		super(realData, imagData);
	}

	public ComplexArray(double[] complexData) {
		super(complexData);
	}

	public ComplexArray(int n) {
		super(n);
	}



	/* (non-Javadoc)
	 * @see java.lang.Object#clone()
	 */
	@Override
	public ComplexArray clone() {
		ComplexArray newOne;
		try {
			newOne = (ComplexArray) super.clone();
			newOne.data = data.clone();
			return newOne;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}




}
