x = 40; // ukulele handle width
d = 5; // shell thickness
a = 10; // ukulele hooks thickness
l = 50; // shelf grippers length
h = 20; // shelf height

color("olive") {
  y = 1000;
  z = 230;
  translate([-y/2,-z,-h])
    cube([y,z,h]);
}

color("white") {
  translate([-x/2-a,-l,-h-d])
    cube([x+2*a,l+d,h+2*d]);
}

