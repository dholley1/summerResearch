///* Edge detecting. */

//// Mess with these variables:

////String fileName = "original.png";
//String fileName = "frog.png";
////String fileName = "road.jpg";
////String fileName = "frog1.png";

//// Don't mess with these variables:

//PImage originalImage;         // the image that we are analyzing
//boolean clickedOnce = false;  // true when the user has clicked on one pixel but not another yet
//color colorOne, colorTwo;     // the RGB colors of the first and second clicked pixels

//void setup() {
//  size(400, 200);
//  ellipseMode(CENTER);
//  background(0);
  
//  colorMode(RGB, 100); // sets the RGB scale to 0-100 (rather than 0-255)
  
//  // Put the original image on the left side of the window:
//  originalImage = loadImage(fileName);
//  image(originalImage, 0, 0);
//}

//void draw() {
  
//  //analyzeImage(originalImage);
  
//}







void setup() {
  size(400, 200);
  ellipseMode(CENTER);
  background(0);

  colorMode(RGB, 100); // sets the RGB scale to 0-100 (rather than 0-255)
  
  // Put the original image on the left side of the window:
  originalImage = loadImage(fileName);
  
  image(originalImage, 0, 0);

}

void draw() {
  
  noLoop();
  analyzeImage();
}

void analyzeImage() {
  /* Move through the originalImage pixel by pixel, assigning a probability
     to each of being on an edge. */
       
  // Iterate through all of the pixels in the image:
  
  for (int i = 0; i < width/2; i++) {
    for (int j = 0; j < height; j++) {
      if (i % 5 == 0) {        
        stroke(255);
        point(i, j);
      }

      // Grab the probability that a pixel is on an edge:
      int edgeProb = (int) pixelCheck(i, j);
      
      // Color the associated pixel (on the right) with a grayscale version of that probability:
      
      float edgeProbAdj = constrain(pow(edgeProb, powerMod), 0, 1000);  // tweak the probability
      stroke(edgeProbAdj);
      point(i+width/2, j);
      
    }
  }
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width/2; x++) {
      if (y % 5 == 0 || y % 5 == 1) {
        stroke(0);
        point(x, y);
      }
      int edgeProb2 = (int) pixelCheck(x, y);
      float edgeProbAdj2 = constrain(pow(edgeProb2, powerMod), 0, 1000);
      stroke(edgeProbAdj2);
      point(x+width/2, y);
    }
  }
}
