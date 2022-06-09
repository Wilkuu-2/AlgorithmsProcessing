/*
   Fish
    Sample text
    
    Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/
class Fish extends SimObject{
  
  Fish(PVector pos, int team, Force[] forces){
    super(pos,team,forces);
    
    speed = new PVector(random(-1,1),random(-1,1));
    
    mass = 7f;
    rad = 5f;
  }
  
  void update(ArrayList<SimObject> others){
    PVector acceleration = new PVector(0,0);
 
    for(Force f : forces){
      acceleration.add(f.getForce(this,others));
     
    }
    
    acceleration.div(mass);
    
    speed.add(acceleration);
    speed.limit(maxSpeed);
    
    // Rebound with double speed
    
    if(position.x < 0)
      speed.x = abs(speed.x) * 2;
    if(position.y < 0)
      speed.y = abs(speed.y) * 2;
    
    if(position.x > width)
      speed.x = -abs(speed.x) * 2;
    if(position.y > height)
      speed.y = -abs(speed.y) * 2;
      
      
    position.add(speed);
  }
  
  void display(){
    pushMatrix();
    translate(position.x,position.y);
    scale(rad);
    rotate(speed.heading());
    fill(teamColors[team]);
    noStroke();
    triangle(-1f,-0.5,
             -1f,0.5,
              1f, 0f);
    popMatrix();
  
  }
  
  
  

} 
