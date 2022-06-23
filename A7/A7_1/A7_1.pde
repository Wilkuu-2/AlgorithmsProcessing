/*
  7.1 Structure
 A ground-up and object oriented version of 3.1 with the addition of a wall
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

// -- CONSTANTS

final static float GRAVITY  = 2f;
final static PVector VA_GRAVITY = new PVector(0, GRAVITY);
final static boolean HAS_GRAVITY = true;

final static boolean BOUNCE = true;
final static boolean DELETE_ON_OUT = false;
final static boolean DELETE_WHEN_STUCK = true;
final static boolean FADE_OLD_IMPRINTS = true;

final static int FADE_DELAY = 100;

final static float PROJ_DENSITY = 0.2;
final static float FRICTION_MULT = 0.02f;
final static float WALL_FRICTION_MULT = 0.08f;
final static float CATAPULT_FORCE_MULT = 200;



// -- GLOBALS

SlingshotAndWall sling;
PVector mousePos = new PVector(mouseX, mouseY);


// -- INIT
void setup() {
  size(800, 800, P2D);
  Wall wall = new Wall(new PVector(width-500, height*0.3),
    new PVector(300, height*0.7),
    color(150, 150, 150),
    color(100, 10, 10));

  sling = new SlingshotAndWall(300, height/2, wall);
}


// -- Every Frame
void draw() {
  background(255);

  sling.update();
  sling.display();


  // Projectile on the mouse
  if (mousePressed && PVector.dist(sling.VPos, mousePos) > 40) {
    PVector slingPos = sling.getPosition();
    stroke(color(10, 10, 100));
    strokeWeight(4);
    line(slingPos.x, slingPos.y, mouseX, mouseY);
    noStroke();


    fill(color(100, 10, 10));
    circle(mouseX, mouseY, 40);
  }

  fill(color(10, 100, 20));
  circle(sling.VPos.x, sling.VPos.y, 20);
}

// -- Callbacks
void mouseMoved() {
  // This vector is updated andused for spawning the projectiles
  mousePos.x = mouseX;
  mousePos.y = mouseY;
}

void mouseDragged() {
  // This vector is updated andused for spawning the projectiles
  mousePos.x = mouseX;
  mousePos.y = mouseY;
 }

void mouseReleased() {
  if (PVector.dist(sling.VPos, mousePos) > 40) 
    sling.spawn(mousePos);
  
}

void keyPressed() {
  if (key == ' ')
    sling.resetWall();
}

// -- Misc
static boolean circleInRectCollision(PVector cPos, float cRad, PVector rectPos, PVector rectSize) {
  // Use the circle as the point of referrence
  PVector nRectPos = PVector.sub(rectPos, cPos);
  PVector closestPoint = new PVector(0, 0);

  // Getting the x dimension of the closest point on the rectangle
  if (nRectPos.x > 0) {
    closestPoint.x = nRectPos.x;
  } else if (nRectPos.x > -rectSize.x) {
    closestPoint.x = 0; // Circle is on the same x - interval as the rectangle
  } else {
    closestPoint.x = nRectPos.x + rectSize.x;
  }

  // Getting the y dimension of the closest point on the rectangle
  if (nRectPos.y > 0) {
    closestPoint.y = nRectPos.y;
  } else if (nRectPos.y > -rectSize.y) {
    closestPoint.y = 0; // Circle is on the same y - interval as the rectangle
  } else {
    closestPoint.y = nRectPos.y + rectSize.y;
  }

  boolean result = closestPoint.mag() < cRad;
  return result;
}
