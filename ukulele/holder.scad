x = 40; // ukulele handle width
d = 5; // shell thickness
p = 10; // front plate thickness
a = 10; // ukulele hooks thickness
l = 80; // shelf grippers length
h = 20; // shelf height
b = 45; // ukulele handles length

module shelf() {
  color("olive") {
    y = 1000;
    z = 230;
    e = 0.01;
    translate([-y/2,-z,-h+e/2])
      cube([y,z,h-e]);
  }
}

module holder_side() {
  translate([x/2+a/2,0,0]) {
    rotate([-90,90,0]) {
      linear_extrude(height=b+p) {
        hull() {
          circle(d=a,$fn=50);
          translate([h+2*d-a,0,0])
            circle(d=a,$fn=50);
        }
      }
    }
  }
}

module holder() {
  holder_side();
  mirror() holder_side();
}

module frame() {
  difference() {
    translate([-x/2-a,-l,-h-d])
      cube([x+2*a,l+p,h+2*d]);
    translate([-(x+2*a+1)/2,-l-1,-h])
      cube([x+2*a+1,l+1,h]);
    translate([-(x+1)/2,-l+a,-h-d-1])
      cube([x,l-a,h+2*d+2]);
  }
}

// shelf();
color("white") {
  holder();
  intersection() {
    s = 2*(d+l)/b;
    frame();
    translate([0,-(d+l),0]) scale([1,s,1]) hull() holder();
  }
}

