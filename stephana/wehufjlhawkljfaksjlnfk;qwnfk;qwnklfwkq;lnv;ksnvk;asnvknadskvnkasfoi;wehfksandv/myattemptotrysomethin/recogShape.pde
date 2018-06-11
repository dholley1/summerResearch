/*
SHAPE RECOGNITION

1. Choose a starting point
2. Write a function that finds "length" of how long the similar color continues in eight directions
3. Create a variable "strength" that represents how similar colors are
4. Until "strength" is less than the minimum, march to the direction to find "length"

suggestion: use bicycle idea?
*/

float[] getLength(tuple center) {

  tuple[] directions = {new tuple(0, 1), new tuple(1, 1), new tuple(1, 0), new tuple(1, -1),
                        new tuple(0, -1), new tuple(-1, -1), new tuple(-1, 0), new tuple(-1,1)};
    
  tuple point = center;
  int samplePop = 10;
  int radius = 10;
  
  float[] lenAry = new float[8];
  
  // for eight directions
  for (int i=0; i<8; i++) {
    // get the next point from the original center
    point = march(point, directions[i], radius);
    // length and strength to the direction at the starting set up
    float len = 0;
    float strength = 100;
    
    // while strength is greater than 50
    while (strength > 50) {
      point = march(point, directions[i], radius);
      float avgDiff = 0;
      // get samples for samplePop times
      for (int j=0; j<samplePop; j++) {
        tuple p = randomPoint(point, radius);
        float distDiff = findDist(getColor(center), getColor(p));
        avgDiff += distDiff;
      }

      // divide to get average
      avgDiff /= samplePop;
      if (avgDiff >= 4) {
        strength *= 0.75;
      }
      if (strength <= 50) {
        len += 2 * radius;
      }
    }
    lenAry[i] = len;
  }
  return lenAry;
}

tuple randomPoint(tuple point, float radius) {
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
