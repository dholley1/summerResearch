/* Edge detecting. */

// Mess with these variables:

String fileName = "bb.jpg";

float powerMod = 1;    // an exponent used in assigning whiteness to a pixel
int discRad = 1;       // the radius of the disc neighborhood for each pixel
int numChecks = 1;     // the number of pixel pairs to check for each 180 degree rotation

// Don't mess with these variables:

PImage originalImage;  // the image that we are analyzing

boolean oneClicked = false;     // true: when the mouse has been clicked on a first pixel
color firstColor, secondColor;  // stores the two clicked pixels' colors


PGraphics analyzeImage(PImage img) {
  /* Move through the originalImage pixel by pixel, assigning a probability
     to each of being on an edge. */
     
  PGraphics edges = createGraphics(200, 200);
  
  // Iterate through all of the pixels in the image:
  edges.beginDraw();
  
  for (int i = 0; i < WIDTH; i++) {
    for (int j = 0; j < HEIGHT; j++) {
      
      // Grab the probability that a pixel is on an edge:
      int edgeProb = (int) pixelCheck(i, j, img);
      
      // Color the associated pixel (on the right) with a grayscale version of that probability:
      
      float edgeProbAdj = constrain(pow(edgeProb, powerMod), 0, 255);  // tweak the probability
      edges.stroke(edgeProbAdj);
      edges.point(i, j);
      
    }
  }
  edges.endDraw();
  edges.save("data/edges.png");
  return edges;
}

int pixelCheck(int i, int j, PImage img) {
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
    color c0 = img.get(x0, y0);
    color c1 = img.get(x1, y1);
    
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
    
  }
  
  // Take (and return) the average of the pairwise distances:
  int result = (int) (diffCounter / numChecks);
  return result;

}
