package org.jamdev.jpamutils.wavFiles;

import javax.sound.sampled.AudioFormat;
import java.util.Arrays;

public class TestWavFileExtract {
    public static void main(String[] args) {
        // Create a fake 24-bit stereo byte stream (little endian per sample)
        // Frame 0: ch0 = 0x01 0x02 0x03, ch1 = 0x11 0x12 0x13
        // Frame 1: ch0 = 0x04 0x05 0x06, ch1 = 0x14 0x15 0x16
        byte[] interleaved = new byte[] {
            (byte)0x01, (byte)0x02, (byte)0x03, (byte)0x11, (byte)0x12, (byte)0x13,
            (byte)0x04, (byte)0x05, (byte)0x06, (byte)0x14, (byte)0x15, (byte)0x16
        };

        AudioFormat fmt = new AudioFormat(AudioFormat.Encoding.PCM_SIGNED, 44100f, 24, 2, 6, 44100f, false);

        byte[] ch0 = WavFile.getSingleChannelByte(fmt, interleaved, 0);
        byte[] ch1 = WavFile.getSingleChannelByte(fmt, interleaved, 1);

        System.out.println("Interleaved bytes: " + toHex(interleaved));
        System.out.println("Channel 0 bytes:   " + toHex(ch0));
        System.out.println("Channel 1 bytes:   " + toHex(ch1));

        // Assert expected
        byte[] expectedCh0 = new byte[] {(byte)0x01,(byte)0x02,(byte)0x03,(byte)0x04,(byte)0x05,(byte)0x06};
        byte[] expectedCh1 = new byte[] {(byte)0x11,(byte)0x12,(byte)0x13,(byte)0x14,(byte)0x15,(byte)0x16};

        System.out.println("Ch0 matches: " + Arrays.equals(ch0, expectedCh0));
        System.out.println("Ch1 matches: " + Arrays.equals(ch1, expectedCh1));
    }

    private static String toHex(byte[] b) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < b.length; i++) {
            sb.append(String.format("%02X", b[i]));
            if (i < b.length-1) sb.append(" ");
        }
        return sb.toString();
    }
}
