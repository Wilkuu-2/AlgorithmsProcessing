

void draw() {
  int counter=0;
  int sum3=0;
  int sum5=0;

  for (int i=0; i<1000; i+=3) {

    if (counter==5) {
      counter=0;
    } else {
      sum3 +=i;
      println("n of 3= ", i, "sum = ", sum3,"counter = ",counter);
    }
    counter+=1;
  }
  for (int i=0; i<1000; i+=5) {
    sum5 +=i;
    println("n of 5= ", i, "sum = ", sum5);
  }
  
  println("total sum of multiple of 3 and 5 is = ",sum3+sum5);
  
  noLoop();
}
