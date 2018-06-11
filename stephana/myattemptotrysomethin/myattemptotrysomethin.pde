PImage die;
int dwidth;
int dheight;

storage st;

void setup() {
  size(300, 188);
  //noSmooth();
  fill(126);
  background(102);
  die = loadImage("die.jpg");
  dwidth = die.width;
  dheight = die.height;
}

void draw() {
  image(die, 0, 0, dwidth, dheight);
  tuple center = new tuple(dwidth/2, dheight/2);
  float[] hahaha = getLength(center);
  println(hahaha);
  noLoop();
  ellipse(dwidth/2, dheight/2, 10, 10);
  ellipse(dwidth/2+60, dheight/2+60, 10, 10);
  ellipse(dwidth/2-60, dheight/2-60, 10, 10);
  ellipse(dwidth/2-60, dheight/2+60, 10, 10);
  ellipse(dwidth/2+60, dheight/2-60, 10, 10);
}

void mousePressed() {
  println("At (", mouseX, ", ", mouseY, ")");
}

class tuple {
  int x;
  int y;
  
  tuple(int xpos, int ypos) {
    x = xpos;
    y = ypos;
  }
  
  int x() {
    return x;
  }

  int y() {
    return y;
  }
}

class storage {
  // variables
  tuple[] store; 
  int size;
  
  storage() {
    store = new tuple[dwidth * dheight];
    size = 0;
  }
  
  void addIntXInt(int x, int y) {
    tuple item = new tuple(x, y);
    store[size] = item;
    size++;
  }
  
  void addTuple(tuple point) {
    store[size] = point;
    size++;
  }
  
  void removeItem() {
    // remove the last item
    size--;
  }
  
  tuple firstItem() {
    return store[0];
  }
  
  tuple lastItem() {
    return store[size-1];
  }
  
  int getSize() {
    return size;
  }
}

color getColor(tuple pair) {
  color c = get(pair.x, pair.y);
  return c;
}

tuple nextPoint(tuple point, int dir) {
  int x = point.x;
  int y = point.y;
  
  tuple newTuple = new tuple(-10, -10);
  
  if (dir == 1) {
    newTuple = new tuple(x, y++);
  }
  else if (dir == 2) {
    newTuple = new tuple(x++, y++);
  }
  else if (dir == 3) {
    newTuple = new tuple(x++, y);
  }
  else if (dir == 4) {
    newTuple = new tuple(x++, y--);
  }
  else if (dir == 5) {
    newTuple = new tuple(x, y--);
  }
  else if (dir == 6) {
    newTuple = new tuple(x--, y--);
  }
  else if (dir == 7) {
    newTuple = new tuple(x--, y);
  }
  else if (dir == 8) {
    newTuple = new tuple(x--, y++);
  }
  return newTuple;
}

///********************************************************************/
boolean checkRGB(tuple point){
  // true if the difference is visibly noticeable to human eyes
  // false if considered "similar"

  // get color of the point-- point is in tuple form
  color center = getColor(point);
  float x = point.x;
  float y = point.y;
  float r = 5;

  // go thru the whole circle
  for (float i = y-r; i < y+r; i++) {

    for (float j = x; (j-x)*(j-x) + (i-y)*(i-y) <= r*r; j--) {
      color c = get(int(j), int(i));
      if (findDist(center, c) >= 4) {
        return true; // too often
      }
    }

    for (float j = x+1; (j-x)*(j-x) + (i-y)*(i-y) <= r*r; j++) {
      color c = get(int(j), int(i));
      if (findDist(center, c) >= 4)
        return true;
    }
  }    
  return false;
}
///********************************************************************/

void chocolatemochalatte(tuple point) {
  if (checkRGB(point)) {
    st.addTuple(point);
  }
  int d=1;
  while (d<9) {
    if (checkRGB(nextPoint(point, d))) {
      st.addTuple(nextPoint(point, d));
      chocolatemochalatte(nextPoint(point, d));
    }
    d++;
  }
}
