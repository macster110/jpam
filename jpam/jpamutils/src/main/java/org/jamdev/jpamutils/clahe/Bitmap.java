package org.jamdev.jpamutils.clahe;

import java.awt.image.BufferedImage;
import java.awt.image.IndexColorModel;

/**
 * Bitmap class that uses a bufferred image instead of Android Bitmap. 
 * <p?
 * This allows us to use the FastBitMap class - although how fast it now is accessing a 
 * Bufferred image is a little unknown
 * 
 * @author Jamie Macaulay 
 */
public class Bitmap extends BufferedImage {

	public Bitmap(int width, int height, int cm) {
		super(width, height, cm);
	}

	public boolean isMutable() {
		return true;
	}

	public static Bitmap createBitmap(int width, int height) {
		// TODO Auto-generated method stub
		return new Bitmap(width,  height, BufferedImage.TYPE_USHORT_GRAY);
	}

	/**
	 * Returns in pixels[] a copy of the data in the bitmap. Each value is a packed
	 * int representing a Color. The stride parameter allows the caller to allow for
	 * gaps in the returned pixels array between rows. For normal packed results,
	 * just pass width for the stride value. The returned colors are
	 * non-premultiplied ARGB values in the sRGB color space.
	 * 
	 * @param pixels -The array to receive the bitmap's colors This value cannot be
	 *               null.
	 * @param offset     - The first index to write into pixels[]
	 * @param stride  - The number of entries in pixels[] to skip between rows (must
	 *               be >= bitmap's width). Can be negative.  (NOT YET IMPLEMENTED)
	 * @param x      - The x coordinate of the first pixel to read from the bitmap
	 * @param y      - The y coordinate of the first pixel to read from the bitmap
	 * @param width  - The number of pixels to read from each row
	 * @param height - The number of rows to read
	 */
	public void getPixels(int[] pixels, int offset, int stride, int x, int y, int width, int height) {

//		System.out.println("Get pixels: x " + x + " y " + y + " width " + width + " height " + height + " pixels" + pixels.length +  "  " +this.getHeight() +  "  " + this.getWidth()); 
		
		
		pixels = this.getData().getPixels(x, y, width, height, pixels);

	}

	/**
	 * Replace pixels in the bitmap with the colors in the array. Each element in
	 * the array is a packed int representing a non-premultiplied ARGB Color in the
	 * sRGB color space.
	 * 
	 * @param pixels - The colors to write to the bitmap This value cannot be null.
	 * @param offset - The index of the first color to read from pixels[]
	 * @param stride - The number of colors in pixels[] to skip between rows.
	 *               Normally this value will be the same as the width of the
	 *               bitmap, but it can be larger (or negative). (NOT YET IMPLEMENTED)
	 * @param x      - The x coordinate of the first pixel to write to in the
	 *               bitmap.
	 * @param y      - The y coordinate of the first pixel to write to in the
	 *               bitmap.
	 * @param width  - The number of colors to copy from pixels[] per row
	 * @param height - The number of rows to write to the bitmap
	 */
	public void setPixels(int[] pixels, int offset, int stride, int x, int y, int width, int height) {
		
		this.getRaster().setPixels(x, y, width, height, pixels);
	}

}
