// global variables
PImage result;
int PICSIZE = WIDTH * HEIGHT;


// PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // 
// PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // 
// PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // 
// PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // 
// PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // 
// PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // 
// PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // // PIXEL COLOR // 

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


// CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE //
// CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // 
// CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // 
// CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // 
// CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // 
// CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // 
// CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // // CHECK WHITE // 

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

float check_white() {
  
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
  //println("count: ", count);
  float score = ((PICSIZE - count) / PICSIZE) * 100;
  //println(round(cw_scale(score)));
  return cw_scale(score);
}


// COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // 
// COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // 
// COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // 
// COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // 
// COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // 
// COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // 
// COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // // COLOR VARIETY // 

class variety {

  float[] r;
  float[] g;
  float[] b;

  int _size;
  
  variety() {
    r = new float[PICSIZE];
    g = new float[PICSIZE];
    b = new float[PICSIZE];

    _size = 0;
  }
  
  boolean checkColor(color c) {
    // true if the given color exists in the array
    // false if the given color can be added

    for (int i=0; i<_size; i++) {
      if (r[i]==red(c) && g[i]==green(c) && b[i]==blue(c))
        return true;
    }

    return false;
  }
  
  void addColor(color c) {
    if (!checkColor(c)) {
      r[_size] = red(c);
      g[_size] = green(c);
      b[_size] = blue(c);

      _size++;
    }
  }
  
  int getSize() {
    // return the size of the array
    return _size;
  }
}

float color_variation() {
  variety v = new variety();

  for (int i=0; i<PICSIZE; i++) {
    v.addColor(result.pixels[i]);
  }
  
  float infloat = v.getSize();
  float score = (infloat/PICSIZE)*100;
  //println(score);
  return score;
}



// CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV //
// CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // 
// CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // 
// CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // 
// CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // 
// CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // 
// CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // // CHECK HSV // 

// alpha-- extracts the alpha value -- opacity between 0 and 1
// hue-- extracts the hue value -- colorful or black and white?
// saturation-- extracts the saturation value -- amount of grey

// only works when transparency exist
float alpha_check() {
  float sum = 0;
  for (int i = 0; i < PICSIZE; i++) {
    sum += abs(alpha(input.pixels[i])-alpha(result.pixels[i]));
    //println("hmm? ", alpha(input.pixels[i]));
    //println("ahh! ", alpha(result.pixels[i]));
  }
  float sumavg = sum / PICSIZE;
  float score = sumavg * 100;
  //println("sum: ", sum, " sumavg: ", sumavg, " score: ", score);
  return score;
}

// only works when transparency exist
float hue_check() {
  float input_sum = 0;
  float result_sum = 0;
  for (int i = 0; i < PICSIZE; i++) {
    input_sum += hue(input.pixels[i]);
    result_sum += hue(result.pixels[i]);
  }
  float score = abs((input_sum - result_sum) / input_sum)*100;
  return score;
}

float sat_check() {
  float input_sum = 0;
  float result_sum = 0;
  for (int i = 0; i < PICSIZE; i++) {
    input_sum += saturation(input.pixels[i]);
    result_sum += saturation(result.pixels[i]);
  }
  float score = abs((input_sum - result_sum) / input_sum)*100;
  return score;
}
