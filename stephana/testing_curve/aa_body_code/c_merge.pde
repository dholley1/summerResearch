int global = 0;

// Take a filename of a painting to test how different it is from the
// original and return the score in float type
float score_painting(String filename) {
  result = loadImage(filename);
  input.loadPixels();
  result.loadPixels();

  float scorePixel = pixel_color();
  float scoreWhite = check_white();
  float scoreColor = color_variation();

  float finalScore = round(scorePixel*0.4 + scoreWhite*0.3 + scoreColor*0.3);
  //println(global, "pixel: ", scorePixel, " white: ", scoreWhite, " color: ", scoreColor, " final: ", finalScore);
  
  global++;
  return finalScore;
}


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

// Compare a given random number with the range to find what range does
// the given random number represent
int compare(float[] range, float randNum) {
  if (randNum<range[0]) return 0;
  else if (range[0]<=randNum && randNum<range[1]) return 1;
  else if (range[1]<=randNum && randNum<range[2]) return 2;
  else if (range[2]<=randNum && randNum<range[3]) return 3;
  else if (range[3]<=randNum && randNum<range[4]) return 4;
  else if (range[4]<=randNum && randNum<range[5]) return 5;
  else if (range[5]<=randNum && randNum<range[6]) return 6;
  else if (range[6]<=randNum && randNum<range[7]) return 7;
  else if (range[7]<=randNum && randNum<range[8]) return 8;
  else return 9;
}

// Select two parents using other methods
int[] selection() {

  // Run percentage to store the percentages of fitness of paintings
  float[] percent = percentage();

  // Variable to calculate the range
  float[] range = new float[POPULATION];
  
  // Calculate the range
  for (int n=0; n<POPULATION; n++) {
    if (n==0) {
      range[n] = percent[n];
    }
    else {
      range[n] = range[n-1] + percent[n];
    }
  }

  // Select two random numbers
  float r1 = random(100);
  float r2 = random(100);
  
  // Reselect the second random number if the two random numbers are the same
  if (r1 == r2) {
    while (r1 != r2) {
      r2 = random(100);
    }
  }

  // Array to save parents
  int[] parents = new int[2];
 
  // Run the compare funtion on both random numbers
  parents[0] = compare(range, r1);
  parents[1] = compare(range, r2);

  // Run the compare function again if two parents are the same
  if (parents[0] == parents[1]) {
    while (parents[0] == parents[1]) {
      r2 = random(100);
      parents[1] = compare(range, r2);
    }
  }
  return parents;
}