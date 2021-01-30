package org.jamdev.pambinaries.audiomoth;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jpamutils.wavFiles.WavFile;

import us.hebi.matlab.mat.format.Mat5;
import us.hebi.matlab.mat.types.MatFile;
import us.hebi.matlab.mat.types.Matrix;
import us.hebi.matlab.mat.types.Struct;

/**
 * 
 * Loads an AudioMoth triggered file and extract each triggered chunk. 
 * 
 * @author Jamie Macaulay
 *
 */
public class AudioMothTFile {

	/* File read constants */

	//	public static final int FILENAME_BUFFER_SIZE = 1024; 

	/* Encoded block constant */

	public static final int  ENCODED_BLOCK_SIZE_IN_BYTES  =  512; 


	/**
	 * The size of the wav file header in bytes. 
	 */
	public static final int  HEADER_SIZE_IN_BYTES  =  488; 


	/**
	 * The number of bytes in a sample.
	 */
	public static final int  NUMBER_OF_BYTES_IN_SAMPLE = 2; 




	//	String file = "/Users/au671271/Google Drive/SoundSort_dev/audiomoth/20200530_210400T.WAV";


	/**
	 * Load an AudioMoth trigger file and return a list of trigger chunks with associated wave data and time stamps. 
	 * @param file - the triggered AudioMoth file. 
	 * @return an array of trigger objects, each which contains waveform and time information. 
	 * @throws UnsupportedAudioFileException
	 * @throws IOException 
	 * @throws ParseException 
	 */
	private static ArrayList<AudioMothTData> loadTFile(File file) throws UnsupportedAudioFileException, IOException, ParseException {

		//create an array to hold all the trigger data. 
		ArrayList<AudioMothTData> detections = new ArrayList<AudioMothTData>(); 

		//open the wav file and read the header.
		WavFile wavFile = new  WavFile(file);

		//parse the date time from the file
		long dateFileStart = readFileDateTime(file).getTime(); 

		//get a reference to the AudioFormat from the file 
		AudioFormat format = wavFile.getAudioFileFormat().getFormat(); 

		//get the audio input stream- this starts after the header. 
		AudioInputStream inputStream  = wavFile.getAudioInputStream();

		//get the length of the header. 
		int headerLen = (int) (wavFile.getFile().length()-inputStream.available());

		//System.out.println("Header len in bytes: " + headerLen); 

		//array to hold all the 512byte chunks of data of raw sound files. 
		ArrayList<short[]> triggerChunkBlocks = new ArrayList<short[]>(); 

		//the first chunk is overwritten by the header. The input stream does NOT include the header so we need to find the first 
		//true 512kB chunk and save the wav data. 
		int firstChunkLen = ENCODED_BLOCK_SIZE_IN_BYTES%headerLen; 

		//System.out.println("firstChunkLen len in bytes: " + firstChunkLen); 

		byte[] encodBlockRaw = inputStream.readNBytes(firstChunkLen); 
		short[] encodBlock = new short[encodBlockRaw.length/2]; 
		for (int i =0; i<encodBlockRaw.length; i=i+2) {
			encodBlock[i/2]=(short) bytes2Short(encodBlockRaw[i], encodBlockRaw[i+1]); 
		}
		triggerChunkBlocks.add(encodBlock);

		//the number of samples that were skipped for the current chunk
		int samplesSkip = headerLen/NUMBER_OF_BYTES_IN_SAMPLE; 

		int samplesWave = 0; 
		//OK, now should be at the start of the first ENCODED_BLOCK
		while (inputStream.available()>ENCODED_BLOCK_SIZE_IN_BYTES) {

			//read the encoded block
			encodBlockRaw = inputStream.readNBytes(ENCODED_BLOCK_SIZE_IN_BYTES); 

			//convert the encoded block to short values. 	
			encodBlock = new short[ENCODED_BLOCK_SIZE_IN_BYTES/2]; 

			int sum = 0; 
			for (int i =0; i<encodBlockRaw.length; i=i+2) {
				encodBlock[i/2]= bytes2Short(encodBlockRaw[i], encodBlockRaw[i+1]); 
				if (i>64) {
					sum+=encodBlock[i/2]; 
				}
			}


			//if all values from 64 to 512 are zero then this almost certainly an encoded block (or a broken AudioMoth)
			if (sum==0) {
				//System.out.println("This is an encoded block: " + sum); 
				//need to extract the metadata from the file. 

				//save the current chunk 
				detections.add(makeDetection(samplesSkip, dateFileStart, 
						format.getSampleRate(), triggerChunkBlocks));

				//now figure out the samples skipped for the next chunk 
				int samplesSkipEncod = 0; 

				//ooft now need to use bitwise operation to extract the number from the encoded block
				for (int i= 0; i<32; i++) {
					//System.out.println("Encoded block val: " + encodBlock[i]); 
					if (encodBlock[i]>=1) {
						samplesSkipEncod |= 1 << i; // set the bit at i
					}
				}

				samplesSkip=samplesSkip+samplesSkipEncod*(ENCODED_BLOCK_SIZE_IN_BYTES/NUMBER_OF_BYTES_IN_SAMPLE)+samplesWave; 

				samplesWave=0; 
				//System.out.println("Blocks skippped to next block: " + samplesSkip); 

				triggerChunkBlocks.clear();
			}
			else {
				//System.out.println("This is not an encoded block: " + sum); 
				
				//have to read as little endian samples
				byte[] sampleByte = new byte[NUMBER_OF_BYTES_IN_SAMPLE]; 
				for (int i =0; i<encodBlockRaw.length; i=i+2) {
					for (int j = 0; j<NUMBER_OF_BYTES_IN_SAMPLE; j++) {
						sampleByte[j] = encodBlockRaw[i+j]; 
					}
					encodBlock[i/2]= sampleByte(sampleByte); 
				}
				
				triggerChunkBlocks.add(encodBlock); 
				samplesWave+=encodBlock.length; 
			}

		}
		//System.out.println(inputStream.available()); 
		return detections; 
	}


