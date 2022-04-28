class Confetti {
  
  color pinkish;      // a confetti has a colour
  float radius;       // a confetti has a radius;
  PVector location, speed;
  //constructor: gives values to the variables
  Confetti() { 
    //random pinkish colour with opacity
    pinkish = color(int(random(180,255)), int(random(0,150)), int(random(100,200)), 70);  //pinkish
    
    //random radius and position
    radius = random(10,25);

    location=new PVector (int(random(radius,width-radius)),int(random(radius,height-radius)));
    speed=new PVector (int(random(-4,4)),int(random(-4,4)));
  }
    
  void render() {
    noStroke();
    fill(pinkish);
    ellipse(location.x, location.y, 2*radius, 2*radius);
  }
  
  void update() {
    //if the confetti reaches the left wall or the right wall, it bounces
    if ((location.x > width - radius - speed.x) || (location.x < radius - speed.x)) {
      speed.x = -speed.x;
    }    
    //if the confetti reaches the top wall or the botton wall, it bounces
    if ((location.y > height - radius - speed.y) || (location.y < radius - speed.y)) {
      speed.y = -speed.y;
    }
    location=location.add(speed);
    //location=location+speed;
    //xPos = xPos + xSpeed;
    //yPos = yPos + ySpeed;
  }
  
  void setSpeed(PVector speed){
    this.speed=speed;
    
  }  
}
