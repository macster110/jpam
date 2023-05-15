package org.jamdev.jpamutils.wavFiles;

//https://gist.github.com/lichard49/a46b4afc9236ef7295425aba1a70774f
// make sure JTransforms-3.1-with-dependencies.jar is under lib/
// javac -Xlint:deprecation -cp .:lib/* *.java ; java -cp .:lib/* Resample

import edu.emory.mathcs.jtransforms.fft.DoubleFFT_1D;
import org.jamdev.jpamutils.spectrogram.Complex;
import org.jamdev.jpamutils.spectrogram.ComplexArray;
import org.jamdev.jpamutils.spectrogram.FastFFT;

public class Resample {

    /*
     * Resample an input signal to new number of samples using the Fourier method
     * Based on implementation from scipy.signal. Original does not work with odd length
     * https://github.com/scipy/scipy/blob/v1.3.0/scipy/signal/signaltools.py#L2162-L2290
     */
//    public static double[] fourierResample(double[] input, int targetNumSamples) {
//        // copy input signal because FFT is in-place
//        double[] inputCopy = new double[2*input.length];
//        System.arraycopy(input, 0, inputCopy, 0, input.length);
//
//        // perform FFT
//        DoubleFFT_1D fft = new DoubleFFT_1D(input.length);
//        fft.realForwardFull(inputCopy);
//
//        int n = Math.min(input.length, targetNumSamples);
//        double[] output = new double[2*targetNumSamples];
//        System.arraycopy(inputCopy, 0, output, 0, n);
//        System.arraycopy(inputCopy, inputCopy.length - n, output, output.length - n, n);
//
//        if (n % 2 == 0) {
//            // special treatment if low number of points is even. So far we have set Y[-N/2]=X[-N/2]
//            if (n < input.length) {
//                // if downsampling
//                output[n] += inputCopy[n]; // select the component at frequency N/2
//                output[n + 1] += inputCopy[n + 1]; // add the component of X at N/2
//            } else if (n < targetNumSamples) {
//                // if upsampling
//                output[targetNumSamples - n] /= 2; // halve the component at frequency N/2
//                output[targetNumSamples - n + 1] /= 2;
//                output[n] = output[targetNumSamples - n]; // set the component at -N/2 equal to the component at N/2
//                output[n + 1] = output[targetNumSamples - n + 1];
//            }
//        }
//
//        fft = new DoubleFFT_1D(output.length / 2);
//        fft.complexInverse(output, true);
//
//        double[] realOutput = new double[output.length / 2];
//        double realMultiplier = (double) targetNumSamples / input.length;
////        System.out.println(realMultiplier);
//        for (int i = 0; i < realOutput.length; i++) {
//            realOutput[i] = output[i * 2] * realMultiplier;
//        }
//
//        return realOutput;
//    }