	/**
	 * Read the date time from the AudioMoth file header. 
	 * @param file - the file. 
	 * @return a date number of the file start time in Java millis. 
	 * @throws ParseException 
	 */
	private static Date readFileDateTime(File file) throws ParseException {
		//parse the date time from an audiomoth triiger file 

		//		Example : 20200530_210400T.wav
		String fileName = file.getName(); 

		fileName=fileName.substring(0, fileName.length()-4); 

		//System.out.println(fileName); 

		SimpleDateFormat format=new SimpleDateFormat("yyyyMMDD_HHmmss");  

		return format.parse(fileName);
	}


	/**
	 * Create an AudioMoth data chunk from multiple encoded blocks. 
	 * @param samplesStart - the number of samples since the dateFileStart that the chunk starts
	 * @param dateFileStart - the start date number of the file (not the chunk). 
	 * @param sR - the sample rate in samples per second. 
	 * @param sampleBlocks - list of concurrent blocks of wave data. These are concatenated into one wave array
	 * @return a data chunk object. 
	 */
	public static AudioMothTData  makeDetection(int samplesStart, long dateFileStart, float sR, ArrayList<short[]> sampleBlocks) {

		if (sampleBlocks==null) return null; 

		int numSamps = 0; 
		for (int i=0; i<sampleBlocks.size(); i++) {
			numSamps+=sampleBlocks.get(i).length; 
		}

		short[] wave = new short[numSamps]; 
		int n=0; 
		for (int i=0; i<sampleBlocks.size(); i++) {
			for (int j=0; j<sampleBlocks.get(i).length; j++) {
				wave[n]=sampleBlocks.get(i)[j]; 
				n++;
			}
		}

		long timeMillis = ((long)  (dateFileStart + 1000*(samplesStart/sR))); 

		AudioMothTData detection = new AudioMothTData(samplesStart, timeMillis, wave, sR); 

		return detection; 
	}

