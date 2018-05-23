PImage input;

int imgwidth;
int imgheight;
boolean done = false;

void setup() {
  //size(648, 864);
  size(648, 432);
  input = loadImage("input.jpg");
  imgwidth = input.width;
  imgheight = input.height;
  image(input, 0, 0, imgwidth, imgheight);
}

void draw() {
  noLoop();
  noStroke();
  selection();
}


float test(String filename) {
  // take the original and the result and test the fitness of the result

  //Color range: 0 to 255
  
  //5: -15 ~ +15 very good (81 ~ 100)
  //4: -30 ~ +30 good (61 ~ 80)
  //3: -45 ~ +45 okay (41 ~ 60)
  //2: -60 ~ +60 bad (21 ~ 40)
  //1: Beyond is very bad (1 ~ 20)
  
  //1. go through the whole panel
  //2. get red, green, blue
  //3. take the difference and average them 

  PImage result = loadImage(filename);
  //image(result, 0, 432, result.width, result.height);
  //image(input, 0, 0, imgwidth, imgheight);
  
  // load pixels!
  input.loadPixels();
  result.loadPixels();
  
  // the size of the pixel array
  int arySize = imgwidth * imgheight;
  //print("pixel size: ", arySize, "\n");
  
  // total sum
  float total_sum = 0;
  
  for (int i = 0; i < arySize; i++) {
    // get the difference of colors and take an abs
    float r = abs(red(input.pixels[i]) - red(result.pixels[i]));
    float g = abs(green(input.pixels[i]) - green(result.pixels[i]));
    float b = abs(blue(input.pixels[i]) - blue(result.pixels[i]));
    
    // take an avg and add to the total sum
    total_sum += (r + g + b) / 3;
  }
  
  //println("total sum: ", total_sum);
  //println("sum avg: ", total_sum / arySize);
  
  float score = total_sum / arySize;
  return score;
}


float[] percentage() {
  int number = 4; // later change to ten
  
  String[] filename = {"1.jpg", "2.jpg", "3.jpg", "4.jpg"};
  
  float[] scoreChart = new float[number];
  float[] perChart = new float[number];

  float totalScore = 0;
  float totalPer = 0;
  
  for (int n=0; n<number; n++) {
    String tester = "\"" + char(n + 49) + ".jpg\"";
    scoreChart[n] = test(filename[n]);
    totalScore += scoreChart[n];
    //println("score of", n, "th painting:", scoreChart[n]);
  }
  
  //float[] dumbT = new float[number];

  //for (int n=0; n<number; n++) {  
  //  dumbT[n] = scoreChart[n] / totalScore;
  //}
  
  for (int n=0; n<number; n++) {  
    scoreChart[n] = totalScore - scoreChart[n];
    totalPer += scoreChart[n];
    //println("reversed score of", n, "th painting:", scoreChart[n]);
  }
  
  for (int n=0; n<number; n++) {  
    perChart[n] = scoreChart[n] / totalPer * 100;
    //println("percent of", n, "th painting:", perChart[n], "%");
  }
  
  return perChart;
}

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

int[] selection() {

  int number = 4; // later change to ten

  // this is just to print percent
  float[] percent = percentage();
  for (int n=0; n<number; n++) {
    println("percent", n, ":", percent[n]);
  }

  // make an ary of range
  float[] range = new float[number];
  for (int n=0; n<number; n++) {
    if (n==0) {
      range[n] = percent[n];
    }
    else {
      range[n] = range[n-1] + percent[n];
    }
  }
  for (int n=0; n<number; n++) {
    println("range", n, ":", range[n]);
  }
  
  // get two random number
  float r1 = random(100);
  float r2 = random(100);
  if (r1 == r2) {
    while (r1 != r2) {
      r2 = random(100);
    }
  }
  println("r1:", r1, "r2:", r2);

  int[] parents = new int[2];

  // get the first parent
  parents[0] = compare(range, r1);

  // get the second parent
  parents[1] = compare(range, r2);

  if (parents[0] == parents[1]) {
    while (parents[0] == parents[1]) {
      r2 = random(100);
      println("in loop");
      println("r1:", r1, "r2:", r2);
      parents[1] = compare(range, r2);
    }
  }

  println("parents:", parents[0], ",", parents[1]);
  return parents;
}