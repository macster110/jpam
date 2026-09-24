package org.jamdev.jdl4pam.genericmodel;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.jamdev.jdl4pam.utils.DLDeviceUtils;

import ai.djl.Device;
import ai.djl.MalformedModelException;
import ai.djl.Model;
import ai.djl.engine.Engine;
import ai.djl.engine.EngineException;
import ai.djl.inference.Predictor;
import ai.djl.ndarray.types.Shape;


/**
 * The generic model. Generic models are for running bespoke models. 
 * 
 * @author Jamie Macaulay
 *
 */
public class GenericModel {


	/**
	 * The currently loaded model 
	 */
	private Model model;

	/**
	 * The predictor for the model. 
	 */
	Predictor<float[][][], float[]> specPredictor;
	
	
	/**
	 * Predictor for the model for waveforms. 
	 */
	Predictor<float[][], float[]> wavePredictor;


	/**
	 * The input shape from the loaded model. 
	 */
	private Shape inputShape = null; 

	/**
	 * The output shape from the model. 
	 */
	private Shape outShape = null; 


	private SpectrogramTranslator specTranslator;

	private WaveformTranslator waveTranslator;
	
	/**
	 * The index of the audio input shape.
	 */
	private Integer inputShapeIndex = null;

	/**
	 * The device the model is currently loaded on (e.g. mps or cpu). Null means the
	 * DJL default device.
	 */
	private Device device;

	/**
	 * Set once the model has fallen back from the GPU to the CPU.
	 */
	private boolean cpuFallbackDone = false;

	String lastModelPath = null;
	
	public String getLastModelPath() {
		return lastModelPath;
	}

	public void setLastModelPath(String lastModelPath) {
		this.lastModelPath = lastModelPath;
	}

	/**
	 * Load a model from a file.
	 * @param modelPath - path to the file.
	 * @throws MalformedModelException 
	 * @throws IOException
	 */
	public GenericModel(String modelPath) throws MalformedModelException, IOException, EngineException {
		this(modelPath, null);
	}

	/**
	 * Load a model from a file 
	 * @param modelPath - path to the model file. Can be a Tensorflow model (e.g. daved_model.pb) or Pytorch model (e.g. modelname.py). 
	 * @param inputShapeIndex- This can be null in which case the shape with the largest
	 * dimensions will be assumed to be the input data.  Note that often only one input shape 
	 * is retrieved from the model in which case this index is redundant. 
	 * @throws MalformedModelException
	 * @throws IOException
	 */
	public GenericModel(String modelPath, Integer inputShapeIndex) throws MalformedModelException, IOException, EngineException {

		this.inputShapeIndex = inputShapeIndex;

		/**
		 * Load the model.
		 */
		Model model = loadModel(modelPath);

		if (model == null) {
			System.err.println("Generic Model: Could not load model: " + modelPath);
		}

		else {
			buildPredictors(model);
		}

	}

	/**
	 * Read the input/output shapes from the model and (re)build the spectrogram and
	 * waveform predictors. Called on first load and again if the model has to be
	 * reloaded on a different device.
	 *
	 * @param model - the loaded model.
	 */
	private void buildPredictors(Model model) {
		if (model!=null && model.describeInput()!=null) {
			for (int i=0; i<model.describeInput().size(); i++)
			System.out.println("Generic Model: Input: " + i + " - " + model.describeInput().get(i).getValue());
			inputShape =  model.describeInput().get(0).getValue();
		}
		if (model!=null && model.describeOutput()!=null) {
			System.out.println("Generic Model: Output: " + model.describeOutput().get(0).getValue());
			outShape = model.describeOutput().get(0).getValue();
		}

		this.model=model;

		specTranslator = new SpectrogramTranslator(inputShape);
		specTranslator.setAudioShapeIndex(inputShapeIndex); //usually null or zero.


		waveTranslator = new WaveformTranslator(model.describeInput());
		waveTranslator.setAudioShapeIndex(inputShapeIndex); //usually null or zero.

		//predictor for the model if using images as input
		specPredictor = model.newPredictor(specTranslator);

		//predictor for the model if using
		wavePredictor = model.newPredictor(waveTranslator);
	}

	
	/**
	 * Load a model form a path. 
	 * @param modelPath - the path to the model
	 * @return the loaded mode3l
	 * @throws MalformedModelException
	 * @throws IOException
	 */
	public Model loadModel(String modelPath) throws MalformedModelException, IOException, EngineException {
		//prefer the Apple GPU (MPS) for PyTorch models where available; this returns
		//null (the DJL default device) on other platforms so CUDA behaviour is unchanged.
		return loadModelOnDevice(modelPath, DLDeviceUtils.getPreferredPyTorchDevice());
	}

