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
  }

  void sortScore() {
    for (int i=0; i<survivors.size(); i++) {
      inorder.add(scores.get(survivors.get(i)));
    }
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

  void elimination() {
    // how to check if it's gonna be less than one
    bigMAD();

    float limit = findLow() + MAD;
    
    MADinOrder.clear();
    subMedi.clear();

    for (int i=0; i<survivors.size(); i++) {
      int index = survivors.get(i);
      if (scores.get(index) > limit) {
        survivors.remove(i);
      }
    }
    if (survivors.size() == 1) {
      found = true;
      inorder.clear();
    }
  }
}

class tuple {
  int x;
  int y;
  
  tuple(int xpos, int ypos) {
    x = xpos;
    y = ypos;
  }
  
  int x() {
    return x;
  }

  int y() {
    return y;
  }
}


color getColor(PImage img, tuple pair) {
  // get the color of the pixel in tuple

  color c = img.get(pair.x, pair.y);
  return c;
}