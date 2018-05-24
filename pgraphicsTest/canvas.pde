class Canvas {
  /* A Canvas is a child window, independent of the rest. */
  
  float xCenter, yCenter;  // center coordinates of child window
  int sideLength;          // side length of child window
  color fillColor;         // fill color of child window
  
  PGraphics body;          // the graphical body of the Canvas
  
  Canvas(float x, float y, int s, color c) {
    
    xCenter = x;
    yCenter = y;
    sideLength = s;
    fillColor = c;
    
  }
  
  void display() {
    /* Draws the Canvas to the main window. */
    
    body = createGraphics(sideLength, sideLength);
    
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
      }
    }
    
  }
  
}