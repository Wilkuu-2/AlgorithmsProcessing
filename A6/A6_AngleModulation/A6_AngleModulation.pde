
float increase = PI/100; 
float r = 0; 

void setup(){
  size(800,800,P2D);
  
}
// A helper method to put the angle in a certain range, it keeps the angle the same when put through the rotate(float) method
static float modularizeAngle(float a){
   float modularized; 
  
  // Take the modulo 
  if(a < 0)
    modularized = ((TWO_PI) + a) % TWO_PI;
  else
    modularized =   (a % TWO_PI);
    
  // Last looparound 
  if (modularized > PI)
    modularized = -TWO_PI + modularized;
  if (modularized < -PI)
    modularized =  TWO_PI + modularized;
    
  return modularized; 
}

void draw() {
  background(100);
  r += increase;
  
  pushMatrix();
  
  translate(width/2 - 80, height/2);
  
  pushMatrix();
  rotate(r);
  fill(255,0,0);
  triangle(-10,-10,
            10, -10,
            0 , 40);
  popMatrix();
  
  float modularized = modularizeAngle(r);
    
  translate(160, 0);
  pushMatrix();
  
  rotate(modularized);
  
  fill(0,0,255);
  triangle(-10,-10,
            10, -10,
            0 , 40);
  popMatrix();
  popMatrix();
 
  fill(0);
  text(String.format("ANGLE:%.4f\nMOD:%.4f", r ,modularized), 20 , 20);
  
}

void keyPressed(){
  increase = -increase; 
} 
