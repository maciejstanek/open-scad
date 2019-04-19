plexi = 8;
walls = 2;
walls_support = 1.5;
bottom = 30;
side_width = 15;
hole_diameter = 8;
/* top_width = plexi + 2*walls; */
top_width = hole_diameter + 8;
height = 130;
thickness = 4;
depth = 18;
/* depth = 30; */
supports = height - 12;
column = 6;
$fn = 100;

module column() {
  difference() {
    translate([-(top_width - hole_diameter)/2, 0]) {
      minkowski() {
        circle(d = top_width - hole_diameter);
        square([top_width - hole_diameter, height - hole_diameter/2]);
      }
    }
    translate([0, height - hole_diameter/2]) {
      circle(d = hole_diameter);
    }
    translate([0, height]) {
      square([hole_diameter, hole_diameter], center = true);
    }
    rotate(180) {
      translate([-500, -plexi/2]) {
        square([1000, 1000]);
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

module walls_half() {
  translate([0, plexi/2]) {
    square([side_width, walls]);
  }
  translate([plexi - walls, -plexi/2 - walls]) {
    square([side_width + walls - plexi, walls]);
  }
  translate([plexi/2, -bottom]) {
    square([walls, bottom - plexi/2]);
  }
}

module supports_half() {
  translate([top_width/2, plexi/2 + walls, walls]) {
    rotate([0, -90, 0]) {
      linear_extrude(height = walls_support) {
        polygon([[0, 0], [depth - walls, 0], [0, supports]]);
      }
    }
  }
}

module supports() {
  supports_half();
  mirror() supports_half();
}

module walls() {
  walls_half();
  mirror() walls_half();
}

module outer() {
  color("red") linear_extrude(height = walls) plate();
  color("yellow") linear_extrude(height = column) column();
  color("blue") linear_extrude(height = depth) walls();
  /* color("yellow") supports(); */
}

module inter() {
  color("red") linear_extrude(height = walls) {
    difference() {
      plate();
      translate([top_width/2, -walls - plexi/2 - 1]) {
        square([side_width, 2*walls + plexi + 2]);
      }
      translate([-plexi/2, -bottom]) {
        square([plexi, bottom + plexi/2]);
      }
    }
  }
  color("yellow") linear_extrude(height = column) column();
  color("blue") linear_extrude(height = depth) {
    mirror() walls_half();
    translate([0, plexi/2]) {
      square([top_width/2, walls]);
    }
    translate([plexi/2, -bottom]) {
      square([walls, bottom + plexi/2]);
    }
  }
}

outer();
/* inter(); */
