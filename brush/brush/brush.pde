boolean pressed = false;
boolean active = false;
float xpos = 0;
float ypos = 0;
float brushVelocity = 0;
float brushRange = 10;
float transparency = 100;
color c = color(100, 200, 50, 100);

float[] xbristles = new float[400];
float[] ybristles = new float[400];

void setup() {
  size(500, 500);
  background(255);
  stroke(c);
}

void draw() {
  transparency *= .999;
  c = color(100, 200,  50, transparency);
  print(red(c));
  stroke(c);
  brushVelocity = sqrt(pow(mouseX - xpos, 2) + 
                       pow(mouseY - ypos, 2));
  if(brushVelocity >= 5)
    brushRange *= .99;
  else {
    brushRange *= 1.01;
    if(brushRange > 20)
      brushRange = 20;
  }
  if(pressed && active) {
    //executes when the mouse is already pressed
    for(int i = 0; i < 400; i++) {
      float angle = random(0, 2*PI);
      xpos = cos(angle) * brushRange + mouseX;//random(mouseX - brushRange, mouseX + brushRange);
      ypos = sin(angle) * brushRange + mouseY;//random(mouseY - brushRange, mouseY + brushRange);
      line(xbristles[i], ybristles[i], xpos, ypos);
      xbristles[i] = xpos;
      ybristles[i] = ypos;
    }
  }
  else if(pressed) {
    //executes if the mouse has just been pressed
    for(int i = 0; i < 400; i++) {
      float angle = random(0, 2*PI);
      xpos = cos(angle) * brushRange + mouseX;//random(mouseX - brushRange, mouseX + brushRange);
      ypos = sin(angle) * brushRange + mouseY;//random(mouseY - brushRange, mouseY + brushRange);
      point(xbristles[i], ybristles[i]);
      xbristles[i] = xpos;
      ybristles[i] = ypos;
    }
    active = true;
  }
  xpos = mouseX;
  ypos = mouseY;
}

void mousePressed() {
  pressed = true;
}

void mouseReleased() {
  pressed = false;
  active = false;
  transparency = 10;
  brushRange = 10;
}