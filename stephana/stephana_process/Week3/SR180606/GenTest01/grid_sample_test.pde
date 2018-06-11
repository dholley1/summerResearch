PrintWriter distTxt;
PrintWriter scaledTxt;
PrintWriter pairTxt;
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
        distTxt.println(dist);
        
        // scale it
        float scaledScore = scaleDist(dist);
        scaledTxt.println(scaledScore);
        
        // add to totalScore
        totalScore += scaledScore;
      }
    }
  }
  float avgScore = totalScore/totalSample;
  println(totalScore);
  println(totalSample);
  return avgScore;
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
