class bristle {
  float xpos;
  float ypos;
  float lowXFactor = -.5;
  float highXFactor = .5;
  float lowYFactor = -.5;
  float highYFactor = .5;
  float thresh = 5;
  float shift = .1;
  
  float div = 100;
  
  void press(float x, float y) {
    xpos = x;
    ypos = y;
    point(x, y);
  }
  
  void drag(float dx, float dy, float x, float y) {
    float speed = sqrt(pow(dx, 2) + pow(dy, 2));
    float xchange = speed < thresh ? (xpos - x) / div / (speed + 1) 
                                   : (x - xpos) / div * (speed + 1);
    float ychange = speed < thresh ? (ypos - y) / div / (speed + 1)
                                   : (y - ypos) / div * (speed + 1);
    float newx = xpos + dx + random(lowXFactor, highXFactor) + xchange;
    float newy = ypos + dy + random(lowYFactor, highYFactor) + ychange;
    line(xpos, ypos, newx, newy);
    xpos = newx;
    ypos = newy;
  }
}