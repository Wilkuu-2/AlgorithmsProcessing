/*
  Perlin Noise landscape
    Using per;in noise to make a landscape
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- GLOBALS 

float noiseScale = 0.3; 
float gridSize = 50; 
float gridHeight = 300; 
PVector size = new PVector(100,100);

// -- INIT 
void setup(){
   size(1000,500,P3D);
   //Camera will look onto the mildle of the landscape 
   camera(size.x*gridSize*1.1, size.y*gridSize*0.8, -gridHeight*4, 
         size.x*gridSize/2, size.y*gridSize/2,gridHeight, 
         0, 0, 1);
}


// -- Every Frame
void draw(){
   background(0);
   fill(255);
   stroke(125);
   //Iterate over almost all the points 
    for(int i = 0; i < size.x -1; i++){
      for(int j = 0; j < size.y -1 ;j++){
        //Create the grid of planes 
        beginShape(QUADS);
          putVertex(i,j);
          putVertex(i,j+1);
          putVertex(i+1,j+1);
          putVertex(i+1,j);
        endShape();
      }
    }
}
//Helper function that adds a scaled vertex with the proper height 
void putVertex(float i, float j){
  vertex(i*gridSize,j*gridSize, noise(i*noiseScale,j*noiseScale)*gridHeight);
}
