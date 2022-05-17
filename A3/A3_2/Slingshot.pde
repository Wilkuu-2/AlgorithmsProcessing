/*
  Slingshot
    A container for Projectile Objects that launches them depending on their position 
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/



class Slingshot{
  final PVector VPos;
  
  final ArrayList<Projectile> children;
  
  Slingshot(float posX, float posY){
    VPos = new PVector(posX,posY);
    children = new ArrayList<Projectile>();
  }
  
  void update(){
    println("UPDATING ", children.size(),  " PROJECTILES");
    for(Projectile p : children){
      p.update(); 
    }
    
    children.removeIf(p -> p.deleteMe); //Remove all projectiles if deleteMe is true 
  }
  
  void display(){
    for(Projectile p : children){
      p.display();
    }
  
  }
  
  void spawn(PVector InitPos){
    children.add(new Projectile(InitPos.copy(),PVector.sub(VPos.copy(),InitPos.copy()).mult(CATAPULT_SPEED_MULT),random(10,50),true));
  }

  
}
