int MAX_CONFETTI = 30;
float SPEEDMULT = 1;
class Confetties {

  //this makes an array of 30 confettis
  Confetti[] confetti = new Confetti[MAX_CONFETTI];
  // number of confettis that is created already
  int generated;

  Confetties() {
    // for this example the constructor is indeed empty,
    // as all confetties are created dynamically...
  }

  void update() {
    // collision detection: this is not in the no bouncing version
    for (int k=0; k<generated-1; k++) {   
      for (int l=k+1; l<generated; l++) { 
        collide( confetti[k], confetti[l]);
      }
    }
    
    // movement
    for (int k=0; k<generated; k++) {
      confetti[k].update();
    }
  }

  void render() {
    for (int k=0; k<generated; k++) {
      confetti[k].render();
    }
  }

   void collide(Confetti c1, Confetti c2) {
     PVector centers  = PVector.sub(c1.position,c2.position);
     float dist = centers.mag();
     PVector centersNorm = centers.normalize();
     if(dist < c1.radius + c2.radius){
       
       // Speed calculation without mass (same mass)):
   
       PVector c2Speed = PVector.mult(centersNorm,
                         PVector.dot(c1.speed.copy(),centers.copy()));
                         
       PVector c1SpeedTemp = PVector.sub(c1.speed.copy(),c2Speed.copy());
       
       //Invert the centers vector, since we are swithcing to the other confetti
       centersNorm = PVector.mult(centersNorm,-1f);
       centers = PVector.mult(centers,-1f);
       
       PVector c1Speed = PVector.mult(centersNorm,
                         PVector.dot(c2.speed.copy(),centers.copy()));
                         
                         
        //Apply the prev speed to get them unstuck 
       c1.position.add(PVector.mult(c1.speed,-1));
       c2.position.add(PVector.mult(c2.speed,-1));           
              
       // Apply new speed
       c2.speed = PVector.add(c2Speed.copy(),
                   PVector.sub(c2.speed.copy(),c1Speed.copy()));
       c1.speed = PVector.add(c1Speed, c1SpeedTemp);

       
       // Set the speeds to the confettis
       
      
       

     }
  }

  void  mousePressedEvent() {
    // a new confetti is only created here!
    if ( generated < MAX_CONFETTI) {
      Confetti newCandidate = new Confetti();
      // I do not want to create overlapping Confettis, does not look nice
      boolean addThisConfetti = true;
      for (int i = 0; i<generated; i++) {
        if (PVector.dist(confetti[i].position, newCandidate.position) < (confetti[i].radius + newCandidate.radius)) {
          addThisConfetti = false;
        };
      };
      if (addThisConfetti) {
        confetti[generated] = newCandidate;
        generated++;
      }
    };
  }
  
}
