plexi = 8;
walls = 2;
walls_support = 1.5;
bottom = 30;
side_width = 15;
hole_diameter = 8;
top_width = plexi + 2*walls;
height = 140;
thickness = 4;
depth = 18;
supports = height - 12;
column = 6;
head_diameter = hole_diameter + 12;

hole_l1_w = 24;
hole_l1_h = 29;
hole_l2_w = 0;
hole_l2_h = 45;
hole_r1_w = 21;
hole_r1_h = 24;
hole_r2_w = 21;
hole_r2_h = 42;
hole_d1 = 3;
hole_d2 = 10;

$fn = 100;

module column() {
  difference() {
    union() {
      translate([0, height]) {
        circle(d = head_diameter);
      }
      translate([-top_width/2, plexi/2]) {
        square([top_width, height]);
      }
    }
    union() {
      translate([0, height]) {
        circle(d = hole_diameter);
      }
      translate([-hole_diameter/2, plexi/2 + height - hole_diameter/2]) {
        square([hole_diameter, height]);
      }
    }
  }
}

module plate() {
  square([2*side_width, plexi + 2*walls], center = true);
  translate([0, -bottom/2]) {
    square([plexi + 2*walls, bottom], center = true);
  }
}

module wall_side(is_outer = true) {
  translate([-top_width/2, plexi/2 + walls, 0]) {
    rotate([0, 270, 180]) {
      linear_extrude(height = walls) {
        if (is_outer) {
          difference() {
            hull() {
              square([depth, bottom + plexi/2 + walls]);
              translate([hole_r1_w + walls, hole_r1_h + walls]) {
                circle(d = hole_d2);
              }
              translate([hole_r2_w + walls, hole_r2_h + walls]) {
                circle(d = hole_d2);
              }
            }
            translate([hole_r1_w + walls, hole_r1_h + walls]) {
              circle(d = hole_d1);
            }
            translate([hole_r2_w + walls, hole_r2_h + walls]) {
              circle(d = hole_d1);
            }
          }
        }
        else {
          translate([0, plexi + walls]) {
            square([depth, bottom - plexi/2]);
          }
        }
      }
    }
  }
  if (!is_outer) {
    mirror() {
      translate([plexi/2, -plexi/2 - walls, 0]) {
        cube([side_width - plexi/2, walls, depth]);
      }
    }
  }
}

module wall_top(is_outer = true) {
  if (is_outer) {
    difference() {
      hull() {
        translate([-side_width, 0]) {
          square([2*side_width, depth]);
        }
        translate([hole_l2_w, hole_l2_h]) {
          circle(d = hole_d2);
        }
        translate([hole_l1_w, hole_l1_h]) {
          circle(d = hole_d2);
        }
        translate([-side_width + hole_d2/2, depth + hole_d2/2]) {
          circle(d = hole_d2);
        }
      }
      translate([hole_l2_w, hole_l2_h]) {
        circle(d = hole_d1);
      }
      translate([hole_l1_w, hole_l1_h]) {
        circle(d = hole_d1);
      }
    }
  }
  else {
    translate([-top_width/2, 0]) {
      square([side_width + top_width/2, depth]);
    }
  }
}

module holder(is_outer = true) {
  color("red") linear_extrude(height = walls) {
    difference() {
      plate();
      if(!is_outer) {
        translate([top_width/2, -walls - plexi/2 - 1]) {
          square([side_width, 2*walls + plexi + 2]);
        }
        translate([-plexi/2, -bottom]) {
          square([plexi, bottom + plexi/2]);
        }
      }
    }
  }
  color("yellow") linear_extrude(height = column) column();
  color("navy") {
    wall_side(is_outer = false);
  }
  color("blue") {
    mirror() wall_side(is_outer = !is_outer);
  }
  color("green") {
    translate([0, plexi/2, 0]) {
      rotate([-90, 180, 0]) {
        linear_extrude(height = walls) {
          wall_top(is_outer = is_outer);
        }
      }
    }
  }
}

holder(is_outer = false);
