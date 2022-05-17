class Rain {
  float rainX, rainY;
  float size;
  PVector position, speed, acc;
  float xoff=0;


  Rain(float s) {
    position = new PVector(random(-width, width), random(-height*2, -100)); // creating the rain dropps in a random position 
    speed = new PVector(0, random(0, 5)); //eatch dropp of water will have a different speed 
    acc = new PVector(0, 0); 
    acc.y=0.05;
    size=s;
  }

  void rainMovement() {


    acc.x=(noise(xoff, position.y/200, position.x/200))*0.1;
    acc.x*=noise(xoff/10+1000)>0.5?-1:1; //divide the  xoff to change the frequenzy of it
    speed.add(acc);
    xoff+=0.1;
    position.add(speed);






    if (position.y>height) { //if the rain drop hits the bottom then it spawns again at the top 
      position = new PVector(random(-width, width), random(-height*2, -100));

      acc=new PVector(0, 0.1); // resets the acceleration 
      speed =new PVector(0, random(0, 5)); // reset the speed 
    }
  }

  void rain() {
    fill(0, 155, 255);
    stroke(0, 0, 0);
    circle(position.x, position.y, size);
  }
}
