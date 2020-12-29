package org.jamdev.jdl4pam.pytorch2Java;

import java.util.Arrays;

import org.pytorch.IValue;
import org.pytorch.Tensor;
import org.pytorch.Module;

/**
 * The Pytorch to Java tutorial from:
 * https://github.com/pytorch/java-demo
 * @author Jamie Macaulay
 *
 */
public class PyTorch2JavaTest {
	
	 public static void main(String[] args) {
		 
		 String modelpath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/BAT_4ms_256ft_8hop_128_NOISEAUG_40000_100000_-100_0_256000.pk";
//		 String modelpath = "/Users/au671271/Google Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/BAT_15_80_6ms_12hop_256fft.pk";
//		 String modelpath = "/Users/au671271/git/pytorch2java/PyTorch2Java/src/main/java/pytorch2Java/demo-model.pt1";
		 
		    Module mod = Module.load(modelpath);
		    Tensor data =
		        Tensor.fromBlob(
		            new int[] {1, 2, 3, 4, 5, 6}, // data
		            new long[] {2, 3} // shape
		            );
		    IValue result = mod.forward(IValue.from(data), IValue.from(3.0));
		    Tensor output = result.toTensor();
		    System.out.println("shape: " + Arrays.toString(output.shape()));
		    System.out.println("data: " + Arrays.toString(output.getDataAsFloatArray()));

		    // Workaround for https://github.com/facebookincubator/fbjni/issues/25
		    System.exit(0);
		  }
}
