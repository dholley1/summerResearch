
int[] VARIANTS = {4, 5, 10, 15, 16};
class Canvas {
  /* A Canvas is a child window, independent of the rest. */
  
  
  
  
  
  
  
  float xCenter, yCenter;  // center coordinates of child window
  int sideLength;          // side length of child window
  color fillColor;         // fill color of child window
  
  PGraphics body;          // the graphical body of the Canvas
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
  
  
  float offChance;
    
    
  //XTRA
  float changeAreaChance;
  //float changeAreaRange;
  float changeVariantChance;
  //float changeVariantRange;
  //float resetCharacteristicChance;
  float reverseXChance;
  float reverseYChance;
  //float reverseDeltaPressureChance;
  float reverseVariantChance;
  
  float offXColor;
  float offYColor;
  float xRangeColor;
  float yRangeColor;
  
  
  float colorDifferenceThresh;
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
  
  float[] genes = new float[GENECOUNT];
  
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
  color targetc;
  
  color c;
  float transparency = 20;
  
  
  int strokes = 0;
  
  
  
  
  
  Canvas(float x, float y, int s, color c,
         float xv, float yv, float dxv, float dyv, float vxv, float vyv,
         float bl, float bt, float bp, float dbp, float vbp, float xp,
         float yp, float dxp, float dyp, float vxp, float vyp, float off,
         float cac, float cvc, float rxc, float ryc, float rvc,
         float oxc, float oyc, float xrc, float yrc, float cdt) {
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
    offChance = off;
    changeAreaChance = cac;
    changeVariantChance = cvc;
    reverseXChance = rxc;
    reverseYChance = ryc;
    reverseVariantChance = rvc;
    offXColor = oxc;
    offYColor = oyc;
    xRangeColor = xrc;
    yRangeColor = yrc;
    colorDifferenceThresh = cdt;
    
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
    genes[17] = offChance;
    genes[18] = changeAreaChance;
    genes[19] = changeVariantChance;
    genes[20] = reverseXChance;
    genes[21] = reverseYChance;
    genes[22] = reverseVariantChance;
    genes[23] = offXColor;
    genes[24] = offYColor;
    genes[25] = xRangeColor;
    genes[26] = yRangeColor;
    genes[27] = colorDifferenceThresh;
    
    body = createGraphics(sideLength, sideLength);
    for(int i = 0; i < 100; i ++)
      bristles.add(new bristle(body));
  }
  
  
  
  
  
  

  void display() {
    /* Draws the Canvas to the main window. */
    
    body.beginDraw();
      // Not doing anything interesting graphically yet:
      randVal = random(1);
      if(start || reset) {
        body.background(fillColor);
        //start = false;
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
      //transparency *= .95;
      if(start) {
        //c = get((int)xPos, (int)yPos);
        c = averageColor(xPos + (int)offXColor, 
                         yPos + (int)offYColor, 
                         xPos + (int)offXColor + (int)xRangeColor, 
                         yPos + (int)offYColor + (int)yRangeColor);
        c = color(red(c), green(c), blue(c), transparency);
        start = false;
      }
      body.stroke(c);

      //in case the brush was picked up
      if(pressed) {
        strokes++;
        lastXPos = xPos;
        lastYPos = yPos;
        
        //get new location color
        //c = picture.get((int)vals[0], (int)vals[1]);
        
        //c = get((int)xPos, (int)yPos);
        c = averageColor(xPos + offXColor, 
                         yPos + offYColor, 
                         xPos + offXColor + xRangeColor, 
                         yPos + offYColor + yRangeColor);
        
        //reset transparency
        //transparency = 100;
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
        
        targetc = get((int)xPos, (int)yPos);
        if (colorDifference(c, targetc) > colorDifferenceThresh) {xVelocity *= -1; yVelocity *= -1;}
        
        
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
    if(strokes == 250) {
      done = true;
      strokes = 0;
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
        if(offChance > randVal) {
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
      if (changeAreaChance > randVal) {
        xPos = random(WIDTH);
        yPos = random(HEIGHT);
      }
      //if (changeAreaRange > randVal) {
      //}
      if (changeVariantChance > randVal) {
        //genes[VARIANTS[int(randVal * 5)]] = random(-.5, .5);
        changeVariant(int(randVal * 5));
      }
      //if(changeVariantRange > randVal) {
      //  
      //}
      //if(resetCharacteristicChance > randVal) {
      //  
      //}
      //if(reverseDeltaPressureChance > randVal) {
      //  
      //}
      if(reverseVariantChance > randVal) {
        //genes[VARIANTS[int(randVal * 5)]] *= -1;
        reverseVariant(int(randVal * 5));
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
      if(reverseXChance > randVal) {
        xVelocity *= -1;
      }
      if(reverseYChance > randVal) {
        yVelocity *= -1;
      }
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
        currentLength = 0;
      }
      if (xPos < 0 || xPos > WIDTH || yPos < 0 || yPos > HEIGHT)
        offscreen = true;
      else
        offscreen = false;
    }
  }
  
  float[] crossover(Canvas partner) {
    float[] newGenes = new float[GENECOUNT];
    for(int i = 0; i < GENECOUNT; i++) {
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
    offChance = genes[17];
    changeAreaChance = genes[18];
    changeVariantChance = genes[19];
    reverseXChance = genes[20];
    reverseYChance = genes[21];
    reverseVariantChance = genes[22];
    offXColor = genes[23];
    offYColor = genes[24];
    xRangeColor = genes[25];
    yRangeColor = genes[26];
    colorDifferenceThresh = genes[27];
  }
  
  void changeVariant(int index) {
    if(index == 0)
      variationXVelocity *= -1;
    else if(index == 1)
      variationYVelocity *= -1;
    else if(index == 2)
      variationBrushPressure *= -1;
    else if(index == 3)
      variationYPos *= -1;
    else
      variationXPos *= -1;
  }
  
  void reverseVariant(int index) {
    float value = random(-1, 1);
    if(index == 0)
      variationXVelocity = value;
    else if(index == 1)
      variationYVelocity = value;
    else if(index == 2)
      variationBrushPressure = value;
    else if(index == 3)
      variationYPos = value;
    else
      variationXPos = value;
  }
  
  color averageColor(float startX, float startY, float endX, float endY) {
    int totalRed = 0;
    int totalGreen = 0;
    int totalBlue = 0;
    for(int i = 0; i < endX - startX; i++) {
      for(int j = 0; j < endY - startY; j++) {
        totalRed += red(get(int(i + startX), j + int(startY)));
        totalGreen += green(get(int(i + startX), int(j + startY)));
        totalBlue += blue(get(int(i + startX), int(j + startY)));
      }
    }
    int total = int(xRangeColor) * int(yRangeColor);
    return color(totalRed / total, totalGreen / total, totalBlue / total);
  }
  
  int colorDifference(color c1, color c2) {
    return int(abs(red(c1) - red(c2)) + abs(green(c1) - green(c2)) + abs(blue(c1) - blue(c2)));
  }
  
  void saveImage(String name) {
    body.save(name);
  }
}