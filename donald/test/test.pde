PImage edges;
int shift = 10;
int checks = 50;

float getEdgeAngle(float x, float y) {
  float totalBrightness = 0;
  float best = 0;
  float brightest = 0;
  int checks = 50;
  int shift = 10;
  float theta = random(0, PI);
  for(int i = 0; i < checks; i++) {
    for(int j = -shift; j < shift; j++) {
      totalBrightness += brightness(
        edges.get((int)(x+j*cos(theta)), (int)(y+j*sin(theta))) 
      );
      stroke(color(0, 255, 0));
      point((int) (x+j*cos(theta)) + 1, (int)(y+j*sin(theta)) + 1); 
    }
    if(totalBrightness>=brightest) {
      best = theta;
      brightest = totalBrightness;
      
    }
    totalBrightness = 0;
    theta = (theta + PI / checks) % PI;
  }
  return best;
}

void setup() {
  size(400, 400);
  edges = loadImage("../GenTest01/data/0edges.png");
  image(edges, 0, 0);
}

void draw() {
  
}

void mouseClicked() {
  float angle = getEdgeAngle(mouseX, mouseY);
  println(angle);
  
  stroke(color(255, 0, 0));
  
  line(mouseX - shift*cos(angle), mouseY - shift*sin(angle), 
       mouseX + shift*cos(angle), mouseY + shift*sin(angle));
  
}