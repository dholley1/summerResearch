boolean pressed = false;
boolean active = false;
float xpos = 0;
float ypos = 0;
float brushVelocity = 0;
float brushPressure = .99;
float brushRange = 5;
float transparency = 100;
color c = color(100, 200, 50, 100);

ArrayList<bristle> bristles = new ArrayList<bristle>();
ArrayList<Leak> LEAKS = new ArrayList<Leak>();
ArrayList<Leak> newLeaks = new ArrayList<Leak>();

void setup() {
  size(500, 500);
  background(255);
  stroke(c);
  //fill(c);
  for(int i = 0; i < 400; i ++)
    bristles.add(new bristle(i > 20? true: false));
}

void draw() {
  //c = color(100, 200,  50, transparency);
  stroke(c);
  fill(c);
  brushVelocity = sqrt(pow(mouseX - xpos, 2) + 
                       pow(mouseY - ypos, 2));
  if(pressed && active) {
    //executes when the mouse is already pressed
    for(bristle b: bristles) {
      float dx = mouseX - xpos;
      float dy = mouseY - ypos;
      b.drag(dx, dy, xpos, ypos, brushPressure);
    }
    if(keyPressed == true) {
        brushPressure += .1;
        if (brushPressure > 10) brushPressure = 10;
      }
      else {
        brushPressure -= .1;
        if (brushPressure < 1) brushPressure = 1;
      }
  
    //LEAKS.add(new Leak(mouseX, mouseY));
  }
  else if(pressed) {
    //executes if the mouse has just been pressed
    c = color(random(255), random(255), random(255), transparency);
    for(bristle b: bristles) {
      float angle = random(0, 2*PI);
      b.press(mouseX + cos(angle) * random(0, brushRange),
              mouseY + sin(angle) * random(0, brushRange));
    }   
    active = true;
  }
  for(Leak l: LEAKS) l.addTo();
  for(Leak l: newLeaks) LEAKS.add(l);
  newLeaks.clear();
  for(Leak l: LEAKS) l.spread();
  xpos = mouseX;
  ypos = mouseY;
}

void mousePressed() {
  pressed = true;
}

void mouseReleased() {
  pressed = false;
  active = false;
  transparency = 100;
  brushRange = 5;
}