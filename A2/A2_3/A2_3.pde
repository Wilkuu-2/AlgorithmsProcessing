/*
  Template
    Sample text
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- GLOBALS 

ArrayList<Dot> dots;
float sizeMin = 3;
float sizeMax = 3; 
float fillratio = 0.7;
float surfaceArea = 600*600;

// -- INIT 
void setup(){
  size(600,600,"P2D");
  genDots();
  
}

void genDots(){
  float filled = 0; 
  while(filled < fillratio){
     Dot d = new Dot();
     d.ret
  }

}




// -- Every Frame
void draw(){
  background(255);
  
  for(Dot d: dots){
    d.display()
  }
}
