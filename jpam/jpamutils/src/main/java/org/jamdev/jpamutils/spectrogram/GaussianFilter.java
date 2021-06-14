package org.jamdev.jpamutils.spectrogram;

/**
 * Kernel smoothing for the spectrogram. 
 * <p>
 * This is almost a carbon copy from PAMGuard (www.pamguard.org)
 * 
 * @author Jamie Macaulay
 */
public class GaussianFilter {

	private double kernel[][];
	private int nCol, nRow;
	private ChannelProcess[] channelProcesses;
	
	public GaussianFilter() {
		super();
		
		/*
		 * Create and normalise a standard Gaussian kernel. 
		 */
//		setKernel(new double[][] { { 1, 2, 1 }, { 2, 4, 2 }, { 1, 2, 1 } });
		setKernel(new double[][] { { 1, 1, 1 }, { 1, 1, 1 }, { 1, 1, 1 } });
//		setKernel(new double[][] { { 0, 0, 0 }, { 0, 1, 0 }, { 0, 0, 0 } });
		
		initialise(1); 
	}
	
	
	/**
	 * Generate the Kernel for a sigma value  
	 * @param sigma
	 * @return
	 */
	public double[][] generateKernal(double sigma) {
		int W = 5;
		double[][] kernel = new double[W][W];
		double mean = W/2;
		double sum = 0.0; // For accumulating the kernel values
		for (int x = 0; x < W; ++x) 
		    for (int y = 0; y < W; ++y) {
		        kernel[x][y] = Math.exp( -0.5 * (Math.pow((x-mean)/sigma, 2.0) + Math.pow((y-mean)/sigma,2.0)) )
		                         / (2 * Math.PI * sigma * sigma);

		        // Accumulate the kernel values
		        sum += kernel[x][y];
		    }

		// Normalize the kernel
		for (int x = 0; x < W; ++x) 
		    for (int y = 0; y < W; ++y)
		        kernel[x][y] /= sum;
		
		return kernel; 

	}
	
	public void setKernel(double[][] kernel) {
		this.kernel = kernel;
		nCol = kernel.length;
		nRow = kernel[0].length;
		normaliseKernel();
	}
	
	private void normaliseKernel() {
		double kt = 0;
		
		for (int i = 0; i < kernel.length; i++) {
			for (int j = 0; j < kernel[i].length; j++) {
				kt += kernel[i][j];
			}
		}
		for (int i = 0; i < kernel.length; i++) {
			for (int j = 0; j < kernel[i].length; j++) {
				kernel[i][j] /= kt;
			}
		}
	}

	/**
	 * Run the Gaussian filter on a spectrogram. Convenience function. This will 
	 * reset the current channel processes. 
	 * 
	 * @param complexArray - the spectrogram including the complex number. 
	 * @return the complex array out. 
	 */
	public ComplexArray[] runFilter(ComplexArray[] complexArray) {
		initialise(1); //make sure the array is initialised.
		
		for (int i=0; i<complexArray.length ; i++) {
			runNoiseReduction(complexArray[i]); 
		}
		
		return complexArray;
	}
	
	public String getDescription() {
		return "<html>The spectrogram is smoothed by convolving <p>"+
		             "the image with a Gaussian smoothing kernel e.g.<p>"+
		             " 1 2 1<p>" +
		             " 2 4 2<p>" +
		             " 1 2 1</html>";
	}

	/**
	 * Initialise the channelMap store
	 * @param channelMap - the channel map of expected input units. 
	 * @return the channel map. 
	 */
	public boolean initialise(int channelMap) {
		channelProcesses = new ChannelProcess[Integer.BYTES];
		for (int i = 0; i < channelProcesses.length; i++) {
			if ((channelMap & 1<<i) != 0) {
				channelProcesses[i] = new ChannelProcess();
			}
		}
		return true;
	}

	public boolean runNoiseReduction(ComplexArray fftDataUnit) {
//		int iChan = PamUtils.getSingleChannel(fftDataUnit.getChannelBitmap());
//		int iChan = PamUtils.getSingleChannel(fftDataUnit.getSequenceBitmap());
		return channelProcesses[0].run(fftDataUnit);
	}
	
	/**
	 * Run the noise reduction. 
	 * @param fftDataUnit - the FFT data unit. 
	 * @param sigma - the sigma value. 
	 * @return true if success. 
	 */
	public boolean runNoiseReduction(ComplexArray fftDataUnit, int sigma) {
//		int iChan = PamUtils.getSingleChannel(fftDataUnit.getChannelBitmap());
//		int iChan = PamUtils.getSingleChannel(fftDataUnit.getSequenceBitmap());
		return channelProcesses[0].run(fftDataUnit);
	}

	
	class ChannelProcess {
		
		private double[][] localStore;
		private ComplexArray[] localComplex;
		
		public ChannelProcess() {
			localStore = new double[nCol][];
			localComplex = new ComplexArray[nCol];
		}
		
		/**
		 * The kernel is made up of power data, and is used as a
		 * scaling factor on the FFT data so that FFT data phase is maintained. 
		 * @param complexArray FFT data to smooth.
		 * @param space - sigma in pixels units.
		 * @return true if OK.
		 */
		boolean run(ComplexArray complexArray) {
			/*
			 * Shuffle along old stores, then add the latest to the list end
			 * keeping old arrays so that they don't need to be reallocated. 
			 */
			int lastCol = nCol-1;
			double[] dummyStore = localStore[0];
			ComplexArray dummyComplex = localComplex[0];
			for (int iCol = 0; iCol < lastCol; iCol++) {
				localStore[iCol] = localStore[iCol+1];
				localComplex[iCol] = localComplex[iCol+1];
			}
			localStore[lastCol] = dummyStore;
			localComplex[lastCol] = dummyComplex;
			
			/*
			 * Data will have to be copied into the double arrays - so
			 * make the arrays a bit longer so that when the 
			 * convolution is run, there are enough spare zeros
			 * at the ends. 
			 */
//			
			int space = 1;
			
			int L = complexArray.length() + 2*space;
			if (localStore[lastCol] == null || localStore[lastCol].length != L) {
				localStore[lastCol] = new double[L];
			}
//			if (localComplex[lastCol] == null || localComplex[lastCol].length() != complexArray.length()) {
//				localComplex[lastCol] = new ComplexArray(complexArray.length());
//			}
			for (int i = 0; i < complexArray.length(); i++) {
				localStore[lastCol][i+space] = complexArray.magsq(i);
//				localComplex[lastCol][i].assign(complexArray[i]);
			}
			localComplex[lastCol] = complexArray.clone();
			
			/*
			 * If the first row is empty, then it's not possible
			 * to do the convolution, so just return. things will kick
			 * in when the arrays all fill up on the third call.  
			 */
			if (localStore[0] == null) {
				return false;
			}
			/*
			 * Now do the convolution for each point
			 */
			double dumTot;
			double cenVal;
			for (int i = 0; i < complexArray.length(); i++) {
				dumTot = 0;
				cenVal = localStore[1][i+space];
				for (int iCol = 0; iCol < nCol; iCol++) {
					for (int iRow = 0; iRow < nRow; iRow ++) {
						dumTot += localStore[iCol][iRow+i] * kernel[iCol][iRow];
					}
				}
				double f = Math.sqrt(dumTot / cenVal);
				complexArray.set(i, localComplex[1].getReal(i)*f, localComplex[1].getImag(i)*f); //= localComplex[1][i].times(Math.sqrt(dumTot / cenVal));
			}			
			
			return true;
		}
	}


}
