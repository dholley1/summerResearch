// take tuple and radius
// modify this such that it compares the center with the random samples
// original color 80% and the next color 20%

int pixelCheck(tuple center, tuple point, int radius, int samplePop) {
  /* Analyze the pixel (i, j) in the original image to predict the likelihood that it is on an edge. */

  float i = point.x;
  float j = point.y;
  
  // Set the original angle (for polar coordinates) to 0:
  float theta = 0;
  
  // Initialize a difference counter to keep track of total LAB distance between pairs:
  float diffCounter = 0;
  
  // Begin choosing pairs of pixels surrounding the given pixel (i, j):
  while ( theta <= PI ) {
  
    // Convert polar coordinates to rectangular; determine the 'start' and 'end' points for measuring gradient:
    int x0 = (int) (i + radius * cos(theta));
    int y0 = (int) (j + radius * sin(theta));
    int x1 = (int) (i + radius * cos(theta + PI));
    int y1 = (int) (j + radius * sin(theta + PI));
  
    // Grab the colors associated with the points (x0, y0) and (x1, y1):
    color c0 = get(x0, y0);
    color c1 = get(x1, y1);
    
    // Convert those colors to LAB values:
    float[] c0_LAB = RGB2LAB(red(c0), green(c0), blue(c0));
    float[] c1_LAB = RGB2LAB(red(c1), green(c1), blue(c1));
    
    // Grab the LAB distance between those colors:
    float distance = findDist(color(red((int) c0_LAB[0]), green((int) c0_LAB[1]), blue((int) c0_LAB[2])),
                              color(red((int) c1_LAB[0]), green((int) c1_LAB[1]), blue((int) c1_LAB[2])));
    
    // Keep track of the total of the pairwise distances:
    diffCounter += distance;
  
    // Increment the angle so that we can perform a new gradient check:
    theta += PI / samplePop;
  
  }
  
  // Take (and return) the average of the pairwise distances:
  int result = (int) (diffCounter / samplePop);
  return result;

}