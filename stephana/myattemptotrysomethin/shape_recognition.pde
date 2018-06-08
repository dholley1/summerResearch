/*
SHAPE RECOGNITION

1. Choose a starting point
2. Write a function that finds "length" of how long the similar color continues in eight directions
3. Create a variable "strength" that represents how similar colors are
4. Until "strength" is less than the minimum, march to the direction to find "length"

suggestion: use bicycle idea?
*/


// function that uses "strength" to return "length"
void getLength(tuple start, tuple direction) {

  color startC = getColor(start); // color of the starting point
  tuple dir = direction;  
  int strength = 100;
  int len = 0;
  tuple point = start;
  int sampleNum = 10;
  int radius = 10;
  
  while (strength > 10) {
    // compare color c and color of march(start, direction)
    point = march(point, dir); // each time point is reset    
    float sumDist = 0;
     //<>//
    // each time run a function that gets sample from a circle with radius 5 than compare to the center
    // to choose a random point within a circle--- choose a random radius r and random angle theta: x=rcos(theta), y=rsin(theta)
    // within a radius,
    for (int i=0; i<sampleNum; i++) {
      float r = random(radius);
      float theta = random(2*PI);
      int x = int(r*cos(theta));
      int y = int(r*sin(theta));
      
      color sampleC = get(x, y);
      
      sumDist += findDist(startC, sampleC);
    }
    
    float avgDist = sumDist / sampleNum;
    
    if (avgDist < 6) strength /= 1;
    else if (avgDist < 10) strength /= 2;
    else if (avgDist < 15) strength /= 4;
    else if (avgDist < 20) strength /= 8;
    else strength /= 10;
    
    len += radius;
  }
}


tuple march(tuple point, tuple dir) {
  int multiplier = 5;
  tuple next = new tuple(point.x + multiplier * dir.x, point.y + multiplier * dir.y);
  return next;
}