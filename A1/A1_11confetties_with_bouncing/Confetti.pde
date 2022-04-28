class Confetti {
  
  color pinkish;      // a confetti has a colour
  //float xPos;         // a confetti has an x-position
  //float yPos;         // a confetti has an y-position
  float radius;       // a confetti has a radius;
  //float speed.x;           // the confetti moves with some speed in x direction
  //float speed.y;           // the confetti moves with some speed in y direction
  
  PVector position;
  PVector speed; 
  
  //constructor: gives values to the variables
  Confetti() { 
    //random pinkish colour with opacity
    pinkish = color(int(random(180,255)), int(random(0,150)), int(random(100,200)), 70);  //pinkish
    
    //random radius and position
    radius = random(10,25);
    
    position = new PVector(int(random(radius,width-radius)),int(random(radius,height-radius)));
   
    // random speed
    speed = PVector.random2D().mult(sqrt(20));
  }
    
  void render() {
    noStroke();
    fill(pinkish);
    ellipse(position.x, position.y, 2*radius, 2*radius);
  }
  
  void update() {
    //if the confetti reaches the left wall or the right wall, it bounces
    if ((position.x > width - radius - speed.x) || (position.x < radius - speed.x)) {
      speed.x = -speed.x;
    }    
    //if the confetti reaches the top wall or the botton wall, it bounces
    if ((position.y > height - radius - speed.y) || (position.y < radius - speed.y)) {
      speed.y = -speed.y;
    }
    
    position = PVector.add(position,speed);
    
  }
  
  //void setSpeed(float sx, float sy){
  //  this.speed.x = sx;
  //  this.speed.y = sy;
  //}  
}
