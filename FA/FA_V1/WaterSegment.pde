/*
  WaterSegment
 
 A singular segment of the water surface
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 
 */

class WaterSegment {
  static final float mass = 1000f;
  static final float springConstant = .1f;
  static final float dampingConstant = 15f;
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
    // Forces
    float spring =  -displacement / springConstant;
    float damping = -velocity* dampingConstant;
    force = spring + damping + collisionForce;

    // Newtons second law
    float forceDivisor = (prev != null && next != null) ? 2f : 1f;
    if (prev != null) {
      velocity -= prev.force / mass / forceDivisor;
    }
    if (next != null) {
      velocity -= next.force / mass / forceDivisor;
    }
    
    // Apply force then velocity
    velocity += force / mass;
    displacement += velocity;
    
    // Reset force from collision for the next frame
    collisionForce = 0;
  }
  
  // Collide with particles 
  void collide(PVector pos, Particle c) {
    PVector toObject = PVector.sub(c.getPosition(),
      pos.copy().add(new PVector(0, -displacement)));
    float distance = toObject.mag();

    if (distance < c.getRadius() + radius) {
      //Bubble lowers the displacement since the bubble is air
      if (c instanceof Bubble) {
        collisionForce += c.getVelocity().y * c.getMass();
        c.applyForce(new PVector(0, collisionForce));
      // Pellet should change trajectories when entering a different material (WATER)
      } else if ( c instanceof Pellet) {
        collisionForce += c.getVelocity().y * c.getMass();
        c.applyForce(new PVector(0, -0.01 * collisionForce));
        c.applyConstantForce(new PVector(0, -0.05)); // Buoyancy
        c.FRICTION_COEFF = 20f;
        c.ROT_FRICTION = 0.10f;
      }
    }
  }

  // Collide with the fish
  void collide(PVector pos, Fish f) {
    PVector toObject = PVector.sub(f.position,
      pos.copy().add(new PVector(0, -displacement)));
    float distance = toObject.mag();

    if (distance < f.r + radius) {
      collisionForce += f.speed.y * 100f;
    }
  }

  
  // Display the line between the previous segment and this segment and the water under that line;
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
