void draw() {
  float[] input = {100, 100, 100};
  float[] result = LAB2RGB(input[0], input[1], input[2]);
  println(result);
  noLoop();
}

float[] LAB2RGB(float L, float a, float b) {
  float y = (L + 16)/116.0;
  float x = y + a/500.0;
  float z = y - b/200.0;
 
  float[] XYZ = new float[3];
 
  x = x*x*x > 8856e-6? x*x*x : (-16.0/116.0 + x)/7.787;
  y = y*y*y > 8856e-6? y*y*y : (-16.0/116.0 + y)/7.787;
  z = z*z*z > 8856e-6? z*z*z : (-16.0/116.0 + z)/7.787;
 
  XYZ[0] = 95.047*x;
  XYZ[1] = 100.0*y;
  XYZ[2] = 108.883*z;
 
  float r = XYZ[0]*.01, s = XYZ[1]*.01, t = XYZ[2]*.01;
 
  float red = r*3.2406 - s*1.5372 - t*.4986;
  float green = r*-.9689 + s*1.8758 + t*.0415;
  float blue = r*.0557  - s*.204   + t*1.057;
  
  float[] RGBcolor = new float[3];
 
  red = red > 31308e-7? pow(red, 1.0/2.4)*1.055 - .055 : red*12.92;
  green = green > 31308e-7? pow(green, 1.0/2.4)*1.055 - .055 : green*12.92;
  blue = blue > 31308e-7? pow(blue, 1.0/2.4)*1.055 - .055 : blue*12.92;
 
  RGBcolor[0] = constrain((red*255.0), 0, 0xFF);
  RGBcolor[1] = constrain((green*255.0), 0, 0xFF);
  RGBcolor[2] = constrain((blue*255.0), 0, 0xFF);
 
  return RGBcolor;
}