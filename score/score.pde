PImage input;
//PImage result;

int imgwidth;
int imgheight;
boolean done = false;

void setup() {
  //size(648, 864);
  size(648, 432);
  input = loadImage("input.jpg");
  imgwidth = input.width;
  imgheight = input.height;
  //println("w:", imgwidth, " h:", imgheight);
  //size(imgwidth, imgheight);
  image(input, 0, 0, imgwidth, imgheight);
}

void draw() {
  noLoop();
  noStroke();
  //for (int x=0; x<imgwidth; x+=20) {
  //  for (int y=0; y<imgheight; y+=20) {
  //    if (done) return;
  //    color c = input.get(x, y);
  //    fill(c);
  //    stroke(c);  
  //    rect(x+5, y+5, 20, 20);
  //    //line(x, y, x+10, y+10);
  //    if (x>(imgwidth) && y>(imgheight)) {
  //      done = true;
  //    }
  //  }
  //}
  //save("4.jpg");
  //test("4.jpg");
  //percentage();
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
    println("score of", n, "th painting:", scoreChart[n]);
  }
  
  //float[] dumbT = new float[number];

  //for (int n=0; n<number; n++) {  
  //  dumbT[n] = scoreChart[n] / totalScore;
  //}
  
  for (int n=0; n<number; n++) {  
    scoreChart[n] = totalScore - scoreChart[n];
    totalPer += scoreChart[n];
    println("reversed score of", n, "th painting:", scoreChart[n]);
  }
  
  for (int n=0; n<number; n++) {  
    perChart[n] = scoreChart[n] / totalPer * 100;
    println("percent of", n, "th painting:", perChart[n], "%");
  }
  
  return perChart;
}


String[] selection() {
  float[] percent = percentage();
  
  float r1 = random(100);
  float r2 = random(100);
  if (r1 == r2) {
    while (r1 != r2) {
      r2 = random(100);
    }
  }
  
  String[] selected = {r1, r2};
  
  for (int i=0; i<2; i++) {
    if (0<=r1 && r1<percent[1]) {
    }
    else if (percent[1]<=r1 && r1<percent[2]) {
    }
    else if (percent[2]<=r1 && r1<percent[3]) {
    }
    else if (percent[3]<=r1 && r1<percent[4]) {
    }
    else if (percent[4]<=r1 && r1<percent[5]) {
    }
    else if (percent[5]<=r1 && r1<percent[6]) {
    }
    else if (percent[6]<=r1 && r1<percent[7]) {
    }
    else if (percent[7]<=r1 && r1<percent[8]) {
    }
    else if (percent[8]<=r1 && r1<percent[9]) {
    }
    else if (percent[9]<=r1 && r1<100) {
    }
  }
  
  // the second
  
  println(total);
}