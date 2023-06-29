package org.jamdev.jdl4pam;

/**
 * ENUM for the different supported frameworks. 
 * @author Jamie Macaulay
 *
 */
public enum FrameWork {

	GENERIC("Bespoke"),
	KETOS("Ketos"),
	ANIMAL_SPOT("Animal Spot"),
	KOOGU("Koogu");

	public final String label;

	public String getLabel() {
		return label;
	}

	private FrameWork(String label) {
		this.label = label;
	}
}
