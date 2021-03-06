/* Final version of the RGB <-> LAB conversions, along with a color average test.

   Three rectangular strips are displayed. Strip 1 is randomly filled. Strip 2 has the
   same Red value but the Green and Blue values react to the mouse. Strip 3 is the
   'average' of the first two strip colors, using RGB to LAB conversion.
*/

color c1;    // fill color of the first strip

void setup() {
  size(600, 255);
  
  // Set the color of the first strip's fill. Can be changed with keypress:
  c1 = color(130, 100, 127);
}

void draw() {
  
  // The second strip keeps the same Red value as the first:
  color c2 = color(red(c1), mouseX, mouseY);
  
  // The first two strips show the given colors:
  
  fill(c1);
  rect(0, 0, width/3, height);
  
  fill(c2);
  rect(width/3, 0, width/3, height);
  
  // The third strip shows the 'average' of the colors, using LAB (to RGB):
  
  float[] c1asLAB = RGB2LAB(red(c1), green(c1), blue(c1));
  float[] c2asLAB = RGB2LAB(red(c2), green(c2), blue(c2));
  
  float[] c3asLAB = {(int) ((c1asLAB[0] + c2asLAB[0]) / 2),
                     (int) ((c1asLAB[1] + c2asLAB[1]) / 2),
                     (int) ((c1asLAB[2] + c2asLAB[2]) / 2)
                    };
  
  float[] c3asRGB = LAB2RGB(c3asLAB[0], c3asLAB[1], c3asLAB[2]);
  
  fill(c3asRGB[0], c3asRGB[1], c3asRGB[2]);
  rect(width * 2 / 3, 0, width/3, height);
  
  // Print the LAB distance between the first two colors:
  println(findDist(c1, c2));
  
}

void keyPressed() {
  /* Change the c1 color to a new random color. */
  c1 = color(random(255), random(255), random(255));
}

float findDist(color c1, color c2) {
  /* Returns the Euclidean distance between the LAB colors c1 and c2. */
  
  float[] ColorInLab1 = RGB2LAB(red(c1), green(c1), blue(c1));
  float[] ColorInLab2 = RGB2LAB(red(c2), green(c2), blue(c2));

  // Get the distance between the two LAB colors:
  float distance = calculateDist(ColorInLab1, ColorInLab2);
  return distance;
}

float calculateDist(float[] color1, float[] color2) {
  /* Calculates a vector distance between two LAB colors. */

  float L1 = color1[0];
  float a1 = color1[1];
  float b1 = color1[2];

  float L2 = color2[0];
  float a2 = color2[1];
  float b2 = color2[2];
  
  float distance = sqrt(pow(L1-L2, 2) + pow(a1-a2, 2) + pow(b1-b2, 2));
  
  return distance;
}

public float[] RGB2LAB(float R, float G, float B) {
  /* Convert a given RGB triple to its LAB equivalent. */

  float r, g, b, X, Y, Z, xr, yr, zr;

  float Xr = 95.047;  
  float Yr = 100.0;
  float Zr = 108.883;


  // --------- RGB to XYZ ---------//

  r = R/255.0;
  g = G/255.0;
  b = B/255.0;

  if ( r > 0.04045 )
    r = pow((r+0.055)/1.055,2.4);
  else
    r = r/12.92;

  if ( g > 0.04045 )
    g = pow((g+0.055)/1.055,2.4);
  else
    g = g/12.92;

  if ( b > 0.04045 )
    b = pow((b+0.055)/1.055,2.4);
  else
    b = b/12.92 ;

  r *= 100;
  g *= 100;
  b *= 100;

  X = 0.4124*r + 0.3576*g + 0.1805*b;
  Y = 0.2126*r + 0.7152*g + 0.0722*b;
  Z = 0.0193*r + 0.1192*g + 0.9505*b;


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


public float[] LAB2RGB(float L, float a, float b) {
  /* Return the RGB triple equivalent to a given LAB triple. */
  
  float y = (L + 16)/116.0;
  float x = y + a/500.0;
  float z = y - b/200.0;
 
  float[] XYZ = new float[3];
 
  x = x*x*x > 8856e-6? x*x*x : (-16.0/116.0 + x)/7.787;
  y = y*y*y > 8856e-6? y*y*y : (-16.0/116.0 + y)/7.787;
  z = z*z*z > 8856e-6? z*z*z : (-16.0/116.0 + z)/7.787;
 
  XYZ[0] = 95.047*x;
  XYZ[1] = 100.0*y;
  XYZ[2] = 108.883*z;
 
  float r = XYZ[0]*.01, s = XYZ[1]*.01, t = XYZ[2]*.01;
 
  float red   = r*3.2406 - s*1.5372 - t*.4986;
  float green = r*-.9689 + s*1.8758 + t*.0415;
  float blue  = r*.0557  - s*.204   + t*1.057;
  
  float[] RGBcolor = new float[3];
 
  red   = red > 31308e-7? pow(red, 1.0/2.4)*1.055 - .055 : red*12.92;
  green = green > 31308e-7? pow(green, 1.0/2.4)*1.055 - .055 : green*12.92;
  blue  = blue > 31308e-7? pow(blue, 1.0/2.4)*1.055 - .055 : blue*12.92;
 
  RGBcolor[0] = constrain((red*255.0), 0, 0xFF);
  RGBcolor[1] = constrain((green*255.0), 0, 0xFF);
  RGBcolor[2] = constrain((blue*255.0), 0, 0xFF);
 
  return RGBcolor;
}