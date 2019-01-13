module rounded_rect(a, r) {
  if (a < 2 * r) {
    translate([-a/2 + r, -a/2 + r]) {
      minkowski() {
        square([a - 2*r, a - 2*r]);
        circle(r = r, $fn = 100);
      }
    }
  }
  else {
    circle(r = r, $fn = 100);
  }
}

module pot_outer_face(a, r) {
  rounded_rect(a, r);
}

module pot_inner_face(a, t, r) {
  rounded_rect(a - 2*t, r - t);
}

module pot_template(h, a, t, r) {
  difference() {
    linear_extrude(height = h) {
      pot_outer_face(a, r);
    }
    translate([0, 0, t]) {
      linear_extrude(height = h - t + 1) {
        pot_inner_face(a, t, r);
      }
    }
  }
}

module pot(type, debug = false) {
  if (type == "carrefour") {
    h = 100;
    a = 76;
    t = 1;
    r = 11;
    pot_template(h, a, t, r);
  }
  else if (type == "lidl") {
    h = 84;
    a = 77;
    t = 1;
    r = a / 2;
    pot_template(h, a, t, r);
  }
}

module TEST_pot_slice(type) {
  linear_extrude(height = 1) {
    projection(cut = true) {
      translate([0, 0, -10]) {
        pot(type);
      }
    }
  }
}

pot("lidl");
/* TEST_pot_slice("lidl"); */
