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
  println("w:", imgwidth, " h:", imgheight);
  //size(imgwidth, imgheight);
  image(input, 0, 0, imgwidth, imgheight);
  println("1");
}

void draw() {
  noLoop();
  noStroke();
  //for (int x=0; x<imgwidth; x+=10) {
  //  for (int y=0; y<imgheight; y+=10) {
  //    if (done) return;
  //    color c = input.get(x, y);
  //    fill(c);
  //    stroke(c);  
  //    rect(x+5, y+5, 10, 10);
  //    //line(x, y, x+10, y+10);
  //    if (x>(imgwidth) && y>(imgheight)) {
  //      done = true;
  //    }
  //  }
  //}
  //save("3.jpg");
  //test();
  
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
  print("pixel size: ", arySize, "\n");
  
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
  
  println("total sum: ", total_sum);
  println("sum avg: ", total_sum / arySize);
  
  float score = total_sum / arySize;
  return score;
}

void percentage() {
  // run test for all resulting paintings-- need to figure out how to pass PImage as a parameter
  
  // use three examples to write this =)
  float one = test("1.jpg");
  float two = test("2.jpg");
  float three = test("3.jpg");
}