PImage die;
int dwidth;
int dheight;
PrintWriter output;

void setup() {
  size(300, 188);
  //size(150, 94);
  noSmooth();
  fill(126);
  background(102);
  die = loadImage("die.jpg");
  dwidth = die.width;
  dheight = die.height;
  output = createWriter("table.txt");
}

// 1. recognize color difference between the background and
// 2. find the range of non background color

void draw() {
  image(die, 0, 0, dwidth, dheight);
}

class Circle{
  // WHAT: class of an imaginary circle
  //  WHY: compare colors within a circle to see if they are all similar colors
  //  HOW: given x, y positions of a point, get a circle and compare color
  float x; // x-value of the center
  float y; // y-value of the center
  float r = 5;

  Circle(float xpos, float ypos){
    x = xpos;
    y = ypos;
  }

  void makeCircle(){
    ellipse(x, y, r, r);
  }

  boolean checkCircle(){
    // color of the center
    color center = get(x, y);

    // CHECK HUE AND SATURATION

    // set range
    float hmin = hue(center) - 5;
    float hmax = hue(center) + 5;
    float smin = saturation(center) - 5;
    float smax = saturation(center) + 5;

    // loop through circle to compare
    for (int j = y-r; j < y+r; j++) {
      for (int i = x; (i-x)^2 + (j-y)^2 <= r^2; i--) {
        // if the circle satifies certain requirement then return yes
        // question: under what condition can colors be similar?
        // answer: when similar hue different saturation
        // approach: compare the color at the center with the rest of circle2
        color c = get(i, j);
        if (hue(c) < hmin || hue(c) > hmax || saturation(c) < smin || saturation(c) > smax) {
          return false;
        }
      }
      for (int i = x+1; (i-x)*(i-x) + (j-y)*(j-y) <= r*r; i++) {
        // if the circle satifies certain requirement then return yes
        color c = get(i, j);
        if (hue(c) < hmin || hue(c) > hmax || saturation(c) < smin || saturation(c) > smax) {
          return false;
        }
      }
    }
    // the circle contains only similar colors-- if it passes all the test
    return true;
  }
}
