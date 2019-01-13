
t_z = 50;
t_p_h_a = 10;
t_p_h_b = 10;
t_p_h_p = 0.92;
t_p_h_a_t = t_p_h_p * t_p_h_a;
t_p_h_b_t = t_p_h_p * t_p_h_b;
h_r = 30;

module hook_profile() {
  square([t_z, t_p_h_a_t]);
  translate([0, t_p_h_a_t - h_r]) {
    intersection() {
      difference() {
        circle(r = h_r, $fn = 200);
        circle(r = h_r - t_p_h_a_t, $fn = 200);
      }
      polygon([[0, 0], [-h_r, h_r], [0, h_r]]);
    }
  }
  translate([(t_p_h_a_t - 2*h_r)/sqrt(2), t_p_h_a_t - h_r + (2*h_r - t_p_h_a_t)/sqrt(2)]) {
    intersection() {
      difference() {
        circle(r = h_r, $fn = 200);
        circle(r = h_r - t_p_h_a_t, $fn = 200);
      }
      polygon([[0, 0], [h_r, -h_r], [-h_r, -h_r], [-h_r, 0]]);
    }
  }
  translate([(t_p_h_a_t - 2*h_r)/sqrt(2) - h_r + t_p_h_a_t/2, t_p_h_a_t - h_r + (2*h_r - t_p_h_a_t)/sqrt(2)]) {
    circle(d = t_p_h_a_t, $fn = 200);
  }
}

linear_extrude(height = t_p_h_b_t) {
  hook_profile();
}
