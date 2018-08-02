import java.io.*;
import java.lang.*;
import java.util.*;
int GENECOUNT = 33;     //number of genes each canvas has

int POPULATION = 10;    //number of canvases

int WIDTH = 200;        //dimensions of screen
int HEIGHT = 200;

boolean START = false;  //boolean for starting next generation of drawings

ArrayList<Canvas> allCanvases = new ArrayList<Canvas>();
PImage input;
int PAINTING = 0;
int GEN = 0;
float[][] genes = new float[POPULATION][GENECOUNT];
float[] SCORES = new float[POPULATION];

void setup() {
  size(1005, 603);
  background(50);
  //target image
  input = loadImage("bb.jpg");
  input.resize(WIDTH, HEIGHT);
  image(input, 0, 0, WIDTH, HEIGHT);
  PGraphics standardEdge = analyzeImage(input);
  standardEdge.save("bbEdge.png");
  goodEdge = loadImage("bbEdge.png");
  //first generation
  for(int i = 0; i < POPULATION; i++) {
    allCanvases.add(new Canvas(100 + (i < 5 ? 201 * i : 201 * (i - 5)), 
                               301 + (i < 5 ? 0 : 201), 200, color(255),
                               
                               //random genes
                               random(1,5)*random(1)>.5?-1:1, //x, y velocities
                               random(1,5)*random(1)>.5?-1:1,
                               random(-.01, .01), random(-.01, .01), //dx, dy
                               random(-.001, .001), random(-.001, .001), //ddx, ddy
                               random(5, 50), 2.0, //bl, bs
                               random(1, 2), random(1, 2), random(1, 2), //bp
                               random(0, WIDTH), random(0, HEIGHT), //starting x, y
                               random(-10, 10), random(-10, 10),
                               random(-.5, .5), random(-.5, .5),
                               random(.05), random(.05), random(.05), random(.05), random(.05), random(.05), //change genes
                               random(-5, 5), random(-5, 5), random(1, 10), random(1, 10),
                               random(1, 5), random(1, 5), random(1, 5), 
                               random(1, 20), random(1), random(-.5, .5)));
  }
}

void display() {
  for(Canvas c: allCanvases) {
      c.display();
  }
}

void draw() {
  display();
  //to keep track of generations
  GEN = PAINTING / POPULATION;
  
  //in case of new paintings
  if(START) {
    for (Canvas c: allCanvases)
      c.restart = true;
    START = false;
  }
    //while painting are being done
  else {
    //counter for if all paintings are finished
    int count = 0;
    for(Canvas c: allCanvases) {
      if(c.done)
        count+=1;
      else
        break;
    }
    
    //if all painting are finished
    if(count == POPULATION) {
      for(Canvas c: allCanvases) {
        //saves images so they can be compared to original image
        c.saveImage("data/"+Integer.toString(PAINTING)+".png");
        PAINTING++;
      }
      runTest();
      //loop for creating offspring
      for(int i = 0; i < POPULATION; i++) {
        allCanvases.get(i).reset = true;
        int[] sel = lexicase();
        Canvas parent = allCanvases.get(sel[0]);
        Canvas partner = allCanvases.get(sel[1]);
        genes[i] = parent.crossover(partner);
      }
      sblist.clear();
      
      //loop for assigning new genes
      for(int i = 0; i < POPULATION; i++) {
        allCanvases.get(i).genes = genes[i];
        allCanvases.get(i).assignGenes();
        allCanvases.get(i).pressed = true;
      }
    }
    //reset count each time
    count = 0;}
  }