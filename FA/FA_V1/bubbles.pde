class Bubbles {
PVector locationB;


  Bubbles() {
    locationB=new PVector(0,0,0);
  }
  
  void display(){
  
  circle(locationB.x,locationB.y,locationB.z);
  }
  
}
