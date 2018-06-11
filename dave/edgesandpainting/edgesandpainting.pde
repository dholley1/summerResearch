/* Edge detecting plus watercolor painting. */

PImage originalImage;  // the image that we are analyzing

int discRad = 2;       // the radius of the disc neighborhood for each pixel
int numChecks = 8;     // the number of pixel pairs to check for each 180 degree rotation

int xPt, yPt;          // for choosing a random point to paint

boolean oneClicked = false;     // true: when the mouse has been clicked on a first pixel
color firstColor, secondColor;  // stores the two clicked pixels' colors

void setup() {
  size(400, 200);
  ellipseMode(CENTER);
  
  colorMode(RGB, 100); // sets the RGB scale to 0-100 (rather than 0-255)
  background(100);
  
  // Put the original image on the left side of the window:
  originalImage = loadImage("mountain.jpg");
  image(originalImage, 0, 0);
}

void draw() {
  
  noLoop();
  
  // Paint a bunch of random points:
  for (int ctr = 0; ctr < 1000; ctr++) {
  
    // Paint a random point:
    xPt = (int) random(width);
    yPt = (int) random(height);
  
    Brush b = new Brush(get(xPt, yPt));
    b.display(xPt + width/2, yPt);
    
  }
  
  analyzeImage(originalImage);
  
}

void mousePressed() {
  ///* Check on a specific pixel. */
  
  //// Grab the probability that a pixel is on an edge:
  //int edgeProb = (int) pixelCheck(mouseX, mouseY);
  
  //// Color the associated pixel (on the right) with a grayscale version of that probability:
  //stroke(edgeProb);
  //point(mouseX + width/2, mouseY);
  
  //// For debugging:
  //println(edgeProb);
  
  //// Mark the clicked spot:
  //fill(50);
  //ellipse(mouseX, mouseY, 20, 20);
  //ellipse(mouseX + width/2, mouseY, 20, 20);
  
  // Alternative: Print the LAB colors of two clicked pixels, as well as their LAB distance:
  
  //if ( oneClicked == false ) {
  //  // then this is the first pixel clicked:
  //  firstColor = get(mouseX, mouseY);
  //  oneClicked = true;
  //} else {
  //  // else this is the second pixel clicked:
  //  secondColor = get(mouseX, mouseY);
  //  oneClicked = false;
    
  //  // Convert those colors to LAB values:
  //  float[] c0_LAB = RGB2LAB(red(firstColor), green(firstColor), blue(firstColor));
  //  float[] c1_LAB = RGB2LAB(red(secondColor), green(secondColor), blue(secondColor));
    
  //  println(c0_LAB);
  //  println(c1_LAB);
    
  //  // Grab the LAB distance between those colors:
  //  float distance = findDist(color((int) c0_LAB[0], (int) c0_LAB[1], (int) c0_LAB[2]),
  //                            color((int) c1_LAB[0], (int) c1_LAB[1], (int) c1_LAB[2])
  //                           );
    
  //  println(distance);
  //  println();
    
  //  fill(firstColor);
  //  rect(width/2, 0, width/4, height);
    
  //  fill(secondColor);
  //  rect(width - width/4, 0, width/4, height);
    
  //}
  
}

void analyzeImage(PImage img) {
  /* Move through the originalImage pixel by pixel, assigning a probability
     to each of being on an edge. */
     
  image(img, 0, 0);
  
  // Iterate through all of the pixels in the image:
  
  for (int i = 0; i < width/2; i++) {
    for (int j = 0; j < height; j++) {
      
      // Grab the probability that a pixel is on an edge:
      int edgeProb = (int) pixelCheck(i, j);
      
      // Color the associated pixel (on the right) with a grayscale version of that probability:
      //int edgeProbAdj = (edgeProb > 15) ? 100 : 0;
      //float edgeProbAdj = constrain(100 - pow(edgeProb, 2), 0, 100);
      //stroke(pow(edgeProb, 4));
      float edgeProbAdj = 100 - pow(edgeProb, 3);
      if ( edgeProbAdj < 90 ) {
        //stroke(edgeProbAdj);
        stroke(50);
        point(i + width/2, j);
      }
    }
  }
}

