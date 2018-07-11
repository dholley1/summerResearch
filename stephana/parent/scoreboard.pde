class scoreboard {

  ArrayList<Float> scores = new ArrayList<Float>();
  ArrayList<Float> inorder = new ArrayList<Float>();
  ArrayList<Float> subMedi = new ArrayList<Float>();
  ArrayList<Float> MADinOrder = new ArrayList<Float>();
  int size = 0;
  int sizy = 0;
  float minimum = 100000;
  float median;
  float MAD;
  
  
  scoreboard() {
    scores = new ArrayList<Float>();
  }
  
  void addNew(float item) {
    ordering(item);
    scores.add(item);
    if (item < minimum) minimum = item;
    //println("I added!", item);
  }
  
  
  void ordering(float item) {
    if (inorder.size()==0) {
      inorder.add(item);
    }
    else{
      for (int i=0; i<inorder.size(); i++) {
        if (item < inorder.get(i)) { // if the item is less than the ith item
          inorder.add(i, item);
          return;
        }
      }
      inorder.add(item);
    }
  }

  
  void bigMAD() {
    median = findMedian();
    for (int i=0; i<scores.size(); i++) {
      subMedi.add(abs(inorder.get(i)-median));
      smallMAD(abs(inorder.get(i)-median));
      sizy++;
    }
  }
  
  void smallMAD(float item) {
    // make MADinOrder which subMedi in order
    if (sizy==0) {
      MADinOrder.add(subMedi.get(0));
      sizy++;  
    }
    for (int j=0; j<sizy; j++) {
      if (item <= MADinOrder.get(j)) {
        MADinOrder.add(j, item);
      }
    }
  }
  
  
  float findLow() {
    return inorder.get(0);
  }
  
  float findMAD() {
    if (sizy % 2 == 0) { // if even
      MAD = (MADinOrder.get((int)(sizy/2)) + MADinOrder.get(sizy/2 + 1) / 2);
    }
    else {
      MAD = MADinOrder.get((sizy+1)/2);
    }
    
    return MAD;
  }
  
  float findMedian() {
    // assume size == capacity when this function is being called
    if (inorder.size() % 2 == 0 ) { // if even
      median = (inorder.get((int)(inorder.size()/2)) + inorder.get(inorder.size()/2 + 1)) / 2;
    }
    else {
      median = inorder.get((inorder.size()+1)/2);
    }
    
    return median;
  }
  
  void inRange() {
    bigMAD();
    
    float limit = findLow() + findMAD();
    
    for (int i=0; i<survivors.size(); i++) {
      int index = survivors.get(i);
      if (scores.get(index) > limit) {
        survivors.remove(index);
      }
    }
  }
}