// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;

  float lifespan;
  int r, g, b; 
  float size;

  Particle(PVector l) {

    velocity = new PVector(random(-1, 1), random(-1, 1));
    position = l.copy();
    lifespan = 255;
    r=int(random(255)); // random color variables
    g=int(random(255));
    b=int(random(255));
    size= random(1,8);
  }

  void update() { // adds the speed to the location of the particle
    position.add(velocity);
    lifespan -= 2.0;
  }
  void run() {
    update();
    display();
  }

  void display() {
    noStroke();
    fill(r, g, b, lifespan);
    ellipse(position.x, position.y, size, size); // creates an ellipse of the particle
  }

  boolean spanTime() {
    return (lifespan < 0);
  }
}
