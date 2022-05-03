/*
  1.9 RedDot
 Displaying dots using an Array of objects
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

// -- GLOBALS
ArrayList<RedDot> dots;
static final int dotAmount = 100; 

// -- INIT
void setup() {
  size(500,500);
  
  dots = new ArrayList<RedDot>();
  for(int i = 0; i < dotAmount; i++){
    dots.add(new RedDot());
  }
  println("AMOUNT OF DOTS: " + dots.size());
}


// -- Every Frame
void draw() {
  background(color(255,255,100));
  
  for(RedDot d: dots)
    d.display();
  for(RedDot d: dots)
    d.move();
}
