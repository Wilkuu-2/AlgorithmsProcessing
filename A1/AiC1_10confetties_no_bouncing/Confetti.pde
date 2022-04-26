class Confetti {
  
  color pinkish;      // a confetti has a colour
  float xPos;         // a confetti has an x-position
  float yPos;         // a confetti has an y-position
  float radius;       // a confetti has a radius;
  float xSpeed;           // the confetti moves with some speed in x direction
  float ySpeed;           // the confetti moves with some speed in y direction
  
  //constructor: gives values to the variables
  Confetti() { 
    //random pinkish colour with opacity
    pinkish = color(int(random(180,255)), int(random(0,150)), int(random(100,200)), 70);  //pinkish
    
    //random radius and position
    radius = random(10,25);
    xPos = int(random(radius,width-radius));
    yPos = int(random(radius,height-radius));
    
    // random speed
    xSpeed = int(random(-4,4));               // speed in x-direction
    ySpeed = int(random(-4,4));               // speed in y-direction
  }
    
  void render() {
    noStroke();
    fill(pinkish);
    ellipse(xPos, yPos, 2*radius, 2*radius);
  }
  
  void update() {
    //if the confetti reaches the left wall or the right wall, it bounces
    if ((xPos > width - radius - xSpeed) || (xPos < radius - xSpeed)) {
      xSpeed = -xSpeed;
    }    
    //if the confetti reaches the top wall or the botton wall, it bounces
    if ((yPos > height - radius - ySpeed) || (yPos < radius - ySpeed)) {
      ySpeed = -ySpeed;
    }
    
    xPos = xPos + xSpeed;
    yPos = yPos + ySpeed;
  }
  
  void setSpeed(float xSpeed, float ySpeed){
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }  
}
