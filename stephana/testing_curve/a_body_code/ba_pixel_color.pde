// global variables
PImage result;
int PICSIZE = WIDTH * HEIGHT;

float pc_scale(float d) {
  if (d < 180) return 0;
  else if (d < 190) return 10;
  else if (d < 192.5) return 20;
  else if (d < 195) return 30;
  else if (d < 197.5) return 40;
  else if (d < 200) return 50;
  else if (d < 202.5) return 60;
  else if (d < 205) return 70;
  else if (d < 207.5) return 80;
  else if (d < 210) return 90;
  else return 100;
}

float pixel_color() {

  float total_diff = 0;
  float tester = 0;
  
  // for each pixel
  for (int i = 0; i < PICSIZE; i++) {
    
    float r = abs(red(input.pixels[i]) - red(result.pixels[i]));
    float g = abs(green(input.pixels[i]) - green(result.pixels[i]));
    float b = abs(blue(input.pixels[i]) - blue(result.pixels[i]));

    // maximum posst diffszble difference is 255
    total_diff += 255 - ((r + g + b) / 3);
  }

  // average of difference for all pixels
  float score = total_diff / PICSIZE;
  //println("score: ", round(score), " scaled: ", scaling(score));
  // scale the average difference
  return pc_scale(score);
}