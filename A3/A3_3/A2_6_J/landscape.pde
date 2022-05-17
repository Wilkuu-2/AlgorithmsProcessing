class Landscape {

  float xincrement = 0.01, yincrement=0.3;
  float xoffset = 0, yoffset=0;
  int num =int(width);
  float xball, yball, xspeed, yspeed;
  PVector position, speed;

  Landscape () {
    position =new PVector(xball, yball);
    speed =new PVector(xspeed, yspeed);
  }



  void heightUpdate() {

    for (int i=0; i<num; i++) { //Iterate over array


      stroke(0, 255, 0);
      position.x=i*xincrement+xoffset;
      position.y=i*yincrement+yoffset;

      circle(int(noise(position.x)*width), int(noise(position.y)*width/2), 20);
      println(int(noise(position.x)*width/2));
    }


    xoffset += 0.05;
    yoffset +=0.6;
  }
}
