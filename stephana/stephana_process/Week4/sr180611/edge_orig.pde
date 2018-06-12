// 1 take the original picture and get the edge of it
// 2 take the painting and get the edge of it

PImage inputEdge;
PImage resultEdge;

float powerMod = 3; // 
int discRad = 2; // radius of spinner
int numChecks = 8; // number of samples

boolean oneClicked = false;
color firstColor, secondColor;

void analyzeImage(PImage img) {
  /* Move through the originalImage pixel by pixel, assigning a probability
     to each of being on an edge. */
     
  //image(img, 0, 0);
  
  // Iterate through all of the pixels in the image:
  
  for (int i = 0; i < img.width/2; i++) {
    for (int j = 0; j < img.height; j++) {
      
      // Grab the probability that a pixel is on an edge:
      int edgeProb = (int) pixelCheck(i, j);
      
      // Color the associated pixel (on the right) with a grayscale version of that probability:
      
      float edgeProbAdj = constrain(pow(edgeProb, powerMod), 0, 100);  // tweak the probability
      stroke(edgeProbAdj);
      point(i + img.width/2, j);
      
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
    
  }
  
  // Take (and return) the average of the pairwise distances:
  int result = (int) (diffCounter / numChecks);
  return result;

}
