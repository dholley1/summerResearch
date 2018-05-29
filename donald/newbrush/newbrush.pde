boolean pressed = false;
boolean active = false;
float xpos = 0;
float ypos = 0;
float brushVelocity = 0;
float brushRange = 10;
float transparency = 100;
color c = color(100, 200, 50, 100);

ArrayList<bristle> bristles = new ArrayList<bristle>();
ArrayList<Leak> LEAKS = new ArrayList<Leak>();

void setup() {
  size(500, 500);
  background(255);
  stroke(c);
  fill(c);
  for(int i = 0; i < 400; i ++)
    bristles.add(new bristle());
}

void draw() {
  //transparency *= .99;
  c = color(100, 200,  50, transparency);
  stroke(c);
  fill(c);
  brushVelocity = sqrt(pow(mouseX - xpos, 2) + 
                       pow(mouseY - ypos, 2));
  if(pressed && active) {
    //executes when the mouse is already pressed
    for(bristle b: bristles) {
      float dx = mouseX - xpos;
      float dy = mouseY - ypos;
      b.drag(dx, dy, xpos, ypos);
    }
    Leak l = new Leak(xpos, ypos);
      LEAKS.add(l);
  }
  else if(pressed) {
    //executes if the mouse has just been pressed
    for(bristle b: bristles) {
      float angle = random(0, 2*PI);
      b.press(mouseX + cos(angle) * random(0, brushRange),
              mouseY + sin(angle) * random(0, brushRange));
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
  transparency = 100;
  brushRange = 10;
  //LEAKS.clear();
}