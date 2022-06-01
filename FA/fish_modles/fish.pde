class Fish {
  PVector location;
  float r, counter;
  Fish() {
    location = new PVector(width/2, height/2);
    r = 20;
  }


  void display() {


    float theta=radians(counter);
    fill(200, 100);
    stroke(255);
    pushMatrix();

    translate(location.x, location.y);
    fill(255);
    rotate(theta);



    beginShape(TRIANGLES);
    vertex(0, -r);
    vertex(-r, r);
    vertex(r, r);
    endShape();
    beginShape(TRIANGLES);
    vertex(-r, r);
    vertex(-r*2, r*3);
    vertex(r*0.5, r*3);
    endShape();
    beginShape(TRIANGLES);
    vertex(r, r);
    vertex(r*2, r*3);
    vertex(-r*0.5, r*3);
    endShape();
    beginShape(TRIANGLES);
    vertex(0, r*3);
    vertex(-r*1.75, r*5);
    vertex(r*1.75, r*5);

    endShape();
    fill(0);
    noStroke();
    circle(0, 1, r);
    popMatrix();
  }
  void increse() {


    if (counter<360) {
      counter++;
    } else {
      counter=0;
    }
  }
}
