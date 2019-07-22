d1 = 70;
d2 = 98;
h = 74;
w = 0.7;
$fn = 200;

hole_n = 10;
hole_w = 3;
hole_d = d1/2-10;
hole_h = 20;

mounthole_a = 30;
mounthole_d = 3;
mounthole_h = h-5;

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
  /*
  for (i=[-1,1]) {
    translate([i*mounthole_a/2, 0, mounthole_h]) {
      rotate([90, 0, 0]) {
        cylinder(h=d2+2, d=mounthole_d, center=true);
      }
    }
  }
  */
}
