/*
  2x1D Perlin noise
    Sample text
    
    A 2-dimentional version of: https://processing.org/examples/noise1d.html 
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- GLOBALS 
// ---- Source: https://processing.org/examples/noise1d.html 
float xoff = 0.0;
float xincrement = 0.01; 
// ---- End 
float yoff = 0.0; 
float yincrement = 0.01; 



// -- INIT 
void setup(){
  // ---- Source: https://processing.org/examples/noise1d.html 
  size(640, 360);
  background(0);
  noStroke();
  // ---- End
}


// -- Every Frame
void draw(){
  // ---- Source: https://processing.org/examples/noise1d.html 
  // Create an alpha blended background
  fill(0, 10);
  rect(0,0,width,height);
  
  //float n = random(0,width);  // Try this line instead of noise
  
  // Get a noise value based on xoff and yoff and scale it according to the window's width
  // Following two perpedicular lines on the 2d perlin noise map to make n and o independent 
  
  // OLD: float n = noise(xoff)*width;
  float n = noise(xoff,yoff)*width;
  float o = noise(yoff,xoff)*height;  // Using 2d perlin noise and going along 
  // With each cycle, increment xoff
  xoff += xincrement;
  
  // Draw the ellipse at the value produced by perlin noise
  fill(200);
  //OLD: ellipse(n,height/2, 64, 64);
  ellipse(n,o, 64, 64);
  // ---- End 
}
