


static class Alignment implements Force {
  float factor = 1f;
  float neighborDist = 20f;

  PVector getForce(SimObject origin, ArrayList<SimObject> others) {
    PVector force = new PVector(0, 0);

    int added = 0;
    for (SimObject other : others) {
      if (origin.team == other.team && other != origin && other instanceof Fish && origin.position.dist(other.position) < neighborDist ) {
        force.add(other.speed);
        added++;
      }
    }
    if (added > 0)
      force.div((float)added);

    if (force.mag() > 0) {
      force.normalize();
      force.mult(6f);
      force.sub(origin.speed);
      force.limit(1);
      force.mult(factor);
    }

    return force;
  }

  Alignment(float f) {
    factor = f;
  }
}
