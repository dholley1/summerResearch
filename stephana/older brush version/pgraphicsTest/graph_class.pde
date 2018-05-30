// represent a pie of a circle graph
class pie {
  int n;
  float min;
  float max;
  
  pie(int number, float minimum, float maximum) {
    n = number;
    min = minimum;
    max = maximum;
  }
  
  boolean within_range(float f) {
    if (min <= f && f < max) return true;
    return false;
  }
  
  int check_range(float f) {
    if (within_range(f)) return n;
    return -1;
  }
}


class circleGraph {
  pie[] pies;
  
  circleGraph() {
    pies = new pie[POPULATION];
  }
  
  void makeGraph(float[] range) {
    for (int i = 0; i<POPULATION; i++) {
      if (i==0) pies[i] = new pie(i, 0, range[i]);
      pies[i] = new pie(i, range[i-1], range[i]);
    }
  }
  
  int whereGraph(float f) {
    for (int i = 0; i<POPULATION; i++) {
      if (pies[i].check_range(f) != -1) return pies[i].check_range(f);
    }
    return -1;
  }
}