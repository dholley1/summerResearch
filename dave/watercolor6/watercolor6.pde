/* Attempting to simulate a watercolor effect.
   A Brush is comprised of layers, each of which is a random-ish polygon. */

int origWidth = 600;    // assuming the original image is 600x400
int origHeight = 400;

PImage originalImage;

int xPt, yPt;


void setup() {
  size(1200, 400);
  background(255);
  
  originalImage = loadImage("portrait.jpg");
  image(originalImage, 0, 0);
}

void draw() {
  /* Process the given image and decide how to paint it. */
  
  //int xPt, yPt;
  
  // Choose a random point on the original image, and see if the corresponding
  //  point on the painting has yet to be filled:
  //boolean hunting = true;
  //while (hunting) {
  //  xPt = (int) random(width);
  //  yPt = (int) random(height);
  //  color cPt = get(xPt + width/2, yPt);
  //  if (cPt == color(255)) {
  //    hunting = false;
  //  }
  //}
  
  // Paint a random point:
  xPt = (int) random(width);
  yPt = (int) random(height);

  Brush b = new Brush(get(xPt, yPt));
  b.display(xPt + width/2, yPt);
}

void keyPressed() {
  /* Resets the sketch. */
  setup();
}

class Brush {
  /* A Brush is comprised of 'child' layers added to a single 'parent' PShape. */
  
  PShape parent = createShape(GROUP);

  int brushRad = (int) random(3, 5);     // initial radius of brush
  int numLayers = (int) random(5, 9);    // number of layers that comprise each brush
  int numVerts[];                        // each layer has a different number of vertices
  
  color brushCol;   // the color of the paint to apply with the Brush
  
  Brush(color bc) {
    /* Constructor for a Brush; each 'child' layer is a polygon with a random number of sides. */
    
    brushCol = color(red(bc), green(bc), blue(bc), 3);
    
    float tempRad = brushRad;    // the radius changes as the 'child' layer is created
    float tempAng = 0;           // initialize the angle at 0
    int deltaRad = 2;            // radius changes by random(-deltaRad, +deltaRad)
    
    // Determine the (random) number of vertices per layer, and store them in an array:
    
    numVerts = new int[numLayers];
    for (int v = 0; v < numLayers; v++)
      numVerts[v] = (int) random(8, 16);
    
    // Create the 'child' layers:
        
    for (int layer = 0; layer < numLayers; layer++) {
      
      PShape child = createShape();
    
      child.beginShape();
        child.fill(brushCol);
        child.noStroke();
        int nv = numVerts[layer];
        for (int v = 0; v < nv; v++) {
          child.vertex(tempRad * cos(tempAng), tempRad * sin(tempAng));
          tempRad += (int) random(-deltaRad, deltaRad);
          tempAng += TWO_PI / nv;
        }
      child.endShape(CLOSE);

      parent.addChild(child);

    }
  }
  
  void display(float x, float y) {
    /* Put the Brush to paper. */
    
    float xNow = x;
    float yNow = y;
    for (int squiggle = 0; squiggle < 3; squiggle++) {
      shape(this.parent, xNow, yNow);
      xNow += random(-3, 3);
      yNow += random(-3, 3);
    }  
  }
  
}