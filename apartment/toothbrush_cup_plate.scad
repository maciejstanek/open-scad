module my_cone() {
  linear_extrude(height=100,scale=0) circle(d=100,$fn=6);
}

rotate([0,0,0]) {
  difference() {
    union() {
      difference() {
        difference() {
          my_cone();
          translate([0,0,-10]) my_cone();
        }
        translate([0,0,10]) cylinder(h=9999,d=74,$fn=200);
        translate([0,0,16]) cylinder(h=9999,d=9999);
      }
      translate([0,0,10]) difference() {
        cylinder(h=10,d=88,$fn=6);
        translate([0,0,2]) cylinder(h=9999,d=74,$fn=200);
      }
    }
    for(i=[0,120,240]) {
      rotate([0,90,0]) rotate([0,90+i,90]) {
        cylinder(d=20,h=9999,center=true,$fn=6);
      }
    }
  }
}
