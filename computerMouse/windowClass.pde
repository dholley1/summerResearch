//import java.io.BufferedWriter;
//import java.io.FileWriter;
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.InputStreamReader;

public class window extends PApplet {
  //main canvas
  PApplet picture;
  //0:mouseX, 1:mouseY, 2:dx, 3:dy, 4:brushLength, 5:brushTarget 6:brushThickness
  public float[] vals = {0, 0, 0, 0, 0, 0, 0};
  //x and y value of window position
  public int x;
  public int y;
  
  boolean saved = false;
  
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
  float brushVelocity = 0;
  float brushRange;
  float brushThickness;

  float xpos = 0;
  float ypos = 0;
  
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
  
  public void settings() {
    size(300, 300);
  }
  
  public void draw() {
    if(start) {background(255); start = false;}
    if(!done) {
      surface.setLocation(x, y);
      transparency *= .95;
      stroke(c);
      advance(vals, 300, 300);
      if(brushVelocity >= 9)
        brushRange *= .9;
      else {
        brushRange *= 1.1;
        if(brushRange > 20)
        brushRange = 20;
      }
      if(pressed) {
        c = picture.get((int)vals[0], (int)vals[1]);
        transparency = 100;
        c = color(red(c), green(c), blue(c), transparency);
        brushRange = brushThickness;
        for(int i = 0; i < 200; i++) {
          float rand = random(0, 2*PI);
          xpos = cos(rand) * brushRange + vals[0];
          ypos = sin(rand) * brushRange + vals[1];
          point(xpos, ypos);
          xbristles[i] = xpos;
          ybristles[i] = ypos;
          pressed = false;
        }
      }
      else {
        c = color(red(c), green(c), blue(c), transparency);
        for(int i = 0; i < 200; i++) {
          float rand = random(0, 2*PI);
          xpos = cos(rand) * brushRange + vals[0];
          ypos = sin(rand) * brushRange + vals[1];
          line(xbristles[i], ybristles[i], xpos, ypos);
          xbristles[i] = xpos;
          ybristles[i] = ypos;
        }
      }
    }
    /*else if (!saved){
      save("../SR/summerResearch/computerMouse/data/"+Integer.toString(PAINTING)+".jpg");
      PAINTING++;
      saved = true;
    }*/
    if(reset){      
      //save("../SR/summerResearch/computerMouse/data/example.jpg");
      background(255);
      xpos = 0;
      ypos = 0;
      reset = false;
      START = true;
    }
    if(restart) {
      restart = false;
      done = false;
      saved = false;
    }
  }
  
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
  
  float[] crossover(window partner) {
    float[] newGenes = new float[7];
    for(int i = 0; i < 7; i++) {
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