// variables for the entire file
ArrayList<scoreboard> sblist = new ArrayList<scoreboard>();


// variables for runTest() and perPainting()
int gridSide = 10;
int gridX = (int) (WIDTH / gridSide);
int gridY = (int) (HEIGHT / gridSide);

int totalGrid = gridX * gridY;
int sampleGrid = (int) (totalGrid * 0.2);
int sampleNum = 10;

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
  return diffSum;
}


// variables for lexicase()
boolean found = false;
IntList survivors = new IntList();
IntList rng = new IntList();
IntList randomOrder = new IntList();
int[] parents = new int[2];

int[] lexicase() {
  for (int i=0; i<2; i++) {
    process(i);
  }
  return parents;
}

// this is the process file
void process(int h) {
  for (int i=0; i<POPULATION; i++) {
    survivors.append(i);
  }
  // choose the random order
  for (int i=0; i<sampleGrid; i++) {
    rng.append(i);
  }
  for (int j=0; j<sampleGrid; j++) {
    int selected = (int)random(rng.size());
    randomOrder.append(rng.get(selected));
    rng.remove(selected);
  }

  while (!found) {

    // 1. take the first test out
    scoreboard sb = sblist.get(randomOrder.get(0));

    randomOrder.remove(0);

    // 2. remove deads from the survivor list
    sb.testround();

    if (randomOrder.size() == 0) {
      found = true;
    }
  }
  parents[h] = survivors.get(0);
  survivors.clear();

  // isn't this supposed to reset everything?
  while (survivors.size() != 0) {
    survivors.remove(survivors.size()-1);
  }
  while (randomOrder.size() != 0) {
    randomOrder.remove(randomOrder.size()-1);
  }
  found = false;
}
