/*
  RedDot
    A class that contains a position of a dot and that can draw said dot.

*/

final static color RED = 0x00FF8888;
final static float moveMult = 0.01;
final static float margin = 120;

class RedDot{
  int size;
  PVector pos;
  color dotColor;
  float moveSpeed;

  RedDot(){
    //Random size
    size = ceil(random(3,20));
    
    //Random position 
    this.pos = new PVector(random(margin, width - size - margin), random(margin, height - size - margin)); 
    
    //Random transparency
    dotColor = color(red(RED),green(RED),blue(RED),random(50,255)); 
    
    //Random speed
    moveSpeed = random(size, (size * 10 ))*moveMult;
  }
  
  void display(){
    stroke(dotColor);
    fill(dotColor);
    circle(pos.x,pos.y,size);
    println();
  }
  
  void move(){ //Simple browning motion with looparound
    this.pos = PVector.add(pos, PVector.random2D().mult(moveSpeed));
    
    if(pos.x < 0)
      pos.x = width; 
    else if(pos.x > width)
      pos.x = 0;
    if(pos.y < 0)
      pos.y = height; 
    else if(pos.y > height)
      pos.y = 0;
    
  }
} 
