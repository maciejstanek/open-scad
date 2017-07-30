difference() {
  cube([19.1, 39.2, 6.8]);
  translate([1, 1, 2.1]) cube([17.1, 37.2, 10]);
  translate([2, 1.4, -5]) cube([15.1, 2.3, 10]);
  translate([5.9, 20.6, 1.2]) cylinder(10, 4.2, 4.2, $fn = 100);
}

translate([22, 0, 0]) difference() {
  union() {
    cube([19.1, 39.2, 1]);
    translate([1, 1, 0]) cube([17.1, 37.2, 2]);
  }
  translate([9.5, 26, 0.5]) scale(0.1) surface("assets/bluetooth_symbol.png", center = true, invert = true);
  label = ["KEY", "RX ", "TX ", "5V ", "3V3", "GND"];
  for(i = [0:5]) {
    echo([i, label[i]]);
    translate([3.6 + 2.8 * i, 8, 0.5]) rotate([180, 0, 270]) linear_extrude(height = 1) text(label[i], 2.5, "Ubuntu Mono", $fn = 6);
  }
}    
