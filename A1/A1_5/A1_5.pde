
/*Write a program that transforms a binary number, e.g. 110101, represented as a 
string, to its decimal representation which is defined as follows:  
1 * 25 + 1 * 24 + 0 * 23 + 1 * 22 + 0 * 21 + 1 = 53 decimal. 

Copyright 2022 Jakub Stachurski and Jules Verhagen*/

void draw() {

  char binary[]={'1', '1', '0', '1', '0', '1'}; // inputt of the bynary 
  ;
  printBinary(binary);
  noLoop();
}

int charToInt(char c) { //will print only 1 or 0 
  if (c == '1')
    return 1;
  return 0;
}

void printBinary( char[] binary) {
  int deci=0;
  int sum=0;
  for (int i = binary.length -1 ; i >= 0 ;i--) { // writest the binary backwards then it calculates it 
    int bin = charToInt(binary[i]);
    
    deci=bin * int(pow(2,binary.length-i-1));
    println(deci, "=", binary[i], "*2^(", i, ")");
    sum +=deci;
    println("the total value =",sum);
  }
  println();
}
