wall_thickness = 105;
grip_length = 30;
hook_diameter = 20;
hook_length = 40;
width = 10;
thickness = 1.5;

linear_extrude(height = width) {
  translate ([-thickness, -thickness]) {
    square([wall_thickness + 2*thickness, thickness]);
  }
  translate ([wall_thickness + thickness, 0]) {
    rotate(90) {
      square([grip_length, thickness]);
    }
  }
  rotate(90) {
    square([hook_length - hook_diameter/2, thickness]);
  }
  translate([-hook_diameter/2, hook_length - hook_diameter/2]) {
    rotate(180) {
      difference() {
        circle(d = hook_diameter, $fn = 100);
        circle(d = hook_diameter - 2*thickness, $fn = 100);
        translate([-2*hook_diameter, 0]) {
          square([4*hook_diameter, 2*hook_diameter]);
        }
      }
    }
  }
}
