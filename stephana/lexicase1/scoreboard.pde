//class scoreboard {

//  ArrayList<Float> scores = new ArrayList<Float>();
//  ArrayList<Float> inorder = new ArrayList<Float>();
//  ArrayList<Float> subMedi = new ArrayList<Float>();
//  ArrayList<Float> MADinOrder = new ArrayList<Float>();
//  int size = 0;
//  int sizy = 0;
//  float minimum = 100000;
//  float median = 0;
//  float MAD = 0;
  
  
//  scoreboard() {
//    scores = new ArrayList<Float>();
//  }
  
//  int getSize() {
//    return scores.size();
//  }
  
//  float getItem(int i) {
//    return scores.get(i);
//  }

//  void addNew(float item) {
//    ordering(item);
//    scores.add(scores.size(), item);
//    if (item < minimum) minimum = item;
//    size++;
//  }

//  void ordering(float item) {
//    if (inorder.size()==0) {
//      inorder.add(inorder.size(), item);
//    }
//    else{
//      for (int i=0; i<inorder.size(); i++) {
//        if (item < inorder.get(i)) { // if the item is less than the ith item
//          inorder.add(i, item);
//          return;
//        }
//      }
//      inorder.add(inorder.size(), item);
//    }
//  }
  
//  void bigMAD() {
//    findMedian();
//    println("inorder size", inorder.size());
//    for (int i=0; i<inorder.size(); i++) {
//      println(i, ":", inorder.get(i));
//      subMedi.add(abs(inorder.get(i)-median));
//      smallMAD(abs(inorder.get(i)-median));
//    }

//  }

//  void smallMAD(float item) {
//    // make MADinOrder which subMedi in order 
//    if (MADinOrder.size()==0) {
//      MADinOrder.add(MADinOrder.size(), subMedi.get(0));
//      //println(MADinOrder.size());
//    }
//    else{
//      for (int j=0; j<MADinOrder.size(); j++) {
//        if (item <= MADinOrder.get(j)) {
//          MADinOrder.add(j, item);
//          //println(MADinOrder.size());
//          return;
//        }
//        else if (j == MADinOrder.size() - 1) {
//          MADinOrder.add(item);
//          //println(MADinOrder.size());
//          return;
//        }
//      }
//    }
//  }

//  float findLow() {
//    float low = 10000000;
//    for (int i=0; i<survivors.size(); i++) {
//      if (scores.get(survivors.get(i)) < low) {
//        low = scores.get(survivors.get(i));
//      }
//    }
//    return low;
//  }
  
//  void findMAD() {
//    if (MADinOrder.size() == 0) return;
//    if (MADinOrder.size() % 2 == 0) { // if even
//      MAD = (MADinOrder.get((int)(MADinOrder.size()/2)) + MADinOrder.get(MADinOrder.size()/2-1)) / 2;
//    }
//    else {
//      MAD = MADinOrder.get((MADinOrder.size()-1)/2);
//    }
//  }
  
//  void findMedian() {
//    // assume size == capacity when this function is being called
//    if (inorder.size() == 0) return;
//    if (inorder.size() % 2 == 0 ) { // if even
//      median = (inorder.get((int)(inorder.size()/2)) + inorder.get(inorder.size()/2 - 1)) / 2;
//    }
//    else {
//      median = inorder.get((inorder.size()-1)/2);
//    }
//    //return median;
//  }

//  void testround() {
//    // how to check if it's gonna be less than one
//    bigMAD();

//    IntList newSurvivors = new IntList();

//    float limit = findLow() + MAD;
//    println("limit:", limit, "median:", median, "Low:", findLow(), "MAD:", MAD);
    
//    for (int h=0; h<inorder.size(); h++) {
//      if (inorder.get(h) > limit) {
//        inorder.remove(h);
//      }
//    }
    
//    MADinOrder.clear();
//    subMedi.clear();

//    for (int i=0; i<survivors.size(); i++) {
//      int index = survivors.get(i);
//      if (scores.get(index) <= limit) {
//        newSurvivors.append(i);
//      }
//    }
//    if (newSurvivors.size() == 1) {
//      survivors.clear();
//      for (int i=0; i<newSurvivors.size(); i++) {
//        survivors.append(newSurvivors.get(i));
//      }
//      found = true;
//      inorder.clear();
//    }
//  }
//}
