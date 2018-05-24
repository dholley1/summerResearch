class Canvas {
  /* A Canvas is a child window, independent of the rest. */
  
  float xCenter, yCenter;  // center coordinates of child window
  int sideLength;          // side length of child window
  color fillColor;         // fill color of child window
  
  PGraphics body;          // the graphical body of the Canvas
  
  //0:mouseX, 1:mouseY, 2:dx, 3:dy, 4:brushLength, 
  // 5:brushTarget 6:brushThickness
  public float[] vals = {0, 0, 0, 0, 0, 0, 0};
  
  //booleans for when windows are created, when paintings are done,
  //and when new paintings can be started
  boolean start = true;
  boolean reset = false;
  boolean restart = false;
  
  //bools for picking up and putting down brush
  boolean pressed = true;
  boolean move = false;
  public boolean done = false;
  
  //indivitual bristle points
  float[] xbristles = new float[400];
  float[] ybristles = new float[400];
  
  //brush velocity and thickness variables
  float brushVelocity = 0;
  float brushRange;
  float brushThickness;

  //x and y position of the brush at its last position
  float xpos = 0;
  float ypos = 0;
  
  //color values for the paint
  color c;
  float transparency = 100;
  
  Canvas(float x, float y, int s, color c, float[] v) {
    xCenter = x;
    yCenter = y;
    sideLength = s;
    fillColor = c;
    vals = v;
    brushRange = vals[6];
    brushThickness = vals[6];
    body = createGraphics(sideLength, sideLength);
  }

  void display() {
    /* Draws the Canvas to the main window. */
    
    
    body.beginDraw();
      // Not doing anything interesting graphically yet:
      if(start || reset) {
        body.background(fillColor);
        start = false;
      }
      update();
    body.endDraw();
    
    // Add the Canvas to the window; the math is for centering correctly,
    // as an image uses the upper left corner as the origin:
    image(body, xCenter - sideLength/2, yCenter - sideLength/2);
    
  }
  
  
    void update() {
    //set background and location
    
    //loop for painting
    if(!done) {
      
      //paint gets lighter during one stroke
      transparency *= .95;
      body.stroke(c);
      
      //advaces the brush by dx and dy, or puts the brush at a new location
      advance(200, 200);
      
      //increase or decrease radius of brush depending on speed
      if(brushVelocity >= 5)
        brushRange *= .9;
      else {
        brushRange *= 1.1;
        if(brushRange > 20)
          brushRange = 20;
      }
      
      //in case the brush was picked up
      if(pressed) {
        
        //get new location color
        //c = picture.get((int)vals[0], (int)vals[1]);
        c = get((int)vals[0], (int)vals[1]);
        
        //reset transparency
        transparency = 100;
        c = color(red(c), green(c), blue(c), transparency);
        
        //reset brush thickness
        brushRange = brushThickness;
        
        //pick random points for each bristle
        for(int i = 0; i < 100; i++) {
          float rand = random(0, 2*PI);
          xpos = cos(rand) * brushRange + vals[0];
          ypos = sin(rand) * brushRange + vals[1];
          body.point(xpos, ypos);
          xbristles[i] = xpos;
          ybristles[i] = ypos;
          pressed = false;
        }
      }
      
      //if brush is dragging
      else {
        //update transparency
        c = color(red(c), green(c), blue(c), transparency);
        
        //drag each bristle to new random location
        for(int i = 0; i < 100; i++) {
          float rand = random(0, 2*PI);
          xpos = cos(rand) * brushRange + vals[0];
          ypos = sin(rand) * brushRange + vals[1];
          body.line(xbristles[i], ybristles[i], xpos, ypos);
          xbristles[i] = xpos;
          ybristles[i] = ypos;
        }
      }
    }
    //after painting is done and saved, reset to all white
    if(reset){
      xpos = 0;
      ypos = 0;
      reset = false;
      START = true;
    }
    
    //communication with main window
    if(restart) {
      restart = false;
      done = false;
    }
  }
  
  //method for advancing each frame
  public void advance(int sizeX, int sizeY) {
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
  
  //method for reproducing traits
  float[] crossover(Canvas partner) {
    float[] newGenes = new float[7];
    for(int i = 0; i < 7; i++) {
      
      //random parent for each gene
      float choice = random(1);
      if (choice < .5)
        newGenes[i] = vals[i];
      else
        newGenes[i] = partner.vals[i];
    }
    newGenes[0] = 0;
    newGenes[1] = 0;
    newGenes[4] = newGenes[5];
    return newGenes;
  }
  
  void saveImage(String name) {
    body.save(name);
  }
}