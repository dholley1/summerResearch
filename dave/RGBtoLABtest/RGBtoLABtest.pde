/* Places two rectangles side by side, one with a fixed RGB color and the other with
   a variable RGB color; outputs to the console the LAB distance between the colors.
   
   According to 
   https://www.colourphil.co.uk/lab_lch_colour_space.shtml
   the untrained human eye can detect color difference when the LAB score is 4.0 and up.

   RGB to LAB converstion is based on a stackoverflow post: 
   https://stackoverflow.com/questions/4593469/java-how-to-convert-rgb-color-to-cie-lab

   The conversion checks out with the conversion at:
   http://colormine.org/convert/rgb-to-lab */

void setup() {
  size(400, 255);
}

void draw() {
  /* Put two colors side by side in the window, with the second color's blue value
     sensitive to the vertical mouse location: */
     
  color c1 = color(255, 100, 127);      // a fixed color
  color c2 = color(255, 100, mouseY);   // a color that varies by blue
  
  // Make the rectangles:
  fill(c1);
  rect(0, 0, width/2, height);
  
  fill(c2);
  rect(width/2, 0, width/2, height);
  
  // Output the LAB distance to the console:
  println(distLAB(rgbToLab((int) red(c1), (int) green(c1), (int) blue(c1)),
                  rgbToLab((int) red(c2), (int) green(c2), (int) blue(c2))));
}

float[] rgbToLab(int R, int G, int B) {
  /* Converts an RGB triple to a LAB triple. */

    float r, g, b, X, Y, Z, xr, yr, zr;

    // D65/2° (Dave is not sure what this comment means..)
    float Xr = 95.047;  
    float Yr = 100.0;
    float Zr = 108.883;


    // --------- RGB to XYZ ---------//

    r = R/255.0;
    g = G/255.0;
    b = B/255.0;

    if (r > 0.04045)
        r = pow((r+0.055)/1.055,2.4);
    else
        r = r/12.92;

    if (g > 0.04045)
        g = pow((g+0.055)/1.055,2.4);
    else
        g = g/12.92;

    if (b > 0.04045)
        b = pow((b+0.055)/1.055,2.4);
    else
        b = b/12.92 ;

    r*=100;
    g*=100;
    b*=100;

    X =  0.4124*r + 0.3576*g + 0.1805*b;
    Y =  0.2126*r + 0.7152*g + 0.0722*b;
    Z =  0.0193*r + 0.1192*g + 0.9505*b;


    // --------- XYZ to Lab --------- //

    xr = X/Xr;
    yr = Y/Yr;
    zr = Z/Zr;

    if ( xr > 0.008856 )
        xr = pow(xr, 1/3.);
    else
        xr = ((7.787 * xr) + 16 / 116.0);

    if ( yr > 0.008856 )
        yr = pow(yr, 1/3.);
    else
        yr = ((7.787 * yr) + 16 / 116.0);

    if ( zr > 0.008856 )
        zr = pow(zr, 1/3.);
    else
        zr = ((7.787 * zr) + 16 / 116.0);


    float[] lab = new float[3];

    lab[0] = (116*yr)-16;
    lab[1] = 500*(xr-yr); 
    lab[2] = 200*(yr-zr); 

    return lab;
} 

float distLAB(float[] colorOne, float[] colorTwo) {
  /* Return the LAB distance between colorOne and colorTwo (both in RGB): */
  
  float d = sqrt(pow(colorOne[0] - colorTwo[0], 2) +
                 pow(colorOne[1] - colorTwo[1], 2) +
                 pow(colorOne[2] - colorTwo[2], 2));
                 
  return d;
}