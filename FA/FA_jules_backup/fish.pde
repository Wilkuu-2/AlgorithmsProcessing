class Fish {


  PVector position, speed, acceleration;
  PVector toTarget, accelerationToTarget;
  float maxSpeed=2;
  float x=width/2, y=height/2;
  float mouseForce;
  float red, green, blue;
 
  Fish(PVector _position) {


    position = new PVector(0, 0);
    speed = new PVector(random(1), random(1));
    acceleration = new PVector(0, 0);
    

    position=_position;

    blue= random(0, 255);
    red=random(0, 255);
    green=random(0, 255);
  }


  void run(ArrayList<Fish> allfishes, Sub sub) {
    bounce();
    update(allfishes, sub);
    display();
  }

  void display() {
    //------------------display fish----------------
    float theta = speed.heading2D() + radians(90);
    int r=5;
    fill(200, 100);
    //stroke(255);
    pushMatrix();


    fill(red, green, blue);
    stroke(red, green, blue);
    translate(position.x, position.y);
    //fill(255);
    rotate(theta);

    beginShape(TRIANGLES);
    vertex(0, -r);
    vertex(-r, r);
    vertex(r, r);
    endShape();
    beginShape(TRIANGLES);
    vertex(-r, r);
    vertex(-r*2, r*3);
    vertex(r*0.5, r*3);
    endShape();
    beginShape(TRIANGLES);
    vertex(r, r);
    vertex(r*2, r*3);
    vertex(-r*0.5, r*3);
    endShape();
    beginShape(TRIANGLES);
    vertex(0, r*3);
    vertex(-r*1.75, r*5);
    vertex(r*1.75, r*5);

    endShape();
    fill(0);
    noStroke();
    circle(0, 1, r);
    endShape();

    popMatrix();
  }
  //-------------------------border-----------------------
  void bounce() {//if the ball hits the edges then changes direction
    if ( position.x<width/15)  speed.x = abs(speed.x) * 2;
    if ( position.y<height/15)  speed.y = abs(speed.y) * 2;
    if (position.x>width-width/15 ) speed.x = -abs(speed.x) * 2;
    if (position.y>height-height/15 )  speed.y = -abs(speed.y) * 2;
  }
  void update(ArrayList<Fish> allFishs, Sub sub) {
    acceleration(fishs);



    //limit velocity
    //if (speed.mag()>maxSpeed) {// samle line of code but more effitient the one bellow
    if (speed.magSq()>maxSpeed*maxSpeed) {
      speed.setMag(maxSpeed);
    }
    speed.add(acceleration);//acceleration changes the speed
    position.add(speed);//speed changes the position

  
  }

  void acceleration(ArrayList<Fish> allFishs) {



    //--------------------flock gose to the position-----------------
    mouseForce=0.15; // force of atractio of flock to mouse
    acceleration.set(0, 0);
    toTarget =new PVector(x, y).sub(position);//creates a vector that will atractthe unit to the location placed in the toTarget locations
    accelerationToTarget= toTarget.setMag(mouseForce); //setMag() = set to magnetude so how mutch force is applysed to the target
    acceleration.add(accelerationToTarget);
    ///-----------------------------avoidence objects----------------

    float avoidObj =2;//radius that the flock will avoid
    PVector objVector = PVector.sub(sub.subPosition, position);
    float squareDistanceObj=objVector.magSq();
    if (squareDistanceObj<sub.subSize*sub.subSize) {
      float objAvoid=map(squareDistanceObj, 0, sub.subSize*sub.subSize, avoidObj, 0);
      acceleration.add(objVector.setMag(-avoidObj));
    }


    //----------------------------seperation---------------------------
    float unitRadius=50;
    float seperationForce=0.5;
    for (Fish otherFish : allFishs) {
      if (otherFish==this) continue;// cont mistake same bird
      PVector otherFishVector=PVector.sub(otherFish.position, position);
      float distanceOtherSquared = otherFishVector.magSq();
      if (distanceOtherSquared>unitRadius*unitRadius) continue;    // if its outside radius do nothign
      else {
        PVector repelForce =  otherFishVector.setMag(-seperationForce); //repel force
        acceleration.add(repelForce);
      }
    }

    //----------------------------ALIGNMENT---------------------------
    PVector averegeVectorsOthers= new PVector(0, 0);
    float alignmentRadius=100;
    int alignmentOther=0;
    float forceAlignment=1;
    for (Fish otherFish : allFishs) {
      if (otherFish==this) continue;// wont mistake same bird
      PVector otherFishVector=PVector.sub(otherFish.position, position);
      float distanceOtherSquared = otherFishVector.magSq();
      if (distanceOtherSquared>alignmentRadius*alignmentRadius) continue;    // if its outside radius do nothign
      else {
        //averege force
        ++alignmentOther;
        PVector repelForce =  otherFishVector.setMag(-seperationForce);
        averegeVectorsOthers.add(otherFish.speed);
      }// will add the forces to align
      if (alignmentOther>0) {
        averegeVectorsOthers.mult(1 /alignmentOther);
        PVector alignForce= averegeVectorsOthers.setMag(forceAlignment);
        acceleration.add(alignForce);
      }
    }
  }

  void position() {
    x=mouseX;
    y=mouseY;
  }
}
