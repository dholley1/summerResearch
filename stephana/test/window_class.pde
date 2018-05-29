//class for seperate windows
public class window extends PApplet {
  
  //main canvas
  PApplet picture;
  
  //0:mouseX, 1:mouseY, 2:dx, 3:dy, 4:brushLength, 
  // 5:brushTarget 6:brushThickness
  public float[] vals = {0, 0, 0, 0, 0, 0, 0};
  
  //x and y value of window position
  public int x;
  public int y;
  
  //booleans for when windows are created, when paintings are done,
  //and when new paintings can be started
  boolean start = true;
  boolean reset = false;
  boolean restart = false;
  
  //bools for picking up and putting down brush
  boolean pressed = false;
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
  
  //constructor
  window(int xval, int yval, float[] v, PApplet p) {
    x = xval;
    y = yval;
    vals = v;
    brushRange = vals[6];
    brushThickness = vals[6];
    picture = p;
    c = picture.get((int)vals[0], (int)vals[1]);
  }
  
  void settings() {
    size(300, 300);
  }
  
  void draw() {
    //set background and location
    if(start) {
      background(255);
      surface.setLocation(x, y);
      start = false;
    }
    
    //loop for painting
    if(!done) {
      
      //paint gets lighter during one stroke
      transparency *= .95;
      stroke(c);
      
      //advaces the brush by dx and dy, or puts the brush at a new location
      advance(vals, 300, 300);
      
      //increase or decrease radius of brush depending on speed
      if(brushVelocity >= 9)
        brushRange *= .9;
      else {
        brushRange *= 1.1;
        if(brushRange > 20)
        brushRange = 20;
      }
      
      //in case the brush was picked up
      if(pressed) {
        
        //get new location color
        c = picture.get((int)vals[0], (int)vals[1]);
        
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
          point(xpos, ypos);
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
          line(xbristles[i], ybristles[i], xpos, ypos);
          xbristles[i] = xpos;
          ybristles[i] = ypos;
        }
      }
    }
    
    //after painting is done and saved, reset to all white
    if(reset){
      background(255);
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
  public void advance(float[] vals, int sizeX, int sizeY) {
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
  float[] crossover(window partner) {
    float[] newGenes = new float[7];
    for(int i = 0; i < 7; i++) {
      
      //random parent for each gene
      float choice = random(1);
      if (choice < .5)
        newGenes[i] = this.vals[i];
      else
        newGenes[i] = partner.vals[i];
    }
    newGenes[0] = 0;
    newGenes[1] = 0;
    newGenes[4] = newGenes[5];
    return newGenes;
  }
}