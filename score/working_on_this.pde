//// Take a filename of a painting to test how different it is from the
//// original and return the score in float type
//float test(String filename) {
  
//  // Load a resultant painting
//  PImage result = loadImage(filename);

//  // Load the original picture and the resultant painting into arrays
//  input.loadPixels();
//  result.loadPixels();
  
//  // Get the size of the picture (count the number of pixels)
//  int arySize = imgwidth * imgheight;

//  // Variable for the total sum of the difference of rgb
//  float difference = 0;
  
//  // Go through the pixels to calculate the total difference
//  for (int i = 0; i < arySize; i++) {
    
//    // Calculate the difference in color between the pixel in the picture
//    // and the painting
//    float r = abs(red(input.pixels[i]) - red(result.pixels[i]));
//    float g = abs(green(input.pixels[i]) - green(result.pixels[i]));
//    float b = abs(blue(input.pixels[i]) - blue(result.pixels[i]));
    
//    // Add the average of the difference of the selected pixel
//    difference += (r + g + b) / 3;
//  }
  
//  // The score the selected painting is the average of the difference in
//  // color among all pixels
//  float score = difference / arySize;
//  return score;
//}