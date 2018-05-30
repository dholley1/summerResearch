//float cv_scale(float d) {
  
//}

class variety {

  float[] r;
  float[] g;
  float[] b;

  int _size;
  
  variety() {
    r = new float[PICSIZE];
    g = new float[PICSIZE];
    b = new float[PICSIZE];

    _size = 0;
  }
  
  boolean checkColor(color c) {
    // true if the given color exists in the array
    // false if the given color can be added

    for (int i=0; i<_size; i++) {
      if (r[i]==red(c) && g[i]==green(c) && b[i]==blue(c))
        return true;
    }

    return false;
  }
  
  void addColor(color c) {
    if (!checkColor(c)) {
      r[_size] = red(c);
      g[_size] = green(c);
      b[_size] = blue(c);

      _size++;
    }
  }
  
  int getSize() {
    // return the size of the array
    return _size;
  }
}

float color_variation() {
  variety v = new variety();

  for (int i=0; i<PICSIZE; i++) {
    v.addColor(result.pixels[i]);
  }
  
  float infloat = v.getSize();
  float score = (infloat/PICSIZE)*100;
  //println(score);
  return score;
}