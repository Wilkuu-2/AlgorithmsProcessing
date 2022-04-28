void draw() {
  long num = 317584931803L ;
  long i;
  for ( i = 2; i <= num / 2; i++) {
    if (num % i == 0) {
      println("yes");
      break;
    }
  }
  println("the number is divisible by ",i);
  noLoop();
}
