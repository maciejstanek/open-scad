a=96;
h=6;
r=4;

linear_extrude(h) {
  minkowski() {
    square(a-2*r);
    circle(r=r,$fn=50);
  }
}
