void draw() {

  char [] bit={'0', '1'};
  for (int i=0; i<2; i++) {
    for (int j=0; j<2; j++) {
      for (int p=0; p<2; p++) {
        println(bit[i],bit[j],bit[p]);
      }
    }
  }
  noLoop();
}