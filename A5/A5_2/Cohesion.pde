
class Cohesion implements Force {
  float factor = 2f;
  float neighborDistance = 80f;
  float desiredDistance  = 20f;
  PVector getForce(SimObject origin, ArrayList<SimObject> others) {

    PVector force = new PVector(0, 0);
    int added = 0;
    for (SimObject other : others) {
      float d = other.position.dist(origin.position);
      if (origin.team == other.team && d > 0 && d < neighborDistance && d - origin.rad - other.rad > desiredDistance) {
        force.add(other.position);
        added++;
      }
    }

    if (added > 0) {
        force.div(added);
        
        force.sub(origin.position);
        force.normalize();
        force.mult(origin.maxSpeed);
        force.sub(origin.speed);
        force.limit(1);
        return force;
    }
    
    return new PVector(0,0);
    
  }

  Cohesion(float f) {
    factor = f;
  }
}
