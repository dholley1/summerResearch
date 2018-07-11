int[] VARIANTS = {4, 5, 10, 15, 16};  //position of variant genes
int STROKES = 10;  //number of strokes until paintings stop
int EDGE = 0;  //current edge detection image being saved

class Canvas implements Runnable {
  /* A Canvas is a child window, independent of the rest. */
  
  public Thread t = new Thread(this);
  

  float xCenter, yCenter;  // center coordinates of child window
  int sideLength;          // side length of child window
  color fillColor;         // fill color of child window
  PGraphics body;          // the graphical body of the Canvas
  PGraphics edges;         // edge map for canvas

  //GENES
  float xVelocity;              // x, y velocity of brush
  float yVelocity;              
  float deltaXVelocity;         // dx, dy of velocity of brush
  float deltaYVelocity;
  float variationXVelocity;     // ddx, ddy of velocity of brush
  float variationYVelocity;
  float brushLength;            // brush length, in pixels
  float brushThickness;         // brush thickness, in pixels
  float brushPressure;          // brush pressure
  float deltaBrushPressure;     // change in brush pressure
  float variationBrushPressure; // rate of change in change in brush pressure
  float xPos;                   // x, y position on canvas
  float yPos;
  float deltaXPos;              // dx, dy of start of brush stroke on canvas
  float deltaYPos;
  float variationYPos;          // ddx, ddy of start of brush stroke on canvas
  float variationXPos;
  
  float offChance;              // chance that brush reverses or picks a new random point
    
  float changeAreaChance;       // chance that brush picks a new random starting point
  float changeVariantChance;    // chance that brush variant gets changed
  float reverseXChance;         // chance that brush reverses x, y direction
  float reverseYChance;
  float reverseVariantChance;   // chance that brush variant gets reversed
  
  float offXColor;              // offset of x, y color selection
  float offYColor;
  float xRangeColor;            // range of x, y where color is averaged to select brush color
  float yRangeColor;
  
  float colorDifferenceThresh;  // inactive
  
  float powerM;                 // power mod for edge detection map
  float discR;                  // disc radius for edge detection map
  float numC;                   // number of checks for edge detection map
  float foresight;              // number of pixels that brush looks ahead for edge
  float gas;                    // giving a shit if there is an edge
  
  float angleWeight;            // weighted change in direction when edge is detecteds
  
  float[] genes = new float[GENECOUNT];  // array for all genes
  
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
  
  float[] edgePoint = new float[2];
  
  
  Canvas(float x, float y, int s, color c,
         float xv, float yv, float dxv, float dyv, float vxv, float vyv,
         float bl, float bt, float bp, float dbp, float vbp, float xp,
         float yp, float dxp, float dyp, float vxp, float vyp, float off,
         float cac, float cvc, float rxc, float ryc, float rvc,
         float oxc, float oyc, float xrc, float yrc, float cdt,
         float pm, float dr, float nc, float f, float g, float aw) {
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
    powerM = pm;
    discR = dr;
    numC = nc;
    foresight = f;
    gas = g;
    angleWeight = aw;
    
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
    genes[28] = powerM;
    genes[29] = discR;
    genes[30] = numC;
    genes[31] = foresight;
    genes[32] = gas;
    genes[33] = angleWeight;
    
    body = createGraphics(sideLength, sideLength);
    for(int i = 0; i < 100; i ++)
      bristles.add(new bristle(this, body, i > 10? true:false));
      
    makeEdgeMap();
  }
  
  void makeEdgeMap() {
    powerMod = powerM;
    discRad = (int)discR;
    numChecks = (int)numC;
    edges = analyzeImage(input);
    edges.save("data/" + Integer.toString(EDGE) + "edges.png");
    EDGE++;
  }
  

  void run() {
    /* Draws the Canvas to the main window. */
    println("started");
    
    body.beginDraw();
      while(!done) {
        randVal = random(1);
        if(start || reset) {
          body.background(fillColor);
          //start = false;
        }
      update();
      }
    body.endDraw();
    println("ended");
  }
  
  void display() {
    image(body, xCenter - sideLength/2, yCenter - sideLength/2);
    println(millis());
    t = new Thread(this);
  }
  
