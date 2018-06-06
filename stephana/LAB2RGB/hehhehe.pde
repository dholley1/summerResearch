//float[] LABtoXYZ(float[] LAB) {
//  float y = (LAB[0] + 16)/116.0;
//  float x = y + LAB[1]/500.0;
//  float z = y - LAB[2]/200.0;
 
//  float[] XYZ = new float[3];
 
//  x = x*x*x > 8856e-6? x*x*x : (-16.0/116.0 + x)/7.787;
//  y = y*y*y > 8856e-6? y*y*y : (-16.0/116.0 + y)/7.787;
//  z = z*z*z > 8856e-6? z*z*z : (-16.0/116.0 + z)/7.787;
 
//  XYZ[0] = 95.047*x;
//  XYZ[1] = 100.0*y;
//  XYZ[2] = 108.883*z;
 
//  return XYZ;
//}
 
//float[] XYZtoRGB(float[] XYZ) {
//  float x = XYZ[0]*.01, y = XYZ[1]*.01, z = XYZ[2]*.01;
 
//  float r = x*3.2406 - y*1.5372 - z*.4986;
//  float g = x*-.9689 + y*1.8758 + z*.0415;
//  float b = x*.0557  - y*.204   + z*1.057;
  
//  float[] RGBcolor = new float[3];
 
//  r = r > 31308e-7? pow(r, 1.0/2.4)*1.055 - .055 : r*12.92;
//  g = g > 31308e-7? pow(g, 1.0/2.4)*1.055 - .055 : g*12.92;
//  b = b > 31308e-7? pow(b, 1.0/2.4)*1.055 - .055 : b*12.92;
 
//  RGBcolor[0] = constrain(round(r*255.0), 0, 0xFF);
//  RGBcolor[1] = constrain(round(g*255.0), 0, 0xFF);
//  RGBcolor[2] = constrain(round(b*255.0), 0, 0xFF);
 
//  return RGBcolor;
//}

//float[] LAB2RGB(int L, int a, int b) {
//  float[] LAB = {L, a, b};
//  return XYZtoRGB(LABtoXYZ(LAB));
//}