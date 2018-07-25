rotate([180, 0, 0]) {
  cylinder(d=6, h=20, $fn=100); // hole depth is about 26mm
}
intersection() {
  sphere(d=17, $fn=100);
  cylinder(d=16, h=930, $fn=100);
}