int pixelCheck(int i, int j) {
  /* Analyze the pixel (i, j) in the original image to predict the likelihood that it is on an edge. */
  
  // Set the original angle (for polar coordinates) to 0:
  float theta = 0;
  
  // Initialize a difference counter to keep track of total LAB distance between pairs:
  float diffCounter = 0;
  
  // Begin choosing pairs of pixels surrounding the given pixel (i, j):
  while ( theta < 3.14 ) {
  
    // Convert polar coordinates to rectangular; determine the 'start' and 'end' points for measuring gradient:
    int x0 = (int) (i + discRad * cos(theta));
    int y0 = (int) (j + discRad * sin(theta));
    int x1 = (int) (i + discRad * cos(theta + PI));
    int y1 = (int) (j + discRad * sin(theta + PI));
  
    // Grab the colors associated with the points (x0, y0) and (x1, y1):
    color c0 = get(x0, y0);
    color c1 = get(x1, y1);
    
    // Convert those colors to LAB values:
    float[] c0_LAB = RGB2LAB(red(c0), green(c0), blue(c0));
    float[] c1_LAB = RGB2LAB(red(c1), green(c1), blue(c1));
    
    // Grab the LAB distance between those colors:
    float distance = findDist(color((int) c0_LAB[0], (int) c0_LAB[1], (int) c0_LAB[2]),
                              color((int) c1_LAB[0], (int) c1_LAB[1], (int) c1_LAB[2])
                             );
    
    // Keep track of the total of the pairwise distances:
    diffCounter += distance;
  
    // Increment the angle so that we can perform a new gradient check:
    theta += PI / numChecks;
    
    // For debugging:
    //println("total distance / theta", diffCounter, theta);
  
  }
  
  // Take (and return) the average of the pairwise distances:
  int result = (int) (diffCounter / numChecks);
  return result;

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

class Brush {
  /* A Brush is comprised of 'child' layers added to a single 'parent' PShape. */
  
  PShape parent = createShape(GROUP);

  int brushRad = (int) random(5, 8);     // initial radius of brush
  int numLayers = (int) random(5, 9);    // number of layers that comprise each brush
  int numVerts[];                        // each layer has a different number of vertices
  
  color brushCol;   // the color of the paint to apply with the Brush
  
  Brush(color bc) {
    /* Constructor for a Brush; each 'child' layer is a polygon with a random number of sides. */
    
    brushCol = color(red(bc), green(bc), blue(bc), 1);
    
    float tempRad = brushRad;    // the radius changes as the 'child' layer is created
    float tempAng = 0;           // initialize the angle at 0
    int deltaRad = 2;            // radius changes by random(-deltaRad, +deltaRad)
    
    // Determine the (random) number of vertices per layer, and store them in an array:
    
    numVerts = new int[numLayers];
    for (int v = 0; v < numLayers; v++)
      numVerts[v] = (int) random(8, 16);
    
    // Create the 'child' layers:
        
    for (int layer = 0; layer < numLayers; layer++) {
      
      PShape child = createShape();
    
      child.beginShape();
        child.fill(brushCol);
        child.noStroke();
        int nv = numVerts[layer];
        for (int v = 0; v < nv; v++) {
          child.vertex(tempRad * cos(tempAng), tempRad * sin(tempAng));
          tempRad += (int) random(-deltaRad, deltaRad);
          tempAng += TWO_PI / nv;
        }
      child.endShape(CLOSE);

      parent.addChild(child);

    }
  }
  
  void display(float x, float y) {
    /* Put the Brush to paper. */
    
    float xNow = x;
    float yNow = y;
    for (int squiggle = 0; squiggle < 8; squiggle++) {
      shape(this.parent, xNow, yNow);
      xNow += random(-3, 3);
      yNow += random(-3, 3);
    }  
  }
  
}