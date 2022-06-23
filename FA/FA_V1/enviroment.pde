class Enviroment {

  int sandCount=2000;
  float sandDensity= 0.5;
  PVector[]sand=new PVector[sandCount];
  color[] sandColors = {#AFAE9F, #DED99A, #EEE357,#CFCE6F,#E8DC3D,#DED99A};
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
    PVector sandPos = new PVector(width/15, height-height/6);
    PVector sandSize = new PVector(width-width/7.5, height * (1f/6f - 1f/13f));
    loadPixels();
    for (float i=0; i<sandSize.x; i += sandDensity) {
      for (float j=0; j<sandSize.y; j += sandDensity) {
        float z = noise(i*0.1f,j*0.2f) * (sandColors.length -1) ;

        fill(sandColors[round(z)]);
        set(round(sandPos.x + i + noise(0,i,j) * sandDensity),
            round(sandPos.y + j + noise(0,j,i) * sandDensity),
            sandColors[round(z)]);
  
      }
    }
    
    updatePixels();


    //------------------vase-------------
    float ARatio = vase.width/ vase.height;

    image(vase, width/10, height-height/3.2, ARatio * height/4, height/4);
    //----------------aquarium glass--------------
    fill(125, 191, 255, 90);
    rect(width/16, height/20, width-width*2/16, height-height*2/16, 10);

    //--------------------desk-------------------
    fill(198, 162, 126);
    rect(0, height-height/20, width, height);
  }
}
