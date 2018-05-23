PImage input;

int WINDOWS = 10;

window[] pApps = new window[WINDOWS];

float[][] genes = new float[WINDOWS][7];

static boolean START = false;
static int PAINTING = 0;
static int GEN = 0;

void setup(){
  //blendMode(MULTIPLY);
  input = loadImage("flower.jpg");
  image(input, 0, 0, 300, 300);
  
  String[] args = {"PaintWindow"};
  for(int i = 0; i < WINDOWS; i++) {
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
  GEN = PAINTING / WINDOWS;
  if(START) {for(int i = 0; i < WINDOWS; i++) pApps[i].restart = true; START = false;}
  else {int count = 0;
  for(int i = 0; i < WINDOWS; i++) {
    if(pApps[i].done)
      count+=1;
    else
      break;
  }
  if(count == WINDOWS) {
    for(int i = 0; i < WINDOWS; i++) {
      println(pApps[i].vals[6]);
      pApps[i].save("../SR/summerResearch/computerMouse/data/"+Integer.toString(PAINTING)+".jpg");
      PAINTING++;
    }
    float[][] genes = new float[WINDOWS][7];
    for(int i = 0; i < WINDOWS; i++) {
      pApps[i].reset = true;
      int[] sel = selection();
      window parent = pApps[sel[0]];
      window partner = pApps[sel[1]];
      genes[i] = parent.crossover(partner);
    }
    for(int i = 0; i < WINDOWS; i++) {
      pApps[i].vals = genes[i];
      pApps[i].pressed = true;
    }
  }
  count = 0;
  }
}