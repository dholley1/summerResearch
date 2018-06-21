class bristle {
  float xpos;
  float ypos;
  float lowXFactor = -.1;
  float highXFactor = .1;
  float lowYFactor = -.1;
  float highYFactor = .1;
  float thresh = 5;
  float shift = .1;
  
  boolean atMax = false;
  
  float div = 100;
  
  void press(float x, float y) {
    xpos = x;
    ypos = y;
    point(x, y);
  }
  
  void drag(float dx, float dy, float x, float y, float p) {
    
    float speed = sqrt(pow(dx, 2) + pow(dy, 2));
    float xchange = speed < thresh ? (xpos - x) / div / (speed + 1) * p 
                                   : (x - xpos) / div * (speed + 1) / p;
    float ychange = speed < thresh ? (ypos - y) / div / (speed + 1) * p
                                   : (y - ypos) / div * (speed + 1) / p;
    float newx = xpos + dx + random(lowXFactor, highXFactor) + xchange;
    float newy = ypos + dy + random(lowYFactor, highYFactor) + ychange;
    if (sqrt(pow(x - newx, 2) + pow(y - newy, 2)) > 20) {
      newx = xpos + dx;
      newy = ypos + dy;
    }
    float whiteOffset = newx - mouseX + newy - mouseY < 5 ?
          5 * (newx - mouseX + newy - mouseY) :
          newx - mouseX + newy - mouseY < 10 ?
          5 * (-10 + newx - mouseX + newy - mouseY) :
          newx - mouseX + newy - mouseY < 15 ?
          5 * (-15 + newx - mouseX + newy - mouseY):
          5 * (-20 + newx - mouseX + newy - mouseY);
    stroke(red(c) + whiteOffset, green(c) + whiteOffset, blue(c) + whiteOffset);
    if(random(1) > .1)
    stroke(get((int)newx, (int)newy));
    line(xpos, ypos, newx, newy);
    xpos = newx;
    ypos = newy;
  }
}