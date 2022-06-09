


class Obstruction extends SimObject {

  Obstruction(PVector pos, float rad){
    super(pos, OBSTACLE, new Force[]{});
    this.rad = rad; 
    
  }
  
  void update(ArrayList<SimObject> others){
    
  }
  void display(){
    fill(0xFFFF00FF);
    circle(position.x,position.y,rad*2);
  }
  
  void scale(float scale){
     rad *= scale;
  }

} 
