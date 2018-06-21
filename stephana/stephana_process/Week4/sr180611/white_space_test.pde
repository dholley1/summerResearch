float whiteSpaceTest() {
  
  float count = 0;
  
  for (int i=0; i<PICSIZE; i++) {
    
    // get the color of the pixel
    color c = result.pixels[i];
    
    // if the pixel is white
    if (red(c)==255 && green(c)==255 && blue(c)==255) {

      // and if the orig isn't white, it means the painting is different from the orig
      if (input.pixels[i] != result.pixels[i]) { // random white space
        count++;
      }
    };
  }
  
  // count is the count of wrongly placed white pixels
  // PICSIZE - count is the properly placed pixels
  float score = ((PICSIZE - count) / PICSIZE) * 100;
  return cw_scale(score);
}

float cw_scale(float d) {
  if (d < 50) return 0;
  else if (d < 53) return 5;
  else if (d < 55) return 10;
  else if (d < 57) return 15;
  else if (d < 60) return 20;
  else if (d < 63) return 25;
  else if (d < 65) return 30;
  else if (d < 67) return 35;
  else if (d < 70) return 40;
  else if (d < 73) return 45;
  else if (d < 75) return 50;
  else if (d < 77) return 55;
  else if (d < 80) return 60;
  else if (d < 83) return 65;
  else if (d < 85) return 70;
  else if (d < 87) return 75;
  else if (d < 90) return 80;
  else if (d < 93) return 85;
  else if (d < 95) return 90;
  else if (d < 97) return 95;
  else return 100;
}
