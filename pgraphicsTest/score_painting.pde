float pixel_color(String filename) {
  PImage result = loadImage(filename);
  target.loadPixels();
  result.loadPixels();
  int arySize = WIDTH * HEIGHT;

  float difference = 0;
  
  for (int i = 0; i < arySize; i++) {
    
    float r = abs(red(target.pixels[i]) - red(result.pixels[i]));
    float g = abs(green(target.pixels[i]) - green(result.pixels[i]));
    float b = abs(blue(target.pixels[i]) - blue(result.pixels[i]));
    difference += ((r + g + b) / 3);
  }

  float score = difference / arySize;
  return score;
}

float check_white(String filename) {
  PImage result = loadImage(filename);
  target.loadPixels();
  result.loadPixels();
  int arySize = WIDTH * HEIGHT;
  
  float count = 0;
  
  for (int i=0; i<arySize; i++) {
    // if white pixel
    if (result.pixels[i] == 255) {
      // and if the orig isn't white, it means the painting is different from the orig
      if (target.pixels[i] != result.pixels[i]) {
        count++;
      }
    };
  }
  
  float score = count / arySize;
  
  return score;
}

// Take a filename of a painting to test how different it is from the
// original and return the score in float type
float score_one(String filename) {
  float score1 = pixel_color(filename);
  float score2 = check_white(filename);
  return score1 + score2;
}


float[] percentage() {
  
  // Create arrays to save scores and percentages for each painting
  float[] scoreChart = new float[POPULATION];
  float[] perChart = new float[POPULATION];

  // Variables to calculate total scores and total percentage
  float totalScore = 0;
  float totalPer = 0;
  
  // Call the test function on each painting to get its score
  for (int n=0; n<POPULATION; n++) {
    String painting = Integer.toString(n + GEN * 3) + ".jpg";
    scoreChart[n] = score_one(painting);
    totalScore += scoreChart[n];
  }
  
  // Rearrange the scores in the proper order
  for (int n = 0; n < POPULATION; n++) {  
    // Subtract a score from the total score to arrange scores in proper order
    // Higher number represents a better painting
    scoreChart[n] = totalScore - scoreChart[n];
    totalPer += scoreChart[n];
  }
  
  // Calculate the percentage of the scores
  for (int n = 0; n < POPULATION; n++) {  
    perChart[n] = scoreChart[n] / totalPer * 100;
  }
  
  return perChart;
}

// Compare a given random number with the range to find what range does
// the given random number represent
int compare(float[] range, float randNum) {
  if (randNum<range[0]) {
    return 0;
  }
  else if (range[0]<=randNum && randNum<range[1]) {
    return 1;
  }
  else if (range[1]<=randNum && randNum<range[2]) {
    return 2;
  }
  else if (range[2]<=randNum && randNum<range[3]) {
    return 3;
  }
  else if (range[3]<=randNum && randNum<range[4]) {
    return 4;
  }
  else if (range[4]<=randNum && randNum<range[5]) {
    return 5;
  }
  else if (range[5]<=randNum && randNum<range[6]) {
    return 6;
  }
  else if (range[6]<=randNum && randNum<range[7]) {
    return 7;
  }
  else if (range[7]<=randNum && randNum<range[8]) {
    return 8;
  }
  else if (range[8]<=randNum) {
    return 9;
  }
  return 1000;
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