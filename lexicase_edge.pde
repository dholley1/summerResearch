// variables for the entire file
ArrayList<scoreboard> sblist = new ArrayList<scoreboard>();
float[] EDGESCORES = new float[TOTALPOPULATION];
float[] COLORSCORES = new float[TOTALPOPULATION];
// variables for runTest() and perPainting()
int gridSide = 10;
int gridX = (int) (WIDTH / gridSide);
int gridY = (int) (HEIGHT / gridSide);

int totalGrid = gridX * gridY;
int sampleGrid = (int) (totalGrid * 0.2);
int sampleNum = (int) ((gridSide * gridSide) * 0.5);

PImage paint;

tuple[][] colorSamples = new tuple[sampleGrid][sampleNum];

void sampling() {
  for (int i=0; i<sampleGrid; i++) {
    float randGridX = random(gridX);
    float randGridY = random(gridY);

    for (int j=0; j<sampleNum; j++) {
      int x = (int) (randGridX * gridSide + random(gridSide));
      int y = (int) (randGridY * gridSide + random(gridSide));
      colorSamples[i][j] = new tuple(x, y);
    }
  }
}


float scorePainting(int i) { // i is the first index
  float diffSum = 0;
 
  for (int j=0; j<sampleNum; j++) { // for each sample to be used for the ith test
  
    // Compare color at pixels
    color origC = getColor(input, colorSamples[i][j]);
    color resuC = getColor(paint, colorSamples[i][j]);
  
    float dist = findDist(origC, resuC);
    diffSum += dist;
  }
  
  diffSum /= sampleNum;
  return diffSum;
}

PImage goodEdge;
PImage paintEdge;

tuple[][] edgeSamples = new tuple[sampleGrid][sampleNum];

void edgeSampling() { // assuming this works, consider white space around edges, and taking only white samples

  for (int i=0; i<sampleGrid; i++) { // exclude edges
    float randGridX = random(1, gridX-1);
    float randGridY = random(1, gridY-1);

    for (int j=0; j<sampleNum; j++) {
      
      int x = (int) (randGridX * gridSide + random(gridSide));
      int y = (int) (randGridY * gridSide + random(gridSide));
      
      edgeSamples[i][j] = new tuple(x, y);
    }
  }
}

//void edgeSampling() { // assuming this works, consider white space around edges, and taking only white samples

//  println("edge sampling");

//  for (int i=0; i<sampleGrid; i++) { // exclude edges
//    float randGridX = random(1, gridX-1);
//    float randGridY = random(1, gridY-1);
    
//    ArrayList<tuple> tuples = new ArrayList<tuple>();
        
//    for (int m=0; m<gridSide; m++) {
//      for (int n=0; n<gridSide; n++) {
//        int x = (int) (randGridX * gridSide + m);
//        int y = (int) (randGridY * gridSide + n);
//        if (brightness(goodEdge.get(x, y)) > 240)
//          tuples.add(new tuple(x, y));
//      }
//    }
    
//    println("size", tuples.size());
//  }
//}

float edgeTest(int i) {
  
  // use brightness
  

  float diffSum = 0;
  
  for (int j=0; j<sampleNum; j++) {
    color origC = getColor(goodEdge, edgeSamples[i][j]);
    color resuC = getColor(paintEdge, edgeSamples[i][j]);
    
    float dist = findDist(origC, resuC);
    if (dist <= 4) {
      dist = 0;
    }
    
    // if dist is less then good
    diffSum += dist;
  }
  
  diffSum /= sampleNum;
  return diffSum;
}


void runTest() {
  
  // Choose sample points to compare
  sampling();
  edgeSampling();

  // ArrayList of scoreboards
  for (int i=0; i<sampleGrid; i++) {
    scoreboard sb = new scoreboard();
    sblist.add(sb);
  }
  // Score paintings
  for (int j =0; j<TOTALPOPULATION; j++) {
    ALLSCORES[j] = 0;
    EDGESCORES[j] = 0;
    COLORSCORES[j] = 0;
  }
  // go through paintings
  for (int p=0; p<TOTALPOPULATION; p++) {
    paint = loadImage("\\\\gemini.cs.hamilton.edu\\summer18/data/" + (TOTALPOPULATION * GEN + p) + ".png");
    PGraphics edging = analyzeImage(paint);
    edging.save("\\\\gemini.cs.hamilton.edu\\summer18/data/" + (TOTALPOPULATION * GEN + p) + "edged.png");
    paintEdge = loadImage("\\\\gemini.cs.hamilton.edu\\summer18/data/" + (TOTALPOPULATION * GEN + p) + "edged.png");
    // painting # is already known, now given which test we want, run scorePainting to get the score
    
    float et = 0;
    float sp = 0;
    float oneScore = 0;
    for (int j=0; j<sampleGrid; j++) { // sampleGrid is the number of tests
      et = edgeTest(j);
      sp = scorePainting(j);
      oneScore = sp + et;
      sblist.get(j).addNew(oneScore);
      ALLSCORES[p] += oneScore;
      EDGESCORES[p] += et;
      COLORSCORES[p] += sp;
    }
   
    ALLSCORES[p] /= sampleGrid;
    EDGESCORES[p] /= sampleGrid;
    COLORSCORES[p] /= sampleGrid;
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
  for (int i=0; i<TOTALPOPULATION; i++) {
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