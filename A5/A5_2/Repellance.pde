


class Repellance implements Force {
  float desiredDistance = 90f;
  float factor    = 0.5;
  float obstacleFactor = 10f; 

  PVector getForce(SimObject origin, ArrayList<SimObject> others) {

    PVector force = new PVector(0, 0, 0);
    int count = 0;
    for (SimObject other : others) {
      if (other != origin) {
        PVector fromOther = PVector.sub(origin.position, other.position);
        float dist = fromOther.mag();
        if (origin.team != other.team && dist - other.rad - origin.rad < desiredDistance && dist > 0) {
          force.add(fromOther.normalize().mult(pow(4,-dist/10 - 1)));
          if(other.team == OBSTACLE)
            force.mult(obstacleFactor);
          count++;
        }
      }
    }
    if (count > 0 && force.mag() > 0) {
      force.div(count);
      force.normalize();
      force.mult(6);
      force.sub(origin.speed);
      force.limit(1);
      force.mult(factor);
    }
    return force; 
  }

  Repellance(float f) {
    factor = f;
  }
}
