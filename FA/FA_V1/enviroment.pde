class Enviroment {

  int num=2000;
  PVector[]sand=new PVector[num];
  PImage vase;

  Enviroment( ) {


    for (int i=0; i<sand.length; i++) {
      sand[i]=new PVector(random(width/15, width-width/15), random(height-height/10, height-height/13), int(random(1, 4)));
      println(sand[i].z);
    }

    vase=loadImage("vase.png");
  }



  void display() {
    objects();
  }



  void objects() {
    noStroke();
    //---------------aquarium glime------------------
    fill(169, 213, 255, 155);
    rect(width/20, height/20, width-width*2/20, height-height*2/20, 10);

    //----------------sand---------------------
    for (int i=0; i<sand.length; i++) {
      if (sand[i].z==1) {
        fill(#AFAE9F);
      }
      if (sand[i].z==2) {
        fill(#DED99A);
      }
      if (sand[i].z==3) {
        fill(#EEE357);
      }
      if (sand[i].z==4) {
        fill(#E8DC3D);
      }
      circle(sand[i].x, sand[i].y, width/200);
    }

    //------------------vase-------------
    vase.resize(width/6, width/6);
    image(vase, width/10, height-height/2.9);
    //----------------aquarium glass--------------
    fill(125, 191, 255, 90);
    rect(width/16, height/20, width-width*2/16, height-height*2/16, 10);

    //--------------------desk-------------------
    fill(198, 162, 126);
    rect(0, height-height/20, width, height);
  }
}
