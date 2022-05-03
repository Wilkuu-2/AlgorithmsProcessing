/*
  1.7 Combinations
      This algorithm leverages on the fact that if you map each item to it's own bit, each number that fits into that mapping will be each own combination.
      It iterates over all numbers beneath and including 0b111100000 (example) where the amount of 1's is the sample size and the total amount of bits is the amount of objects
      
      Estimated complexity O((2^N-2^(N-S))-1)*N)
      Maximal nesting: 2 nested loops 
      Max object count: 31
      
 
 Copyright 2022 Jakub Stachurski and Jules Verhagen
 */

// -- INIT
 public void start() {
}

// Brian Kernighan Algorithm
// Source: https://iq.opengenus.org/number-of-set-bits/
 public int getSetBits(int N) {
  int C = 0;
  while (N != 0) {
    N = N & (N-1);
    C++;
  }
  return C;
}


 public void printAsBin(IntList in, int L) {
  for (int i : in) {
    println(String.format("%" + L + "s", Integer.toBinaryString(i)).replace(' ', '0'));
  }
}

 public ArrayList<int[]> mapToNumbers(IntList in, int L,int sample) {
  ArrayList<int[]> out = new ArrayList<int[]>();
  for (int n : in) {
    int arrPos = 0; 
    int[] arr = new int[sample];
    for (int i = 0; i < L; i++) {
      if (((n >> i) & 1) == 1){
        arr[arrPos] = i; 
        arrPos ++;
      }
    }
   out.add(arr);
  }
  return out; 
}

 public void printMapped(ArrayList<int[]> mapped){
  for(int[] list : mapped){
    print("L:");
    for(int n: list){
      print(","+ n);
    }
    println("");
  }
}
// -- The actual algorithm 
 public IntList binaryCountFilteredCombinations(int objects, int sample ){
  // Compressed output
  IntList compressedCombinations = new IntList();

  int arrayMask = 0; //Sets first [objects] bits to 1
  for (int i = 0; i < objects; i++)
    arrayMask += 1 << i;

  // gets the last compressed combination by leaving last [sample] bits set while setting the rest to 0
  int maxJ = (arrayMask >> (objects-sample) << (objects-sample));

  // Combs through the numbers to get those with [sample] bits set
  for (int j = 0; j <= maxJ; j++) {
    if (getSetBits(j) == sample)
      compressedCombinations.append(j);
  }
  return compressedCombinations; 

}

 public void draw() {
  int objects = 9, sample = 4; 
  IntList compressedCombinations = binaryCountFilteredCombinations(objects, sample);
  
  println("012345678");
  println("_________");
  printAsBin(compressedCombinations, objects);
  //println(CompressedCombinations);
  print("_________\nSize = ");
  println(compressedCombinations.size());
  
  ArrayList<int[]> combinations = mapToNumbers(compressedCombinations,objects,sample);
  printMapped(combinations);
  println("Size: "+combinations.size());
  
  
  noLoop();
}