	/**
	 * Load a model on a specific device. The device only affects PyTorch models -
	 * TensorFlow on this platform is CPU-only. Used both on first load (preferring
	 * the GPU) and when reloading on the CPU after a GPU failure.
	 *
	 * @param modelPath - the path to the model.
	 * @param pyTorchDevice - the device to load a PyTorch model on, or null for the
	 *            DJL default device.
	 * @return the loaded model.
	 */
	protected Model loadModelOnDevice(String modelPath, Device pyTorchDevice) throws MalformedModelException, IOException, EngineException {
		File file = new File(modelPath);
		this.lastModelPath = modelPath;

		Path modelDir = Paths.get(file.getAbsoluteFile().getParent()); //the directory of the file (in case the file is local this should also return absolute directory)
		String modelName = file.getName();

		String extension = FilenameUtils.getExtension(file.getAbsolutePath());

		System.out.println("Generic Model: Available engines: " + Engine.getAllEngines());

		Model model;
		switch  (extension) {
		case "pb":
			model = Model.newInstance(modelPath, "TensorFlow");
			model.load(modelDir, modelName, getLoadOptions());
			this.device = Device.cpu(); //TensorFlow is CPU-only on this platform.
			break;
		case "h5":
			model = Model.newInstance(modelPath, "TensorFlow");
			model.load(modelDir, modelName, getLoadOptions());
			this.device = Device.cpu();
			break;
		case "py":
			model = DLDeviceUtils.newPyTorchModel(modelName, pyTorchDevice);
			model.load(modelDir, modelName);
			this.device = pyTorchDevice;
			break;
		default:
			//will try to load a model automatically - problematic but let's see.
			model = Model.newInstance(modelPath);
			break;
		}

		return model;
	}

	/**
	 * Options passed to DJL when loading a TensorFlow model, for example
	 * "SignatureDefKey" to select which signature of a SavedModel is used. If the
	 * SavedModel has no "serving_default" signature and none is specified, DJL uses
	 * whichever signature it finds first.
	 * 
	 * @return the load options, or null to use the DJL defaults.
	 */
	protected Map<String, ?> getLoadOptions() {
		return null;
	}

	/**
	 * Get the predictor for spectrogram images.  
	 * @return
	 */
	public Predictor<float[][][], float[]> getSpecPredictor() {
		return specPredictor;
	}

	/***
	 * Get the predictor for the waveform input. 
	 * @return the predictor for waveforms. 
	 */
	public Predictor<float[][], float[]> getWavePredictor() {
		return wavePredictor;
	}

	/**
	 * Get the model shape for the input. 
	 * @return the input shape. 
	 */
	public Shape getInputShape() {
		return inputShape;
	}

	/**
	 * Set the input shape. 
	 * @param inputShape - the input shape. 
	 */
	public void setInputShape(Shape inputShape) {
		this.inputShape = inputShape;
		specTranslator.setShape(inputShape);
	}

	/**
	 * Get the output shape. The shape is null if the model does not specify shape. 
	 * @return the output shape. 
	 */
	public Shape getOutShape() {
		return outShape;
	}

	 

	/**
	 * Run the model on spectrogram images
	 * @param specImage - the spectrogram image [no. batches][image x][image y]
	 * @return the results 
	 */
	public float[] runModel(float[][][] specImage) {
		try {
			return specPredictor.predict(specImage);
		} catch (Throwable e) {
			//if the model failed on the GPU (Apple MPS), reload on the CPU and retry once.
			if (fallbackToCpu()) {
				try {
					return specPredictor.predict(specImage);
				} catch (Throwable e2) {
					e2.printStackTrace();
				}
			} else {
				System.out.println("Error on model: ");
				e.printStackTrace();
			}
		}
		return null;
	}


	/**
	 * Run the model on a raw waveform data
	 * @param specImage - waveform data [no. batches][samples]
	 * @return the results
	 */
	public float[] runModel(float[][] waveform) {
		try {
			return wavePredictor.predict(waveform);
		} catch (Throwable e) {
			//if the model failed on the GPU (Apple MPS), reload on the CPU and retry once.
			if (fallbackToCpu()) {
				try {
					return wavePredictor.predict(waveform);
				} catch (Throwable e2) {
					e2.printStackTrace();
				}
			} else {
				System.out.println("Error on model: ");
				e.printStackTrace();
			}
		}
		return null;
	}

	/**
	 * Reload the model on the CPU after a failure on the GPU (Apple MPS). Only
	 * happens once; subsequent failures are reported normally.
	 *
	 * @return true if the model was successfully reloaded on the CPU.
	 */
	protected synchronized boolean fallbackToCpu() {
		if (cpuFallbackDone || !DLDeviceUtils.isMps(device) || lastModelPath == null) {
			return false;
		}
		cpuFallbackDone = true;
		try {
			System.err.println("GenericModel: model failed on the Apple GPU (MPS) - reloading on the CPU.");
			if (specPredictor != null) {
				specPredictor.close();
			}
			if (wavePredictor != null) {
				wavePredictor.close();
			}
			if (model != null) {
				model.close();
			}
			//reload directly from the (already unzipped) model file on the CPU.
			Model cpuModel = loadModelOnDevice(lastModelPath, Device.cpu());
			buildPredictors(cpuModel);
			//let subclasses rebuild any custom predictors they hold against the new model.
			onModelReloaded();
			return true;
		} catch (Throwable e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * Called after the model has been reloaded on a different device (during a GPU
	 * to CPU fall-back). Subclasses that create their own predictor(s) from
	 * {@link #getModel()} should override this to rebuild them against the reloaded
	 * model. The default implementation does nothing.
	 */
	protected void onModelReloaded() {
	}

	
	public Model getModel() {
		return model;
	}

	public void setModel(Model model) {
		this.model = model;
	}


}
