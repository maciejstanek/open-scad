scalar = 0.4 * 1.5;
height = 2;
scale([scalar, scalar, height]) {
  intersection() {
    linear_extrude(height = 1) {
      square([100, 100], center = true);
    }
    translate([100, -100, 0]) {
      import("puzzle_orig.stl");
    }
  }
}

