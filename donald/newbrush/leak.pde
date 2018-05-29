class Leak {
  int val = 5;
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
    for(int i = 0; i < 2; i++) {
      float angle = random(0, 2*PI);
      float dx = cos(angle) * random(0, 20);
      float dy = sin(angle) * random(0, 20);
      line(xpos, ypos, xpos + dx, ypos + dy);
      leaks.add(new Leak(xpos + dx, ypos + dy, val - 1));
    }
    done = true;
  }
  
  void addTo() {
    for(Leak l: leaks) {
      LEAKS.add(l);
    }
    leaks.clear();
  }
}