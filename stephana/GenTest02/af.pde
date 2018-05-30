

// Select two parents using other methods
int[] selection() {

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

  // Select two random numbers
  float r1 = random(100);
  float r2 = random(100);
  
  // Reselect the second random number if the two random numbers are the same
  if (r1 == r2) {
    while (r1 != r2) {
      r2 = random(100);
    }
  }

  // Array to save parents
  int[] parents = new int[2];
 
  //for (int i=0; i<range.length; i++) {
  //  println("range", i, ": ", range[i]);
  //}
 
  circleGraph cg = new circleGraph();
  cg.fillGraph(range);
  parents[0] = cg.whereGraph(r1);
  parents[1] = cg.whereGraph(r2);

  // Run the compare function again if two parents are the same
  if (parents[0] == parents[1]) {
    while (parents[0] == parents[1]) {
      r2 = random(100);
      parents[1] = cg.whereGraph(r2);
    }
  }
  //println("parents: ", parents[0], parents[1]);
  return parents;
}
