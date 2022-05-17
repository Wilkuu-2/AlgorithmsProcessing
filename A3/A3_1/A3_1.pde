/**
 * Bouncing Ball with Vectors
 * by Daniel Shiffman.
 *
 * Demonstration of using vectors to control motion
 * of a body. This example is not object-oriented
 * See AccelerationWithVectors for an example of how
 * to simulate motion using vectors in an object.
 */

PVector location;  // Location of shape
PVector velocity;  // Velocity of shape
PVector gravity;   // Gravity acts at the shape's acceleration
boolean controll=false;
float angle=19, trigger=1;
int counter=0;
void setup() {
  size(640, 360);
  location = new PVector(165, width/2);
  velocity = new PVector(0.8, 4.1);
  gravity = new PVector(0, 0.2);
}

void draw() {
  background(0);


  if (controll) {

    // Add velocity to the location.
    location.add(velocity);
    // Add gravity to velocity
    velocity.add(gravity);
    
println(counter);
    if (counter<=5) {
      angle+=0.4;
      counter+=1;
      
    } else {
      angle=90;
     
    }
    
     
  }

println(velocity.x);
  // Bounce off edges
  if ((location.x > width) || (location.x < 0)) {
    velocity.x = velocity.x * -0.6;
    
  }
  if (location.y > height) {
    // We're reducing velocity ever so slightly
    // when it hits the bottom of the window
    velocity.y = velocity.y * -0.7;
    location.y = height;
    
     
  }

  // Display circle at location vector
  stroke(255);
  strokeWeight(2);
  fill(127);
  ellipse(location.x, location.y, 20, 20);
  catapultModdle();
}

void mousePressed() {
  controll=!controll;
  velocity.x=10;
  velocity.y=-5;
}


void catapultModdle() {


  float c = angle;
  circle(220, height-20, 20);
  translate(220, height-20);
  rotate(c);
  rect(-60, 0, 60, 5);
  arc(-60, 0, 25, 25, 0, PI+QUARTER_PI);
}
