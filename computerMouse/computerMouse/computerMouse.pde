//0:mouseX, 1:mouseY, 2:dx, 3:dy, 4:targetX, 5:targetY
//float[] vals = {0, 0, 4, 2, 40, 40};
boolean done = false;
boolean move = false;
boolean pressed = false;

color c;

float[] xbristles = new float[400];
float[] ybristles = new float[400];
float brushVelocity = 0;
float brushRange = 10;

float xpos = 0;
float ypos = 0;

PImage input;

void advance(float[] vals, int sizeX, int sizeY) {
  if (vals[0] >= sizeX)
    done = true;
  else if (vals[1] >= sizeY) {
    vals[1] = 0;
    vals[4] += 40;
    pressed = true;
    move = false;
  }
  else if (move) {
    vals[0] -= 40;
    vals[1] += 5;
    vals[2] = 4;
    vals[3] = 2;
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



void setup(){
  background(255);
  //blendMode(MULTIPLY);
  input = loadImage("flower.jpg");
  image(input, 0, 0, 300, 300);
  
  String[] args = {"PaintWindow"};
  for(int i = 0; i < 3; i++) {
    float deltaX = random(10, 100);
    float[] vals = {0, 0, random(.1, 20), random(.1, 20), deltaX, deltaX};
    window win = new window(i < 5 ? 300 * i : 300 * i - 1500,
                            i < 5 ? 0 : 300, 
                            vals, this);
    PApplet.runSketch(args, win);
  }
  
}

void settings() {
  size(300, 300);
}

void draw() {
  /*if(!done) {
    surface.setLocation(600, 600);
    advance(vals, 300, 300);
    c = get((int)vals[0], (int)vals[1]);
    stroke(c);
    //transparency *= .99;
    //c = color(100, 200,  50, transparency);
    //stroke(c);
    /*brushVelocity = sqrt(pow(vals[0], 2) + 
                       pow(vals[1], 2));
    if(brushVelocity >= 5);
      //brushRange *= .9;
    else {
      //brushRange *= 1.01;
      if(brushRange > 20)
      brushRange = 20;
    }*/
}