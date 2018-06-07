/* Edge detecting. */

PImage originalImage;  // we compare this image..

void setup() {
  size(400, 200);
  
  originalImage = loadImage("original.png");
  image(originalImage, 0, 0);
  
}