class bristle {
  float xpos;  //x, y position
  float ypos;
  float lowXFactor = -.1;  //random offset limits
  float highXFactor = .1;
  float lowYFactor = -.1;
  float highYFactor = .1;
  float thresh = 1.4;  //speed threshold
  float shift = .1;
  boolean smear;  //whether bristle is adding color or smearing what's under it
  color lastColor;  //color under bristle
  
  float div = 100;
  
  PGraphics body;
  Canvas can;
  
  public bristle(Canvas c, PGraphics b, boolean s) {
    smear = s;
    body = b;
    can = c;
  }
  
  void press(float x, float y) {
    //put bristles on canvas
    lastColor = body.get((int)x, (int)y);
    xpos = x;
    ypos = y;
    body.point(x, y);
  }
  
  void drag(float dx, float dy, float x, float y, float p) {
    // for when bristles are down and dragging
    float speed = sqrt(pow(dx, 2) + pow(dy, 2));
    //if above threshold, get closer to center, else further away
    float xchange = speed < thresh ? (xpos - x) / div / (speed + 1) * p 
                                   : (x - xpos) / div * (speed + 1) / p;
    float ychange = speed < thresh ? (ypos - y) / div / (speed + 1) * p
                                   : (y - ypos) / div * (speed + 1) / p;
    float newx = xpos + dx + random(lowXFactor, highXFactor) + xchange;
    float newy = ypos + dy + random(lowYFactor, highYFactor) + ychange;
    if (sqrt(pow(x - newx, 2) + pow(y - newy, 2)) > 5) {
      newx = xpos + dx;
      newy = ypos + dy;
    }
    if(smear) {
      //take color underneath brush
      body.stroke(lastColor);
      lastColor = body.get((int)newx, (int)newy);
    }
    else {
      //add new color
      float whiteOffset = dx + dy < 5 ?
            5 * (dx + dy) / 2 :
            dx + dy < 10 ?
            5 * (-10 + dx + dy) / 2 :
            dx + dy < 15 ?
            5 * (-15 + dx + dy) / 2:
            5 * (-20 + dx + dy) / 2;
      body.stroke(red(can.c) + whiteOffset, green(can.c) + whiteOffset, blue(can.c) + whiteOffset);
    }
    body.line(xpos, ypos, newx, newy);
    xpos = newx;
    ypos = newy;
  }
}