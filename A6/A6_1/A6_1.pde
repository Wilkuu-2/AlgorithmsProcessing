
/*
  Template
 Sample text
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

// -- GLOBALS


SpringNode root; 




// -- INIT
void setup() {
  size(800,800, P2D);
  frameRate(60);
  
  root = new SpringNode(null,0,0);
  
  for(int x = 0; x < 10; x ++)
   root.AddToRandomNode(new SpringNode(null, random(0,2), random(-PI/1000f,PI/1000f)));
   //root.AddToRandomChildlessNode(new SpringNode(null, random(0,2), random(-PI/1000f,PI/1000f)));
  root.rad = 5f;
}


// -- Every Frame
void draw() {
  background(100);
  root.update1();
  pushMatrix();
  translate(width/2, height/2);
  root.display();

  popMatrix();
}
