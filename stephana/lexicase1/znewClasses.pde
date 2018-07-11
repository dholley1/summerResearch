class list {

  // attributes
  float[] dist;
  float[] diff;
  int size = 0;
  int capacity;
  
  
  // initializer
  list(int listCap) {
    capacity = listCap;
    dist = new float[capacity];
  }
  
  // add method
  void add(float item) {
    dist[size] = item;
    size++;
  }
  
  // find items in minimum range
  list findMin() {
    list minis = new list(size);
    float max = 10000;
    for(int i=0; i<size; i++) {
      if (dist[i] < max) max = dist[i];
    }
    return minis;
  }
  
  int getSize() {
    return size;
  }
  
  void diffChart() {
    diff = new float[size];
    for (int i=0; i<size; i++) {
      diff[i] = abs(dist[(i+1)%size] - dist[i]);
    }
  }
  
  void printDiff() {
    print("diff: ");
    for (int i=0; i<size; i++) {
      if (i!=0) print(", ");
      print(diff[i]);
    }
    print("\n");
  }
  
  void printDist() {
    print("dist: ");
    for (int i=0; i<size; i++) {
      if (i!=0) print(", ");
      print(dist[i]);
    }
    print("\n");
  }
  
  float edgeProb() {
    float edgeProb = 0;
    int count = 0;
    for (int i=0; i<size; i++) {
      if (diff[i] < 4) {
        edgeProb += 0;
        count++;  
      }
      else {
        edgeProb += diff[i];
        count++;
      }
    }
    return edgeProb/count;
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


color getColor(tuple pair) {
  // get the color of the pixel in tuple

  color c = get(pair.x, pair.y);
  return c;
}


tuple randomPoint(tuple point, float radius) {
  // get a random point within the circle centered at the given point with the given radius
  float randRadi = random(radius);
  float randTheta = random(PI);
  int x = point.x + int(randRadi * cos(randTheta));
  int y = point.y + int(randRadi * sin(randTheta));
  tuple randPoint = new tuple(x, y);
  return randPoint;
}


tuple march(tuple point, tuple dir, int r) {
  tuple next = new tuple(point.x + 2 * r * dir.x, point.y + 2 * r * dir.y);
  return next;
}
