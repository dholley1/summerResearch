// this is where all scoring tests are being merged


int global = 0;

// RUN ALL THE SCORING TESTS
float score_painting(String filename) {
  // Take a filename of a painting to test how different it is from the
  // original and return the score in float type
  
  result = loadImage(filename);
  input.loadPixels();
  result.loadPixels();
  
  float scorePixel = round(pixel_color());
  float scoreWhite = round(check_white());
  float scoreColor = round(color_variation());
  float scoreAlpha = round(alpha_check());
  float scoreHue = round(hue_check());
  float scoreSat = round(sat_check());
  check_black();

  float finalScore = round(scorePixel*0.3 + scoreWhite*0.3 + scoreColor*0.2
                           + scoreAlpha*0.05 + scoreHue*0.05 + scoreSat*0.1);
  //println(global, "pixel: ", scorePixel, " white: ", scoreWhite, " color: ",
  //        scoreColor, " alpha: ", scoreAlpha, " hue: ", scoreHue, " saturation: ",
  //        scoreSat, " final: ", finalScore);
  
  global++;
  return finalScore;
}


// CREATE THE PERCENTS CHART
float[] percentage() {
  
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
