//v1 = new PVector(noise(xVector)*width, noise(yVector)*height);

class landscape {
  float x=0;
  float y=0;
  float f;
  PVector v1;

  landscape(float xPos) { //constructor this defines the made atributes. en je maakt twee variable aan
    x=xPos; //haalt de ingevoerde x op van de andere  tablat. de init x is een parameter.
    f = noise(yoff)*height;
    yoff += yincrement;
  }

  void display() { 
    
    //maak zelf een naam aan om alle variables ook zichtbaar te maken. dit is de method. je add een bahaviour
    
    fill(0, 255, 0);
    rect(x, height, 1, -f);
    x=x-10;
  }
}
