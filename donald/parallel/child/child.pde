import java.lang.*;
import java.util.*;
import java.io.*;
int TOTALPOPULATION = 207;

int COMPS = 9;
int GENECOUNT = 33;
int NUM = 1;

boolean wait = false;
boolean saveImages = true;

int POPULATION = 23;
float[] SCORES = new float[POPULATION];
int WIDTH = 200;
int HEIGHT = 200;
boolean START = false;
ArrayList<Canvas> allCanvases = new ArrayList<Canvas>();
PImage input;
static int PAINTING = 0;
static int GEN = 0;
float[][] genes = new float[POPULATION][GENECOUNT];

void setup() {
  size(1205, 803);
  background(50);
  rectMode(CENTER);
  input = loadImage("frog.jpg");
  image(input, 0, 0, 200, 200);
  for(int i = 0; i < POPULATION; i++) {
    allCanvases.add(new Canvas(100 + (i<5?201+201*i:(i<11?201*(i-5):(i<17?201*(i-11):201*(i-17)))), 
                               301 + (i<5?-201:(i<11?0:(i<17?201:402))), 200, color(255),
                               
                               random(-5, 5), random(-5, 5), random(-.01, .01), random(-.01, .01),
                               random(-.005, .005), random(-.005, .005), random(5, 50), 2.0,
                               
                               random(1, 2), random(1, 2), random(1, 2), //bp
                               
                               random(0, WIDTH), random(0, HEIGHT), random(-10, 10),
                               random(-10, 10), random(-.5, .5), random(-.5, .5),
                               random(.05), random(.05), random(.05), random(.05), random(.05), random(.05),
                               random(-5, 5), random(-5, 5), random(1, 10), random(1, 10),
                               random(50, 400),
                               random(1, 5), random(1, 5), random(1, 5), random(1, 20), random(1)));
  }
}

void draw() {
  for(Canvas c: allCanvases)
    c.display();
  //to keep track of generations
  //GEN = PAINTING / POPULATION;
  
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
    if(count == POPULATION && saveImages) {
      for(int i = 0; i < POPULATION; i++) {
        genes[i] = allCanvases.get(i).genes;
      }
      for(Canvas c: allCanvases) {
        //saves images so they can be compared to original image
        c.saveImage("\\\\gemini.cs.hamilton.edu\\summer18/data/" + Integer.toString(PAINTING + POPULATION*NUM + GEN*(TOTALPOPULATION-POPULATION)) + ".png");
        PAINTING++;
        saveImages = false;
        wait = true;
      }
      sendIt();
      GEN++;
    }
    if(wait && fileReady()) {wait = false; saveImages = true;}
    if(count == POPULATION && !wait) {
      try {
        Scanner s = new Scanner(new File("\\\\gemini.cs.hamilton.edu\\summer18/newCanvases" + Integer.toString(NUM) + ".txt"));
        for(int p = 0; p < POPULATION; p++) {
          for(int g = 0; g < GENECOUNT; g++) {
            String number = s.next();
            genes[p][g] = Float.valueOf(number);
          }
        }
        s.close();
        new File("\\\\gemini.cs.hamilton.edu\\summer18/scores" + Integer.toString(NUM) + ".txt").delete();
        new File("\\\\gemini.cs.hamilton.edu\\summer18/newCanvases" + Integer.toString(NUM) + ".txt").delete();
      }
      catch(Exception e) {
        
      }
      
      //loop for assigning new genes
      for(int i = 0; i < POPULATION; i++) {
        allCanvases.get(i).genes = genes[i];
        allCanvases.get(i).assignGenes();
        allCanvases.get(i).pressed = true;
        allCanvases.get(i).reset = true;
      }
    }
    
    //reset count each time
    count = 0;
  }
}


void sendIt() {
  try{
    Formatter newFile = new Formatter("\\\\gemini.cs.hamilton.edu\\summer18/scores" + 
      Integer.toString(NUM) + ".txt");
    for(int i = 0; i < POPULATION; i++) {
      for(int j = 0; j < GENECOUNT; j++) {
        newFile.format(Float.toString(genes[i][j]) + " ");
      }
    }
    newFile.close();
  }
  catch(Exception e){
    println(e);
  }
}

boolean allFilesGood() {
  for(int i = 0; i < COMPS; i++) {
    try {
      Scanner s = new Scanner(new File("\\\\gemini.cs.hamilton.edu\\summer18/scores" + 
        Integer.toString(i) + ".txt"));
      s.close();
    }
    catch(Exception e) {
      print(e);
      return false;
    }
  }
  return true;
}

boolean fileReady() {
  try {
    Scanner s = new Scanner(new File("\\\\gemini.cs.hamilton.edu\\summer18/newCanvases" + 
      Integer.toString(NUM) + ".txt"));
    s.close();
  }
  catch(Exception e) {
    //print(e);
    return false;
  }
  return true;
}