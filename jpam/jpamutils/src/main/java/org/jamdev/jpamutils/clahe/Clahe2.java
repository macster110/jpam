package org.jamdev.jpamutils.clahe;


/**
 * A self-contained, library-free implementation of the Contrast Limited Adaptive
 * Histogram Equalization (CLAHE) algorithm in Java.
 * This version is adapted to take a float[][] (normalized 0.0-1.0) as input.
 */
public class Clahe2 {

    // The number of gray levels used for internal histogram calculations.
    private static final int NUM_GRAY_LEVELS = 256;

    /**
     * Performs the CLAHE transformation on a normalized float image.
     *
     * @param image An image represented by a 2D float array with values normalized between 0.0 and 1.0.
     * @param xTiles The number of tiles in the X direction.
     * @param yTiles The number of tiles in the Y direction.
     * @param clipLimit The contrast clip limit, typically between 0.001 and 0.01.
     * @param alpha The alpha parameter for the Rayleigh distribution.
     * @return A new 2D float array representing the transformed image, with values normalized between 0.0 and 1.0.
     */
    public static double[][] transform(double[][] image, int xTiles, int yTiles, double clipLimit, double alpha) {
        int width = image[0].length;
        int height = image.length;

        // 1. Vertically flip the image (replicating 'flipud')
        //        double[][] flippedImage = flipVertical(image);
        //don't need this in Java, but keeping for clarity
        double[][] flippedImage =image;

        // Calculate tile dimensions
        int tileWidth = width / xTiles;
        int tileHeight = height / yTiles;

        // 2. Create the mapping functions (Lookup Tables) for each tile
        int[][][] luts = new int[xTiles][yTiles][NUM_GRAY_LEVELS];
        double[] targetRayleighCDF = createRayleighCDF(NUM_GRAY_LEVELS, alpha);

        for (int i = 0; i < xTiles; i++) {
            for (int j = 0; j < yTiles; j++) {
                int startX = i * tileWidth;
                int startY = j * tileHeight;
                int endX = startX + tileWidth;
                int endY = startY + tileHeight;

                // Create a histogram for the current tile by discretizing float values
                int[] tileHistogram = new int[NUM_GRAY_LEVELS];
                int tilePixelCount = tileWidth * tileHeight;

                for (int x = startX; x < endX; x++) {
                    for (int y = startY; y < endY; y++) {
                        // Discretize the float value to an integer bin (0-255)
                        int grayValue = (int) (flippedImage[y][x] * (NUM_GRAY_LEVELS - 1));
                        grayValue = Math.max(0, Math.min(NUM_GRAY_LEVELS - 1, grayValue)); // Clamp to be safe
                        tileHistogram[grayValue]++;
                    }
                }

                // Clip the histogram
                int[] clippedHistogram = clipHistogram(tileHistogram, clipLimit, tilePixelCount, NUM_GRAY_LEVELS);

                // Create the mapping LUT for this tile based on the Rayleigh distribution
                luts[i][j] = createMappingLUT(clippedHistogram, targetRayleighCDF, tilePixelCount, NUM_GRAY_LEVELS);
            }
        }
        
        // 3. Apply bilinear interpolation and create the final image
        double[][] resultImage = new double[height][width];
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                // Interpolate to get the new integer gray value
                int newGrayValue = interpolate(x, y, flippedImage[y][x], luts, tileWidth, tileHeight, xTiles, yTiles);
                // Normalize the result back to a float between 0.0 and 1.0
                resultImage[y][x] = newGrayValue / (float)(NUM_GRAY_LEVELS - 1);
            }
        }

        return resultImage;
    }

    // --- Helper Methods ---

    /**
     * Replicates MATLAB's flipud function for a float matrix.
     */
    private static double[][] flipVertical(double[][] matrix) {
        int height = matrix.length;
        int width = matrix[0].length;
        double[][] flipped = new double[height][width];
        for (int i = 0; i < height; i++) {
            flipped[i] = matrix[height - 1 - i];
        }
        return flipped;
    }

    /**
     * Clips the histogram according to the clipLimit and redistributes the excess.
     * (This method does not need to change)
     */
    private static int[] clipHistogram(int[] histogram, double clipLimit, int tilePixelCount, int numGrayLevels) {
        int clipThreshold = (int) (clipLimit * tilePixelCount);
        if (clipThreshold < 1) clipThreshold = 1;

        int totalExcess = 0;
        for (int i = 0; i < numGrayLevels; i++) {
            if (histogram[i] > clipThreshold) {
                totalExcess += histogram[i] - clipThreshold;
                histogram[i] = clipThreshold;
            }
        }

        int redistributionPerBin = totalExcess / numGrayLevels;
        int remainder = totalExcess % numGrayLevels;

        for (int i = 0; i < numGrayLevels; i++) {
            histogram[i] += redistributionPerBin;
        }
        for (int i = 0; i < remainder; i++) {
            histogram[i]++;
        }
        
        return histogram;
    }

    /**
     * Creates the target Cumulative Distribution Function (CDF) for a Rayleigh distribution.
     * (This method does not need to change)
     */
    private static double[] createRayleighCDF(int numGrayLevels, double alpha) {
        double[] rayleighCDF = new double[numGrayLevels];
        double scale = -2 * alpha * alpha;
        for (int i = 0; i < numGrayLevels; i++) {
            double normalizedVal = (double) i / (numGrayLevels - 1);
            rayleighCDF[i] = 1 - Math.exp((normalizedVal * normalizedVal) / scale);
        }
        return rayleighCDF;
    }

    /**
     * Creates the final pixel mapping lookup table (LUT) for a tile.
     * (This method does not need to change)
     */
    private static int[] createMappingLUT(int[] tileHistogram, double[] targetCDF, int tilePixelCount, int numGrayLevels) {
        int[] lut = new int[numGrayLevels];
        double[] tileCDF = new double[numGrayLevels];
        
        double cumulativeFrequency = 0;
        for (int i = 0; i < numGrayLevels; i++) {
            cumulativeFrequency += tileHistogram[i];
            tileCDF[i] = cumulativeFrequency / tilePixelCount;
        }

        for (int i = 0; i < numGrayLevels; i++) {
            int j = 0;
            while (j < numGrayLevels - 1 && targetCDF[j] < tileCDF[i]) {
                j++;
            }
            lut[i] = j;
        }
        return lut;
    }
    
    /**
     * Performs bilinear interpolation for a single pixel.
     * Takes the original float value as input.
     */
    private static int interpolate(int x, int y, double originalValue, int[][][] luts, int tileWidth, int tileHeight, int xTiles, int yTiles) {
        // Convert original float value to an integer bin index for LUT lookup
        int originalBinIndex = (int)(originalValue * (NUM_GRAY_LEVELS - 1));
        originalBinIndex = Math.max(0, Math.min(NUM_GRAY_LEVELS - 1, originalBinIndex));

        // Find indices of the four surrounding tiles
        int tx = Math.min((int) Math.floor((double) x / tileWidth), xTiles - 1);
        int ty = Math.min((int) Math.floor((double) y / tileHeight), yTiles - 1);
        
        // Calculate the center coordinates of the top-left tile's interpolation region
        double cx = (tx + 0.5) * tileWidth;
        double cy = (ty + 0.5) * tileHeight;

        // Get the four surrounding tile LUTs
        int[] lutA = luts[tx][ty];
        int[] lutB = (tx + 1 < xTiles) ? luts[tx + 1][ty] : lutA;
        int[] lutC = (ty + 1 < yTiles) ? luts[tx][ty + 1] : lutA;
        int[] lutD = (tx + 1 < xTiles && ty + 1 < yTiles) ? luts[tx + 1][ty + 1] : lutA;
        
        // Get mapped values from each of the four LUTs using the bin index
        int valA = lutA[originalBinIndex];
        int valB = lutB[originalBinIndex];
        int valC = lutC[originalBinIndex];
        int valD = lutD[originalBinIndex];

        // Calculate interpolation weights
        double xFrac = (x - (cx - 0.5 * tileWidth)) / tileWidth;
        double yFrac = (y - (cy - 0.5 * tileHeight)) / tileHeight;
        xFrac = Math.max(0, Math.min(1.0, xFrac)); // Clamp weights
        yFrac = Math.max(0, Math.min(1.0, yFrac));

        // Interpolate in x-direction
        double top = valA * (1 - xFrac) + valB * xFrac;
        double bottom = valC * (1 - xFrac) + valD * xFrac;
        
        // Interpolate in y-direction
        double result = top * (1 - yFrac) + bottom * yFrac;

        return (int) Math.round(result);
    }

    /**
     * Example usage.
     */
    public static void main(String[] args) {
        // Create a sample float image (e.g., a gradient from 0.0 to 1.0)
        int width = 512;
        int height = 512;
        double[][] sampleImage = new double[height][width];
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                // Create a diagonal gradient
                sampleImage[y][x] = (double)(x + y) / (width + height);
            }
        }
        
        // Parameters from the user's MATLAB code
        int xTile = 8;
        int yTile = 8;
        double clipLimit = 0.005;
        double alpha = 0.4;
        
        System.out.println("Applying custom CLAHE transform to float image...");
        
        // Perform the transformation
        double[][] resultImage = Clahe2.transform(sampleImage, xTile, yTile, clipLimit, alpha);
        
        System.out.println("Transform complete.");
        // You can now use the `resultImage` array. Let's print a few example values.
        System.out.printf("Original value at (10, 10): %.4f\n", sampleImage[10][10]);
        System.out.printf("Transformed value at (10, 10): %.4f\n", resultImage[10][10]);
        System.out.printf("Original value at (256, 256): %.4f\n", sampleImage[256][256]);
        System.out.printf("Transformed value at (256, 256): %.4f\n", resultImage[256][256]);
    }
}