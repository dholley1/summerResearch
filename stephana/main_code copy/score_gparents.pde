// global variable
circleGraph CG;


// BRIDGE BETWEEN THE MAIN BODY CODE AND SCORING
void createGraph() {

  // Run percentage to store the percentages of fitness of paintings
  float[] percent = percentage();

  // Variable to calculate the range
  float[] range = new float[POPULATION];
  
  // Calculate the range
  for (int n=0; n<POPULATION; n++) {
    if (n==0) {
      range[n] = percent[n];
    }
    else {
      range[n] = range[n-1] + percent[n];
    }
  }

  CG = new circleGraph();
  CG.fillGraph(range);
}


// SEPARATE EVERYTHING

// WITH THE GIVEN CG SELECT PARENTS
int[] selection() {
  // Array to save parents
  int[] parents = new int[2];
 
  // Select two random numbers
  float r1 = random(100);
  float r2 = random(100);
  
  // Reselect the second random number if the two random numbers are the same
  if (r1 == r2) {
    while (r1 != r2) {
      r2 = random(100);
    }
  }
 
  parents[0] = CG.whereGraph(r1);
  parents[1] = CG.whereGraph(r2);

  // Run the compare function again if two parents are the same
  if (parents[0] == parents[1]) {
    while (parents[0] == parents[1]) {
      r2 = random(100);
      parents[1] = CG.whereGraph(r2);
    }
  }
  //println("parents: ", parents[0], parents[1]);
  return parents;
}
