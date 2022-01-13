# JPAM

## Overview

_jpam_ is an acoustics focused deep learning library based on [djl](https://djl.ai/) that allows deep learning models to be run natively in Java. This offers several advantages over other methods (for example calling executable python files) including ease of use, speed and interoperability. 

## Modules

jpam consists of four primary modules;

### jdl4pam

jdl4pam is a library for opening acoustic deep learning models and transforming sound data into a format which can be accepted by individual models. Each deep learning model (usually) requires sound to undergo a set of transforms (often converting into an image) before it can be processed. The transform process can be complicated, involving the calculation of FFT's, noise reduction and image enhancement. Ideally a model should contain metadata about the number of type of transforms that are required, however, this not always the case. jdl4pam implements two frameworks, AnimalSpot and Ketos, which produce deep learning models that automatically generate the required transforms for sound. jdl4pam also implements a Generic Model which allows users to manually create transforms - this means most deep learning models not trained using an implemented framework can be used with jdl4pam but this is more complex and requires the user to manually generate the transforms and associated settings. More details on the implemented frameworks are below;  

#### AnimalSpot
[ANIMAL-SPOT](https://github.com/ChristianBergler/ANIMAL-SPOT) is a deep learning based framework which was initially designed for [killer whale sound detection]((https://github.com/ChristianBergler/ORCA-SPOT)) in noise heavy underwater recordings (see [Bergler et al. 2019](https://www.nature.com/articles/s41598-019-47335-w)). AnimalSpot has now been expanded to a be species independent framework for training acoustic deep learning models using PyTorch and Python. Imported AnimalSpot model will automatically set up their own data transforms and output classes. 

#### Ketos
[Ketos](https://meridian.cs.dal.ca/2015/04/12/ketos/) is an acoustic deep learning framework based on Tensorflow and developed by Meridian. It has excellent resources and tutorials and Python libraries can be installed easily via pip. Imported Ketos model will automatically set up their own data transforms and output classes. 

#### Generic Model
A generic model allows a user to load any model compatible with the djl (PyTorch (JIT), Tensorflow, ONXX) library and then manually set up a series of transforms using PAMGuard's transform library. It is recommended that users use an existing framework instead of a generic model as these models will automatically generate the required transforms. 


#### Example Code

The following code opens an AnimalSpot model and processes a small wav file. Note that you can find example models [here](https://github.com/macster110/PAMGuard_resources/tree/main/deep_learning/bat_DL_tutorial). 

```Java
String wavFilePath = "/Volumes/GoogleDrive/My Drive/Programming/MATLAB/research_Aarhus/bats_pamguard/deep_learning/species_classificiation/_tests/20200817_011424.wav";

int[] samplesChunk = new int[] {0, 1999}; // the sample chunk to use. 

String modelPath = "/Volumes/GoogleDrive/My Drive/Aarhus_research/PAMGuard_bats_2020/deep_learning/BAT/models/BAT_MODEL_3/species_classifier_5/minmax/1_BAT_MULTI_JAMIE_5ms_256fft_10hop_MM_0_100_128_256_AUG_LN_WITHJAMIEDATA_AUGMENTATION_V1.pk"; _
		
try {			
	//first open the model and get the correct parameters. 
	AnimalSpotModel soundSpotModel = new AnimalSpotModel(modelPath); 

	//create the DL params. 
	AnimalSpotParams dlParams = new AnimalSpotParams(soundSpotModel.getTransformsString());

	//Open wav files. 
	AudioData soundData = DLUtils.loadWavFile(wavFilePath);
	soundData = soundData.trim(samplesChunk[0], samplesChunk[1]); 

	//generate the transforms - this converts the acoustic data into an image with the correct size and format for the deep learning model.
	ArrayList<DLTransform> transforms =	DLTransformsFactory.makeDLTransforms(dlParams.dlTransforms); 

	System.out.println(dlParams.toString());

	((WaveTransform) transforms.get(0)).setWaveData(soundData); 

	DLTransform transform = transforms.get(0); 
	for (int i=0; i<transforms.size(); i++) {
		System.out.println(transform.toString()); 
		transform = transforms.get(i).transformData(transform); 
	}
			
	double[][] dataTest = ((FreqTransform) transform).getSpecTransfrom().getTransformedData(); 
	System.out.println("Data min:  " + JamArr.min(dataTest) +  " max:  " +  JamArr.max(dataTest));

	float[] output = null; 
  float[][][] data;
	int nStack = 1; //number of specs to give to the classifier. 
	for (int i=0; i<10; i++) {
		long time1 = System.currentTimeMillis();
		data = new float[nStack][][]; 
		for (int j=0; j<nStack; j++) {
			data[j] = DLUtils.toFloatArray(((FreqTransform) transform).getSpecTransfrom().getTransformedData()); 
		}
	  output = soundSpotModel.runModel(data); 
	  long time2 = System.currentTimeMillis();
		System.out.println("Time to run model: " + (time2-time1) + " ms"); 
	}

	double[] prob = new double[output.length]; 
	for (int j=0; j<output.length; j++) {
		//softmax function
		prob[j] = DLUtils.softmax(output[j], output); 
		System.out.println("Class : " + j +" prediction:" + prob[j]); 
	}

} catch (Exception e) {
	// TODO Auto-generated catch block
		e.printStackTrace();
		return;
}
```

### jpamutils

jpamutils contains useful functions for transforming sound data, e.g. FFT's, filters, code for opening wav files etc. 

### jpambinaries

jpambinaries is used for opening bespoke sound files, such as AudioMoth triggered data. 

### jpamutilsfx

jpamutilsfx contains useful [JavaFX](https://openjfx.io/) controls. 

## Repository 

jpam modeuls can be accessed using Maven. Each package requires both a repository and dependency to be declared. So for example, to use jdl4pam add the following to the list of repositories in your `pom.xml` file
 
    <repository>
      <id>jdl4pam</id>
      <url>https://raw.github.com/macster110/jpam/mvn-repo/</url>
    </repository>
 
 and then add the dependancy 
 
     <dependency>
      <groupId>org.jamdev</groupId>
      <artifactId>jdl4pam</artifactId>
      <version>0.0.91</version>
      <scope>compile</scope>
    </dependency>
    
    
    
   
