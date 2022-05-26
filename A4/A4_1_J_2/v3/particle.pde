// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  
  float lifespan;
  int r,g,b;

  Particle(PVector l) {
    
    velocity = new PVector(random(-1, 1), random(-1,1));
    position = l.copy();
    lifespan = 255.0;
    r=int(random(255));
     g=int(random(255));
    b=int(random(255));
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    
    position.add(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
    //stroke(255, lifespan);
    noStroke();
    fill(r,g,b, lifespan);
    ellipse(position.x, position.y, 8, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}
