class Landscape {

  float xincrement = 0.01;
  float xoffset = 0;
  int num =int(width);

  Landscape () {
  }



  void heightUpdate() {

    for (int i=0; i<num; i++) { //Iterate over array
      float xVector;

      stroke(0, 255, 0);
      xVector = i * xincrement + xoffset;
      strokeWeight(1);
      fill(255);
      line(i, height, i, int(noise(xVector)*height/2));
    }
    xoffset += 0.05;
  }


  void carModdle() {

    fill(150);
    rect(0,height/2+35,width,50);
    noStroke();
    fill(0, 160, 255);
    rect(width/2+30, 200, 50, 25);
    fill(255, 0, 0);
    rect(width/2, 210, 100, 25);
    fill(70);
    circle(width/2+20,240,25);
    circle(width/2+80,240,25);
    
    
  }
}
