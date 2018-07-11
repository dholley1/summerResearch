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

tuple[][] allSamples = new tuple[sampleGrid][sampleNum];

void sampling() {
  for (int i=0; i<sampleGrid; i++) {
    float randGridX = random(gridX);
    float randGridY = random(gridY);

    for (int j=0; j<sampleNum; j++) {
      int x = (int) (randGridX * gridSide + random(gridSide));
      int y = (int) (randGridY * gridSide + random(gridSide));
      allSamples[i][j] = new tuple(x, y);
    }
  }
}


float scorePainting(int i) { // i is the first index
  float diffSum = 0;
  for (int j=0; j<sampleNum; j++) { // for each sample to be used for the ith test
  
    // Compare color at pixels
    color origC = getColor(input, allSamples[i][j]);
    color resuC = getColor(paint, allSamples[i][j]);
  
    float dist = findDist(origC, resuC);
    diffSum += dist;
  }
  
  diffSum /= sampleNum;
  return diffSum;
}

PImage goodEdge;
PImage paintEdge;

float edgeTest(int i) {

  float diffSum = 0;
  for (int j=0; j<sampleNum; j++) {
    color origC = getColor(goodEdge, allSamples[i][j]);
    color resuC = getColor(paintEdge, allSamples[i][j]);
    
    float dist = findDist(origC, resuC);
    if (dist <= 4) {
      dist /= 4;
    }
    diffSum += dist;
  }
  
  diffSum /= sampleNum;
  return diffSum;
}


void runTest() {
  
  // Choose sample points to compare
  sampling();

  // ArrayList of scoreboards
  for (int i=0; i<sampleGrid; i++) {
    scoreboard sb = new scoreboard();
    sblist.add(sb);
  }
  
  // Score paintings
  for (int j =0; j<POPULATION; j++) {
    SCORES[j] = 0;
  }
  
  // go through paintings
  for (int p=0; p<POPULATION; p++) {
    paint = loadImage("data/" + (POPULATION* GEN + p) + ".png");
    PGraphics edging = analyzeImage(paint);
    edging.save("data/" + (POPULATION* GEN + p) + "edged.png");
    paintEdge = loadImage("data/" + (POPULATION* GEN + p) + "edged.png");

    // painting # is already known, now given which test we want, run scorePainting to get the score
    for (int j=0; j<sampleGrid; j++) { // sampleGrid is the number of tests
      float edgeScore = edgeTest(j);
      float a_score = scorePainting(j) + edgeScore;
      sblist.get(j).addNew(a_score);
      SCORES[p] += a_score;
    }
    SCORES[p] /= sampleGrid;
  }
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
    sb.elimination();

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