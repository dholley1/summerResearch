class Canvas {
  /* A Canvas is a child window, independent of the rest. */
  
  float xCenter, yCenter;  // center coordinates of child window
  int sideLength;          // side length of child window
  color fillColor;         // fill color of child window
  
  PGraphics body;          // the graphical body of the Canvas
  
  //0:mouseX, 1:mouseY, 2:dx, 3:dy, 4:brushLength, 
  // 5:brushTarget 6:brushThickness 7:startingSpeed 
  //public float[] vals = {0, 0, 0, 0, 0, 0, 0, 0};
  ////////////////
  //GENES
  float xVelocity;
  float yVelocity;
  float deltaXVelocity;
  float deltaYVelocity;
  float variationXVelocity;
  float variationYVelocity;
  float brushLength;
  float brushThickness;
  float brushPressure;
  float deltaBrushPressure;
  float variationBrushPressure;
  float xPos;
  float yPos;
  float deltaXPos;
  float deltaYPos;
  float variationYPos;
  float variationXPos;
  
  //XTRA
  float changeAreaChance;
  float changeAreaRange;
  float changeVariantChance;
  float changeVariantRange;
  float resetCharacteristicChance;
  float reverseXChance;
  float reverseYChance;
  float reverseDeltaPressureChance;
  float reverseVariantChance;
  
  float offChance;
  ////////////////
  //GENES AS RANGES
  //float[] xVelocityRange;
  //float[] yVelocityRange;
  //float[] brushLengthRange;
  //float[] brushThicknessRange;
  //float[] brushPressureRange;
  //float[] deltaXPosRange;
  //float[] deltaYPosRange;
  ////////////////
  
  float[] genes = new float[17];
  
  //STORE VALUES
  float origXVelocity;
  float origYVelocity;
  float origDeltaYVelocity;
  float origDeltaXVelocity;
  float origXPos;
  float origYPos;
  float lastXPos;
  float lastYPos;
  float origDeltaXPos;
  float origDeltaYPos;
  float origBrushPressure;
  float origDeltaBrushPressure;
  float origBrushThickness;
  float currentLength;
  
  
  //booleans for when windows are created, when paintings are done,
  //and when new paintings can be started
  boolean start = true;
  boolean reset = false;
  boolean restart = false;
  
  
  float randVal;
  
  
  boolean offscreen = false;
  //bools for picking up and putting down brush
  boolean pressed = true;
  boolean move = false;
  public boolean done = false;
  
  //indivitual bristle points
  //float[] xbristles = new float[400];
  //float[] ybristles = new float[400];
  //bristles for brush
  ArrayList<bristle> bristles = new ArrayList<bristle>();
  
  //brush velocity and thickness variables
  float brushVelocity = 0;
  float brushRange;
  //float brushThickness;

  //x and y position of the brush at its last position
  float xpos = 0;
  float ypos = 0;
  
  //color values for the paint
  color c;
  float transparency = 100;
  
  Canvas(float x, float y, int s, color c,
         float xv, float yv, float dxv, float dyv, float vxv, float vyv,
         float bl, float bt, float bp, float dbp, float vbp, float xp,
         float yp, float dxp, float dyp, float vxp, float vyp) {
    xCenter = x;
    yCenter = y;
    sideLength = s;
    fillColor = c;
    
    xVelocity = origXVelocity = xv;
    yVelocity = origYVelocity = yv;
    deltaXVelocity = origDeltaXVelocity = dxv;
    deltaYVelocity = origDeltaYVelocity = dyv;
    variationXVelocity = vxv;
    variationYVelocity = vyv;
    brushLength = bl;
    brushThickness = origBrushThickness = bt;
    brushPressure = origBrushPressure = bp;
    deltaBrushPressure = origDeltaBrushPressure = dbp;
    variationBrushPressure = vbp;
    xPos = origXPos = xp;
    yPos = origYPos = yp;
    deltaXPos = origDeltaXPos = dxp;
    deltaYPos = origDeltaYPos = dyp;
    variationXPos = vxp;
    variationYPos = vyp;
    
    genes[0] = xVelocity;
    genes[1] = yVelocity;
    genes[2] = deltaXVelocity;
    genes[3] = deltaYVelocity;
    genes[4] = variationXVelocity;
    genes[5] = variationYVelocity; 
    genes[6] = brushLength;
    genes[7] = brushThickness;
    genes[8] = brushPressure;
    genes[9] = deltaBrushPressure;
    genes[10] = variationBrushPressure;
    genes[11] = xPos;
    genes[12] = yPos;
    genes[13] = deltaXPos;
    genes[14] = deltaYPos;
    genes[15] = variationYPos;
    genes[16] = variationXPos;
    
    body = createGraphics(sideLength, sideLength);
    for(int i = 0; i < 400; i ++)
      bristles.add(new bristle(body));
  }

  void display() {
    /* Draws the Canvas to the main window. */
    
    body.beginDraw();
      // Not doing anything interesting graphically yet:
      randVal = random(1);
      if(start || reset) {
        body.background(fillColor);
        start = false;
      }
      update();
    body.endDraw();
    
    // Add the Canvas to the window; the math is for centering correctly,
    // as an image uses the upper left corner as the origin:
    //if(done)
    image(body, xCenter - sideLength/2, yCenter - sideLength/2);
    
  }
  
  
    void update() {
    //set background and location
    
    //loop for painting
    if(!done) {
      
      //paint gets lighter during one stroke
      transparency *= .95;
      body.stroke(c);
      
      //increase or decrease radius of brush depending on speed
      //if(brushVelocity >= 5)
       // brushRange *= .9;
      //else {
       // brushRange *= 1.1;
        //if(brushRange > 20)
         // brushRange = 20;
      //}
      
      //in case the brush was picked up
      if(pressed) {
        
        lastXPos = xPos;
        lastYPos = yPos;
        
        //get new location color
        //c = picture.get((int)vals[0], (int)vals[1]);
        c = get((int)xPos, (int)yPos);
        
        //reset transparency
        transparency = 100;
        c = color(red(c), green(c), blue(c), transparency);
        
        //reset brush thickness
        brushRange = brushThickness;
        
        //pick random points for each bristle
        for(bristle b: bristles) {
          float angle = random(0, 2*PI);
          b.press(xPos + cos(angle) * random(0, brushRange),
                  yPos + sin(angle) * random(0, brushRange));
          
          pressed = false;
        }
      }
      
      //if brush is dragging
      else {
        //update transparency
        c = color(red(c), green(c), blue(c), transparency);
        
        //drag each bristle to new random location
        float dx = xPos - xpos;
        float dy = yPos - ypos;
        for(bristle b: bristles) {
          b.drag(dx, dy, xpos, ypos);
        }
      }
      xpos = xPos;
      ypos = yPos;
      //advaces the brush by dx and dy, or puts the brush at a new location
      advance();
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

  void advance() {

    if(move) {
      
      if (offscreen) {
        if(offChance < randVal) {
          xPos = random(WIDTH);
          yPos = random(HEIGHT);
        }
        else {
          deltaXPos *= -1;
          deltaYPos *= -1;
        }
        offscreen = false;
      }
      else {
        xPos = lastXPos;
        yPos = lastYPos;
   
        xPos += deltaXPos;
        yPos += deltaYPos;
      }
      deltaXPos += variationXPos;
      deltaYPos += variationYPos;
        
      xVelocity = origXVelocity;
      yVelocity = origYVelocity;
      deltaXVelocity = origDeltaXVelocity;
      deltaYVelocity = origDeltaYVelocity;
        
      brushPressure = origBrushPressure;
      deltaBrushPressure = origDeltaBrushPressure;
      
      currentLength = 0;
      move = false;
      pressed = true;
    }
    else {
      xPos += xVelocity;
      yPos += yVelocity;
      xVelocity += deltaXVelocity;
      yVelocity += deltaYVelocity;
      deltaXVelocity += variationXVelocity;
      deltaYVelocity += variationYVelocity;
      brushPressure += deltaBrushPressure;
      deltaBrushPressure += variationBrushPressure;
      currentLength += sqrt(pow(xPos - xpos, 2) + pow(yPos - ypos, 2));
      
      if (currentLength >= brushLength) {
        move = true;
      }
      if (xPos < 0 || xPos > WIDTH || yPos < 0 || yPos > HEIGHT)
        offscreen = true;
      else
        offscreen = false;
    }
  }
  
  float[] crossover(Canvas partner) {
    float[] newGenes = new float[17];
    for(int i = 0; i < 17; i++) {
      float choice = random(1);
      if (choice < .5)
        newGenes[i] = genes[i];
      else
        newGenes[i] = partner.genes[i];
    }
    return newGenes;
  }
  
  void assignGenes() {
    xVelocity = genes[0];
    yVelocity = genes[1];
    deltaXVelocity = genes[2];
    deltaYVelocity = genes[3];
    variationXVelocity = genes[4];
    variationYVelocity = genes[5];
    brushLength = genes[6];
    brushThickness = genes[7];
    brushPressure = genes[8];
    deltaBrushPressure = genes[9];
    variationBrushPressure = genes[10];
    xPos = genes[11];
    yPos = genes[12];
    deltaXPos = genes[13];
    deltaYPos = genes[14];
    variationYPos = genes[15];
    variationXPos = genes[16];
  }
  
  void saveImage(String name) {
    body.save(name);
  }
}