int[] lexicase() {

  //
  // SET UP
  //
  for (int i=0; i<POPULATION; i++) {
    survivors.append(i);
  }
  // choose the random order
  IntList rng = new IntList();
  for (int i=0; i<sampleGrid; i++) {
    rng.append(i);
  }
  IntList randomOrder = new IntList();
  for (int j=0; j<sampleGrid; j++) {
    int selected = (int)random(rng.size());
    randomOrder.append(rng.get(selected));
    rng.remove(selected);
  }

  
  //
  // FIRST PARENT SEARCH
  //
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

  int[] parents = new int[2];
  parents[0] = survivors.get(0);
  survivors.clear();
  
  
  // isn't this supposed to reset everything?
  while (survivors.size() != 0) {
    survivors.remove(survivors.size()-1);
  }
  while (randomOrder.size() != 0) {
    randomOrder.remove(randomOrder.size()-1);
  }
  found = false; 


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
  parents[1] = survivors.get(0);
  survivors.clear();
  
  
  
  // isn't this supposed to reset everything?
  while (survivors.size() != 0) {
    survivors.remove(survivors.size()-1);
  }
  while (randomOrder.size() != 0) {
    randomOrder.remove(randomOrder.size()-1);
  }
  found = false; 

  return parents;
}
