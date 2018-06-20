/* Edge detecting. */

// Mess with these variables:

String fileName = "frog.png";

float powerMod = 3;    // an exponent used in assigning whiteness to a pixel
int discRad = 5;       // the radius of the disc neighborhood for each pixel
int numChecks = 5;     // the number of pixel pairs to check for each 180 degree rotation

// Don't mess with these variables:

PImage originalImage;  // the image that we are analyzing

boolean oneClicked = false;     // true: when the mouse has been clicked on a first pixel
//color firstColor, secondColor;  // stores the two clicked pixels' colors


// we want this in the other direction as well

int pixelCheck(int i, int j) {
  /* Analyze the pixel (i, j) in the original image to predict the likelihood that it is on an edge. */
  
  // Set the original angle (for polar coordinates) to 0:
  float theta = 0;
  
  // Initialize a difference counter to keep track of total LAB distance between pairs:
  float diffCounter = 0;
  
  // Begin choosing pairs of pixels surrounding the given pixel (i, j):
  while ( theta < 3.14 ) {
  
    // positions 180 degrees opposite to each other
    
    // Convert polar coordinates to rectangular; determine the 'start' and 'end' points for measuring gradient:
    int x0 = (int) (i + discRad * cos(theta));
    int y0 = (int) (j + discRad * sin(theta));
    int x1 = (int) (i + discRad * cos(theta + PI));
    int y1 = (int) (j + discRad * sin(theta + PI));
      
    /*
    ^^^ here we got two points looking at each other 180 degrees
    take samples of the surrounding to take the average
    */
    
    float sampleR = 3;
    float sampleN = 8;
    
    // for x0 and y0
    
    float[] dist0 = new float[3];
    
    for (int m=0; m<sampleN; m++) {
      // get random radius and random angle
      float randR = random(sampleR);
      float randA = random(TWO_PI);
      
      // calculate x, y of the point
      int randX = (int) (randR * cos(randA));
      int randY = (int) (randR * sin(randA));
      
      // get color and convert to lab
      color c = get(randX, randY);
      float[] CinLab = RGB2LAB(red(c), green(c), blue(c));
      
      // add by L, a, b
      dist0[0] += CinLab[0];
      dist0[1] += CinLab[1];
      dist0[2] += CinLab[2];
    }
    
    float[] avg0 = {dist0[0]/sampleN, dist0[1]/sampleN, dist0[2]/sampleN};
    
    
    // for x0 and y0
    
    float[] dist1 = new float[3];
    
    for (int m=0; m<sampleN; m++) {
      // get random radius and random angle
      float randR = random(sampleR);
      float randA = random(TWO_PI);
      
      // calculate x, y of the point
      int randX = (int) (randR * cos(randA));
      int randY = (int) (randR * sin(randA));
      
      // get color and convert to lab
      color c = get(randX, randY);
      float[] CinLab = RGB2LAB(red(c), green(c), blue(c));
      
      // add by L, a, b
      dist1[0] += CinLab[0];
      dist1[1] += CinLab[1];
      dist1[2] += CinLab[2];
    }
    
    float[] avg1 = {dist1[0]/sampleN, dist1[1]/sampleN, dist1[2]/sampleN};
    
    
    // avg0 and avg1 are the averaged colors in Lab
    
    // at this point, two possible directions: 1) take the difference of avg0 and avg1 and used like the way it was used in the original
    // 2) compare to the color at the center
    
    
    
    
    // Grab the colors associated with the points (x0, y0) and (x1, y1):
    color c0 = originalImage.get(x0, y0);
    color c1 = originalImage.get(x1, y1);
    
    // Convert those colors to LAB values:
    float[] c0_LAB = RGB2LAB(red(c0), green(c0), blue(c0));
    float[] c1_LAB = RGB2LAB(red(c1), green(c1), blue(c1));
    
    // Grab the LAB distance between those colors:
    float distance = findDist(color((int) c0_LAB[0], (int) c0_LAB[1], (int) c0_LAB[2]),
                              color((int) c1_LAB[0], (int) c1_LAB[1], (int) c1_LAB[2]));
    
    // Keep track of the total of the pairwise distances:
    diffCounter += distance;
  
    // Increment the angle so that we can perform a new gradient check:
    theta += PI / numChecks;
    
  }
  
  // Take (and return) the average of the pairwise distances:
  int result = (int) (diffCounter / numChecks);
  return result;

}
