//Target Image
PImage input;

//Population
int POPULATION = 10;
window[] pApps = new window[POPULATION];

//genes holds the information for the next generation
//before they are assigned to the windows
float[][] genes = new float[POPULATION][7];

//START is true when the windows are ready to start
//painting
static boolean START = false;

//PAINTING keeps track of the number of painting that have been
//done and GEN keeps track of the number of generations there have been
static int PAINTING = 0;
static int GEN = 0;

void setup(){
  //target Image
  input = loadImage("flower.jpg");
  image(input, 0, 0, 300, 300);
  
  //info for PApplets
  String[] args = {"window"};
  
  //loop for creating windows, start with random genes with a limit
  for(int i = 0; i < POPULATION; i++) {
    float deltaX = random(10, 100);
    float[] vals = {0, 0, random(.1, 20), random(.1, 20), deltaX, deltaX, random(5, 20)};
    genes[i] = vals;
    window win = new window(i < 5 ? 300 * i : 300 * i - 1500,
                            i < 5 ? 0 : 300,
                            vals, this);
    pApps[i] = win;
    PApplet.runSketch(args, win);
  }
}

void settings() {
  size(300, 300);
}

void draw() {
  //to keep track of generations
  GEN = PAINTING / POPULATION;
  
  //in case of new paintings
  if(START) {
  for(int i = 0; i < POPULATION; i++) 
    pApps[i].restart = true; 
  START = false;
  }
  
  //while painting are being done
  else {
    //counter for if all paintings are finished
    int count = 0;
    for(int i = 0; i < POPULATION; i++) {
      if(pApps[i].done)
        count+=1;
      else
        break;
    }
    
    //if all painting are finished
    if(count == POPULATION) {
      for(int i = 0; i < POPULATION; i++) {
        //saves images so they can be compared to original image
        pApps[i].save("../SR/summerResearch/computerMouse/data/"+Integer.toString(PAINTING)+".jpg");
        PAINTING++;
      }
      
      //loop for creating offspring
      for(int i = 0; i < POPULATION; i++) {
        pApps[i].reset = true;
        int[] sel = selection();
        window parent = pApps[sel[0]];
        window partner = pApps[sel[1]];
        genes[i] = parent.crossover(partner);
      }
      
      //loop for assigning new genes
      for(int i = 0; i < POPULATION; i++) {
        pApps[i].vals = genes[i];
        pApps[i].pressed = true;
      }
    }
    
    //reset count each time
    count = 0;
  }
}