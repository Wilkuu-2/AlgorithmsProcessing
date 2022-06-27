class Fish {
  PVector position, speed, acceleration;
  PVector toTarget, accelerationToTarget;
  float unitRadius=20;
  int r=2;
  float seperationForce=0.5;
  float alignmentRadius=40;
  float maxSpeed=1.5f;
  float x=width/2, y=height/2;
  float attractionForce;
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
  void display() {
    //------------------display fish----------------
    float theta = speed.heading2D() + radians(90);
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
    if ( position.x<width/12f)  speed.x = abs(speed.x) * 2;
    if ( position.y<height/8f)  speed.y = abs(speed.y) * 2;
    if (position.x>width-width/12f ) speed.x = -abs(speed.x) * 2;
    if (position.y>height-height/10f )  speed.y = -abs(speed.y) * 2;
  }

  void update(ArrayList<Fish> allFishs,ArrayList<Pellet> pellets , Sub sub) {
    bounce();
    acceleration(allFishs,pellets, sub);
    //limit velocity
    //if (speed.mag()>maxSpeed) {// samle line of code but more effitient the one bellow
    if (speed.magSq()>maxSpeed*maxSpeed) {
      speed.setMag(maxSpeed);
    }
    speed.add(acceleration);//acceleration changes the speed
    position.add(speed);//speed changes the position
  }

  void acceleration(ArrayList<Fish> allFishs, ArrayList<Pellet> pellets ,Sub sub) {
    //--------------------flock gose to the position-----------------
    attractionForce=0.15; // force of atractio of flock to the center
    acceleration.set(0, 0);
    toTarget =new PVector(x, y).sub(position);//creates a vector that will atractthe unit to the location placed in the toTarget locations
    accelerationToTarget= toTarget.setMag(attractionForce); //setMag() = set to magnetude so how mutch force is applysed to the target
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
    for (Fish otherFish : allFishs) {
      if (otherFish==this) continue;// cont mistake same
      PVector otherFishVector=PVector.sub(otherFish.position, position);
      float distanceOtherSquared = otherFishVector.magSq();
      if (distanceOtherSquared>unitRadius*unitRadius) continue;    // if its outside radius do nothign
      else {
        PVector repelForce =  otherFishVector.setMag(-seperationForce); //repel force
        acceleration.add(repelForce);
      }
    }
    
    float pelletAttraction = 1.2f;
    PVector avgPelletPosition = new PVector(0,0);
    int pelletAddCount = 0;
    for (Pellet p : pellets){
      if(PVector.dist(p.vPos, position) < 120 + p.radius + r){
        avgPelletPosition.add(p.vPos);
        pelletAddCount ++;
      }
    }
    if(pelletAddCount > 0){
      avgPelletPosition.div(pelletAddCount);
      acceleration.add(avgPelletPosition.sub(position).setMag(pelletAttraction));
    }

    //----------------------------ALIGNMENT---------------------------
    PVector averegeVectorsOthers= new PVector(0, 0);

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
        averegeVectorsOthers.add(otherFish.speed);
      }// will add the forces to align
      if (alignmentOther>0) {
        averegeVectorsOthers.mult(1 /alignmentOther);
        PVector alignForce= averegeVectorsOthers.setMag(forceAlignment);
        acceleration.add(alignForce);
      }
    }
  }
}
