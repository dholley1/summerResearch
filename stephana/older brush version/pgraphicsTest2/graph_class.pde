// represent a pie of a circle graph
class pie {
  int n;
  float min;
  float max;
  
  pie(int number, float minimum, float maximum) {
    n = number;
    min = minimum;
    max = maximum;
    println("min:", min, " max:", max);
  }
  
  boolean within_range(float f) {
    if (min <= f && f < max) {
      println(f, "within range");
      return true;
    }
    println("NOT within range");
    return false;
  }
  
  int check_range(float f) {
    if (within_range(f)) return n;
    println("error");
    return -1;
  }
}


class circleGraph {
  pie[] pies;
  
  circleGraph() {
    pies = new pie[POPULATION];
  }
  
  void fillGraph(float[] range) {
    for (int i = 0; i<POPULATION; i++) {
      if (i==0) {
        pies[i] = new pie(i, 0, range[i]);
        println("for 0", range[i]);
      }
      else pies[i] = new pie(i, range[i-1], range[i]);
    }
  }
  
  int whereGraph(float f) {
    println("f value: ", f);
    for (int i = 0; i<POPULATION; i++) {
      int found = pies[i].check_range(f);
      if (found != -1) return found;
    }
    return -1;
  }
}