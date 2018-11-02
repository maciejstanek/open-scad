t_h = 17;
t_a = 32;
t_b = 14;
t_z = 15;
t_d = 15;
t_p = 2;
t_p_s = 1.2;
t_p_h_a = 10;
t_p_h_b = 10;
t_p_h_a_t = 0.95 * t_p_h_a;
t_p_h_b_t = 0.95 * t_p_h_b;
t_p_h_h = 0;
t_b_s = 0.85;
t2_h = 0.98 * (t_z + t_p);
t2_s = 0.98 * t_b_s;
h_r = 30;
s_h_s = 0.5;

module trapezoid() {
  translate([0, t_h/2, 0]) {
    minkowski() {
      polygon([
        [-t_a/2 + t_d/2.5, -t_d/4],
        [t_a/2 - t_d/2.5, -t_d/4],
        [t_b/2 - t_d/6.5, -t_h + t_d/4],
        [-t_b/2 + t_d/6.5, -t_h + t_d/4]
      ]);
      circle(d = t_d/2, $fn = 50);
    }
  }
}

module plate_cutout() {
  translate([0, t_p_h_h]) {
    square([t_p_h_b, t_p_h_a], center = true);
  }
}

module plate() {
  linear_extrude(height = t_p) {
    difference() {
      scale([t_p_s, t_p_s]) {
        trapezoid();
      }
      plate_cutout();
    }
  }
}

module front_face() {
  rotate([0, 180, 0]) {
    linear_extrude(height = t_z) {
      difference() {
        trapezoid();
        scale([t_b_s, t_b_s]) {
          trapezoid();
        }
      }
    }
  }
  plate();
}

module back_face() {
  translate([0, 0, -t_z - t_p]) {
    rotate([0, 0, 0]) {
      plate();
      linear_extrude(height = t2_h) {
        difference() {
          scale([t2_s, t2_s]) {
            trapezoid();
          }
          plate_cutout();
        }
      }
    }
  }
}

module hook_profile() {
  square([t_p + t_z, t_p_h_a_t]);
  translate([0, t_p_h_a_t - h_r]) {
    intersection() {
      difference() {
        circle(r = h_r, $fn = 50);
        circle(r = h_r - t_p_h_a_t, $fn = 50);
      }
      polygon([[0, 0], [-h_r, h_r], [0, h_r]]);
    }
  }
  translate([(t_p_h_a_t - 2*h_r)/sqrt(2), t_p_h_a_t - h_r + (2*h_r - t_p_h_a_t)/sqrt(2)]) {
    intersection() {
      difference() {
        circle(r = h_r, $fn = 50);
        circle(r = h_r - t_p_h_a_t, $fn = 50);
      }
      polygon([[0, 0], [h_r, -h_r], [-h_r, -h_r], [-h_r, 0]]);
    }
  }
  translate([(t_p_h_a_t - 2*h_r)/sqrt(2) - h_r + t_p_h_a_t/2, t_p_h_a_t - h_r + (2*h_r - t_p_h_a_t)/sqrt(2)]) {
    circle(d = t_p_h_a_t, $fn = 50);
  }
}

module small_hook_profile() {
  scale([s_h_s, s_h_s]) {
    mirror([1, 0]) {
      hook_profile();
    }
  }
}

module hook() {
  rotate([0, 90, 0]) {
    translate([0, -t_p_h_a_t/2, -t_p_h_a_t/2]) {
      linear_extrude(height = t_p_h_b_t) {
        hook_profile();
        translate([t_p + t_z, s_h_s*t_p_h_a_t]) {
          small_hook_profile();
        }
      }
    }
  }
}

color("Orange") front_face();
color("Yellow") back_face();
color("Red") hook();
