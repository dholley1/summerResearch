class bristle {
  //class for each bristle in brush
  float xpos;
  float ypos;
  float lowXFactor = -.5;
  float highXFactor = .5;
  float lowYFactor = -.5;
  float highYFactor = .5;
  float thresh = 5;
  float shift = .1;
  
  float div = 100;
  
  PGraphics canvas;
  
  bristle (PGraphics c) {
    canvas = c;
  }
  
  void press(float x, float y) {
    xpos = x;
    ypos = y;
    canvas.point(x, y);
  }
  
  void drag(float dx, float dy, float x, float y, float p) {
    float speed = sqrt(pow(dx, 2) + pow(dy, 2));
    float xchange = speed < thresh ? (xpos - x) / div / (speed + 1) * p 
                                   : (x - xpos) / div * (speed + 1) / p;
    float ychange = speed < thresh ? (ypos - y) / div / (speed + 1) * p
                                   : (y - ypos) / div * (speed + 1) / p;
    float newx = xpos + dx + random(lowXFactor, highXFactor) + xchange;
    float newy = ypos + dy + random(lowYFactor, highYFactor) + ychange;
    if (sqrt(pow(x - newx, 2) + pow(y - newy, 2)) > 4) {
      newx = xpos + dx;
      newy = ypos + dy;
    }
    canvas.line(xpos, ypos, newx, newy);
    xpos = newx;
    ypos = newy;
  }
}