//int global = 0;

//// Take a filename of a painting to test how different it is from the
//// original and return the score in float type
//float score_painting(String filename) {
//  result = loadImage(filename);
//  input.loadPixels();
//  result.loadPixels();
  
//  float scorePixel = round(pixel_color());
//  float scoreWhite = round(check_white());
//  float scoreColor = round(color_variation());
//  float scoreAlpha = round(alpha_check());
//  float scoreHue = round(hue_check());
//  float scoreSat = round(sat_check());

//  float finalScore = round(scorePixel*0.3 + scoreWhite*0.3 + scoreColor*0.2
//                           + scoreAlpha*0.05 + scoreHue*0.05 + scoreSat*0.1);
//  println(global, "pixel: ", scorePixel, " white: ", scoreWhite, " color: ",
//          scoreColor, " alpha: ", scoreAlpha, " hue: ", scoreHue, " saturation: ",
//          scoreSat, " final: ", finalScore);
  
//  global++;
//  return finalScore;
//}


//float[] percentage() {
  
//  // Create arrays to save scores and percentages for each painting
//  float[] scoreChart = new float[POPULATION];
//  float[] perChart = new float[POPULATION];

//  // Variables to calculate total scores and total percentage
//  float totalScore = 0;
  
//  // Call the test function on each painting to get its score
//  for (int n=0; n<POPULATION; n++) {
//    String painting = Integer.toString(n + GEN * 3) + ".png";
//    scoreChart[n] = score_painting(painting); // save an individual score
//    totalScore += scoreChart[n]; // add to the total score
//  }
  
//  // Calculate the percentage of the scores
//  for (int n = 0; n < POPULATION; n++) {  
//    perChart[n] = (scoreChart[n] / totalScore) * 100;
//    //println(n, "score ", scoreChart[n], " percent ", perChart[n]);
//  }

//  return perChart;
//}

//// Select two parents using other methods
//int[] selection() {

//  // Run percentage to store the percentages of fitness of paintings
//  float[] percent = percentage();

//  // Variable to calculate the range
//  float[] range = new float[POPULATION];
  
//  // Calculate the range
//  for (int n=0; n<POPULATION; n++) {
//    if (n==0) {
//      range[n] = percent[n];
//    }
//    else {
//      range[n] = range[n-1] + percent[n];
//    }
//  }

//  // Select two random numbers
//  float r1 = random(100);
//  float r2 = random(100);
  
//  // Reselect the second random number if the two random numbers are the same
//  if (r1 == r2) {
//    while (r1 != r2) {
//      r2 = random(100);
//    }
//  }

//  // Array to save parents
//  int[] parents = new int[2];
 
//  //for (int i=0; i<range.length; i++) {
//  //  println("range", i, ": ", range[i]);
//  //}
 
//  circleGraph cg = new circleGraph();
//  cg.fillGraph(range);
//  parents[0] = cg.whereGraph(r1);
//  parents[1] = cg.whereGraph(r2);

//  // Run the compare function again if two parents are the same
//  if (parents[0] == parents[1]) {
//    while (parents[0] == parents[1]) {
//      r2 = random(100);
//      parents[1] = cg.whereGraph(r2);
//    }
//  }
//  //println("parents: ", parents[0], parents[1]);
//  return parents;
//}
