

ArrayList <Segments> seg;
void setup() {
  size(500, 500);
  seg = new ArrayList <Segments>();
  seg.add(new Segments ());
}
void draw() {
  background(255);
  seg.run();
}
