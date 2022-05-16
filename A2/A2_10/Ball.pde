/*
  Ball 


  Copyright 2022 Jakub Stachurski and Jules Verhagen 
*/


class Ball{
  PVector position;
  PVector speed;
  float radius;


  Ball(PVector x, PVector v, float r){
    position = x.copy(); 
    speed = v.copy();
    radius = r; 
  }
    

}
