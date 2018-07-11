//PrintWriter distTxt;
//PrintWriter scaledTxt;
//PrintWriter pairTxt;
/*
divide a canvas into multiple grids
for eacch grid, choose some samples (in coordiate pairs)
compare colors at picture and painting
*/

float gridSampleTest() {
  
  float totalScore = 0;
  
  //... DIVIDE CANVAS INTO GRIDS ...//
  
  int gridSide = 10;
  
  //... CHOOSE N SAMPLES FROM EACH GRID AND COMPARE TO THE ORIGINAL ...//
  
  int sampleNum = 10;
  int gridNum = (WIDTH/gridSide) * (HEIGHT/gridSide);
  int totalSample = gridNum * sampleNum;

  // (w, h) is the most top-left corner of a grid
  for (int w=0; w<WIDTH; w+=gridSide) {
    for (int h=0; h<HEIGHT; h+=gridSide) {
      
      // get two random number within sampleNum
      for (int i=0; i<sampleNum; i++) {
        int r1 = w + int(random(gridSide)); // random #s indicate which point within a grid
        int r2 = h + int(random(gridSide)); // adding w, h to random #s gives the actual coordinate point of a selected sample
        
        // get input and result colors at the selected point
        color inputC = input.get(r1, r2);
        color resultC = result.get(r1, r2);
        
        //pairTxt.println("(", r1, ", ", r2, ")");
        
        float dist = findDist(inputC, resultC);
        //distTxt.println(dist);
        
        // scale it
        float scaledScore = scaleDist(dist);
        //scaledTxt.println(scaledScore);
        
        // add to totalScore
        totalScore += scaledScore;
      }
    }
  }
  float avgScore = totalScore/totalSample;
  println(totalScore, totalSample, totalScore/totalSample, avgScore, doubleScale(avgScore));
  return doubleScale(avgScore);
}

float scaleDist(float dist) {
  if (dist < 4) return 100;
  else if (dist < 6) return 90;
  else if (dist < 8) return 80;
  else if (dist < 10) return 70;
  else if (dist < 12) return 60;
  else if (dist < 14) return 50;
  else if (dist < 16) return 40;
  else if (dist < 18) return 30;
  else if (dist < 20) return 20;
  else if (dist < 22) return 10;
  return 0;
}

float doubleScale(float dist) {
  if (dist > 20) return 100;
  else if (dist > 18) return 90;
  else if (dist > 16) return 80;
  else if (dist > 14) return 70;
  else if (dist > 12) return 60;
  else if (dist > 10) return 50;
  else if (dist > 8) return 40;
  else if (dist > 6) return 30;
  else if (dist > 4) return 20;
  else if (dist > 2) return 10;
  return 0;
}










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