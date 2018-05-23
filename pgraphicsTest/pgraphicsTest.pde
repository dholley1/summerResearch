  
PGraphics pg;

void setup() {
  size(500, 500);
  pg = createGraphics(300, 300);
}

void draw() {
  pg.beginDraw();
  pg.background(102);
  //pg.stroke(255);
  //pg.line(pg.width/2, pg.height/2, mouseX, mouseY);
  pg.endDraw();
  image(pg, 0, 0, 300, 300); 
}