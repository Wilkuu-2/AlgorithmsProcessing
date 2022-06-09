

final int OBSTACLE = -127; 
final int ATTRACTOR = -128; 

abstract class SimObject {
  Force[] forces; 
  PVector position, speed; 
  int team;  
  float mass, rad;
  float maxSpeed        = 4f;
  float maxForce        = 0.8f;
  
  
  SimObject(PVector pos, int team, Force[] forces){
     position = pos; 
     this.team = team; 
     this.forces = forces; 
  }
  
  abstract void update(ArrayList<SimObject> others);
  abstract void display();

}
