package org.jamdev.jpamutils;

import org.jamdev.jpamutils.wavFiles.WavInterpolator;
import org.junit.Test;

import static org.junit.jupiter.api.Assertions.*;
import static org.jamdev.jpamutils.wavFiles.Resample.fourierResample;
import static org.junit.Assert.assertTrue;

/**
 * Unit test for simple App.
 */
public class ResampleTest
{
    @Test
    public void fourierResampleEvenTargetNumberTest() {
        double eps = 1e-7;
        double[] arr_tmp = new double[32];
        for (int i = 0; i < arr_tmp.length; i++) {
            arr_tmp[i] = i;
        }
        double[] expectedResult = new double[] {12.5, 3.3532928, 11.06090023, 16.5, 19.93909977, 29.6467072};
        double[] result = fourierResample(arr_tmp, 6);

        assertArrayEquals(expectedResult, result, eps);

        // compare this with:
        // $ python
        // > from scipy import signal
        // > signal.resample(range(32), 6)
        // array([12.5, 3.3532928, 11.06090023, 16.5, 19.93909977, 29.6467072 ])
    }

    @Test
    public void fourierResampleOddTargetNumberTest() {
        double eps = 1e-7;
        double[] arr_tmp = new double[33];
        for (int i = 0; i < arr_tmp.length; i++) {
            arr_tmp[i] = i;
        }

//        double[] expectedResult = new double[] {44.,
//                3.1350700153,
//                32.8792753466,
//                35.7892745745,
//                57.8006770028,
//                63.1993229972,
//                85.2107254255,
//                88.1207246534,
//                117.8649299847};
        double[] expectedResult = new double[] {12.,
                0.8550190951,
                8.9670750945,
                9.7607112476,
                15.7638210008,
                17.2361789992,
                23.2392887524,
                24.0329249055,
                32.1449809049};
        double[] result = fourierResample(arr_tmp, 9);

        assertArrayEquals(expectedResult, result, eps);

    }
}
