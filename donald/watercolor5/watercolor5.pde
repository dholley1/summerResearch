/* Attempting to simulate a watercolor effect.
   A Brush is comprised of layers, each of which is a random-ish polygon. */
PShape child;
int currentBrush;       // stores the 'number' of the current Brush we are painting with
int numBrushes = 5;    // how many brushes we have to work with
float xpos;
float ypos;
float speed = 10;

Brush[] allBrushes = new Brush[numBrushes];

void setup() {
  size(500, 400);
  background(255);
  
  // Add brushes to the allBrushes ArrayList:
  for (int b = 0; b < numBrushes; b++)
    allBrushes[b] = new Brush();
}

void draw() {
  /* Click the mouse to paint. */
}

void mousePressed() {
  /* Chooses a random Brush to paint with. */
  currentBrush = (int) random(0, allBrushes.length);
  Brush useBrush = allBrushes[currentBrush];
  useBrush.display(mouseX, mouseY);
  xpos = mouseX;
  ypos = mouseY;
  //useBrush.printBrushInfo();
}

void mouseDragged() {
  /* Paints with the chosen Brush. */
  speed = sqrt(pow(xpos - mouseX, 2) + pow(ypos - mouseY, 2));
  Brush useBrush = allBrushes[currentBrush];
  useBrush.update();
  useBrush.display(mouseX, mouseY);
  xpos = mouseX;
  ypos = mouseY;
}

void keyPressed() {
  /* Resets the sketch. */
  setup();
}

class Brush {
  /* A Brush is comprised of 'child' layers added to a single 'parent' PShape. */
  
  PShape parent = createShape(GROUP);

  public float brushRad = 10;   // initial radius of brush
  int numLayers = 5; //(int) random(5, 9);    // number of layers that comprise each brush
  int numVerts[];                        // each layer has a different number of vertices
  
  color brushCol = color(random(50, 255), random(50, 255), random(50, 255), 10);
  
  Brush() {
    /* Constructor for a Brush; each 'child' layer is a polygon with a random number of sides. */
    
    float tempRad = brushRad;    // the radius changes as the 'child' layer is created
    float tempAng = 0;           // initialize the angle at 0
    int deltaRad = 10;           // radius changes by random(-deltaRad, +deltaRad)
    
    // Determine the (random) number of vertices per layer, and store them in an array:
    
    numVerts = new int[numLayers];
    for (int v = 0; v < numLayers; v++)
      numVerts[v] = (int) random(8, 16);
      
    // Create the 'child' layers:
    for (int layer = 0; layer < numLayers; layer++) {
      
      child = createShape();
    
      child.beginShape();
        child.fill(brushCol);
        child.noStroke();
        int nv = numVerts[layer];
        for (int v = 0; v < nv; v++) {
          child.vertex(tempRad * cos(tempAng), tempRad * sin(tempAng));
          tempRad += random(-deltaRad, deltaRad);
          tempAng += TWO_PI / nv;
        }
      child.endShape(CLOSE);

      parent.addChild(child);

    }
  }
  
  void update() {
    float tempRad = brushRad;    // the radius changes as the 'child' layer is created
    float tempAng = 0;           // initialize the angle at 0
    int deltaRad = 10;           // radius changes by random(-deltaRad, +deltaRad)
    
    // Determine the (random) number of vertices per layer, and store them in an array:
    
    numVerts = new int[numLayers];
    for (int v = 0; v < numLayers; v++)
      numVerts[v] = (int) random(8, 16);
      
    // Create the 'child' layers:
    for (int layer = 0; layer < numLayers; layer++) {
      
      //child = createShape();
    
      child.beginShape();
        child.fill(brushCol);
        child.noStroke();
        int nv = numVerts[layer];
        for (int v = 0; v < nv; v++) {
          child.vertex(tempRad * cos(tempAng), tempRad * sin(tempAng));
          tempRad = speed / 10;//random(-deltaRad, deltaRad);
          tempAng += TWO_PI / nv;
        }
      child.endShape(CLOSE);

      //parent.addChild(child);

    }
  }
  
  void display(float x, float y) {
    /* Put the Brush to paper. */
    //this.parent.brushRad = s;
    shape(parent, x, y);
    
  }
  
  void printBrushInfo() {
    println();
    println("current brush info for brush", currentBrush, ":");
    println("brush radius:", this.brushRad);
    println("number of layers:", this.numLayers);
    
    for (int n = 0; n < numVerts.length; n++)
      println("number of vertices in layer", n, ":", numVerts[n]);
    
    println("colors:", red(this.brushCol), green(this.brushCol), blue(this.brushCol));
  }
  
}