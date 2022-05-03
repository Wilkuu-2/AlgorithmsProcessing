/*
assignment 1.3: Write a program that gives as result the sum of all multiples of 3 and 5 below 1000. 
Note that numbers that are multiples of 3 and 5 at the same time should not be counted 
twice. 
Copyright 2022 Jakub Stachurski and Jules Verhagen
*/

void draw() {
  int sum3=0;
  int sum5=0;

  for (int i=0; i<1000; i+=3) { 

    if (i%5==0) { // checks that no multiple of 5 will be summed up 
    } else {
      sum3 +=i;
      println("n of 3= ", i, "sum = ", sum3);
    }
    
  }
  for (int i=0; i<1000; i+=5) {
     if (i%3==0) {// checks that no multiple of 3 will be summed up
    } else {
      sum5 +=i;
      println("n of 5= ", i, "sum = ", sum5);
    }
  }
  
  println("total sum of multiple of 3 and 5 is = ",sum3+sum5);
  
  noLoop();
}
