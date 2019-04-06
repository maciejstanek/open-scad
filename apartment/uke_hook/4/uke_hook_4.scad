screw_hole_diameter = 5;
screw_head_hole_diameter = 10;
screw_head_hole_depth = 1;
wall_width = 4;
wall_height = 10;
slit_width = 40;
hook_length = 20;
slab_width = 24.5;
slab_length = 141;
/* hole_distance = 11; */
hole_distance = 40 + slit_width/2;
slab_distance = 42;
slab_height = 4;

$fn = 200;

module h1 () {
  polygon([[0, 0], [slab_distance, 0], [slab_distance, slab_width/2], [0, slit_width/2 + wall_width]]);
}
module h2 () {
  polygon([[0, slit_width/2], [slab_distance, slab_width/2 - wall_width], [slab_distance, slab_width/2], [0, slit_width/2 + wall_width]]);
}

module handle() {
  translate([slab_distance, -slab_width/2]) {
    intersection() {
      union() {
        linear_extrude(height = slab_height) {
          square([slab_length + hole_distance, slab_width]);
        }
        linear_extrude(height = wall_height) {
          difference() {
            square([slab_length + hole_distance, slab_width]);
            translate([0, wall_width]) {
              square([slab_length + hole_distance, slab_width - 2*wall_width]);
            }
          }
        }
      }
      union() {
        translate([slab_length + hole_distance - wall_height - 7, slab_width/2, 0]) {
          rotate([0, 90, 90]) {
            cylinder(r = wall_height, h = slab_width + 2, center = true);
          }
        }
        translate([-1, -1, -1]) {
          cube([slab_distance + slab_length + 2, slab_width + 2, wall_height + 2]);
        }
      }
    }
  }
}

module neck() {
  difference() {
    union() {
      linear_extrude(height = slab_height) {
        h1();
        mirror([0, 1, 0]) {
          h1();
        }
      }
      linear_extrude(height = wall_height) {
        h2();
        mirror([0, 1, 0]) {
          h2();
        }
      }
    }
    translate([0, 0, -1]) {
      linear_extrude(height = slab_height + 2) {
        a = slit_width/2;
        b = slab_width/2;
        c = slab_distance;
        y = b*c/(a - b);
        echo(y=y);
        x = a*a/(y + c);
        echo(x=x);
        r = sqrt(a*a + x*x);
        echo(r=r);
        translate([-x, 0]) {
          circle(r = r);
        }
      }
    }
  }
}

module hook() {
  rotate(180) {
    translate([0, -wall_width/2]) {
      square([hook_length, wall_width]);
    }
    translate([hook_length, 0]) {
      circle(d = wall_width);
    }
  }
}

module hooks() {
  linear_extrude(height = wall_height) {
    translate([0, slit_width/2 + wall_width/2, 0]) {
      hook();
    }
    translate([0, -slit_width/2 - wall_width/2, 0]) {
      hook();
    }
  }
}

module h3() {
  linear_extrude(height = 1) {
    square([1, slit_width + 2], center = true);
  }
}

module h4() {
  linear_extrude(height = 1) {
    square([1, slab_width - 2], center = true);
  }
}

module helpers() {
  for(i = [3, 11, 19]) {
    translate([-i, 0, 0]) {
      h3();
    }
  }
  for(i = [0:6]) {
    translate([110 + 14*i, 0, 0]) {
      h4();
    }
  }
}

module hole() {
  translate([-hole_distance, 0, slab_height + 1]) {
    rotate([0, 180, 0]) {
      cylinder(h = slab_height + 2, d = screw_hole_diameter);
      cylinder(h = screw_head_hole_depth + 1, d = screw_head_hole_diameter);
    }
  }
}

module handle_hole() {
  translate([105, 0, -1]) {
    linear_extrude(height = slab_height + 2) {
      translate([0, 0]) {
        circle(d = slab_width - 2*wall_width);
        translate([95, 0]) {
          circle(d = slab_width - 2*wall_width);
        }
        translate([0, -slab_width/2 + wall_width]) {
          square([95, slab_width - 2*wall_width]) {
          }
        }
      }
    }
  }
}

difference() {
  union() {
    handle();
    neck();
    hooks();
  }
  for(i = [0, slab_length]) {
    translate([100 + slab_distance + i, 0, 0]) {
      hole();
    }
  }
  handle_hole();
}
helpers();
