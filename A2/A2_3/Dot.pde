
final static float MIN_RAD= 20.0;
final static float MAX_RAD= 30.0;
final static float MIN_MIN_RAD = 0.01;
final static float MIN_MAX_RAD = 0.02;
final static float SMALLNESS_BASE = 0.3;


class Dot {
  float radius;
  PVector position;
  color fill;
  color stroke;

  // -- Constructor 
  Dot(double d_smallness) {
    // Convert to float
    float smallness = (float) d_smallness;
    
    // Get the maximum and the minimum radius 
    float minRad = min(max(MIN_RAD / (smallness + SMALLNESS_BASE), MIN_MIN_RAD), width/2, height/2);
    float maxRad = min(max(MAX_RAD / (smallness + SMALLNESS_BASE), MIN_MAX_RAD), width/2, height/2);

    // Create radius
    radius = random(minRad, maxRad);

    // Random position 
    position = new PVector(random(0+radius, width-radius), random(0+radius, height-radius));
    //fill = color(random(100, 150), random(100, 150), random(100, 50));

    fill = color(50,70,150);
  }

  // Checks all other dots for collision
  boolean isValid(ArrayList<Dot> dots) {
    for (Dot sDot : dots) {
      if (PVector.dist(sDot.position, this.position)-1.0 < (sDot.radius + this.radius))
        return false;
    }
    return true;
  }
  
  // Return surface area of the dot
  float getSurfaceArea() {
    return PI*pow(radius, 2);
  }
  
  // Display 
  void display() {
    fill(fill);
    noStroke();
    circle(position.x, position.y, radius*2);
  }
}
