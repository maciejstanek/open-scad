t = 13.5;
w_pillar = 15;
d_out = 9;
d_in = 5.5;
h_full = 26;
h_base = 10.5;
w_full = 37;
w_top = 32;
w_in = 28;
w_rail = 21;
h_groove = 8;
h_rail = 4.5;

module face() {
  difference() {
    polygon([
      [-w_full/2, 0],
      [-w_top/2, h_base],
      [w_top/2, h_base],
      [w_full/2, 0],
    ]);
    translate([-w_rail/2, -1]) {
      square([w_rail, h_groove + 1]);
    }
    translate([-w_in/2, h_rail]) {
      square([w_in, h_groove - h_rail]);
    }
  }
  difference() {
    union() {
      translate([0, h_base]) {
        polygon([
          [-w_pillar/2, 0],
          [-d_out/2, h_full - h_base - d_out/2],
          [d_out/2, h_full - h_base - d_out/2],
          [w_pillar/2, 0],
        ]);
      }
      translate([0, h_full - d_out/2]) {
        circle(d = d_out, $fn = 100);
      }
    }
    translate([0, h_full - d_out/2]) {
      circle(d = d_in, $fn = 100);
    }
  }
}

linear_extrude(height = t) face();
