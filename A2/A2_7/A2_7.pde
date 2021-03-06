/*
  3D Perlin noise
    Using the Noise2D example, we created a moving version of it by taking time as the 3rd dimension for the noise;
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/
// Daniel Shiffman
// The Nature of Code
// http://natureofcode.com

float increment = 0.02;
//Added time increment 
float timeInc   =0.001; 

void setup() {
  size(640,360);
  //This program now loops in draw 
}

void draw() {
  background(0);
  
  // Optional: adjust noise detail here
  // noiseDetail(8,0.65f);
  
  loadPixels();

  float xoff = 0.0; // Start xoff at 0
  float toff = millis() * timeInc; //Use millis as base for the time offset (gets updated every frame)
  
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff
      
      // Calculate noise and scale by 255
      float bright = noise(xoff,yoff,toff)*255; //Added toff to the noise function 

      // Try using this line instead
      //float bright = random(0,255);
      
      // Set each pixel onscreen to a grayscale value
      pixels[x+y*width] = color(bright);
    }
  }
  
  updatePixels();
}
