// global variables
PImage result;
int PICSIZE = WIDTH * HEIGHT;
int global = 0;

float scaling(float diff) {
  float d = (diff/255)*100;
  if (d < 80) return 100;
  else if (d < 82) return 95;
  else if (d < 85) return 80;
  else if (d < 87) return 65;
  else if (d < 90) return 50;
  else if (d < 93) return 35;
  else if (d < 97) return 20;
  else if (d < 100) return 5;
  else return 0;
}

float pixel_color() {

  float difference = 0;
  
  for (int i = 0; i < PICSIZE; i++) {
    
    float r = scaling(abs(red(input.pixels[i]) - red(result.pixels[i])));
    float g = scaling(abs(green(input.pixels[i]) - green(result.pixels[i])));
    float b = scaling(abs(blue(input.pixels[i]) - blue(result.pixels[i])));

    difference += ((r + g + b) / 3);
  }

  // divide by PICSIZE since difference at this point is the sum of differences for all pixels
  float score = difference / PICSIZE;
  return score;
}

float check_white() {
  
  float count = 0;
  
  for (int i=0; i<PICSIZE; i++) {
    
    // get the color of the pixel
    color c = result.pixels[i];
    
    // if the pixel is white
    if (red(c)==255 && green(c)==255 && blue(c)==255) {

      // and if the orig isn't white, it means the painting is different from the orig
      if (input.pixels[i] != result.pixels[i]) { // random white space
        count++;
      }
    };
  }
  
  // count is the count of wrongly placed white pixels
  // PICSIZE - count is the properly placed pixels
  //println("count: ", count);
  float score = ((PICSIZE - count) / PICSIZE) * 100;
  
  return score;
}

class variety {

  float[] r;
  float[] g;
  float[] b;

  int _size;
  
  variety() {
    r = new float[PICSIZE];
    g = new float[PICSIZE];
    b = new float[PICSIZE];

    _size = 0;
  }
  
  boolean checkColor(color c) {
    // true if the given color exists in the array
    // false if the given color can be added

    for (int i=0; i<_size; i++) {
      if (r[i]==red(c) && g[i]==green(c) && b[i]==blue(c))
        return true;
    }

    return false;
  }
  
  void addColor(color c) {
    if (!checkColor(c)) {
      r[_size] = red(c);
      g[_size] = green(c);
      b[_size] = blue(c);

      _size++;
    }
  }
  
  int getSize() {
    // return the size of the array
    return _size;
  }
}

float color_variation() {
  variety v = new variety();

  for (int i=0; i<PICSIZE; i++) {
    v.addColor(result.pixels[i]);
  }
  
  float infloat = v.getSize();
  float score = (infloat/PICSIZE)*100;
  
  return score;
}

// Take a filename of a painting to test how different it is from the
// original and return the score in float type
float score_painting(String filename) {
  result = loadImage(filename);
  input.loadPixels();
  result.loadPixels();

  float scorePixel = pixel_color();
  float scoreWhite = check_white();
  float scoreColor = color_variation();

  float finalScore = round(scorePixel*0.3 + scoreWhite*0.5 + scoreColor*0.2);
  //float finalScore = round(scorePixel*0.3 + scoreWhite*0.7);
  //println(global, " finalScore: ", finalScore);
  //global++;
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
    scoreChart[n] = score_painting(painting);
    println(global, " finalScore: ", scoreChart[n]);
    global++;
    totalScore += scoreChart[n];
  }
  
  // Calculate the percentage of the scores
  for (int n = 0; n < POPULATION; n++) {  
    perChart[n] = scoreChart[n] / totalScore * 100;
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