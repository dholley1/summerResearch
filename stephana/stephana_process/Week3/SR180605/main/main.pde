int POPULATION = 10;
int WIDTH = 200;
int HEIGHT = 200;
boolean START = false;
ArrayList<Canvas> allCanvases = new ArrayList<Canvas>();
PImage input;
static int PAINTING = 0;
static int GEN = 0;
float[][] genes = new float[POPULATION][];

void setup() {
  size(1005, 603);
  background(50);
  rectMode(CENTER);
  input = loadImage("IMG_1166.jpg");
  image(input, 0, 0, 200, 200);
  for(int i = 0; i < POPULATION; i++) {
    //float deltaX = 10;//random(10, 40);
    //float[] vs = {0, 0, 20/*random(5, 20)*/, 20/*random(5, 20)*/, deltaX, deltaX, 5/*random(5, 40)*/};
    allCanvases.add(new Canvas(100 + (i < 5 ? 201 * i : 201 * (i - 5)), 
                               301 + (i < 5 ? 0 : 201), 200, color(255),
                               
                               random(-5, 5), random(-5, 5), random(-1, 1), random(-1, 1) ,
                               random(-.1, .1), random(-.1, .1), random(1, 100), random(5, 10),
                               
                               1, 1, 1, //bp
                               
                               random(0, WIDTH), random(0, HEIGHT), random(-20, 20),
                               random(-20, 20), random(-.1, .1), random(-.1, .1)));
  }
}

void draw() {
  for(Canvas c: allCanvases)
    c.display();
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
      
      createGraph();

      //loop for creating offspring
      for(int i = 0; i < POPULATION; i++) {
        allCanvases.get(i).reset = true;
        int[] sel = selection();
        Canvas parent = allCanvases.get(sel[0]);
        Canvas partner = allCanvases.get(sel[1]);
        genes[i] = parent.crossover2(partner);
      }
      
      //loop for assigning new genes
      for(int i = 0; i < POPULATION; i++) {
        allCanvases.get(i).genes = genes[i];
        allCanvases.get(i).pressed = true;
      }
    }
    
    //reset count each time
    count = 0;
  }
}


void keyPressed() {
  save("screenshoooot.jpg");
  for(Canvas c: allCanvases)
    c.done = true;
}