    public static double[] fourierResample(double[] input, int targetNumSamples) {
        // copy input signal because FFT is in-place
        double[] inputCopy = new double[2*input.length];
        System.arraycopy(input, 0, inputCopy, 0, input.length);

        // perform FFT
        DoubleFFT_1D fft = new DoubleFFT_1D(input.length);
        fft.realForwardFull(inputCopy);

        // Compute number of samples to take if even or odd
        int n = Math.min(input.length, targetNumSamples);
        double[] output = new double[2*targetNumSamples];
        if (n%2 == 0){
            System.arraycopy(inputCopy, 0, output, 0, n);
            System.arraycopy(inputCopy, inputCopy.length - n, output, output.length - n, n);
        }
        else {
            int nyq = n / 2 + 1;
            System.arraycopy(inputCopy, 0, output, 0, n + 1);
            System.arraycopy(inputCopy, inputCopy.length - 2 * nyq + 2, output, output.length - 2 * nyq + 2, n - 1);
        }

        if (n % 2 == 0) {
            // special treatment if low number of points is even. So far we have set Y[-N/2]=X[-N/2]
            if (n < input.length) {
                // if downsampling
                output[n] += inputCopy[n]; // select the component at frequency N/2
                output[n + 1] += inputCopy[n + 1]; // add the component of X at N/2
            } else if (n < targetNumSamples) {
                // if upsampling
                output[targetNumSamples - n] /= 2; // halve the component at frequency N/2
                output[targetNumSamples - n + 1] /= 2;
                output[n] = output[targetNumSamples - n]; // set the component at -N/2 equal to the component at N/2
                output[n + 1] = output[targetNumSamples - n + 1];
            }
        }

        fft = new DoubleFFT_1D(output.length / 2);
        fft.complexInverse(output, true);

        double[] realOutput = new double[output.length / 2];
        double realMultiplier = (double) targetNumSamples / input.length;
//        System.out.println(realMultiplier);
        for (int i = 0; i < realOutput.length; i++) {
            realOutput[i] = output[i * 2] * realMultiplier;
        }

        return realOutput;
//
//        int fftSamps;
//        if (input.length%2 != 0){
//            fftSamps = input.length/2 + 1;
//        }
//        else {
//            fftSamps = input.length;
//        }
//
//        // copy input signal because FFT is in-place
//        double[] inputCopy = new double[2*input.length];
//        System.arraycopy(input, 0, inputCopy, 0, input.length);
//
//        // perform FFT
//        DoubleFFT_1D fft = new DoubleFFT_1D(input.length);
//        FastFFT fastFFT = new FastFFT();
//        ComplexArray complexSpectrogram;
////        ComplexArray complexSpectrogramFinal = new ComplexArray;
//
//        //Complex[] specData;
//        complexSpectrogram = fastFFT.rfftFull(input, input.length);
//        fastFFT.ifft(complexSpectrogram, targetNumSamples, true);
////        System.arraycopy(complexSpectrogram, 0, complexSpectrogramFinal, 0, 0);;
//
//		// Check some values. Same values for FFT and 1st/2nd audio segment
//		double[] realValFFT = new double[fftSamps];
//		for (int i = 0; i < realValFFT.length; i++) {
//			realValFFT[i] = inputCopy[i * 2];
//		}
//
////        int fftSamples = 0;
////        if (targetNumSamples%2 != 0){
////            fftSamples = targetNumSamples + 1;
////        }
////        else {
////            fftSamples = targetNumSamples;
////        }
//
////        int n = Math.min(input.length, fftSamples);
////        double[] output = new double[2*fftSamples];
//        int newshape = targetNumSamples / 2 + 1;
//        int n = Math.min(targetNumSamples, input.length);
//        int nyq = n / 2 + 1;
//        double[] Y = new double[2*newshape];
//
//        System.arraycopy(inputCopy, 0, Y, 0, nyq*2);
////        System.arraycopy(inputCopy, inputCopy.length - n, Y, Y.length - n, n);
//
//        if (n % 2 == 0) {
//            // special treatment if low number of points is even. So far we have set Y[-N/2]=X[-N/2]
//            if (n < input.length) {
//                // if downsampling
//                Y[n] += inputCopy[n]; // select the component at frequency N/2
//                Y[n + 1] += inputCopy[n + 1]; // add the component of X at N/2
//            } else if (n < targetNumSamples) {
//                // if upsampling
//                Y[targetNumSamples - n] /= 2; // halve the component at frequency N/2
//                Y[targetNumSamples - n + 1] /= 2;
//                Y[n] = Y[targetNumSamples - n]; // set the component at -N/2 equal to the component at N/2
//                Y[n + 1] = Y[targetNumSamples - n + 1];
//            }
//        }
//        fft = new DoubleFFT_1D(Y.length);
//        fft.realInverse(Y, true);
//
//
//		double[] realValBeforeScaling = new double[Y.length / 2];
//		for (int i = 0; i < realValBeforeScaling.length; i++) {
//			realValBeforeScaling[i] = Y[i * 2];
//		}
//
//        double[] realOutput = new double[Y.length];
//        double realMultiplier = (double) targetNumSamples / input.length;
////        System.out.println(realMultiplier);
//        for (int i = 0; i < realOutput.length; i++) {
//            realOutput[i] = Y[i * 2] * realMultiplier;
//        }
//
//        return realOutput;
    }


//    public static void main(String[] args) {
//        double[] a = new double[32];
//        for (int i = 0; i < a.length; i++) {
//            a[i] = i;
//        }
//
//        System.out.println(Arrays.toString(fourierResample(a, 6)));
//        // compare this with:
//        // $ python
//        // > from scipy import signal
//        // > signal.resample(range(32), 6)
//        // array([12.5, 3.3532928, 11.06090023, 16.5, 19.93909977, 29.6467072 ])
//    }
}
