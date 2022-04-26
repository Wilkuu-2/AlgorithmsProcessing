void draw() {

  char binary[]={'1', '1', '0', '1', '0', '1'};
  ;
  printBinary(binary);
  noLoop();
}

int charToInt(char c) {
  if (c == '1')
    return 1;
  return 0;
}

void printBinary( char[] binary) {
  int deci=0;
  int sum=0;
  for (int i = binary.length -1 ; i >= 0 ;i--) {
    int bin = charToInt(binary[i]);
    //print(bi
    deci=bin * int(pow(2,binary.length-i-1));
    println(deci, "=", binary[i], "*2^(", i, ")");
    sum +=deci;
    // fill in the loop
    println("the total value =",sum);
  }
  println();
  // fill in the loop
}
