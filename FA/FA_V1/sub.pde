class Sub {
 
  float subSize=70, maxSpeed = 12;
  PVector subPosition, subSpeed;
  Sub() {
    subPosition= new PVector(width/2, height/2);
    subSpeed= new PVector(random(1), random(1.3));
  }
  void run() {

    update();
    displaySub();
  }
  void update() {
    // Bounce 
    if ( subPosition.x -subSize<width/12f)  subSpeed.x = abs(subSpeed.x) ;
    if ( subPosition.y -subSize<height/8f)  subSpeed.y = abs(subSpeed.y) ;
    if (subPosition.x +subSize>width-width/12f) subSpeed.x = -abs(subSpeed.x);
    if (subPosition.y +subSize>height-height/10f )  subSpeed.y = -abs(subSpeed.y) ;

    //--------------------------------object update-----------------
    subPosition.add(subSpeed);
      if (subSpeed.magSq()>maxSpeed*maxSpeed) {
      subSpeed.setMag(maxSpeed);
    }




  }
  void displaySub() {
    //--------------------display sub-----------------

    stroke(0);
    //circle(subPosition.x, subPosition.y, objSize);
    fill(255, 238, 0);
    ellipse(subPosition.x, subPosition.y-subSize/4, subSize/3, subSize/5);
    ellipse(subPosition.x, subPosition.y, subSize, subSize/2);

    fill(#00c2f3);
    circle(subPosition.x-subSize/3, subPosition.y, subSize/6);
    circle(subPosition.x+subSize/3, subPosition.y, subSize/6);
    circle(subPosition.x, subPosition.y, subSize/6);
  }
}
