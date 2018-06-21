class Leak {
  int val = 100;
  float xpos;
  float ypos;
  float dx;
  float dy;
  public boolean done = false;
  ArrayList<Leak> leaks = new ArrayList<Leak>();
  
  Leak(float x, float y) {
    xpos = x;
    ypos = y;
  }
  
  Leak(float x, float y, int v) {
    xpos = x;
    ypos = y;
    val = v;
    if(val == 0) done = true;
  }
  
  void spread() {
    if(!done) {
      for(int i = 0; i < 1; i++) {
        float angle = random(0, 2*PI);
        float dx = cos(angle) * random(0, 1);
        float dy = sin(angle) * random(0, 1);
        line(xpos, ypos, xpos + dx, ypos + dy);
        leaks.add(new Leak(xpos + dx, ypos + dy, val - 1));
      }
      done = true;
    }
  }
  
  void addTo() {
    for(Leak l: leaks) {
      newLeaks.add(l);
    }
    leaks.clear();
  }
}