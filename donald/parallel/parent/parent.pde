import java.lang.*;
import java.util.*;
import java.io.*;
int TOTALPOPULATION = 207;
int COMPS = 9;

int GENECOUNT = 33;
int NUM = 0;

boolean saveImages = true;
boolean wait = false;


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

float[][] ALLGENES = new float[TOTALPOPULATION][GENECOUNT];
float[] ALLSCORES = new float[TOTALPOPULATION];
float[][] ALLNEWGENES = new float[TOTALPOPULATION][GENECOUNT];


void setup() {
  size(1205, 803);
  background(50);
  //rectMode(CENTER);
  input = loadImage("frog.jpg");
  input.resize(200, 200);
  image(input, 0, 0, 200, 200);
  for(int i = 0; i < POPULATION; i++) {
    allCanvases.add(new Canvas(100+(i<5?201+201*i:(i<11?201*(i-5):(i<17?201*(i-11):201*(i-17)))), 
                               301+(i<5?-201:(i<11?0:(i<17?201:402))), 200, color(255),
                               
                               random(-5, 5), random(-5, 5), random(-.01, .01), random(-.01, .01),
                               random(-.005, .005), random(-.005, .005), random(5, 100), 2.0,
                               
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
        c.saveImage("\\\\gemini.cs.hamilton.edu\\summer18/data/"+Integer.toString(PAINTING + POPULATION*NUM + GEN*(TOTALPOPULATION-POPULATION))+".png");
        PAINTING++;
        saveImages = false;
        wait = true; 
      }
    }
    if(wait &&  allFilesGood()) {wait = false; saveImages = true;}
    if(count == POPULATION && !wait) {
      getData();
      createGraph();
      //loop for creating offspring
      //CREATES ALL NEW CHILDREN FOR ALL COMPUTERS AND SENDS NEW INFORMATION
      for(int i = 0; i < TOTALPOPULATION; i++) {
        int[] sel = selection();
        float[] parent = ALLGENES[sel[0]];
        float[] partner = ALLGENES[sel[1]];
        crossoverAll(parent, partner, i);
      }
      writeData();
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
        println(e);
      }
      
      //loop for assigning new genes
      for(int i = 0; i < POPULATION; i++) {
        allCanvases.get(i).genes = genes[i];
        allCanvases.get(i).assignGenes();
        allCanvases.get(i).pressed = true;
        allCanvases.get(i).reset = true;
      }
      GEN++; 
    }
    //reset count each time
    count = 0;
  }
}

void crossoverAll(float[] parent, float[] partner, int child) {
  for(int i = 0; i < GENECOUNT; i++) {
    float choice = random(1);
    if (choice < .5)
      ALLNEWGENES[child][i] = parent[i];
    else
      ALLNEWGENES[child][i] = partner[i];
  }
}

void getData() {
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
    //println(e);
  }  
  for(int i =0; i < COMPS; i++) {
    try {
      Scanner s = new Scanner(new File("\\\\gemini.cs.hamilton.edu\\summer18/scores" + Integer.toString(i) + ".txt")); 
      int g = 0;
      int p = 0;
      float gene;
      String number = "";
      println(number);
      //String c = " ";
      while(s.hasNext()) {
        number = s.next();
        gene = Float.valueOf(number);
        ALLGENES[p+POPULATION*i][g] = gene;
        g++;
        if(g == GENECOUNT) {
          g = 0;
          p++;
        }
      }
      s.close();
    }
    catch(Exception e) {
      //println(e);
    }
  }
}

void writeData() {
  for(int i = 0; i < COMPS; i++) {
    try {
      Formatter f = new Formatter("\\\\gemini.cs.hamilton.edu\\summer18/newCanvases" + Integer.toString(i) + ".txt");
      for(int j = 0; j < POPULATION; j++) {
        for(int k = 0; k < GENECOUNT; k++) {
          f.format(Float.toString(ALLNEWGENES[j + POPULATION * i][k]) + " ");
        }
      }
      f.close();
      ALLGENES = ALLNEWGENES;
    }
    catch(Exception e) {
      //println(e);
    }
  }
  try {    
    FileWriter fw = new FileWriter("\\\\gemini.cs.hamilton.edu\\summer18/ALLSCORES.txt", true);
    BufferedWriter bw = new BufferedWriter(fw);
    PrintWriter out = new PrintWriter(bw);
    out.println("GENERATION " + Integer.toString(GEN));
    
    
    
    float[] orderedScores = new float[TOTALPOPULATION];
    int[] orderedNumbers = new int[TOTALPOPULATION];
    for(int i = 0; i < TOTALPOPULATION; i++) {
      orderedScores[i] = -1;
      orderedNumbers[i] = -1;
    }
    
    for(int i = 0; i < TOTALPOPULATION; i++) {
      float currentScore = ALLSCORES[i];
      int currentNumber = i;
      for(int j = 0; j < TOTALPOPULATION; j++) {
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
    
    
    
    for(int i = 0; i < TOTALPOPULATION; i++) {
      out.println(Integer.toString(orderedNumbers[i] + GEN*TOTALPOPULATION) + ".png score" + " : " + Float.toString(orderedScores[i]));
    }
    out.println();
    out.close();
  }
  catch(Exception e) {
    
  }  
}

boolean allFilesGood() {
  for(int i = 1; i < COMPS; i++) {
    try {
      Scanner s = new Scanner(
        new File("\\\\gemini.cs.hamilton.edu\\summer18/scores" + Integer.toString(i) + ".txt"));
      s.close();  
    }
    catch(Exception e) {
      //println(e);
      return false;
    }
  }
  return true;
}