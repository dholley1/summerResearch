float findDist(color c1, color c2) {
  float[] ColorInLab1 = rgbToLab(red(c1), green(c1), blue(c1));
  float[] ColorInLab2 = rgbToLab(red(c2), green(c2), blue(c2));

  float distance = calculateDist(ColorInLab1, ColorInLab2);
  return distance;
}

float calculateDist(float[] color1, float[] color2) {
  // calculation of a vector distance between two colors
  // given two CIELab colors returns the distance between them

  float L1 = color1[0];
  float a1 = color1[1];
  float b1 = color1[2];

  float L2 = color2[0];
  float a2 = color2[1];
  float b2 = color2[3];
  
  float distance = sqrt(pow(L1-L2, 2) + pow(a1-a2, 2) + pow(b1-b2, 2));
  
  return distance;
}

public float[] rgbToLab(float R, float G, float B) {

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