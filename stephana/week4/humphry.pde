// want an array of points that represent the edge of the object

void getObject() {
  
}

tuple moveOn(tuple center, int strength, tuple edge) {
  // recursively return the point of the end
  if (strength < 50) return edge;
  // if strength is still higher than 50
  for (int i=0; i<8; i++) {
    tuple point = march(point, directions[i], radius);
  }
}
