/*
  Perlin landscape
    This program creates a random landscape using perlin noise. 
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/

// -- GLOBALS 


final static float HORIZON_Y = 150;
final color MOUNTAIN_COLOR = color(60,140,70);
float landSpeed = 0.4;
float carOffset = 0; 

Landscape land;

// -- INIT 
void setup(){
  size(1000,500);
  land = new Landscape(new PVector(0,HORIZON_Y),new PVector(width, height-HORIZON_Y*2), MOUNTAIN_COLOR);
  noStroke();
}


// -- Every Frame
void draw(){
  background(255);
  
  land.move(landSpeed);
  land.display();
  
  fill(color(70,160,100));
  rect(0,height,width,-HORIZON_Y);
  
  displayCar();

  
}

void displayCar(){
  pushMatrix();
    translate(width/2 + carOffset,height-HORIZON_Y);
    fill(color(255,100,100));
    rect(-30,-5,90,35);
    rect(-15,-25,50,20);
    ellipseMode(CENTER);
    fill(color(50,50,50));
    circle(-15,30,25);
    circle(45,30,25);
    fill(color(255,255,255));
    circle(-15,30,10);
    circle(45,30,10);
    
  popMatrix();
  
}

void keyReleased(){
  if(keyCode == LEFT || keyCode == RIGHT)
    landSpeed = 0.4; 
}

void keyPressed(){
  //println(key);
  switch(keyCode){
    case(LEFT):
      landSpeed = -2; 
      break; 
    case(RIGHT):
      landSpeed = 2;
      break;
    default:
      landSpeed = 0.4; 
      
  } 
  switch(key){  
    case(','):
      land.scale(0.9);
      break; 
    case('.'):
      land.scale(1.1);
      break; 
  }
}
