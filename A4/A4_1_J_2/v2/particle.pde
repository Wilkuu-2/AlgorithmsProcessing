// A simple Particle class

class Particle {
  PVector position;
  PVector parVelocity;
  
  float lifespan;

  Particle(PVector L) {
   
    parVelocity = new PVector(random(-1, 1), random(-1, 1));
    position = L.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
   
    position.add(parVelocity);
    lifespan --;
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(position.x, position.y, 8, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
