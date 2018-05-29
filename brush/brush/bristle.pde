class bristle {
  float xpos;
  float ypos;
  
  bristle(float x, float y) {
    xpos = x;
    ypos = y;
    point(x, y);
  }
  
  void drag(float dx, float dy) {
    float newx = xpos + dx;
    float newy = ypos + dy;
    line(xpos, ypos, newx, newy);
    xpos = newx;
    ypos = newy;
  }
  
}