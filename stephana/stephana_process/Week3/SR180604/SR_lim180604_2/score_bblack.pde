float cb_scale(float d) {
  if (d < 85) return 0;
  else if (d <86.5) return 10;
  else if (d < 88) return 20;
  else if (d < 89.5) return 30;
  else if (d < 91) return 40;
  else if (d < 92.5) return 50;
  else if (d < 94) return 60;
  else if (d < 95.5) return 70;
  else if (d < 97) return 80;
  else if (d < 98.5) return 90;
  else return 100;
}

float check_black() {
  
  float count = 0;
  //float count2 = 0;
  
  for (int i=0; i<PICSIZE; i++) {
    
    // get the color of the pixel
    color c = result.pixels[i];
    //println(red(c), green(c), blue(c));
    
    // if the pixel is white
    if (red(c)<=50 && green(c)<=50 && blue(c)<=50) {
      //count++;

      // and if the orig isn't white, it means the painting is different from the orig
      if (input.pixels[i] != result.pixels[i]) { // random white space
        count++;
        //println(red(c), green(c), blue(c));
      }
    };
  }
  
  // count is the count of wrongly placed white pixels
  // PICSIZE - count is the properly placed pixels
  //println("count: ", count, " count2: ", count2);
  float score = ((PICSIZE - count) / PICSIZE) * 100;
  //println(round(cw_scale(score)));
  //println("check blakc: ", score, " | ", cb_scale(score));
  return cb_scale(score);
  //return(score);
}