    void update() {
    //set background and location
    if(strokes == STROKES) {
      done = true;
      move = false;
      offscreen = false;
      pressed = false;
      strokes = 0;
    }
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
      
      //in case the brush was picked up
      if(pressed) {
        body.stroke(c);
        lastXPos = xPos;
        lastYPos = yPos;
        //get new location color
        c = averageColor(xPos + offXColor, 
                         yPos + offYColor, 
                         xPos + offXColor + xRangeColor, 
                         yPos + offYColor + yRangeColor);
        c = color(red(c), green(c), blue(c), transparency);
        body.stroke(c);
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
          b.drag(dx, dy, xpos, ypos, brushPressure);
        }
      }
      xpos = xPos;
      ypos = yPos;
      //advaces the brush by dx and dy, or puts the brush at a new location
      advance();
    }

    //after painting is done and saved, reset to all white
    if(reset){
      reset = false;
      START = true;
    }
  }

  void advance() {
    //called each frame for brush dragging or when
    //it is moved
    if(move) {
      xPos = random(0, WIDTH);//lastXPos + deltaXPos;
      yPos = random(0, HEIGHT);//lastYPos + deltaYPos;
      if (xPos < 0 || xPos > WIDTH || yPos < 0 || yPos > HEIGHT) {
        xPos = random(WIDTH);
        yPos = random(HEIGHT);
          
      }
      if (changeAreaChance > randVal) {
        xPos = random(WIDTH);
        yPos = random(HEIGHT);
      }
      if (changeVariantChance > randVal) {
        changeVariant(int(randVal * 5));
      }
      if(reverseVariantChance > randVal) {
        reverseVariant(int(randVal * 5));
      }
        
      xVelocity = origXVelocity;
      yVelocity = origYVelocity;
      deltaXVelocity = origDeltaXVelocity;
      deltaYVelocity = origDeltaYVelocity;
        
      brushPressure = origBrushPressure;
      deltaBrushPressure = origDeltaBrushPressure;
      
      currentLength = 0;
      move = false;
      pressed = true;
      offscreen = false;
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
      
      if(detectEdge() && gas > randVal) {
        float speed = sqrt(pow(xVelocity, 2) + (pow(yVelocity, 2)));
        float eAngle = getEdgeAngle(edgePoint[0], edgePoint[1]);
        float average = getAverageBetweenAngles(eAngle);
        xVelocity = average < PI / 2 ? speed * cos(average) :
                    average < PI ? -speed * cos(PI-average) :
                    average < 3*PI/2 ? -speed * cos(average-PI) :
                                      speed * cos(2*PI-average);
        yVelocity = average < PI / 2 ? speed * sin(average) :
                    average < PI ? speed * sin(PI-average) :
                    average < 3*PI/2 ? -speed * sin(average-PI) :
                                      -speed * sin(2*PI-average);
        
      }
      xVelocity += deltaXVelocity;
      yVelocity += deltaYVelocity;
      deltaXVelocity += variationXVelocity;
      deltaYVelocity += variationYVelocity;
      brushPressure += deltaBrushPressure;
      deltaBrushPressure += variationBrushPressure;
      currentLength += sqrt(pow(xPos - xpos, 2) + pow(yPos - ypos, 2));
      
      if (offscreen) {
        move = true;
        currentLength = 0;
        strokes++;
      }
      else if (currentLength >= brushLength) {
        move = true;
        currentLength = 0;
        strokes++;
      }
      if (xPos < 0 || xPos > WIDTH || yPos < 0 || yPos > HEIGHT)
        offscreen = true;
      else
        offscreen = false;
    }
  }
  
  float[] crossover(Canvas partner) {
    //method for combining genes of two partners
    float[] newGenes = new float[GENECOUNT];
    for(int i = 0; i < GENECOUNT; i++) {
      if(random(1) < .01)
        newGenes[i] = mutate(i);
      else {
        float choice = random(1);
        if (choice < .5)
          newGenes[i] = genes[i];
        else
          newGenes[i] = partner.genes[i];
      }
      
    }
    return newGenes;
  }
  
  float mutate(int choice) {
    //method for mutation chance, will change
    //one gene at random
    float value;
    //int choice = int(random(GENECOUNT));
    if(choice < 2) value = random(1, 5)*random(1)>.5?-1:1;
    else if(choice < 4) value = random(-.01, .01);
    else if(choice < 6) value = random(-.01, .01);
    else if(choice == 6) value = random(5, 50);
    else if(choice == 7) value = 2.0;
    else if(choice < 11) value = random(1, 2);
    else if(choice == 11) value = random(0, WIDTH);
    else if(choice == 12) value = random(0, HEIGHT);
    else if(choice < 15) value = random(-10, 10);
    else if(choice < 17) value = random(-.5, .5);
    else if(choice < 23) value = random(.05);
    else if(choice < 25) value = random(-5, 5);
    else if(choice < 27) value = random(1, 10);
    else if(choice == 27) value = random(50, 400);
    else if (choice < 31) value = random(1, 5);
    else if (choice < 32) value = random(1, 20);
    else if (choice < 33) value = random(1);
    else value = random(-.5, .5);
    return value;
  }
  
  void assignGenes() {
    //assigns genes, called right after new generation is created
    xVelocity = origXVelocity = genes[0];
    yVelocity = origYVelocity = genes[1];
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
    powerM = genes[28];
    discR = genes[29];
    numC = genes[30];
    foresight = genes[31];
    gas = genes[32];
    angleWeight = genes[33];
    makeEdgeMap();
  }
  
  void changeVariant(int index) {
    //changes one variant at random
    if(index == 0)
      variationXVelocity = random(-.005, .005);
    else if(index == 1)
      variationYVelocity = random(-.005, .005);
    else if(index == 2)
      variationBrushPressure *= random(-.1, .1);
    else if(index == 3)
      variationYPos *= random(-1, 1);
    else
      variationXPos *= random(-1, 1);
  }
  
  void reverseVariant(int index) {
    //reverses one variant at random
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
  
  color averageColor(float startX, float startY, float endX, float endY) {
    //returns the average rbg value of an area
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
    //returns difference in color of 2 colors
    return int(abs(red(c1) - red(c2)) + abs(green(c1) - green(c2)) + abs(blue(c1) - blue(c2)));
  }
  
  float getEdgeAngle(float x, float y) {
    //returns the likely angle of an edge at point x, y
    float totalBrightness = 0;
    float best = 0;
    float brightest = 0;
    int checks = 50;
    int shift = 10;
    float theta = random(0, PI);
    for(int i = 0; i < checks; i++) {
      for(int j = -shift; j < shift; j++) {
        totalBrightness += brightness(
          edges.get((int)(x+j*cos(theta)), (int)(y+j*sin(theta))) 
        );
      }
      if(totalBrightness>=brightest) {
        best = theta;
        brightest = totalBrightness;
        
      }
      totalBrightness = 0;
      theta = (theta + PI / checks) % PI;
    }
    return best;
  }
  
  boolean detectEdge() {
    //detects edge ahead of brush direction
    float yDir = yVelocity / abs(yVelocity);
    float xDir = xVelocity / abs(xVelocity);
    for(int i = 0; i < foresight; i++) {
      if(brightness(edges.get((int)(xPos+xDir*i), (int)(yPos+yDir*i))) > 200) {
        edgePoint[0] = xPos+xDir*i;
        edgePoint[1] = yPos+yDir*i;
        return true;
      }
    }
    return false;
  }
  
  float getBrushAngle() {
    //retruns brush angle ranging from 0 to 2PI
    return yVelocity > 0 ? atan2(yVelocity, xVelocity)
                         : atan2(yVelocity, xVelocity) + 2*PI;
  }
  
  float getAverageBetweenAngles(float edAngle) {
    //returns the average angle between brush angle and edge
    float edAngle2 = edAngle + PI;
    float bAngle = getBrushAngle();
    float diff1 = abs(abs(bAngle - edAngle) - 2*PI) > abs(bAngle - edAngle) ?
      abs(bAngle - edAngle) :
      abs(abs(bAngle - edAngle) - 2*PI);
    float diff2 = abs(abs(bAngle - edAngle2) - 2*PI) > abs(bAngle - edAngle2) ?
      abs(bAngle - edAngle2) :
      abs(abs(bAngle - edAngle2) - 2*PI);
    float difference = diff1 > diff2 ? diff2 : diff1;
    float edge = diff1 > diff2 ? edAngle2 : edAngle;
    float average = (edge > 3*PI/2 && bAngle < PI/2) ||
                      (edge < PI/2 && bAngle > 3*PI/2) ?
                     abs((edge + bAngle) - (2*PI)) / 2 :
                                   (edge + bAngle) / 2;
    average += bAngle > edge ? !(edge<PI/2&&bAngle>3*PI/2||bAngle<PI&&edge>3*PI/2)? 
           angleWeight*difference :
          -angleWeight*difference : !(edge<PI/2&&bAngle>3*PI/2||bAngle<PI&&edge>3*PI/2)?
          -angleWeight*difference :
           angleWeight*difference;
          
    return average;
  } 
  
  void saveImage(String name) {
    body.save(name);
  }
}