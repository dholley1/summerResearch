float avgColorCmp() {
  // divide a canvas into multiple sections and score the average of it to see
  // if the general color is there or not
  
  // want 10x10 squares
  
  int xnum = WIDTH/10; // how many 10 pixels fit in width
  int ynum = HEIGHT/10; // how many 10 pixels fit in height
  
  println("xnum: ", xnum, " ynum: ", ynum);
  
  float minnie = 255;
  float maxxie = 0;
  
  float total_diff = 0;
  
  // go through the entire canvas by 10x10 squares
  for (int j=0; j<HEIGHT; j+=10) {
    for (int i=0; i<WIDTH; i+=10) {

      // go through each square and take average
      float orig_r = 0;
      float orig_g = 0;
      float orig_b = 0;
      float resu_r = 0;
      float resu_g = 0;
      float resu_b = 0;

      for (int m=0; m<10; m++) {
        for (int n=0; n<10; n++) {
          
          color co = input.get(i+n, j+m);
          color cr = result.get(i+n, j+m);

          orig_r+=red(co);
          orig_g+=green(co);
          orig_b+=blue(co);
          resu_r+=red(cr);
          resu_g+=green(cr);
          resu_b+=blue(cr);
        }
      }
      
      float rrr = 255 - abs(orig_r - resu_r)/100;
      float ggg = 255 - abs(orig_g - resu_g)/100;
      float bbb = 255 - abs(orig_b - resu_b)/100;
      
      float avgDiff_10x10 = (rrr+ggg+bbb)/3;
      
      if (avgDiff_10x10 <= minnie) minnie = avgDiff_10x10;
      if (avgDiff_10x10 >= maxxie) maxxie = avgDiff_10x10;
      total_diff += avgDiff_10x10;
      //println("avgDiff: ", avgDiff_10x10);
    }
  }
  
  println("minnie: ", minnie, " maxxie: ", maxxie);
  float rawScore = total_diff/= (xnum * ynum);
  float convertedScore = avgColorCmpSCALE(rawScore, minnie, maxxie);
  println("total_d: ", total_diff, " rawScore: ", rawScore, " convertedScore: ", convertedScore);
  return convertedScore;
}

float avgColorCmpSCALE(float d, float minnie, float maxxie) {
  // take min max and divide into ten and use that to see where s belongs
  float range = maxxie - minnie;

  if (d < minnie + range / 10) return 10;
  else if (d < minnie + (range / 10) * 2) return 20;
  else if (d < minnie + (range / 10) * 3) return 30;
  else if (d < minnie + (range / 10) * 4) return 40;
  else if (d < minnie + (range / 10) * 5) return 50;
  else if (d < minnie + (range / 10) * 6) return 60;
  else if (d < minnie + (range / 10) * 7) return 70;
  else if (d < minnie + (range / 10) * 8) return 80;
  else if (d < minnie + (range / 10) * 9) return 90;
  else return 100;
}