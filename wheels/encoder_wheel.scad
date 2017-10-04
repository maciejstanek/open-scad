module encoder_wheel(n = 16, d = 25, ring = 1, thickness = 1,
		shaft_d = 2.2, shaft_blind_d = 15, shaft_grip_d = 4,
		shaft_grip_h = 4) {
	// NOTE: Be careful when specifying number of sections 'n'.
	//       This number should be settled by calculations and
	//       a distance between slits of two sensors. Set 'n'
	//       so that the quadrature is not malformed.
	linear_extrude(height = thickness) {
		difference() {
			circle(d = d, $fn = 100);
			circle(d = d - 2 * ring, $fn = 100);
		}
		difference() {
			intersection() {
				circle(d = d - ring, $fn = 100);
				for(i = [0 : n - 1]) {
					rotate(i * 360 / n) intersection() {
						square([2 * d, 2 * d]);
						rotate(90 - 180 / n) square([2 * d, 2 * d]);
					}
				}
			}
			circle(d = shaft_blind_d - 1, $fn = 100);
		}
		difference() {
			circle(d = shaft_blind_d, $fn = 100);
			circle(d = shaft_d, $fn = 100);
		}
	}
	linear_extrude(height = shaft_grip_h) {
		difference() {
			circle(d = shaft_grip_d, $fn = 100);
			circle(d = shaft_d, $fn = 100);
		}
	}
}