	/**
	 * Write to MATLAB .mat file - including the structures. 
	 * @param triggerChunks - the trigger chunks. 
	 */
	public static MatFile write2MAT(ArrayList<AudioMothTData> triggerChunks) {

		MatFile matFile = Mat5.newMatFile(); 
		
		Struct struct = Mat5.newStruct(new int[] {1, triggerChunks.size()}); 
		
		int n=0;
		for (AudioMothTData triggerChunk: triggerChunks ) {
			struct.set("startSample", n, Mat5.newScalar(triggerChunk.sampleStart)); 
			struct.set("date", n, Mat5.newScalar(triggerChunk.timeMillis)); 
			struct.set("sR", n, Mat5.newScalar(triggerChunk.sR)); 
			struct.set("wave", n,	array2Matrix(triggerChunk.wave)); 
			n++; 
		}
		
		matFile.addArray("triggerchunks", struct); 
		
		return matFile; 

	}

//	/**
//	 * Convert a chunk of AudioMoth trigger data into a MATLAB structure. 
//	 * @param triggerChunk - the chunk matlab structure. 
//	 */
//	public static Struct audioMothTData2Struct(AudioMothTData triggerChunk) {
//
//		array2Matrix(triggerChunk.wave); 
//		Struct struct = Mat5.newStruct();
//		struct.set("startSample", Mat5.newScalar(triggerChunk.sampleStart)); 
//		struct.set("date", Mat5.newScalar(triggerChunk.timeMillis)); 
//		struct.set("sR", Mat5.newScalar(triggerChunk.sR)); 
//		struct.set("wave", 	array2Matrix(triggerChunk.wave)); 
//		
//		return struct; 
//
//	}


	/**
	 * Get a Matrix object from a short[] array. 
	 * @param specData - the short array to convert. 
	 * @return the matrix object. 
	 */
	public static Matrix array2Matrix(short[] samplesChunk) {
		Matrix matrix = Mat5.newMatrix(samplesChunk.length, 1);
		for (int i=0; i<samplesChunk.length; i++) {
			matrix.setInt(i,0, samplesChunk[i]);
		}

		return matrix;
	}

	public static short max(short[] samplesChunk) {
		short max = Short.MIN_VALUE;
		for (int i=0; i<samplesChunk.length; i++) {
			if (max<samplesChunk[i]) {
				max = samplesChunk[i];
			}
		}
		return max;
	}



	//	public static print(String string, int verbose) {
	//		if (verbose=0  == 0) return;
	//	}

	/**
	 * Make a short from two bytes. Used only for encoded blocks. 
	 * @param firstByte - the first byte. 
	 * @param secondByte - the second byte
	 * @return the short value of the two bytes. 
	 */
	public static short bytes2Short(byte firstByte, byte secondByte) {
		return (short)(((firstByte & 0xFF) << 8) | (secondByte & 0xFF));
	}
	
	/**
	 * Read little endian wav file. 
	 * @param data - the data
	 * @return the wav sample between 2^16. 
	 */
	public static short sampleByte(byte[] data) {
		short amplitude = 0;
		for (int byteNumber = 0; byteNumber < NUMBER_OF_BYTES_IN_SAMPLE; byteNumber++) {
			// little endian
			amplitude |= (short) ((data[byteNumber] & 0xFF) << (byteNumber * 8));
		}
		return amplitude; 
	}


	public static void main(String[] args) {
		
		//test the algorithm on a file and export as MATLAB structure. 
		
		String file = "/Users/au671271/Google Drive/SoundSort_dev/audiomoth/20200530_210400T.WAV";
		String exportToFile = "/Users/au671271/Google Drive/Programming/MATLAB/Instruments/audiomoth/audiomothchunk.mat"; 

		try {
			ArrayList<AudioMothTData> triggerChunks = AudioMothTFile.loadTFile(new File(file));

			for (AudioMothTData triggerChunk : triggerChunks) {
				System.out.println("---------------");
				System.out.println("Sample start: " + triggerChunk.sampleStart);
				System.out.println("Seconds start: " + triggerChunk.sampleStart/triggerChunk.sR);

				System.out.println("sR: " + triggerChunk.sR);
				System.out.println("TimeMillis: " + triggerChunk.timeMillis);
				System.out.println("Wave len: " + triggerChunk.wave.length);
				System.out.println("Max amp: " + max(triggerChunk.wave));
			}
			
			MatFile matFile = write2MAT(triggerChunks); 
			
			// Serialize to disk using default configurations
			Mat5.writeToFile(matFile,exportToFile);
		} 
		catch (UnsupportedAudioFileException e) {
			e.printStackTrace();
		} 
		catch (IOException e) {
			e.printStackTrace();
		} 
		catch (ParseException e) {
			e.printStackTrace();
		} 
	}



}
