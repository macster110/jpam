module jdl4pam {
	exports org.jamdev.jdl4pam;
	exports org.jamdev.jdl4pam.pytorch2Java;
	exports org.jamdev.jdl4pam.utils;
	exports org.jamdev.jdl4pam.SoundSpot;
	exports org.jamdev.jdl4pam.transforms;
	exports org.jamdev.jdl4pam.genericmodel;

	requires api;
	requires java.desktop;
	requires jpamutils;
	requires org.json;
	requires pytorch.java.only;
	requires us.hebi.matlab.mat.mfl.core;
}