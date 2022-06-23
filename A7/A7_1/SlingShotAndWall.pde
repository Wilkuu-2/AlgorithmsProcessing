/*
  Slingshot
 A container for Projectile Objects that launches them depending on their position
 
 With the addition of the wall it also updates the wall
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

class SlingshotAndWall {
  private final PVector VPos;
  private final ArrayList<Projectile> projectiles;
  private final Wall wall;


  SlingshotAndWall(float posX, float posY, Wall wall) {
    VPos = new PVector(posX, posY);
    projectiles = new ArrayList<Projectile>();
    this.wall = wall;
  }

  void update() {
    //println("UPDATING ", projectiles.size(), " PROJECTILES");
    for (Projectile p : projectiles) {
      p.update(wall);
    }

    projectiles.removeIf(p -> p.deleteMe); //Remove all projectiles if deleteMe is true
    
    wall.update();
  }

  void display() {
    wall.display();
    for (Projectile p : projectiles) {
      p.display();
    }
  }

  void spawn(PVector InitPos) {
    projectiles.add(new Projectile(InitPos.copy(), PVector.sub(VPos.copy(), InitPos.copy()).mult(CATAPULT_FORCE_MULT), random(10, 30)));
  }

  void resetWall() {
    wall.reset();
  }
  
  PVector getPosition(){
    return VPos.copy();
  }
}
