package org.jamdev.jpamutils;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
        double max = JamArr.max(new double[][] {{1.0, 2.0, 3.0},{1.1, 2.1, 3.1},{Double.NaN, 4.0, 3.0}}); 
        double min = JamArr.min(new double[][] {{1.0, 2.0, 3.0},{1.1, 2.1, 3.1},{Double.NaN, 4.0, 3.0}}); 

        System.out.println("Max min test: " + max + "  " + min) ;

    }
}
