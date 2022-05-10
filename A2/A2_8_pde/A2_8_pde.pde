/*
  Template
    Sample text
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- GLOBALS 

float noiseScale = 0.3; 
float gridSize = 50; 
float gridHeight = 300; 
PVector size = new PVector(30,30);

// -- INIT 
void setup(){
   size(1000,500,P3D);
   camera(1500, 1000, -800, 
         size.x*gridSize/2, size.y*gridSize/2,0, 
         0, 0, 1);
}


// -- Every Frame
void draw(){
   background(0);
   fill(255);
   stroke(125);
    for(int i = 0; i < size.x -1; i++){
      for(int j = 0; j < size.y -1 ;j++){
        pushMatrix();
        //translate(i*gridSize,j*gridSize,noise(i*noiseScale,j*noiseScale)*gridHeight);
        
        beginShape(QUADS);
          putVertex(i,j);
          putVertex(i,j+1);
          putVertex(i+1,j+1);
          putVertex(i+1,j);
        endShape();
        
        popMatrix();
      }
    }
}

void putVertex(float i, float j){
  vertex(i*gridSize,j*gridSize, noise(i*noiseScale,j*noiseScale)*gridHeight);
}
