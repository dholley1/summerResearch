/* Experimenting with creating multiple canvases within a single window.
   When a canvas is clicked, the other canvas(es) change color.
*/

ArrayList<Canvas> allCanvases = new ArrayList<Canvas>();

void setup() {
  size(600, 300);
  background(50);
  rectMode(CENTER);
  
  allCanvases.add(new Canvas(150, 150, 200, color(255, 0, 0)));
  allCanvases.add(new Canvas(450, 150, 200, color(0, 255, 0)));
  
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

void keyPressed() {
  /* When a key is pressed, we save the PGraphics images. */
  int x = 0;
  for (Canvas c: allCanvases) {
    c.saveCanvas(str(x));
    x++;
  }
}

class Canvas {
  /* A Canvas is a child window, independent of the rest. */
  
  float xCenter, yCenter;  // center coordinates of child window
  int sideLength;          // side length of child window
  color fillColor;         // fill color of child window
  
  // the graphical body of the Canvas:
  PGraphics body;
  
  Canvas(float x, float y, int s, color c) {
    
    xCenter = x;
    yCenter = y;
    sideLength = s;
    fillColor = c;
    
    body = createGraphics(sideLength, sideLength);
    
  }
  
  void display() {
    /* Draws the Canvas to the main window. */
    
    body.beginDraw();
      // Not doing anything interesting graphically yet:
      body.background(fillColor);
    body.endDraw();
    
    // Add the Canvas to the window; the math is for centering correctly,
    // as an image uses the upper left corner as the origin:
    image(body, xCenter - sideLength/2, yCenter - sideLength/2);
  }
  
  boolean isClicked() {
    /* Check if a Canvas was clicked; return true if so. */
    
    if (   abs(xCenter - mouseX) <= sideLength/2
        && abs(yCenter - mouseY) <= sideLength/2)
          return true;
          
    // ..otherwise:
    return false;
  }
  
  void changeColors() {
    /* Changes the color of all other Canvases. */
    
    for (Canvas c: allCanvases) {
      if (this != c) {
        c.fillColor = color(random(255), random(255), random(255));
        c.body.beginDraw();
          c.body.fill(0, 0, 255);
          c.body.ellipse(int(sideLength/2), int(sideLength/2), 40, 40);
        c.body.endDraw();
        c.display();
      }
    }
    
  }
  
  void saveCanvas(String name) {
    /* Saves the image (when a key is pressed). */
    this.body.save(name + ".png");
  }
  
}