
void draw(){
  int sum5=0;

  for (int i=0; i<1000; i+=5) {
    sum5 +=i;
    println("n of 5= ", i, "sum = ", sum5);
  }
  noLoop();
}
