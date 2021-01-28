package org.jamdev.pambinaries.audiomoth;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.UnsupportedAudioFileException;

import org.jamdev.jpamutils.wavFiles.WavFile;

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
	 */
	private ArrayList<AudioMothTData> loadTFile(File file) throws UnsupportedAudioFileException, IOException {

		//create an array to hold all the trigger data. 
		ArrayList<AudioMothTData> detections = new ArrayList<AudioMothTData>(); 

		//open the wav file and read the header.
		WavFile wavFile = new  WavFile(file);

		//parse the date time from the file
		long dateFileStart = readFileDateTime(file); 

		//get a reference to the AudioFormat from the file 
		AudioFormat format = wavFile.getAudioFileFormat().getFormat(); 

		AudioInputStream inputStream  = wavFile.getAudioInputStream();

		//get the length of the header. 
		int headerLen = (int) (wavFile.getFile().length()-inputStream.available());

		System.out.println("Header len in bytes: " + headerLen); 

		//array to hold all the 512byte chunks of data of raw sound files. 
		ArrayList<short[]> triggerChunkBlocks = new ArrayList<short[]>(); 

		//the first chunk is overwritten by the header. The input stream does NOT include the header so we need to find the first 
		//true 512kB chunk and save the wav data. 
		int firstChunkLen = ENCODED_BLOCK_SIZE_IN_BYTES%headerLen; 

		System.out.println("firstChunkLen len in bytes: " + firstChunkLen); 

		byte[] encodBlockRaw = inputStream.readNBytes(firstChunkLen); 
		short[] encodBlock = new short[encodBlockRaw.length/2]; 
		for (int i =0; i<encodBlockRaw.length; i=i+2) {
			encodBlock[i/2]=(short) bytes2Short(encodBlockRaw[i], encodBlockRaw[i+1]); 
		}
		triggerChunkBlocks.add(encodBlock);

		//the number of samples that were skipper for the current chunk
		int samplesSkip = headerLen/NUMBER_OF_BYTES_IN_SAMPLE; 

		//OK, now should be at the start of the first ENCODED_BLOCK
		while (inputStream.available()>ENCODED_BLOCK_SIZE_IN_BYTES) {

			//read the encoded block
			encodBlockRaw = inputStream.readNBytes(ENCODED_BLOCK_SIZE_IN_BYTES); 

			//convert the encoded block to short values. 	
			encodBlock = new short[ENCODED_BLOCK_SIZE_IN_BYTES/2]; 

			int sum = 0; 
			for (int i =0; i<encodBlockRaw.length; i=i+2) {
				encodBlock[i/2]=(short) bytes2Short(encodBlockRaw[i], encodBlockRaw[i+1]); 
				if (i>64) {
					sum+=encodBlock[i/2]; 
				}
			}


			//if all values from 64 to 512 are zero then this almost certainly an encoded block (or a broken AudioMoth)
			if (sum==0) {
				//System.out.println("This is an encoded block: " + sum); 
				//need to extract the metadata from the file. 

				//save the current chunk 
				detections.add(makeDataChunk(samplesSkip, dateFileStart, 
						format.getSampleRate(), triggerChunkBlocks));

				//now figure out the samples skipped for the next chunk 
				samplesSkip = 0; 
				//ooft now need to use bitwise operation to extract the number from the encoded block
				for (int i= 0; i<32; i++) {
					//System.out.println("Encoded block val: " + encodBlock[i]); 
					if (encodBlock[i]>=1) {
						samplesSkip |= 1 << i; // set the bit at i
					}
				}

				System.out.println("Blocks skippped to next block: " + samplesSkip); 

				triggerChunkBlocks.clear();
			}
			else {
				//System.out.println("This is not an encoded block: " + sum); 
				triggerChunkBlocks.add(encodBlock); 
			}

		}

		//System.out.println(inputStream.available()); 

		return null; 
	}


	/**
	 * Read the date time from the AudioMoth file header. 
	 * @param file - the file. 
	 * @return a date number of the file start time in Java millis. 
	 */
	private long readFileDateTime(File file) {
		// TODO Auto-generated method stub
		return 0;
	}


	/**
	 * Create an AudioMoth data chunk from multiple encoded blocks. 
	 * @param samplesStart - the number of samples since the dateFileStart that the chunk starts
	 * @param dateFileStart - the start date number of the file (not the chunk). 
	 * @param sR - the sample rate in samples per second. 
	 * @param sampleBlocks - list of concurrent blocks of wave data. These are concatenated into one wave array
	 * @return a data chunk object. 
	 */
	public static AudioMothTData  makeDataChunk(int samplesStart, long dateFileStart, float sR, ArrayList<short[]> sampleBlocks) {

		return null; 
	}

	/**
	 * Make a short from two bytes. 
	 * @param firstByte - the first byte. 
	 * @param secondByte - the second byte
	 * @return the short value of the two bytes. 
	 */
	public static short bytes2Short(byte firstByte, byte secondByte) {
		return (short)(((firstByte & 0xFF) << 8) | (secondByte & 0xFF));
	}

	public static void main(String[] args) {
		String file = "/Users/au671271/Google Drive/SoundSort_dev/audiomoth/20200530_210400T.WAV";

		AudioMothTFile audioMothTFile = new AudioMothTFile(); 

		try {
			audioMothTFile.loadTFile(new File(file));
		} catch (UnsupportedAudioFileException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}



}
