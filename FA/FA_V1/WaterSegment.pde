/*
  WaterSegment
  
  A singular segment of the water surface
  
   Copyright 2022 Jakub Stachurski and Jules Verhagen

*/

class WaterSegment {
  static final float mass = 1000f;
  static final float springConstant = .1f;
  static final float dampingConstant = 10f;
  static final float bottomOffset = 100;

  float radius;
  float force;
  float collisionForce;
  float velocity;
  float displacement;


  WaterSegment(float displacentStart) {
    displacement = displacentStart;
  }

  void update(WaterSegment prev, WaterSegment next) {

    float spring =  -displacement / springConstant;
    float damping = -velocity* dampingConstant;
    force = spring + damping + collisionForce;

    if (prev != null)
      velocity -= prev.force / mass / 2f;
    if (next != null)
      velocity -= next.force / mass / 2f;

    velocity += force / mass;
    displacement += velocity;

    collisionForce = 0;
  }

  void collide(PVector pos, Particle c) {
    PVector toObject = PVector.sub(c.getPosition(),
      pos.copy().add(new PVector(0, -displacement)));
    float distance = toObject.mag();

    if (distance < c.getRadius() + radius) {
      if (c instanceof Bubble) {
        collisionForce += c.getVelocity().y * c.getMass();
        c.applyForce(new PVector(0,collisionForce));
      }
    }
  }

  void display(float interval, int index, WaterSegment prev) {
    noStroke();
    fill(0x7F3735A5);
    quad((interval*(index-1)), -prev.displacement,
      (interval * index), -displacement,
      (interval * index), bottomOffset,
      (interval*(index-1)), bottomOffset);

    stroke(0xFF6A9FAD);
    line((interval*(index-1)), -prev.displacement,
      (interval * index), -displacement);
  }
}
