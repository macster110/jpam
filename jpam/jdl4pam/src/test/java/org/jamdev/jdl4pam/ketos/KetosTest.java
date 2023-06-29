package org.jamdev.jdl4pam.ketos;

import org.jamdev.jdl4pam.ketos.KetosAudioProcess.KetosResult;
import org.jamdev.jdl4pam.utils.DLUtils;
import org.jamdev.jpamutils.wavFiles.AudioData;
import org.junit.Test;

import static org.jamdev.jdl4pam.utils.DLUtils.numSamplesKetos;
import static org.jamdev.jpamutils.wavFiles.AudioData.pad_zero;
import static org.jamdev.jpamutils.wavFiles.AudioData.pad_reflect;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import com.github.psambit9791.jdsp.windows.*;

import ai.djl.MalformedModelException;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.sound.sampled.UnsupportedAudioFileException;

/**
 * Test the Ketos models and algorthms. . 
 *
 * @author Jamie Macaulay 
 *
 */
public class KetosTest {
	
//	/**
//	 * Test a model which required quite a few alterations to sort out. This particular model is quite overtained and 
//	 * so an excellent test case at it will respond to very small changes in the transforms. 
//	 * <p>
//	 * Note: this is base don old JSON recipe format
//	 */
//	@Test
//	public void KetosRightWhale2() {
//		
//		//relative paths to the resource folders.
//    	String relModelPath  =	"./src/main/java/org/jamdev/jdl4pam/resources/generic/rightwhale/model_lenet_dropout_input_conv_all/saved_model.pb";
//		String relWavPath  =	"./src/main/java/org/jamdev/jdl4pam/resources/generic/rightwhale/sar98_trk3_8000.wav";
//		
//		Path path = Paths.get(relModelPath);
//		//note that normalize gets rid of all the redundant elements (e.g. .)
//		String modelPath = path.toAbsolutePath().normalize().toString();
//		
//		path = Paths.get(relWavPath);
//		String wavFilePath = path.toAbsolutePath().normalize().toString();
//
//       
//		//set the sizxe of the chunk - note this uses the specific segment size required by Ketos models. 
//		double[] chunk = new double[]{44.9843, 50.05290000000001}; 
//
//		KetosModelTest.simpleModelTest(modelPath, wavFilePath, null); 
//		
//        assertTrue(chunk[0] > 0.8);
//
//    }
	
