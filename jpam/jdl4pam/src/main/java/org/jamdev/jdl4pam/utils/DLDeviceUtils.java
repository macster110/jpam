package org.jamdev.jdl4pam.utils;

import ai.djl.Device;
import ai.djl.Model;

/**
 * Helpers for choosing which physical device (CPU / GPU) a deep learning model
 * runs on.
 * <p>
 * The DJL PyTorch engine defaults to a CUDA GPU if one is present and otherwise
 * the CPU. On Apple Silicon Macs it does <b>not</b> use the integrated GPU by
 * default, even though the bundled libtorch supports Apple's Metal Performance
 * Shaders (MPS) backend. These helpers let the PyTorch model loaders prefer the
 * Apple GPU (with a CPU fall-back handled by the caller), which is a large
 * speed-up for big models.
 * <p>
 * Note: this only applies to the PyTorch engine. The DJL TensorFlow engine on
 * macOS is a CPU-only build (there is no Metal delegate in libtensorflow), so
 * TensorFlow models always run on the CPU regardless.
 *
 * @author Jamie Macaulay
 */
public class DLDeviceUtils {

	/**
	 * The DJL device-type string for Apple's Metal Performance Shaders (MPS). DJL
	 * does not expose this as a constant but the PyTorch engine recognises it.
	 */
	public static final String MPS = "mps";

	/**
	 * The device a PyTorch model should preferentially be loaded on. On Apple
	 * Silicon this is the Metal (MPS) GPU; on all other platforms this returns
	 * {@code null}, meaning "use the DJL default device" (a CUDA GPU if present,
	 * otherwise the CPU) - so existing CUDA behaviour is unchanged.
	 *
	 * @return the preferred device, or null to use the DJL default.
	 */
	public static Device getPreferredPyTorchDevice() {
		if (isAppleSilicon()) {
			return Device.of(MPS, 0);
		}
		return null;
	}

	/**
	 * @param device - a device (may be null).
	 * @return true if the device is the Apple Metal (MPS) GPU.
	 */
	public static boolean isMps(Device device) {
		return device != null && MPS.equals(device.getDeviceType());
	}

	/**
	 * Create a PyTorch model instance on a given device.
	 *
	 * @param name - the model name.
	 * @param device - the device, or null to use the DJL default device.
	 * @return a new (unloaded) model instance.
	 */
	public static Model newPyTorchModel(String name, Device device) {
		return device == null ? Model.newInstance(name) : Model.newInstance(name, device);
	}

	/**
	 * @return true if running on an Apple Silicon (arm64) Mac.
	 */
	public static boolean isAppleSilicon() {
		try {
			String os = System.getProperty("os.name", "").toLowerCase();
			String arch = System.getProperty("os.arch", "").toLowerCase();
			return os.contains("mac") && (arch.contains("aarch64") || arch.contains("arm"));
		} catch (Throwable e) {
			return false;
		}
	}

}
