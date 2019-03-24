shelf_thickness = 19;
width = 120;
hook_slit = 40;
length = 170;
backtrace_length = 100;
drop_radius = 70;
hook_radius = 500;
thickness = 1;

difference() {
  linear_extrude(height = width) {
    square([length, thickness]);
    translate([0, -shelf_thickness - thickness]) {
      rotate(90) {
        square([shelf_thickness + 2*thickness, thickness]);
      }
    }
    translate([backtrace_length, -shelf_thickness]) {
      rotate(180) {
        square([backtrace_length, thickness]);
      }
    }
    translate([backtrace_length, -shelf_thickness - drop_radius]) {
      rotate(180) {
        difference() {
          circle(r = drop_radius, $fn = 100);
          circle(r = drop_radius - thickness, $fn = 100);
          translate([0, -2*drop_radius]) {
            square([4*drop_radius, 4*drop_radius]);
          }
        }
      }
    }
    translate([backtrace_length, -shelf_thickness - 2*drop_radius + hook_radius]) {
      difference() {
        circle(r = hook_radius, $fn = 400);
        circle(r = hook_radius - thickness, $fn = 400);
        translate([0, -2*hook_radius]) {
          square([4*hook_radius, 4*hook_radius]);
        }
        translate([2*hook_radius, 0]) {
          rotate(90) {
            square([4*hook_radius, 4*hook_radius]);
          }
        }
        translate([-backtrace_length - thickness, 2*hook_radius]) {
          rotate(180) {
            square([4*hook_radius, 4*hook_radius]);
          }
        }
      }
    }
  }
  translate ([0, -shelf_thickness - 2*drop_radius, width/2]) {
    cube([2*backtrace_length, 2*drop_radius, hook_slit], center = true);
  }
}
