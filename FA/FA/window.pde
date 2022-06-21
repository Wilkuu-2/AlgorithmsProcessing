class Window{
float s;
Window(float scale){
  s=scale;
}

void display(){

//fill(255);
//rect(s/2,s/2*1.1,s,s/2*1.1,10);
//fill(255,0,0);
//rect(s/2*1.1,s/2*1.1,s*0.9,s/2,10);
//fill(255,0,255);
//rect(s/3,s,s+s/3,s/9,9);

pushMatrix();
noStroke();
translate(width/2,height/2);

//---------------window----------
fill(216,157,80);
rect(-s,-s,width,s/30,5);
rect(-s,-s,s/30,height/2,5);
rect(-s,0,width,s/30,5);
rect(s-s/40,-s,s/30,height/2,5);

//--------------wall----------------------
fill(80,198,216);
rect(-s,0+s/30,width,height);

fill(255);
//---------------aquarium----------
rect(-s/2,-s/2,s,s,10);
fill(199, 219, 255,155);
rect(-s/2*1.1,-s/2,s*1.1,s*1.1,10);
//---------------desk-------------
fill(225,75,34,155);
rect(-s*0.8,s/2*1.2,s*1.6,s,10);
//----------------vase------------
fill(#F5F5DC);
rect(-s/1.3,s/3.7,s/6,s/3);
rect(-s/1.3,s/7,s/6,s/3);
circle(-s/1.35,s/5.3,s/10);
circle(-s/1.6,s/5.3,s/10);

popMatrix();
}

}
