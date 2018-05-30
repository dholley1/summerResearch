int POPULATION = 10;
int WIDTH = 200;
int HEIGHT = 200;
boolean START = false;
ArrayList<Canvas> allCanvases = new ArrayList<Canvas>();
PImage input;
static int PAINTING = 0;
static int GEN = 0;
float[][] genes = new float[POPULATION][7];

void setup() {
  size(1005, 603);
  background(50);
  rectMode(CENTER);
  input = loadImage("flower.jpg");
  image(input, 0, 0, 200, 200);
  for(int i = 0; i < POPULATION; i++) {
    float deltaX = random(10, 20);
    float[] vs = {0, 0, random(5, 20), random(5, 20), deltaX, deltaX, random(5, 40)};
    allCanvases.add(new Canvas(100 + (i < 5 ? 201 * i : 201 * (i - 5)), 
                               301 + (i < 5 ? 0 : 201), 200, color(255), vs));
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
      
      int[] sel = selection();

      
      //loop for creating offspring
      for(int i = 0; i < POPULATION; i++) {
        allCanvases.get(i).reset = true;
        //int[] sel = selection();
        Canvas parent = allCanvases.get(sel[0]);
        Canvas partner = allCanvases.get(sel[1]);
        genes[i] = parent.crossover(partner);
      }
      
      //loop for assigning new genes
      for(int i = 0; i < POPULATION; i++) {
        allCanvases.get(i).vals = genes[i];
        allCanvases.get(i).pressed = true;
        allCanvases.get(i).brushRange = genes[i][6];
        allCanvases.get(i).brushThickness = genes[i][6];
      }
    }
    //reset count each time
    count = 0;
  }
}