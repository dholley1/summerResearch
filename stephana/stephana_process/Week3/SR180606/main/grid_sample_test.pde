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
        int r1 = w + int(random(sampleNum)); // random #s indicate which point within a grid
        int r2 = h + int(random(sampleNum)); // adding w, h to random #s gives the actual coordinate point of a selected sample
        
        // get input and result colors at the selected point
        color inputC = input.get(r1, r2);
        color resultC = result.get(r1, r2);
        
        float dist = findDist(inputC, resultC);
        output.println(dist);
        
        //// scale it
        //float scaledScore = scaleDist(dist);
        
        // add to totalScore
        totalScore += dist;
      }
    }
  }
  float avgScore = totalScore/totalSample;
  return avgScore;
}

float scaleDist(float dist) {
  return dist;
}