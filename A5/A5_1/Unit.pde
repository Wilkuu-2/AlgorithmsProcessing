/*
  Unit
    A flocking object
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
    

    // The Nature of Code
    // Daniel Shiffman
    // http://natureofcode.com

    // Boid class
    // Methods for Separation, Cohesion, Alignment added
*/

class Unit {
  int team; 
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  Unit(float x, float y, int t) {
    team = t; 
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-1,1),random(-1,1));
    position = new PVector(x,y);
    r = 3.0;
    maxspeed = 6;
    maxforce = 0.8;
  }

  void run(ArrayList<Unit> boids) {
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
  void flock(ArrayList<Unit> units) {
    PVector sep = separate(units);   // Separation
    PVector ali = align(units);      // Alignment
    PVector coh = cohesion(units);   // Cohesion
    PVector enemyRep = enemyRepulsion(units);
    PVector bRep = forceTowards(new PVector(width/2, height/2), 0.6); // Apply smal force towards the middle
    
    // Arbitrarily weight these forces
    sep.mult(2.4);
    ali.mult(1.1);
    coh.mult(2.0);
    bRep.mult(1.0);
    
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(bRep);
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
    PVector desired = PVector.sub(target,position);  // A vector pointing from the position to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }
  
  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    fill(colors[team]);
    stroke(0);
    pushMatrix();
    translate(position.x,position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }

  // Bounce
  void borders() {
    if (position.x < -r) 
      velocity.x = abs(velocity.x);
    if (position.y < -r) 
      velocity.y = abs(velocity.y);
    if (position.x > width+r)
      velocity.x = -abs(velocity.x);
    if (position.y > height+r)
      velocity.y = -abs(velocity.y);
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Unit> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Unit other : boids) {
      float d = PVector.dist(position,other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position,other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
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
  PVector align (ArrayList<Unit> boids) {
    float neighbordist = 70;
    PVector sum = new PVector(0,0);
    int count = 0;
    for (Unit other : boids) {
      float d = PVector.dist(position,other.position);
      if (team == other.team && (d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum,velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0,0);
    }
  }
  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Unit> boids) {
    float neighbordist = 70;
    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Unit other : boids) {
      float d = PVector.dist(position,other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } else {
      return new PVector(0,0);
    }
  }
  
  PVector enemyRepulsion(ArrayList<Unit> units){
    
  }
  
  PVector forceTowards(PVector point , float minimum){
    PVector rep = new PVector(0,0);
    
    rep.x = (point.x / width - position.x / width)  * 2;
    rep.y = (0.5 - position.y / height) * 2;
    
    if(rep.x < minimum && rep.x > -minimum)
      rep.x = 0;
    if(rep.y < minimum && rep.y > -minimum)
      rep.y = 0;
      
    return rep; 
       
  }
}
