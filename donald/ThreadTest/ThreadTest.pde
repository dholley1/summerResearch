import java.io.*;
import java.lang.*;
import java.util.*;
int GENECOUNT = 34;  //number of genes for each canvas

boolean startThreads = true;


int POPULATION = 10;
float[] SCORES = new float[POPULATION];
int WIDTH = 200;
int HEIGHT = 200;
boolean START = false;
ArrayList<Canvas> allCanvases = new ArrayList<Canvas>();
PImage input;
static int PAINTING = 0;
static int GEN = 0;
float[][] genes = new float[POPULATION][GENECOUNT];

int count = 0;

void setup() {
  size(1005, 603);
  background(50);
  rectMode(CENTER);
  input = loadImage("frog.jpg");
  input.resize(200, 200);
  PGraphics standardEdge = analyzeImage(input);
  standardEdge.save("bbEdge.png");
  goodEdge = loadImage("bbEdge.png");
  image(input, 0, 0, 200, 200);
  for(int i = 0; i < POPULATION; i++) {
    allCanvases.add(new Canvas(100 + (i < 5 ? 201 * i : 201 * (i - 5)), 
                               301 + (i < 5 ? 0 : 201), 200, color(255),
                               
                               random(1,5)*random(1)>.5?-1:1,
                               random(1,5)*random(1)>.5?-1:1,
                               random(-.01, .01), random(-.01, .01),
                               random(-.01, .01), random(-.01, .01), 
                               random(5, 50), 2.0, //bl, bs
                               random(1, 2), random(1, 2), random(1, 2), //bp
                               random(0, WIDTH), random(0, HEIGHT), //starting x, y
                               random(-10, 10), random(-10, 10),
                               random(-.5, .5), random(-.5, .5),
                               random(.05), random(.05), random(.05), random(.05), random(.05), random(.05), //change genes
                               random(-5, 5), random(-5, 5), random(1, 10), random(1, 10),
                               random(50, 400),
                               random(1, 5), random(1, 5), random(1, 5), 
                               random(1, 20), random(1), random(-.5, .5)));
  }
}

void draw() {
  if (startThreads) {
    for(Canvas c: allCanvases) {
      c.t.start();
    }
    startThreads = false;
  }
  for(Canvas c: allCanvases) {
    if (c.done) {
      count++;
      c.display();
      c.done = false;
    }
  }
  
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
      count = 0;
      startThreads = true;
      writeData();
    }
  }
}


void writeData() {
  try {    
    FileWriter fw = new FileWriter("SR/summerResearch/donald/ThreadTest/ALLSCORES.txt", true);
    BufferedWriter bw = new BufferedWriter(fw);
    PrintWriter out = new PrintWriter(bw);
    out.println("GENERATION " + Integer.toString(GEN));
    
    
    float[] orderedScores = new float[POPULATION];
    int[] orderedNumbers = new int[POPULATION];
    for(int i = 0; i < POPULATION; i++) {
      orderedScores[i] = -1;
      orderedNumbers[i] = -1;
    }
    
    for(int i = 0; i < POPULATION; i++) {
      float currentScore = SCORES[i];
      int currentNumber = i;
      for(int j = 0; j < POPULATION; j++) {
        if (orderedScores[j] < currentScore) {
          float switchScore = orderedScores[j];
          int switchNumber = orderedNumbers[j];
          orderedScores[j] = currentScore;
          orderedNumbers[j] = currentNumber;
          currentScore = switchScore;
          currentNumber = switchNumber;
        }
      }
    }
    
    for(int i = 0; i < POPULATION; i++) {
      out.println(Integer.toString(orderedNumbers[i] + GEN*POPULATION) + ".png score" + " : " + Float.toString(orderedScores[i]));
    }
    out.println();
    out.close();
  }
  catch(Exception e) {
    
  }
}