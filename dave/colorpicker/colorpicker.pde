/* Places an image on the screen, then allows the user to click a pixel on the image;
   the sketch analyzes the surrounding pixels and picks a color that represents the
   local area. Uses RGBtoLAB conversion. */

PImage myImage;

void setup() {
  size(800, 400);
  myImage = loadImage("farmfield.jpg");
  image(myImage, 0, 0);
  ellipseMode(CENTER);
}

void draw() {
  /* Puts image in window. */
  //image(myImage, 0, 0);
  frameRate(1);
}

void mousePressed() {
  /* The user can click the image and we will suggest the color not of that pixel
     but of the neighborhood of that pixel. */
     
   // Grab the RGB color of the clicked pixel:
   color clickedCol = get(mouseX, mouseY);
   
   // STRIP 1: the clicked color
   fill(clickedCol);
   rect(width/2, 0, width/8, height);
   
   // Same, but finalCol will be averaged with nearby similar pixel colors:
   color finalCol = get(mouseX, mouseY);
   
                         // Attributes to play with:
   int numTrials = 3;    // the number of pixels chosen from the neighborhood
   int nbhdRadius = 50;  // the radius of the neighborhood
   int threshold = 4;    // maximum LAB distance that we will allow as we search

   // Indicate on screen where the searching is going on:
   fill(200, 200, 200, 100);
   ellipse(mouseX, mouseY, nbhdRadius/2, nbhdRadius/2);
   
   int trial = 0;             // trial will be incremented while we search
   boolean searching = true;  // for the while loop
   
   while (searching) {
     
     // Close the search if we have enough trials:
     if (trial >= numTrials) searching = false;
     
     // Choose a random point in the neighborhood of the pixel that was clicked:
     float angle = random(TWO_PI);
     float distance = random(nbhdRadius);
     int xPos = (int) (mouseX + distance * cos(angle));
     int yPos = (int) (mouseY + distance * sin(angle));
     
     // Grab the RGB color of the randomly chosen pixel:
     color randomCol = get(xPos, yPos);
     
     // If this color is too different from the original, reject it:
     float[] clickedLAB = rgbToLab((int) red(clickedCol), (int) green(clickedCol), (int) blue(clickedCol));
     float[] randomLAB = rgbToLab((int) red(randomCol), (int) green(randomCol), (int) blue(randomCol));
     
     if (distLAB(clickedLAB, randomLAB) < threshold) {
       
       // STRIP 2: the randomly chosen color that should be within the threshold:
       fill(randomCol);
       rect(width - 3 * width/8, 0, width/8, height);
       
       trial++;

       println("found a similar point:", trial, distLAB(clickedLAB, randomLAB));
                
       color newCol = color ( (int) ((red(finalCol) + red(randomCol)) / 2),
                              (int) ((green(finalCol) + green(randomCol)) / 2),
                              (int) ((blue(finalCol) + blue(randomCol)) / 2)
                            );
       
       println(red(finalCol), red(randomCol));
       println(green(finalCol), green(randomCol));
       println(blue(finalCol), blue(randomCol));
                            
       println((int) ((red(finalCol) + red(randomCol)) / 2),
               (int) ((green(finalCol) + green(randomCol)) / 2),
               (int) ((blue(finalCol) + blue(randomCol)) / 2));
       
       // STRIP 3: The RGB average of the first two strips:
       fill(newCol);
       rect(width - width/4, 0, width/8, height);       
                            
       finalCol = lerpColor(finalCol, newCol, 0.5);
       
       // STRIP 4: The lerp of finalCol and newCol:
       fill(finalCol);
       rect(width - width/8, 0, width/8, height);
       
     }
     
   }
   
}

float[] rgbToLab(int R, int G, int B) {
  /* Converts an RGB triple to a LAB triple. */

    float r, g, b, X, Y, Z, xr, yr, zr;

    // D65/2° (Dave is not sure what this comment means..)
    float Xr = 95.047;  
    float Yr = 100.0;
    float Zr = 108.883;


    // --------- RGB to XYZ ---------//

    r = R/255.0;
    g = G/255.0;
    b = B/255.0;

    if (r > 0.04045)
        r = pow((r+0.055)/1.055,2.4);
    else
        r = r/12.92;

    if (g > 0.04045)
        g = pow((g+0.055)/1.055,2.4);
    else
        g = g/12.92;

    if (b > 0.04045)
        b = pow((b+0.055)/1.055,2.4);
    else
        b = b/12.92 ;

    r*=100;
    g*=100;
    b*=100;

    X =  0.4124*r + 0.3576*g + 0.1805*b;
    Y =  0.2126*r + 0.7152*g + 0.0722*b;
    Z =  0.0193*r + 0.1192*g + 0.9505*b;


    // --------- XYZ to Lab --------- //

    xr = X/Xr;
    yr = Y/Yr;
    zr = Z/Zr;

    if ( xr > 0.008856 )
        xr = pow(xr, 1/3.);
    else
        xr = ((7.787 * xr) + 16 / 116.0);

    if ( yr > 0.008856 )
        yr = pow(yr, 1/3.);
    else
        yr = ((7.787 * yr) + 16 / 116.0);

    if ( zr > 0.008856 )
        zr = pow(zr, 1/3.);
    else
        zr = ((7.787 * zr) + 16 / 116.0);


    float[] lab = new float[3];

    lab[0] = (116*yr)-16;
    lab[1] = 500*(xr-yr); 
    lab[2] = 200*(yr-zr); 

    return lab;
} 

float distLAB(float[] colorOne, float[] colorTwo) {
  /* Return the LAB distance between colorOne and colorTwo (both in RGB): */
  
  float d = sqrt(pow(colorOne[0] - colorTwo[0], 2) +
                 pow(colorOne[1] - colorTwo[1], 2) +
                 pow(colorOne[2] - colorTwo[2], 2));
                 
  return d;
}