

class Separation implements Force {
  float factor = 3f;
  float desiredDistance  = 10f;

  PVector getForce(SimObject origin, ArrayList<SimObject> others) {
    PVector force = new PVector(0, 0, 0);
    int count = 0;
    for (SimObject other : others) {
      if (other != origin) {
        PVector fromOther = PVector.sub(origin.position, other.position);
        float dist = fromOther.mag();
        if (dist - other.rad - origin.rad < desiredDistance && dist > 0) {
          force.add(fromOther.normalize().div(dist * 0.1));
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

  Separation(float f) {
    factor = f;
  }
}
