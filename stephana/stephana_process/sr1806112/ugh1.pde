//static int countEdge = 0;

//float powerMod = 3;
//int discRad = 2;
//int numChecks = 8;

//boolean oneClicked = false;
//color firstColor, secondColor;


///*this is where we create the edge file--
//assuming that i saved the file properly (i don't think i am doing this correctly because
//i need to figure out how to create and save image without showing on the screen uhhh*/

//// take the picture/painting and produce the edge black white version of it
//// gotta save at the end
//void analyzeImage() {
//  for (int i=0; i< result.width; i++) {
//    for (int j=0; j< result.height; j++) {
//      int edgeProb = (int) pixelCheck(i, j);
//      float edgeProbAdj = constrain(pow(edgeProb, powerMod), 0, 100);  // tweak the probability
//      stroke(edgeProbAdj);
//      point(i + result.width, j);
//    }
//  }
//  // look up how we are saving the paintings and modify that to save the edged file
//  // then, come up with a function that takes the original edge and result edge and compare them
//  // ^^^ that is my job!
//  save("data/edge" + Integer.toString(countEdge) + ".jpg");
//  countEdge++;
//}

//int pixelCheck(int i, int j) {
//  /* Analyze the pixel (i, j) in the original image to predict the likelihood that it is on an edge. */
  
//  // Set the original angle (for polar coordinates) to 0:
//  float theta = 0;
  
//  // Initialize a difference counter to keep track of total LAB distance between pairs:
//  float diffCounter = 0;
  
//  // Begin choosing pairs of pixels surrounding the given pixel (i, j):
//  while ( theta < 3.14 ) {
  
//    // Convert polar coordinates to rectangular; determine the 'start' and 'end' points for measuring gradient:
//    int x0 = (int) (i + discRad * cos(theta));
//    int y0 = (int) (j + discRad * sin(theta));
//    int x1 = (int) (i + discRad * cos(theta + PI));
//    int y1 = (int) (j + discRad * sin(theta + PI));
  
//    // Grab the colors associated with the points (x0, y0) and (x1, y1):
//    color c0 = get(x0, y0);
//    color c1 = get(x1, y1);
    
//    // Convert those colors to LAB values:
//    float[] c0_LAB = RGB2LAB(red(c0), green(c0), blue(c0));
//    float[] c1_LAB = RGB2LAB(red(c1), green(c1), blue(c1));
    
//    // Grab the LAB distance between those colors:
//    float distance = findDist(color((int) c0_LAB[0], (int) c0_LAB[1], (int) c0_LAB[2]),
//                              color((int) c1_LAB[0], (int) c1_LAB[1], (int) c1_LAB[2])
//                             );
    
//    // Keep track of the total of the pairwise distances:
//    diffCounter += distance;
  
//    // Increment the angle so that we can perform a new gradient check:
//    theta += PI / numChecks;
    
//  }
  
//  // Take (and return) the average of the pairwise distances:
//  int result = (int) (diffCounter / numChecks);
//  return result;
//}


//// write a function that compares the original edge and the result edge
//// divide the entire canvas into grids and see how many white spaces are there
//// don't compare pixel by pixel but do around the white spaces

//PImage inputEdge;
//PImage resultEdge;

//float okayedgeudontmatterapparently(String filename) {
//  resultEdge = loadImage(filename);
  
//  float totalScore = 0;
//  int gridSide = 5;
//  int sampleNum = 10;
//  int gridNum = (WIDTH/gridSide) * (HEIGHT/gridSide);
//  int totalSample = gridNum * sampleNum;
  
//  for (int w=0; w<WIDTH; w+=gridSide) {
//    for (int h=0; h<HEIGHT; h+=gridSide) {
//      for (int i=0; i<sampleNum; i++) {
//        int r1 = w + int(random(gridSide));
//        int r2 = h + int(random(gridSide));
//        color inputC = inputEdge.get(r1, r2);
//        color resultC = resultEdge.get(r1, r2);
//        float dist = findDist(inputC, resultC);
//        float scaledScore = scaleDist(dist);
//        totalScore += scaledScore;
//      }
//    }
//  }
//  float avgScore = totalScore/totalSample;
//  return avgScore;
//}
