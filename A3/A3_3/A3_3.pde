int num=500;
Rain[] rain= new Rain[num];

void setup(){
  size (500,500);
  
  for(int i=0; i<rain.length;i++){
  rain[i]= new Rain();
  }

}


void draw(){
  background(60,155);
   for(int i=0; i<rain.length;i++){
  rain[i].show();
  rain[i].fall();
  }
  
  
}
