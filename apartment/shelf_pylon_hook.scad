width = 24.5;
hole_distance = 20.5;
top_height = hole_distance + width/2;
hook_radius = 12;
bottom_distance = 5;
bottom_height = bottom_distance + hook_radius;
straight_length = top_height + bottom_distance;
thickness = 4;
screw_hole_diameter = 5;
screw_head_hole_diameter = 10;
screw_head_hole_depth = 1;

$fn = 100;

difference() {
  linear_extrude(height = width) {
    translate([-top_height, thickness/2]) {
      circle(d = thickness);
    }
    translate([-top_height, 0]) {
      square([straight_length, thickness]);
    }
    translate([bottom_distance, hook_radius]) {
      difference() {
        circle(r = hook_radius);
        circle(r = hook_radius - thickness);
        rotate(90) {
          translate([-(hook_radius + 1), 0]) {
            square([2*(hook_radius + 1), hook_radius + 1]);
          }
        }
      }
    }
    translate([bottom_distance, 2*hook_radius - thickness/2]) {
      circle(d = thickness);
    }
  }
  translate([-hole_distance, thickness + 1, width/2]) {
    rotate([90, 90, 0]) {
      cylinder(h = thickness + 2, d = screw_hole_diameter);
      cylinder(h = screw_head_hole_depth + 1, d = screw_head_hole_diameter);
    }
  }
}
