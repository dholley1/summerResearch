ArrayList<Integer> survivors = new ArrayList<Integer>();
int gridSide = 10;
int gridX = (int) (WIDTH / gridSide);
int gridY = (int) (HEIGHT / gridSide);

int totalGrid = gridX * gridY;
int sampleGrid = (int) (totalGrid * 0.2);
int sampleNum = 10;

ArrayList<scoreboard> sblist;

PImage paint;

void runTest() { // this take cares of all tests
  for (int i=0; i<sampleGrid; i++) { // each test == 1 grid
    scoreboard sb = new scoreboard();
    // each time need to do the whole test
    for (int p=0; p<POPULATION; p++) {
      paint = loadImage((POPULATION * GEN + p) + ".png");
      sb.addNew(perPainting()); // fitness score
    }
    sblist.add(sb);
  }
}

float perPainting() { // within a grid-- each test only select one grid to examine
  float randGridX = random(gridX);
  float randGridY = random(gridY);
  
  tuple[] smpl = new tuple[sampleNum];
  
  for (int i=0; i<sampleNum; i++) { // choose samples to use within the grid
   int x = (int) (randGridX * gridSide + random(gridSide));
   int y = (int) (randGridY * gridSide + random(gridSide));
  
   smpl[i] = new tuple(x, y);
  }
  
  float diffSum = 0;
  
  // Compare color at pixels
  for (int i=0; i<sampleNum; i++) {
    color origC = input.get(smpl[i].x, smpl[i].y);
    color resuC = paint.get(smpl[i].x, smpl[i].y);
    
    float dist = findDist(origC, resuC);
    diffSum += dist;
  }
  
  diffSum /= sampleNum;
  println(diffSum);
  return diffSum;
}


int[] lexicase() {
  
  // add all population
  for (int i=0; i<POPULATION; i++) {
    survivors.add(i);
  }
  
  // save scires for all population for twenty tests
  runTest();
  
  // choose the random order
  ArrayList<Integer> rng = new ArrayList<Integer>();
  for (int i=0; i<sampleGrid; i++) {
    rng.add(i);
  }
  
  ArrayList<Integer> randomOrder = new ArrayList<Integer>();
  for (int j=0; j<sampleGrid; j++) {
    int selected = (int)random(rng.size());
    randomOrder.add(selected);
    rng.remove(selected);
  }
  
  // now the process begins 
  while (survivors.size() > 1) {

    // 1. take the first test out
    scoreboard sb = sblist.get(randomOrder.get(0));

    // 2. remove deads from the survivor list
    sb.inRange();
  }
  
  int[] parents = {survivors.get(0), survivors.get(1)};
  return parents;
}