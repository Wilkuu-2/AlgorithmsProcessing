
/*

assignment 1.2: Write a program that gives as result the sum of all multiples of 5 below 1000
Copyright 2022 Jakub Stachurski and Jules Verhagen

*/
void draw(){
  int sum5=0;

  for (int i=0; i<1000; i+=5) {// basic loop of 1000, and will multiply for 5 
    sum5 +=i;
    println("n of 5= ", i, "sum = ", sum5);
  }
  noLoop();
}
