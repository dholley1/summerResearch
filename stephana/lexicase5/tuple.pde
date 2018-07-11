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


color getColor(PImage img, tuple pair) {
  // get the color of the pixel in tuple

  color c = img.get(pair.x, pair.y);
  return c;
}


tuple randomPoint(tuple point, float radius) {
  // get a random point within the circle centered at the given point with the given radius
  float randRadi = random(radius);
  float randTheta = random(PI);
  int x = point.x + int(randRadi * cos(randTheta));
  int y = point.y + int(randRadi * sin(randTheta));
  tuple randPoint = new tuple(x, y);
  return randPoint;
}


tuple march(tuple point, tuple dir, int r) {
  tuple next = new tuple(point.x + 2 * r * dir.x, point.y + 2 * r * dir.y);
  return next;
}
