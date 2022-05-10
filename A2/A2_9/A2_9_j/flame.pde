class Flame {

  float increment  = 0.005;
  float xoffset = 1;
  float yoffset = 2;
  int num =10;

  float wind;
  Flame () {
  }



  void heightUpdate() {







    //for (int i=0; i<num; i++) { //Iterate over array

    float y= noise(yoffset)*height;
    float x= noise(xoffset)*height;
   
    stroke(50);
    xoffset +=  increment ;
    yoffset +=  increment ;
    stroke(255);
    fill(255, 142, 0);
    //circle(int(noise(wind)*height/5), (i+3)+200, 90-log(height-i));
    bezier(x, y, 60, 600, 370, 600, x, y);
    //}
println(xoffset);
    //xoffset += 0.001;
  }
}
