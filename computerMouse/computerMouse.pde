PImage input;

window[] pApps = new window[3];

float[][] genes = new float[10][6];

void setup(){
  //blendMode(MULTIPLY);
  input = loadImage("flower.jpg");
  image(input, 0, 0, 300, 300);
  
  String[] args = {"PaintWindow"};
  for(int i = 0; i < 3; i++) {
    float deltaX = random(10, 100);
    float[] vals = {0, 0, random(.1, 20), random(.1, 20), deltaX, deltaX};
    genes[i] = vals;
    window win = new window(i < 5 ? 300 * i : 300 * i - 1500,
                            i < 5 ? 0 : 300,
                            vals, this, i);
    pApps[i] = win;
    PApplet.runSketch(args, win);
  }
  
}

void settings() {
  size(300, 300);
}

void draw() {
  int count = 0;
  for(int i = 0; i < 3; i++) {
    if(pApps[i].done)
      count+=1;
    else
      break;
  }
  if(count == 3) {
    for(int i = 0; i < 3; i++) {
      window parent = choseParent(pApps);
      window partner = chosePartner(pApps, parent);
      child = parent.crossover(i < 5 ? 300 * i : 300 * i - 1500,
                               i < 5 ? 0 : 300,
                               partner, i);
      PApplet.runSketch(args, child);
    }
  }
  count = 0;
}