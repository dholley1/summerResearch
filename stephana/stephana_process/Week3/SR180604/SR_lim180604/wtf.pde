//PImage die;
//int dwidth;
//int dheight;
//PrintWriter output;

//void setup() {
//  size(300, 188);
//  //size(150, 94);
//  noSmooth();
//  fill(126);
//  background(102);
//  die = loadImage("die.jpg");
//  dwidth = die.width;
//  dheight = die.height;
//  output = createWriter("table.txt");
//}

//// 1. recognize color difference between the background and 
//// 2. find the range of non background color

//void draw() {
//  image(die, 0, 0, dwidth, dheight);
//}

//void mouseReleased() {
//  color c = get(mouseX, mouseY);
//  print("location:", mouseX, mouseY, " color:", round(red(c)), round(green(c)), round(blue(c)), "\n");
//}

//class Circle{
//  // WHAT: class of an imaginary circle
//  //  WHY: compare colors within a circle to see if they are all similar colors
//  //  HOW: given x, y positions of a point, get a circle and compare color
//  float x; // x-value of the center
//  float y; // y-value of the center
//  float r;
  
//  Circle(float xpos, float ypos){
//    x = xpos;
//    y = ypos;
//  }
  
//  void makeCircle(){
    
//  }
//}
