class Flame {

  float increment  = 0.005;
  float xoffset = 1;
  float yoffset = 2;
  int num =10;

  float wind;
  Flame () {
  }



  void heightUpdate() {






    float y= noise(yoffset)*height;
    float x= noise(xoffset)*width;
   
    stroke(50);
    xoffset +=  increment ;
    yoffset +=  increment ;
    stroke(255);
    fill(255, 142, 0);
    bezier(x, y, 60, 600, 370, 600, x, y); //flame modlel
    //}
println(xoffset);
    //xoffset += 0.001;
  }
}
