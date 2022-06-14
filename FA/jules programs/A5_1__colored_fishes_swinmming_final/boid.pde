// The Boid class

class Boid {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r; // radius
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float red, green, blue; // color 
  float xobj, yobj; // variable for objects 

  int team=0; //team
  int counter; 

  Boid(float x, float y) {
    acceleration = new PVector(0, 0);
    blue= random(0, 255);
    red=random(0, 255);
    green=random(0, 255);

    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    position = new PVector(x, y);
    r = 2.0;
    maxforce = .03;
    int counter = int(random(1, 23 ));// random variable determines the team
    
    
    
    //--------------------- make team --------------
    if (counter<9) {
      team= 1;
      maxspeed = 1;
    } else if (10<counter && counter<15) {
      team=2;
      maxspeed = 0.75;
    } else
      if (16<counter && counter<19) {
        team=3;
        maxspeed = 1.75;
      } else
        if (20<counter && counter<30) {
          //team= 5;
          //position.x= random(-width/2, width/2);
          //position.y= random(-height/2, height/2);
          //r = 30f;
        }
    println(team);
  }


//----------------run-------------------------
  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

//----------------applying the forces-------------
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

    //------------fro eatch team there are variables 
    if (team==1) {
      sep.mult(2.0);
      ali.mult(0.5);
      coh.mult(1.5);
    } else if (team==2) {
      sep.mult(2.0);
      ali.mult(1);
      coh.mult(.2);
    } else if (team==3) {
      sep.mult(2.5);
      ali.mult(.5);
      coh.mult(1.0);
    }
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    //checks for the avoidence
    avoidence(boids);
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
    
    velocity.y*=0.9;
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
//-------------------------moddlles for fishes---------------
  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    if (team==1) {
      fill(red,green,blue);
    
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
    } else

      if (team==2) {

        fill(200, 100);
        stroke(255);
        pushMatrix();

        translate(position.x, position.y);
        fill(255);
        rotate(theta);

        fill(255, 0, 0);
        circle(0, r*2, r*6);
        fill(255);

        beginShape(TRIANGLES);
        vertex(0, -r*2);
        vertex(-r*2, r);
        vertex(r*2, r);
        endShape();

        beginShape(TRIANGLES);
        vertex(2*r, r);
        vertex(r*5, r*4);
        vertex(r*2, r*3);
        endShape();

        beginShape(TRIANGLES);
        vertex(-2*r, r);
        vertex(-r*5, r*4);
        vertex(-r*2, r*3);
        endShape();

        beginShape(TRIANGLES);
        vertex(0, r*4.4);
        vertex(-r*4, r*7);
        vertex(r*4, r*7);
        endShape();
        //fill(0,0,255);

        beginShape(TRIANGLES);
        vertex(r*2, -r*2);
        vertex(r, 0);
        vertex(r*2, r);
        endShape();

        fill(0);
        noStroke();
        circle(0, 1, r);
        popMatrix();
      } else
        if (team==3) {
          int  shade=40;
          noStroke();

          fill(200, 100);

          pushMatrix();

          translate(position.x, position.y);
          fill(255);
          rotate(theta);
          circle(0, r, 4);
          fill(0, shade);

          fill(0, shade);
          beginShape(TRIANGLES);
          vertex(r, r);
          vertex(r*4, r*4);
          vertex(r*1, r*3);
          endShape();

          beginShape(TRIANGLES);
          vertex(-r, r);
          vertex(-r*4, r*4);
          vertex(-r*1, r*3);
          endShape();
          fill(0, shade);


          beginShape(TRIANGLES);
          vertex(0, r*2.2);
          vertex(-r*2, r*5);
          vertex(r*2, r*5);
          endShape();
          //fill(0,0,255);
          fill(0, shade);
          ellipse(r, -r*0.5, 5, 10);
          ellipse(-r, -r*0.5, 5, 10);
          fill(0);
          circle(0, 2*r, 10);

          fill(255);
          noStroke();
          circle(0, 1, r);
          popMatrix();
        } else if (team==5) {
          pushMatrix();

          translate(position.x, position.y);
          fill(100);
          circle(0, 0, r);
          popMatrix();
        }
  }







  void borders() {

    PVector orig;
    orig = new PVector(0, 0);
    float radius=width/2;
    PVector border;


    //----------------------circle border----------------------------------

    //border = new PVector(0, 0);
    //border= position;
    //border.add(velocity);
    //if (border.dist(orig) > radius-width/20 ) {
    //  PVector n=position.copy();
    //  n.normalize();

    //  n.mult(2*n.dot(velocity));
    //  n.mult((2)^width/25);
    //  velocity.sub(n);
    //}



    //----------------------rectangle border-----------
    int distance=50;
    if (position.x < -width/2+distance||position.x>width/2-distance ) {
      velocity.x*=-2*width/25;
    }
    if (position.y<-height/2+distance||position.y>height/2-distance) {
      velocity.y*=-2*width/25;
    }
    PVector normal;
    normal= new PVector(0, 0);

    normal.normalize();
    if (normal.x!=0||normal.y!=0) {
      velocity= velocity.sub(normal.mult(2*normal.dot(normal)));
    }
    //--------------------------------------------------------
  }

  //------------------------ Separation--------------------------------------
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;

    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position) + r + other.r;
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 5) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);
        if (other.team == 5) diff.mult(10) ; // if fish go near team 5 (rocks) then they will seperate
        // Weight by distance
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

  // -----------------------------------------Alignment--------------------------------------------
  
  
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;

    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 5) && (d < neighbordist)&& team==other.team) {
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
      if ((d > 0) && (d < neighbordist)&&team==other.team) {
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

// ----------------------------avoidence--------------------------------------
  void avoidence(ArrayList<Boid> boids) {

    int space=0;
    for (Boid other : boids) { 
      if (team==1) {// depending on the type of fish they have different spaceing 
        space=30;
      }
      if (team==2) {
        space=1;
      }

      if (team==3) {
        space=2;
      }


      if (team!=other.team) {

        // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
        if (PVector.dist(position, other.position)<space) {
          // Calculate vector pointing away from neighbor
          acceleration.add(PVector.sub(position, other.position));// if fish in range then it will add difference of the position and go away
        }
      }
    }
  }
}
