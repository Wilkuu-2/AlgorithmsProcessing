class Enviroment {

  Enviroment() {
   
  }



  void display() {
    noStroke();
    
    //---------------background----------------
    fill(255);
    rect(0,0,width,height);
    //---------------picture-------------------
    fill(198, 162, 126);
    rect(width/4,height/2,width/6,height/3,10);
    fill(255);
    rect(width/4+width/40,height/2+height/40,width/6-width/40,width/3+height/40,10);
    //---------------aquarium------------------
    fill(125, 191, 255, 155);
    rect(width/16, height/20, width-width*2/16, height-height*2/16, 10);
    fill(169, 213, 255, 155);
    rect(width/20, height/20, width-width*2/20, height-height*2/20, 10);

    //--------------------desk-------------------
    fill(198, 162, 126);
    rect(0, height-height/20, width, height);
  }
}
