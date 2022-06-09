// The Boid class

class Boid {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float red, green, blue;
  PImage shrimp;

  Boid(float x, float y) {
    acceleration = new PVector(0, 0);
    blue= random(0, 255);
    red=random(0, 255);
    green=random(0, 255);
    shrimp =loadImage ("shrimp.b.png");

    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();

    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    position = new PVector(x, y);
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up

    fill(200, 100);
    stroke(red, green, blue);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    //image(shrimp,r,r);
    beginShape(TRIANGLES);
    vertex(0, -r);
    vertex(-r, r);
    vertex(r, r);
    endShape();
    beginShape(TRIANGLES);
    vertex(-r, r);
    vertex(-r*2, r*3);
    vertex(r*0.5, r*3);
    endShape();
    beginShape(TRIANGLES);
    vertex(r, r);
    vertex(r*2, r*3);
    vertex(-r*0.5, r*3);
    endShape();
    beginShape(TRIANGLES);
    vertex(0, r*3);
    vertex(-r*1.75, r*5);
    vertex(r*1.75, r*5);

    endShape();
    fill(0);
    noStroke();
    circle(0, 1, r);
    endShape();

    popMatrix();
  }

  // Wraparound

  void borders() {
    //translate(width/2,height/2);
    PVector orig;
    orig = new PVector(0, 0);
    float radius=width/2;
    //radius*=0.1;

    PVector border;
    //----------------------rectangle border-----------

    //border = new PVector(width/2, height/2);
    //if (position.x < 50 ) border.add(-1, 0);
    //if (position.y < 50) border.add(0, -1);
    //if (position.x > width+50) border.add(1, 0);
    //if (position.y > height+50) border.add(0, 1);


    //----------------------circle border----------------------------------

    border = new PVector(0, 0);
    border= position;
    border.add(velocity);
    if (border.dist(orig) > radius-width/20 ) {
      PVector n=position.copy();
     n.normalize();
     n.mult(2*n.dot(velocity));
     velocity.sub(n);

    }
    //--------------------------------------------------------
    //if (position.y < radius) border.add(0,-1);
    //if (position.x > width-radius) border.add(1,0);
    //if (position.y > height-radius) border.add(0,1);
    //border.normalize();
    //if (border.x!=0||border.y!=0) {
    //}
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 5) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 5) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() >5) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 5) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 5) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } else {
      return new PVector(0, 0);
    }
  }
}
