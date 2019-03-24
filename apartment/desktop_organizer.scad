h = 10;
d1 = 73;
d2 = 83.5;
w = 1.5;

module socket(d) {
  difference() {
    linear_extrude(h) {
      circle(d = d + 2 * w, $fn = 200);
    }
    translate([0, 0, w]) {
      linear_extrude(h - w + 1) {
        circle(d = d, $fn = 200);
      }
    }
  }
}

translate([-d1/2 - w, 0, 0]) {
  socket(d1);
}
translate([d2/2 + w, 0, 0]) {
  socket(d2);
}

module bases() {
  translate([-d1/2 - w, 0, 0]) {
    circle(d = d1 + 2*w, $fn = 200);
  }
  translate([d2/2 + w, 0, 0]) {
    circle(d = d2 + 2*w, $fn = 200);
  }
}

difference() {
  linear_extrude(h) {
    hull() {
      bases();
    }
  }
  translate([-d1/2 - w, 0, w]) {
    linear_extrude(h - w + 1) {
      circle(d = d1, $fn = 200);
    }
  }
  translate([d2/2 + w, 0, w]) {
    linear_extrude(h - w + 1) {
      circle(d = d2, $fn = 200);
    }
  }
}
