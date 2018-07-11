class scoreboard {
  ArrayList<Float> scores = new ArrayList<Float>();
  ArrayList<Float> inorder = new ArrayList<Float>();
  ArrayList<Float> subMedi = new ArrayList<Float>();
  ArrayList<Float> MADinOrder = new ArrayList<Float>();

  float median = 0;
  float MAD = 0;

  scoreboard() {
  }
  
  int getSize() {
    return scores.size();
  }
  
  float getItem(int i) {
    return scores.get(i);
  }
  
  void addNew(float item) {
    scores.add(item);
    inorder.add(item);
  }
  
  void sortScore() {
    Collections.sort(inorder);
  }
  
  void bigMAD() {
    sortScore();
    findMedian();
    for (int i=0; i<inorder.size(); i++) {
      subMedi.add(abs(inorder.get(i)-median));
      MADinOrder.add(abs(inorder.get(i)-median));
    }
    sortMedi();
    findMAD();
  }
  
  void sortMedi() {
    Collections.sort(MADinOrder);
  }
  
  float findLow() {
    float low = 10000000;
    for (int i=0; i<survivors.size(); i++) {
      if (scores.get(survivors.get(i)) < low) {
        low = scores.get(survivors.get(i));
      }
    }
    return low;
  }
  
  void findMAD() {
    //if (MADinOrder.size() == 0) return;
    if (MADinOrder.size() != 0 && MADinOrder.size() % 2 == 0) { // if even
      MAD = (MADinOrder.get((int)(MADinOrder.size()/2)) + MADinOrder.get(MADinOrder.size()/2-1)) / 2;
    }
    else if (MADinOrder.size() != 0 && MADinOrder.size() % 2 == 1) {
      MAD = MADinOrder.get((MADinOrder.size()-1)/2);
    }
    else {
      MAD = 0;
    }
  }

  void findMedian() {
    if (inorder.size() == 0) return;
    if (inorder.size() % 2 == 0 ) { // if even
      median = (inorder.get((int)(inorder.size()/2)) + inorder.get(inorder.size()/2 - 1)) / 2;
    }
    else {
      median = inorder.get((inorder.size()-1)/2);
    }
  }

  void testround() {
    // how to check if it's gonna be less than one
    bigMAD();

    IntList newSurvivors = new IntList();

    float limit = findLow() + MAD;
    println("limit:", limit, "median:", median, "Low:", findLow(), "MAD:", MAD);

    
    for (int h=0; h<inorder.size(); h++) {
      if (inorder.get(h) > limit) {
        inorder.remove(h);
      }
    }
    
    MADinOrder.clear();
    subMedi.clear();

    for (int i=0; i<survivors.size(); i++) {
      int index = survivors.get(i);
      if (scores.get(index) > limit) {
        survivors.remove(i);
        println("removed");
      }
    }
    if (survivors.size() == 1) {
      found = true;
      inorder.clear();
    }
  }
}
