// the pink confetti example from module 1 for Algorithms topic 1.10
// Angelika Mader - April 2020

// confetties are created by mouse click

Confetties confetties; 

void setup(){
  size(500,500);
  confetties = new Confetties();
}

void draw(){
  background(250);
  confetties.update();
  confetties.render(); 
}

void mousePressed(){        
  confetties.mousePressedEvent();
}
