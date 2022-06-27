class Fish {
  PVector position, speed, acceleration;
  PVector toTarget, accelerationToTarget;
  float maxSpeed=5;
  float x=width/2, y=height/2;
  float objSize=50;
  float mouseForce;
  PVector objPosition;
  Fish(PVector _position) {
    position = new PVector(0, 0);
    speed = new PVector(random(1), random(1));
    acceleration = new PVector(0, 0);
    objPosition= new PVector(width/2, height/2);
    position=_position;
  }

  void run(ArrayList<Fish> allfishes) {
    bounce();
    update(fishs);
    display();
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);

    float angle= atan2(speed.y, speed.x);
    rotate(angle);
    fill(4, 4, 4);
    stroke(0);
    circle(0, 0, 3);
    popMatrix();

    circle(objPosition.x, objPosition.y, objSize);
  }
  //-------------------------border-----------------------
  void bounce() {//if the ball hits the edges then changes direction
    if ( position.x<20)  speed.x = abs(speed.x) * 2;
    if ( position.y<20)  speed.y = abs(speed.y) * 2;
    if (position.x>width-20 ) speed.x = -abs(speed.x) * 2;
    if (position.y>height-20 )  speed.y = -abs(speed.y) * 2;
  }
  void update(ArrayList<Fish> allFishs) {
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

    //float avoidObj =2;//radius that the flock will avoid
    //PVector objVector = PVector.sub(objPosition, position);
    //float squareDistanceObj=objVector.magSq();
    //if (squareDistanceObj<objSize*objSize) {
    //  float objAvoid=map(squareDistanceObj, 0, objSize*objSize, avoidObj, 0);
    //  acceleration.add(objVector.setMag(-avoidObj));
    //}
    ///-----------------------------atraction objects----------------

    float avoidObj =2;//radius that the flock will avoid
    PVector objVector = PVector.sub(objPosition, position);
    float squareDistanceObj=objVector.magSq();
    if (squareDistanceObj<objSize*objSize) {
      float objAvoid=map(squareDistanceObj, 0, objSize*objSize, avoidObj, 0);
      acceleration.sub(objVector.setMag(-avoidObj));
    }
    //----------------------------seperation---------------------------
    float unitRadius=10;
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
    float alignmentRadius=40;
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
