// this is where all scoring tests are being merged
int count = 0;
int global = 0;
PImage result;
int PICSIZE = WIDTH * HEIGHT;

// RUN ALL THE SCORING TESTS
float score_painting(String filename) {
  // Take a filename of a painting to test how different it is from the
  // original and return the score in float type
  
  result = loadImage(filename);
  input.loadPixels();
  result.loadPixels();
  
  float gridSample = gridSampleTest();
  float whiteSpace = whiteSpaceTest();
  //println(count, ": gridSampleTest score: ", hehe);
  //count++;
  
  //global++;
  return gridSample + whiteSpace;
}
 

// CREATE THE PERCENTS CHART
float[] percentage() {
  //distTxt = createWriter("dist.txt");
  //scaledTxt = createWriter("scaled.txt");
  //pairTxt = createWriter("pair.txt");
  // Create arrays to save scores and percentages for each painting
  float[] scoreChart = new float[POPULATION];
  float[] perChart = new float[POPULATION];

  // Variables to calculate total scores and total percentage
  float totalScore = 0;
  
  // Call the test function on each painting to get its score
  for (int n=0; n<POPULATION; n++) {
    String painting = Integer.toString(n + GEN * 3) + ".png";
    scoreChart[n] = score_painting(painting); // save an individual score
    totalScore += scoreChart[n]; // add to the total score
  }
  
  // Calculate the percentage of the scores
  for (int n = 0; n < POPULATION; n++) {  
    perChart[n] = (scoreChart[n] / totalScore) * 100;
    //println(n, "score ", scoreChart[n], " percent ", perChart[n]);
  }
  return perChart;
}