PImage IM = loadImage("0.png");
int PICSIZE = IM.width * IM.height;
IM.loadPixels();
float count = 0;
for (int i = 0; i < PICSIZE; i++) {
  color c = IM.pixels[i];
  if (red(c)==0 && green(c)==0 && blue(c)==0) {
    println("yay");
    count++;
  }
}
println("count:", count);
