int MAX_CONFETTI = 30;

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

   void collide(Confetti confetti1, Confetti confetti2) {
    // fill in here the code for collision
    // and change speed of the the two confettis after collission.
  }

  void  mousePressedEvent() {
    // a new confetti is only created here!
    if ( generated < MAX_CONFETTI) {
      Confetti newCandidate = new Confetti();
      // I do not want to create overlapping Confettis, does not look nice
      boolean addThisConfetti = true;
      for (int i = 0; i<generated; i++) {
        if (dist(confetti[i].xPos, confetti[i].yPos, newCandidate.xPos, newCandidate.yPos) < (confetti[i].radius + newCandidate.radius)) {
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
