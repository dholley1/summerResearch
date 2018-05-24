//PImage INPUT;
//int WIDTH;
//int HEIGHT;

//float scoring(String filename) {
//  float score1 = pixel_color(filename);
//  float score2 = check_white(filename);
//  return score1 + score2;
//}

//float pixel_color(String filename) {
//  PImage result = loadImage(filename);
//  INPUT.loadPixels();
//  result.loadPixels();
//  int arySize = WIDTH * HEIGHT;

//  float difference = 0;
  
//  for (int i = 0; i < arySize; i++) {
    
//    float r = abs(red(INPUT.pixels[i]) - red(result.pixels[i]));
//    float g = abs(green(INPUT.pixels[i]) - green(result.pixels[i]));
//    float b = abs(blue(INPUT.pixels[i]) - blue(result.pixels[i]));
    
//    difference += (r + g + b) / 3;
//  }

//  float score = difference / arySize;
//  return score;
//}

//float check_white(String filename) {
//  PImage result = loadImage(filename);
//  INPUT.loadPixels();
//  result.loadPixels();
//  int arySize = WIDTH * HEIGHT;
  
//  float count = 0;
  
//  for (int i=0; i<arySize; i++) {
//    // if white pixel
//    if (result.pixels[i] == 255) {
//      // and if the orig isn't white, it means the painting is different from the orig
//      if (INPUT.pixels[i] != result.pixels[i]) {
//        count++;
//      }
//    };
//  }
  
//  float score = 0;
  
//  return score;
//}