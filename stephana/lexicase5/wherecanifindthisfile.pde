ArrayList<tuple> edgeSamples = new ArrayList<tuple>();

void complexEdge() {
  PImage bbEdge = loadImage("bbEdge.png");
  bbEdge.loadPixels();
  int imgH = 200;
  int imgW = 200;
  int count = 0;
  
  for (int i=0; i<imgH; i++) {
    for (int j=0; j<imgW; j++) {
      int index = imgW * i + j;
      color c = bbEdge.pixels[index];
      if (red(c)>230 && green(c)>230 && blue(c)>230) {
        edgeSamples.add(new tuple(j, i));
      }
    }
  }
  
  println("Total", imgH*imgW, "pixels, ", count, "pixels are white enough");
  
   
  
  // 3. Then check those points on edge detections on the paintings
  
}
