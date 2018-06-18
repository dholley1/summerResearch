PImage img;

void setup() {
  size(240, 200);
}

void draw() {
  img = loadImage("frog.jpg");
  image(img, 0, 0, 200, 200);

  noLoop();
}

void mousePressed() {
  int x = mouseX;
  int y = mouseY;
  color main = get(x, y);
  
  for (int i=0; i<25; i+=5) {
    color c = get(x, y+i);
    println(x, y+i, " | ", findDist(main, c));
    stroke(255);
    line(x, y, x, y+i);
  }
}