/*
  Fish Container
    Sample text
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/


class SimObjectContainer {
  private ArrayList<SimObject> objects; 
  Force[] fishForces = new Force[]{new Separation(4f) ,new Cohesion(2f), new Alignment(6f), new Repellance(6f)}; 
  
  SimObjectContainer() {
    objects = new ArrayList<SimObject>(100); 
  }
  
  void update(){
    objects.forEach(f -> f.update(objects));
  }
  void display(){
    objects.forEach(f -> f.display());
  }
  
  void addObject(SimObject obj){
    objects.add(obj);
  }
  
  void spawnFish(float x, float y, int t){
    objects.add(new Fish(new PVector(x,y), t, fishForces));
  }
  
  void spawnFish(int n){
    for(int i = 0;  i < n ; i++)
      objects.add(new Fish(new PVector(width/2 + random(-100,100),height/2 + random(-100,100)),0, fishForces));
  }
  
  void spawnObstacle(PVector pos){
    objects.add(new Obstruction(pos,random(10,100)));
  }
}
