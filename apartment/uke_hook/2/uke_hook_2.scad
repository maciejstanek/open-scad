shelf_thickness = 19;
slit_width = 40;
length = 40;
depth = 100;
thickness = 2.2;

total_height = shelf_thickness + 2*thickness;
total_length = length + depth;
total_width = slit_width + 2*total_height;
hook_radius = total_height;

module h1() {
  translate([0, shelf_thickness / 2]) {
    square([depth, thickness]);
  }
}

linear_extrude(height = total_width) {
  translate([0, -total_height / 2]) rotate(90) square([total_height, thickness]);
  h1();
  mirror([0, 1, 0]) h1();
}

module h2() {
  translate([0, -(hook_radius + slit_width/2)]) {
    intersection() {
      circle(r = hook_radius, $fn = 100);
      square([hook_radius, hook_radius]);
    }
  }
}

translate([0, -total_height/2, total_width/2]) {
  rotate([270, 0, 90]) {
    linear_extrude(height = length) {
      mirror([0, 1, 0]) h2();
      h2();
    }
  }
}

