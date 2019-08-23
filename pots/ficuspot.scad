d1 = 90;
d2 = 121;
d3 = 128;
h = 90;
h3 = 2;
w = 0.7;
$fn = 200;

hole_n = 10;
hole_w = 3;
hole_d = d1/2-15;
hole_h = 30;

module basic_pot() {
  rotate([180, 0, 0]) {
    translate([0, 0, -h]) {
      difference() {
        cylinder(d1=d1, d2=d2, h=h);
        translate([0, 0, w]) {
          cylinder(d1=d1-2*w, d2=d2-2*w, h=h);
        }
        for (i=[0:hole_n-1]) {
          rotate([0, 0, i*360/hole_n]) {
            translate([hole_d, -hole_w/2, -1]) {
              cube([d2/2+1, hole_w, hole_h+1]);
            }
          }
        }
      }
    }
  }
}

module better_pot() {
  basic_pot();
  linear_extrude(height=h3) {
    difference() {
      circle(d=d3);
      circle(d=d2-2*w);
    }
  }
}

intersection() {
  /* better_pot(); */
  basic_pot();
  cube([9999, 9999, 20], center=true);
}
