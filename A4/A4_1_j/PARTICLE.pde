
class Particle {
  PVector location, speed, gravity;
  float timer , sizeParticle,fadeParticle;
  Particle(PVector initLocation, PVector initSpeed, float initTimer ,float initSize) {

    location = initLocation.copy();
    gravity=new PVector(0, 0);

    speed = initSpeed.copy();
    timer=initTimer;
    sizeParticle=initSize;
    
  }

  void display() {
    noStroke();
    fill(random(0,255),random(0,255),random(0,255));
    circle(location.x, location.y, sizeParticle);
  }
  void update() {
    location.add (speed);
    timer++;
    fadeParticle--;
    //sizeParticle*=0.9;
    
  }
}
