/* A scoring sketch. */

PImage originalImage;  // we compare this image..
PImage paintingImage;  // ..to this one

void setup() {
  size(400, 200);
  
  originalImage = loadImage("original.png");
  image(originalImage, 0, 0);
  
  paintingImage = loadImage("painting1.png");
  image(paintingImage, 200, 0);
}