/* Experimenting with creating multiple canvases within a single window.
   When a canvas is clicked, the other canvas(es) change color.
*/
int POPULATION = 10;

int WIDTH = 200;
int HEIGHT = 200;

PImage target;

ArrayList<Canvas> allCanvases = new ArrayList<Canvas>();

void setup() {
  size(1005, 603);
  background(50);
  rectMode(CENTER);
  target = loadImage("flower.jpg");
  image(target, 0, 402, 200, 200);
  for(int i = 0; i < POPULATION; i++) {
    allCanvases.add(new Canvas(100 + (i < 5 ? 201 * i : 201 * (i - 5)), 
                               100 + (i < 5 ? 0 : 201), 200, color(255)));
  }
  
}

void draw() {
  for (Canvas c: allCanvases) {
    c.display();
  }
}

void mousePressed() {
  /* When we click a Canvas, we change the color of the other Canvas! */
  for (Canvas c: allCanvases) {
    if (c.isClicked()) {
      c.changeColors();
    }
  }
}