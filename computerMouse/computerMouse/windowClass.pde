public class window extends PApplet {
  //main canvas
  PApplet picture;
  //0:mouseX, 1:mouseY, 2:dx, 3:dy, 4:targetX, 5:targetY
  float[] vals = {0, 0, 0, 0, 0, 0};
  //x and y value of window position
  public int x;
  public int y;
  
  //bools for picking up and putting down brush
  boolean pressed = false;
  boolean move = false;
  boolean done = false;
  
  //indivitual bristle points
  float[] xbristles = new float[400];
  float[] ybristles = new float[400];
  float brushVelocity = 0;
  float brushRange = random(1, 20);

  float xpos = 0;
  float ypos = 0;
  
  color c;
  float transparency = 100;
  
  //constructor
  window(int xval, int yval, float[] v, PApplet p) {
    x = xval;
    y = yval;
    vals[0] = v[0];
    vals[1] = v[1];
    vals[2] = v[2];
    vals[3] = v[3];
    vals[4] = v[4];
    vals[5] = v[5];
    picture = p;
    c = picture.get((int)vals[0], (int)vals[1]);
  }
  
  public void settings() {
    size(300, 300);
  }
  
  public void draw() {
    if(!done) {
      surface.setLocation(x, y);
      
      stroke(c);
      this.advance(vals, 300, 300);
      if(brushVelocity >= 9)
        brushRange *= .9;
      else {
        brushRange *= 1.1;
        if(brushRange > 20)
        brushRange = 20;
      }
      if(pressed) {
        c = picture.get((int)vals[0], (int)vals[1]);
        brushRange = 10;
        for(int i = 0; i < 200; i++) {
          float rand = random(0, 2*PI);
          xpos = cos(rand) * brushRange + vals[0];
          ypos = sin(rand) * brushRange + vals[1];
          point(xpos, ypos);
          xbristles[i] = xpos;
          ybristles[i] = ypos;
          pressed = false;
        }
      }
      else {
        c = color(red(c), green(c), blue(c), transparency);
        for(int i = 0; i < 200; i++) {
          float rand = random(0, 2*PI);
          xpos = cos(rand) * brushRange + vals[0];
          ypos = sin(rand) * brushRange + vals[1];
          line(xbristles[i], ybristles[i], xpos, ypos);
          xbristles[i] = xpos;
          ybristles[i] = ypos;
        }
      }
    }
  }
  
  public void advance(float[] vals, int sizeX, int sizeY) {
    if (vals[1] >= sizeY) {
      if (vals[0] >= sizeX) { 
        done = true;
        return;
      }
      vals[1] = 0;
      vals[4] += vals[5];
      pressed = true;
      move = false;
    }
    else if (move) {
      vals[0] -= vals[5];
      vals[1] += vals[5];
      move = false;
      pressed = true;
    }
    else {
      vals[0] += vals[2];
      vals[1] += vals[3];
      if(vals[0] >= vals[4])
        move = true;
    }
  }
}