/*
divide a canvas into multiple grids
for eacch grid, choose some samples (in coordiate pairs)
compare colors at picture and painting
*/

void gridSampleTest() {
  
  // how many grids in canvas
  int canvasWidth = WIDTH;
  int canvasHeight = HEIGHT;
  
  int gridSide = 10;
  
  int gridInWidth = canvasWidth/gridSide;
  int gridInHeight = canvasHeight/gridSide;
  
  // choose n samples from each grid
  int sampleNum = 10;

  // (w, h) is the most top-left corner of a grid
  for (int w=0; w<canvasWidth; w+=10) {
    for (int h=0; h<canvasHeight; h+=10) {
      
      // get two random number within sampleNum
      for (int i=0; i<sampleNum; i++) {
        int r1 = int(random(sampleNum));
        int r2 = int(random(sampleNum));
        
        // get input and result colors at the selected point
        color inputC = input.get(r1, r2);
        color resultC = result.get(r1, r2);
        
        // compare color-- make a function that takes two colors and return the difference
        // already have distance function for Lab
        // RGB comparison function
      }
    }
  }
}