width_y = 130;
upper_half_x = 38.5;
lower_half_x = 53 - upper_half_x;

function plate_half_r(x, y) = (pow(x, 2) + pow(y, 2)) / (2 * x);
upper_half_r = plate_half_r(upper_half_x, width_y / 2);
lower_half_r = plate_half_r(lower_half_x, width_y / 2);
echo(upper_half_r = upper_half_r, lower_half_r = lower_half_r);
upper_half_a = upper_half_x - upper_half_r;
lower_half_a = lower_half_r - lower_half_x;
echo(upper_half_a = upper_half_a, lower_half_a = lower_half_a);

light_hole_d = 7;
light_hole_x = 10 - light_hole_d / 2;
light_hole_y = 49.5 - light_hole_d / 2 - 7;
knob_hole_inner_d = 6;
knob_hole_outer_d = 9.5;
knob_hole_x = 9.5 - knob_hole_inner_d / 2 + 6;
screw_hole_inner_d = 4;
screw_hole_outer_d = 7;
screw_hole_x = knob_hole_x;
screw_hole_y = 20.5 - screw_hole_outer_d / 2 - knob_hole_inner_d / 2;

module plate() {
  difference() {
    intersection() {
      translate([0, upper_half_a]) {
        circle(r = upper_half_r, $fn = 100);
      }
      translate([0, lower_half_a]) {
        circle(r = lower_half_r, $fn = 100);
      }
    }
    translate([-light_hole_y, light_hole_x]) {
      circle(d = light_hole_d, $fn = 50);
    }
    translate([0, knob_hole_x]) {
      circle(d = knob_hole_outer_d, $fn = 50);
    }
    for(i = [-1, 1]) {
      translate([i * screw_hole_y, screw_hole_x]) {
        circle(d = screw_hole_inner_d, $fn = 50);
      }
    }
  }
}

linear_extrude(1) plate();
