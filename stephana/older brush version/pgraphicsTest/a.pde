// global variables
PImage result;
int PICSIZE = WIDTH * HEIGHT;

float min = 255;
float max = 0;

float pixel_color() {

  float total_diff = 0;
  
  // for each pixel
  for (int i = 0; i < PICSIZE; i++) {
    
    float r = abs(red(input.pixels[i]) - red(result.pixels[i]));
    float g = abs(green(input.pixels[i]) - green(result.pixels[i]));
    float b = abs(blue(input.pixels[i]) - blue(result.pixels[i]));

    float flipped_avg = 255 - (r+g+b)/3;
    
    total_diff += flipped_avg;
  }

  float score = ((total_diff / PICSIZE)/255) * 100;
  if (score <= min) min = score;
  if (score >= max) max = score;
  return plzworkmycurvychild(score);
}

float plzworkmycurvychild(float d) {
  // take min max and divide into ten and use that to see where s belongs
  float range = max - min;

  if (d < min + range / 10) return 10;
  else if (d < min + (range / 10) * 2) return 20;
  else if (d < min + (range / 10) * 3) return 30;
  else if (d < min + (range / 10) * 4) return 40;
  else if (d < min + (range / 10) * 5) return 50;
  else if (d < min + (range / 10) * 6) return 60;
  else if (d < min + (range / 10) * 7) return 70;
  else if (d < min + (range / 10) * 8) return 80;
  else if (d < min + (range / 10) * 9) return 90;
  else return 100;
}