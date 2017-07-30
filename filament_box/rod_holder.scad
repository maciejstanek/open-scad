rod_diameter = 8;
holder_thickness = 6;
holder_length = 20;

color("crimson") union() {
  difference() {
    color("red") hull() for(i = [0:6]) rotate(60 * i, [0, 0, 1]) translate([20, 0, 0]) union() {
      translate([0, 0, 2]) sphere(d = 2, center = true, $fn = 16);
      cylinder(h = 1, d = 2, $fn = 16);
    }
    // TODO: screws holes
  }

  //rotate([180, 0, 0]) translate([0, 0, -holder_length]) 

  difference() {
    rotate_extrude($fn = 100) {
      union() {
        translate([rod_diameter / 2 + holder_thickness / 2, 0, 0]) circle(d = holder_thickness, center = true);
        translate([rod_diameter / 2, 0, 0]) square([holder_thickness , holder_length - 1]);
      }
    }
    translate([50, 0, 0]) cube(100, center = true);
  }
}