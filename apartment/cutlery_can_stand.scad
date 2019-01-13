h=10;
d=73;
w=1.5;

difference() {
  linear_extrude(h) {
    circle(d=(d + 2 * w), $fn=200);
  }
  translate([0, 0, w]) {
    linear_extrude(h - w) {
      circle(d=d, $fn=200);
    }
  }
}
