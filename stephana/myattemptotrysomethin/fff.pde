//PImage die;
//float dwidth;
//float dheight;
//PrintWriter output;

//void setup() {
//  size(300, 188);
//  //noSmooth();
//  fill(126);
//  background(102);
//  die = loadImage("die.jpg");
//  dwidth = die.width;
//  dheight = die.height;
//  output = createWriter("table.txt");
//}

//void draw() {
//  image(die, 0, 0, dwidth, dheight);
//}

//void mouseReleased() {
//  // create a circle with the clicked position
//  Circle circle = new Circle(mouseX, mouseY);
//  circle.checkPrint();
//}

//class Circle{
//  float x; // x-value of the center
//  float y; // y-value of the center
//  float r = 10; // radius
  
//  color centerC;

//  Circle(float xpos, float ypos){
//    x = xpos;
//    y = ypos;
//    centerC = get(int(x), int(y));
//  }
  
//  boolean checkRGB(){
    
//    // go thru the whole circle
//    for (float i = y-r; i < y+r; i++) {
  
//      for (float j = x; (j-x)*(j-x) + (i-y)*(i-y) <= r*r; j--) {
//        color c = get(int(j), int(i));
//        if (abs(red(centerC)-red(c)) > 50
//            && abs(green(centerC)-green(c)) > 50
//            && abs(blue(centerC)-blue(c)) > 50) {
//          return false;
//        }
//      }
  
//      for (float j = x+1; (j-x)*(j-x) + (i-y)*(i-y) <= r*r; j++) {
//        color c = get(int(j), int(i));
//        if (abs(red(centerC)-red(c)) > 50
//            && abs(green(centerC)-green(c)) > 50
//            && abs(blue(centerC)-blue(c)) > 50)
//          return false;
//      }
//    }    
//    return true;
//  }
  
//  void printColor(){
//    print("location:", x, y,
//          " color:", round(red(centerC)), round(green(centerC)),
//          round(blue(centerC)), "\n");
//  }
  
//  void checkPrint(){
//    if (checkRGB()) println("YES all similar colors");
//    else println("NOO color suddenly changes");
//    printColor();
//  }

//}