	/**
	 * Test batch processing a sound file using a Ketos model
	 * <p>
	 * Note: this is base don old JSON recipe format
	 */
	@Test
	public void KetosRightWhaleTestBatch() {
		
		/**
		 * List of the predicitons
		 * Start time (seconds), Length of the segment (seconds), prediciton
		 */
		double[][] ketosPredicitons = {
				{0,	5.0176,	0.1565524},
				{5,	5.0176,	0.99999917},
				{10,	5.0176,	0.99999917},
				{15, 5.0176,	0.97594243},
				{20,	5.0176,	0.8802458},
				{25,	5.0176,	0.9999999},
				{30,	5.0176,	0.999993},
				{35,	5.0176,	0.9998863},
				{40,	5.0176,	0.99998367},
				{45,	5.0176,	0.21531366},
				{50,	5.0176,	0.9999987},
				{55,	5.0176,	1},
				{60,	5.0176,	0.9999989},
				{65,	5.0176,	0.9999993},
				{70,	5.0176,	0.99999845},
				{75,	5.0176,	1},
				{80,	5.0176,	0.20126265},
				{85,	5.0176,	0.9797412},
				{90,	5.0176,	1}}; 
		/** 
		 * Example running Ketos model on a wav file. 
		 */
		
		String relModelPath = 	"./src/main/java/org/jamdev/jdl4pam/resources/Ketos/right_whale/hallo-kw-det_v1/hallo-kw-det_v1.ktpb";

		/****Wav files*****/
		//jasco_reduced - use for right whales hallo-kw-det_v1
		String relWavFilePath = "./src/main/java/org/jamdev/jdl4pam/resources/Ketos/right_whale/hallo-kw-det_v1/jasco_reduced.wav";
	
		
		Path path = Paths.get(relModelPath);
		//note that normalize gets rid of all the redundant elements (e.g. .)
		String modelPath = path.toAbsolutePath().normalize().toString();
		
		path = Paths.get(relWavFilePath);
		String wavFilePath = path.toAbsolutePath().normalize().toString();
		
		System.out.println(modelPath);

		//Open wav files.
		AudioData soundData;
		try {
			soundData = DLUtils.loadWavFile(wavFilePath);

			//the ketos model.
			KetosModel ketosModel = new KetosModel(new File(modelPath));

			ArrayList<KetosResult> results = KetosAudioProcess.processSoundData( ketosModel,  soundData, 5., KetosAudioProcess.VERBOSITY_MEDIUM); 
			
			//check prediction results are within 10%
			//Note we forget the weird edge cases (start and end of file) here for Ketos
			for (int i=1; i<results.size()-1; i++) {
				//System.out.println(i + ": " + results.get(i).prediction[1]);
				assertTrue(results.get(i).prediction[1]> ketosPredicitons[i][2]-0.1 && results.get(i).prediction[1]< ketosPredicitons[i][2]+0.1); 
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MalformedModelException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	

  
    @Test
    public void numSamplesTest() {
        // Meridian Ketos Tests
        // https://gitlab.meridian.cs.dal.ca/public_projects/ketos/-/blob/master/ketos/tests/audio/utils/test_misc.py
        assertEquals(0, numSamplesKetos(0.0, 1000., Boolean.FALSE));
        assertEquals(2000, numSamplesKetos(2.0, 1000., Boolean.FALSE));
        assertEquals(2001, numSamplesKetos(2.001, 1000., Boolean.FALSE));
        assertEquals(2002, numSamplesKetos(2.001, 1000., Boolean.TRUE));
    }

    @Test
    public void windowFunctionHammingPython() {
        double eps = 1e-7;

        int fftLength = 510;
        double [] pythonWindowHammingKetos = new double[fftLength];
        pythonWindowHammingKetos = new double[]{0.08, 0.08003505, 0.08014018, 0.08031539, 0.08056064,
                0.0808759, 0.08126112, 0.08171624, 0.08224119, 0.0828359,
                0.08350026, 0.08423419, 0.08503756, 0.08591026, 0.08685215,
                0.08786309, 0.08894293, 0.09009149, 0.09130862, 0.09259411,
                0.09394778, 0.09536941, 0.0968588, 0.09841571, 0.10003991,
                0.10173114, 0.10348916, 0.10531369, 0.10720446, 0.10916118,
                0.11118355, 0.11327126, 0.11542399, 0.11764142, 0.1199232,
                0.122269, 0.12467845, 0.12715118, 0.12968682, 0.13228499,
                0.13494528, 0.13766729, 0.14045061, 0.1432948, 0.14619945,
                0.14916411, 0.15218832, 0.15527162, 0.15841354, 0.16161361,
                0.16487134, 0.16818623, 0.17155777, 0.17498546, 0.17846877,
                0.18200716, 0.18560011, 0.18924705, 0.19294745, 0.19670072,
                0.20050631, 0.20436363, 0.20827209, 0.2122311, 0.21624005,
                0.22029834, 0.22440534, 0.22856043, 0.23276298, 0.23701234,
                0.24130787, 0.24564892, 0.25003482, 0.2544649, 0.25893849,
                0.26345491, 0.26801346, 0.27261346, 0.27725421, 0.28193499,
                0.28665509, 0.2914138, 0.29621039, 0.30104412, 0.30591427,
                0.31082008, 0.31576082, 0.32073572, 0.32574404, 0.330785,
                0.33585785, 0.3409618, 0.34609607, 0.3512599, 0.35645248,
                0.36167304, 0.36692076, 0.37219486, 0.37749453, 0.38281896,
                0.38816734, 0.39353886, 0.3989327, 0.40434803, 0.40978403,
                0.41523987, 0.42071472, 0.42620775, 0.43171812, 0.43724498,
                0.44278751, 0.44834485, 0.45391615, 0.45950057, 0.46509726,
                0.47070536, 0.47632402, 0.48195239, 0.48758959, 0.49323479,
                0.49888711, 0.50454569, 0.51020968, 0.51587821, 0.52155041,
                0.52722542, 0.53290238, 0.53858042, 0.54425868, 0.54993629,
                0.55561238, 0.5612861, 0.56695657, 0.57262294, 0.57828433,
                0.58393989, 0.58958875, 0.59523006, 0.60086295, 0.60648657,
                0.61210006, 0.61770256, 0.62329322, 0.62887119, 0.63443562,
                0.63998566, 0.64552046, 0.65103918, 0.65654099, 0.66202503,
                0.66749048, 0.67293651, 0.67836227, 0.68376696, 0.68914974,
                0.69450979, 0.6998463, 0.70515845, 0.71044543, 0.71570645,
                0.72094069, 0.72614735, 0.73132566, 0.73647481, 0.74159402,
                0.74668251, 0.75173951, 0.75676425, 0.76175595, 0.76671387,
                0.77163724, 0.77652531, 0.78137734, 0.7861926, 0.79097033,
                0.79570983, 0.80041036, 0.80507121, 0.80969167, 0.81427104,
                0.81880861, 0.8233037, 0.82775562, 0.8321637, 0.83652725,
                0.84084562, 0.84511815, 0.84934419, 0.85352309, 0.85765421,
                0.86173693, 0.86577063, 0.86975469, 0.8736885, 0.87757146,
                0.88140299, 0.88518249, 0.8889094, 0.89258314, 0.89620315,
                0.89976889, 0.90327981, 0.90673537, 0.91013505, 0.91347833,
                0.9167647, 0.91999366, 0.92316472, 0.92627739, 0.9293312,
                0.93232569, 0.9352604, 0.93813488, 0.94094869, 0.94370141,
                0.94639261, 0.94902189, 0.95158884, 0.95409307, 0.95653421,
                0.95891188, 0.96122571, 0.96347536, 0.96566048, 0.96778074,
                0.96983582, 0.9718254, 0.97374918, 0.97560687, 0.97739818,
                0.97912284, 0.98078059, 0.98237117, 0.98389435, 0.98534989,
                0.98673757, 0.98805717, 0.9893085, 0.99049137, 0.99160559,
                0.992651, 0.99362744, 0.99453475, 0.9953728, 0.99614146,
                0.99684062, 0.99747017, 0.99803001, 0.99852005, 0.99894023,
                0.99929048, 0.99957074, 0.99978097, 0.99992115, 0.99999124,
                0.99999124, 0.99992115, 0.99978097, 0.99957074, 0.99929048,
                0.99894023, 0.99852005, 0.99803001, 0.99747017, 0.99684062,
                0.99614146, 0.9953728, 0.99453475, 0.99362744, 0.992651,
                0.99160559, 0.99049137, 0.9893085, 0.98805717, 0.98673757,
                0.98534989, 0.98389435, 0.98237117, 0.98078059, 0.97912284,
                0.97739818, 0.97560687, 0.97374918, 0.9718254, 0.96983582,
                0.96778074, 0.96566048, 0.96347536, 0.96122571, 0.95891188,
                0.95653421, 0.95409307, 0.95158884, 0.94902189, 0.94639261,
                0.94370141, 0.94094869, 0.93813488, 0.9352604, 0.93232569,
                0.9293312, 0.92627739, 0.92316472, 0.91999366, 0.9167647,
                0.91347833, 0.91013505, 0.90673537, 0.90327981, 0.89976889,
                0.89620315, 0.89258314, 0.8889094, 0.88518249, 0.88140299,
                0.87757146, 0.8736885, 0.86975469, 0.86577063, 0.86173693,
                0.85765421, 0.85352309, 0.84934419, 0.84511815, 0.84084562,
                0.83652725, 0.8321637, 0.82775562, 0.8233037, 0.81880861,
                0.81427104, 0.80969167, 0.80507121, 0.80041036, 0.79570983,
                0.79097033, 0.7861926, 0.78137734, 0.77652531, 0.77163724,
                0.76671387, 0.76175595, 0.75676425, 0.75173951, 0.74668251,
                0.74159402, 0.73647481, 0.73132566, 0.72614735, 0.72094069,
                0.71570645, 0.71044543, 0.70515845, 0.6998463, 0.69450979,
                0.68914974, 0.68376696, 0.67836227, 0.67293651, 0.66749048,
                0.66202503, 0.65654099, 0.65103918, 0.64552046, 0.63998566,
                0.63443562, 0.62887119, 0.62329322, 0.61770256, 0.61210006,
                0.60648657, 0.60086295, 0.59523006, 0.58958875, 0.58393989,
                0.57828433, 0.57262294, 0.56695657, 0.5612861, 0.55561238,
                0.54993629, 0.54425868, 0.53858042, 0.53290238, 0.52722542,
                0.52155041, 0.51587821, 0.51020968, 0.50454569, 0.49888711,
                0.49323479, 0.48758959, 0.48195239, 0.47632402, 0.47070536,
                0.46509726, 0.45950057, 0.45391615, 0.44834485, 0.44278751,
                0.43724498, 0.43171812, 0.42620775, 0.42071472, 0.41523987,
                0.40978403, 0.40434803, 0.3989327, 0.39353886, 0.38816734,
                0.38281896, 0.37749453, 0.37219486, 0.36692076, 0.36167304,
                0.35645248, 0.3512599, 0.34609607, 0.3409618, 0.33585785,
                0.330785, 0.32574404, 0.32073572, 0.31576082, 0.31082008,
                0.30591427, 0.30104412, 0.29621039, 0.2914138, 0.28665509,
                0.28193499, 0.27725421, 0.27261346, 0.26801346, 0.26345491,
                0.25893849, 0.2544649, 0.25003482, 0.24564892, 0.24130787,
                0.23701234, 0.23276298, 0.22856043, 0.22440534, 0.22029834,
                0.21624005, 0.2122311, 0.20827209, 0.20436363, 0.20050631,
                0.19670072, 0.19294745, 0.18924705, 0.18560011, 0.18200716,
                0.17846877, 0.17498546, 0.17155777, 0.16818623, 0.16487134,
                0.16161361, 0.15841354, 0.15527162, 0.15218832, 0.14916411,
                0.14619945, 0.1432948, 0.14045061, 0.13766729, 0.13494528,
                0.13228499, 0.12968682, 0.12715118, 0.12467845, 0.122269,
                0.1199232, 0.11764142, 0.11542399, 0.11327126, 0.11118355,
                0.10916118, 0.10720446, 0.10531369, 0.10348916, 0.10173114,
                0.10003991, 0.09841571, 0.0968588, 0.09536941, 0.09394778,
                0.09259411, 0.09130862, 0.09009149, 0.08894293, 0.08786309,
                0.08685215, 0.08591026, 0.08503756, 0.08423419, 0.08350026,
                0.0828359, 0.08224119, 0.08171624, 0.08126112, 0.0808759,
                0.08056064, 0.08031539, 0.08014018, 0.08003505, 0.08};

//        WindowFunction window = new WindowFunction();
//        window.setWindowType(WindowFunction.HAMMING);
//        double[] winJMJava = window.generate(fftLength);

        _Window w1 = new Hamming(fftLength);
        double[] winJMJava = w1.getWindow();

        assertArrayEquals(pythonWindowHammingKetos, winJMJava, eps);
    }


    @Test
    public void padZeroTest(){
        // Meridian Ketos Tests
        // https://gitlab.meridian.cs.dal.ca/public_projects/ketos/-/blob/master/ketos/tests/audio/utils/test_misc.py
        double eps = 1e-7;

        double[] arr = new double[]{0, 1, 2, 3, 4, 5, 6, 7, 8};

        double[] paddedExpectedScenario1 = new double[]{0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0};
        double[] paddedJavaScenario1 = pad_zero(arr, 0, 3);
        assertArrayEquals(paddedExpectedScenario1, paddedJavaScenario1, eps);

        double[] paddedExpectedScenario2 = new double[]{0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8};
        double[] paddedJavaScenario2 = pad_zero(arr, 3, 0);
        assertArrayEquals(paddedExpectedScenario2, paddedJavaScenario2, eps);

        double[] paddedExpectedScenario3 = new double[]{0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0};
        double[] paddedJavaScenario3 = pad_zero(arr, 1, 4);
        assertArrayEquals(paddedExpectedScenario3, paddedJavaScenario3, eps);
    }

    @Test
    public void padReflectNoInvertTest(){
        // Meridian Ketos Tests
        // https://gitlab.meridian.cs.dal.ca/public_projects/ketos/-/blob/master/ketos/tests/audio/utils/test_misc.py

        double eps = 1e-7;

        double[] arr = new double[]{0, 1, 2, 3, 4, 5, 6, 7, 8};
        double[] paddedJavaScenario0 = pad_reflect(arr, 0, 0, false);
        assertArrayEquals(arr, paddedJavaScenario0, eps);

        double[] paddedExpectedScenario1 = new double[]{0, 1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5};
        double[] paddedJavaScenario1 = pad_reflect(arr, 0, 3, false);
        assertArrayEquals(paddedExpectedScenario1, paddedJavaScenario1, eps);

        double[] paddedExpectedScenario2 = new double[]{5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 7, 6};
        double[] paddedJavaScenario2 = pad_reflect(arr, 5, 2, false);
        assertArrayEquals(paddedExpectedScenario2, paddedJavaScenario2, eps);

        double[] paddedExpectedScenario3 = new double[]{5, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 7, 8};
        double[] paddedJavaScenario3 = pad_reflect(arr, 5, 0, false);
        assertArrayEquals(paddedExpectedScenario3, paddedJavaScenario3, eps);

    }

}