
/*
  Projectile
 A round 2D ridgid body with mass that simulates:
 Air Resistance
 Gravity
 Other Forces
 
 You can spawn it with a custom position, speed, and radius, the mass is determined by global density.
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */



class Projectile {
  public static final int traceDelay = 128;

  private PVector VPos;
  private PVector VSpeed;
  private PVector lastPosition = null;
  public boolean deleteMe = false;
  private boolean isOOB = false;
  private float radius;
  private float mass;
  private ArrayList<PVector> trace;
  private long msCounter;

  // -- Constructor
  Projectile(PVector initPos, PVector initForce, float radius) {
    this.radius = radius;
    mass = PI * pow(radius, 2) * PROJ_DENSITY;
    VPos = initPos.copy();
    VSpeed = new PVector(0, 0);


    applyForce(initForce);

    msCounter = millis();
    trace = new ArrayList<PVector>();
  }

  // -- State Update
  void update(Wall wall) {
    PVector VTotalFriction = new PVector(0, 0);
    // Add friction to total force
    VTotalFriction.add(VSpeed.copy().mult(-FRICTION_MULT * PI * pow(radius, 2)));

    // Check for wall collision
    if ( circleInRectCollision(VPos, radius, wall.VPos, wall.VSize)) { // This line of code completely disregards visibility 
      // Apply wall friction
      VTotalFriction.add(VSpeed.copy().mult(-WALL_FRICTION_MULT * PI * pow(radius, 2)));
      // Imprint on the wall
      wall.imprint(lastPosition, VPos, radius);
      
      deleteMe = deleteMe || (VSpeed.mag() < 0.1f && DELETE_WHEN_STUCK); // Delete when stuck in the wall
    } else {
      // Add gravity to total force when not inside wall
      if (HAS_GRAVITY)
        applyForce(VA_GRAVITY.copy().mult(mass));
    }

    //Take note of the last position
    lastPosition = VPos.copy();

    // Limit friction as to not make the projectile bounce of it
    VTotalFriction.limit(VSpeed.mag()*mass);
    applyForce(VTotalFriction);
    //println("Update: MASS ", mass , "RADIUS " , radius );
    // Add a trace
    if (msCounter < millis()) {
      trace.add(VPos.copy());
      msCounter = millis() + traceDelay;
    }



    if (BOUNCE) {
      if (VPos.x < 0)
        VSpeed.x = abs(VSpeed.x);
      if (VPos.y < 0)
        VSpeed.y = abs(VSpeed.y);

      if (VPos.x > width)
        VSpeed.x = -abs(VSpeed.x);
      if (VPos.y > height)
        VSpeed.y = -abs(VSpeed.y);

      deleteMe = deleteMe || (VPos.y > (height - radius) &&  VSpeed.mag() < 1f && VSpeed.y < 0);
    } else {
      // Check if out of bounds and if the projectile needs to be deleted from the parent
      isOOB = (VPos.x > width || VPos.y > height || VPos.x < 0 || VPos.y < 0);
      deleteMe = deleteMe || (isOOB && DELETE_ON_OUT);
    }

    // Add speed to position
    VPos.add(VSpeed);
  }

  // Applies force to projectile
  void applyForce(PVector f) {
    VSpeed.add(f.copy().div(mass));
  }

  // -- Drawing
  void display() {
    // Original projectile
    fill(0);
    noStroke();
    circle(VPos.x, VPos.y, radius*2);

    for (int i = trace.size(); i > 0; i--) {
      fill(100, 100, 255);
      circle(trace.get(i-1).x, trace.get(i-1).y, radius*0.4);
    }
  }
}
