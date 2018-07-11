void setup(){
  size(200, 200);
}

void draw(){
  scoreboard sb = new scoreboard();
  for (int i=0; i<20; i++) {
    sb.addNew(random(100));
  }

  sb.bigMAD();
  
  ArrayList<Integer> hehe = sb.inRange();
  println("here!", hehe.size());
  for (int i=0; i<hehe.size(); i++) {
    println(hehe.get(i));
  }
  println("DONE!!!!!!!! O?");
  noLoop();
}