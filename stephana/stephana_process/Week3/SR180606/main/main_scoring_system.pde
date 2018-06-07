// this is where all scoring tests are being merged


int global = 0;

// RUN ALL THE SCORING TESTS
float score_painting(String filename) {
  // Take a filename of a painting to test how different it is from the
  // original and return the score in float type
  
  result = loadImage(filename);
  input.loadPixels();
  result.loadPixels();
  
  float scorePixel = round(pixel_color());     // 30%
  float scoreWhite = round(check_white());     // 30%
  float scoreColor = round(color_variation()); // 20%
  float scoreAlpha = round(alpha_check());     // 0%
  float scoreHue = round(hue_check());         // 5%
  float scoreSat = round(sat_check());         // 5%
  float scoreBlack = round(check_black());     // 10%
  
  float hehe = gridSampleTest();
  //println("gridSampleTest score: ", hehe);

  float finalScore = round(scorePixel*0.8 + scoreWhite*0.3 + scoreColor*0.2 + scoreAlpha*0 + scoreHue*0.05 + scoreSat*0.05 + scoreBlack*0.1);
  //println(global, "| pixel: ", scorePixel, " white: ", scoreWhite, " color: ", scoreColor,
  //        " alpha: ", scoreAlpha, " hue: ", scoreHue, " saturation: ", scoreSat,
  //        " black: ", scoreBlack, " final: ", finalScore);
  
  global++;
  return finalScore;
}


// CREATE THE PERCENTS CHART
float[] percentage() {
  output = createWriter("table.txt");
  
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