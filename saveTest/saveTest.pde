PGraphics pg;

void setup() {
  size(200, 200, P2D);

  for (int i=0; i<7; i++) {
    createCanvas(100 + i * 10);
    for (int j=0; j<3; j++) {
      saveCanvas("canvas" + i  + "-save" + j);
    }
  }
  exit();
}

void createCanvas(int d) {
  // create PGraphics
  pg = createGraphics(d, d, P2D);

  // draw to PGraphics
  pg.beginDraw();
  pg.background(255, 0, 0);
  pg.fill(0, 255, 0);
  pg.ellipse(pg.width/2, pg.height/2, pg.height/3, pg.height/3);
  pg.endDraw();
}

void saveCanvas(String name) {
  //save PGraphics
  pg.save(name + ".png");
}