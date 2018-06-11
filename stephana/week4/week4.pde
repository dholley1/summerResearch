/* GLOBAL VARIABLE */
PImage img;
int imgWidth;
int imgHeight;

// center of the object in the image that we want to recognize
int centerX;
int centerY;

// array of eight directions
tuple[] directions = {new tuple(0, 1), new tuple(1, 1), new tuple(1, 0), new tuple(1, -1),
                      new tuple(0, -1), new tuple(-1, -1), new tuple(-1, 0), new tuple(-1,1)};

void setup() {
  size(600, 188);
  fill(126);
  background(102);
  img = loadImage("die.jpg");
  imgWidth = img.width;
  imgHeight = img.height;
}

void draw() {
  image(img, 0, 0, imgWidth, imgHeight);
  tuple center = new tuple(imgWidth/2, imgHeight/2);
}

void mouseClicked() {
  centerX = mouseX;
  centerY = mouseY;
}
