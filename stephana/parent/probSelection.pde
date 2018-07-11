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







// represent a pie of a circle graph
class pie {
  int n;
  float min;
  float max;
  
  pie(int number, float minimum, float maximum) {
    n = number;
    min = minimum;
    max = maximum;
    //println("min:", min, " max:", max);
  }
  
  boolean withinRange(float f) {
    if (min <= f && f < max) {
      //println(f, "within range");
      return true;
    }
    //println("NOT within range");
    return false;
  }
  
  int checkRange(float f) {
    if (withinRange(f)) return n;
    //println("error");
    return -1;
  }
}


class circleGraph {
  pie[] pies;
  
  circleGraph() {
    pies = new pie[TOTALPOPULATION];
  }
  
  void fillGraph(float[] range) {
    for (int i = 0; i<TOTALPOPULATION; i++) {
      if (i==0) {
        pies[i] = new pie(i, 0, range[i]);
        //println("for 0", range[i]);
      }
      else pies[i] = new pie(i, range[i-1], range[i]);
    }
  }
  
  int whereGraph(float f) {
    //println("f value: ", f);
    for (int i = 0; i<TOTALPOPULATION; i++) {
      int found = pies[i].checkRange(f);
      if (found != -1) return found;
    }
    return -1;
  }
}

// global variable
circleGraph CG;

// BRIDGE BETWEEN THE MAIN BODY CODE AND SCORING
void createGraph() {

  // Run percentage to store the percentages of fitness of paintings
  float[] percent = percentage();

  // Variable to calculate the range
  float[] range = new float[TOTALPOPULATION];
  
  // Calculate the range
  for (int n=0; n<TOTALPOPULATION; n++) {
    if (n==0) {
      range[n] = percent[n];
    }
    else {
      range[n] = range[n-1] + percent[n];
    }
  }

  CG = new circleGraph();
  CG.fillGraph(range);
}


// SEPARATE EVERYTHING

// WITH THE GIVEN CG SELECT PARENTS
int[] selection() {
  // Array to save parents
  int[] parents = new int[2];
 
  // Select two random numbers
  float r1 = random(100);
  float r2 = random(100);
  
  // Reselect the second random number if the two random numbers are the same
  if (r1 == r2) {
    while (r1 != r2) {
      r2 = random(100);
    }
  }
 
  parents[0] = CG.whereGraph(r1);
  parents[1] = CG.whereGraph(r2);

  // Run the compare function again if two parents are the same
  if (parents[0] == parents[1]) {
    while (parents[0] == parents[1]) {
      r2 = random(100);
      parents[1] = CG.whereGraph(r2);
    }
  }
  //println("parents: ", parents[0], parents[1]);
  return parents;
}