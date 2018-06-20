//float c1x;
//float c1y;
//float c2x;
//float c2y;

//void mousePressed() {
//  /* Allow the user to click on two pixels, and display their LAB colors and their LAB distance. */
  
//  if (clickedOnce) {
//    // ..then the user has already clicked a pixel:
    
//    c2x = mouseX;
//    c2y = mouseY;
    
//    colorTwo = get(mouseX, mouseY);
//    float[] colorTwoLAB = RGB2LAB(red(colorTwo), green(colorTwo), blue(colorTwo));
    
//    println("colorTwoLAB is:", colorTwoLAB[0], colorTwoLAB[1], colorTwoLAB[2]);
    
//    fill(colorTwo);//rkdfbdksdlfktj
//    rect(width - width/4, 0, width/4, height);

//    float distance = findDist(colorOne, colorTwo);
//    println("LAB distance is:", distance);
//    println("Distance is", sqrt(pow(c1x-c2x, 2) + pow(c1y-c2y, 2)), "\n");
    
    
//  } else {
//    // ..the user has not already clicked a pixel:
   
//    c1x = mouseX;
//    c1y = mouseY;
    
//    colorOne = get(mouseX, mouseY);
//    float[] colorOneLAB = RGB2LAB(red(colorOne), green(colorOne), blue(colorOne));
    
//    println("colorOneLAB is:", colorOneLAB[0], colorOneLAB[1], colorOneLAB[2]);
    
//    fill(colorOne);
//    rect(width/2, 0, width/4, height);
//  }
  
//  clickedOnce = !clickedOnce;   // toggle
  
//}
