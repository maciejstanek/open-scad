module wheel_d(wheel_d = 50) {
	shaft_d = 4;
	shaft_d_minus_cut = 3.3;
	shaft_grip_d = shaft_d + 4;
	spoke_width = 0.5;
	tire_width = 2;
	spoke_count = 36;
	wheel_thickness = 8;
	spoke_thickness = 6;
	grip_thickness = 8;
	fn = 100;
	linear_extrude(height = grip_thickness) {
		difference() {
			circle(d = shaft_grip_d, $fn = fn);
			difference() {
				circle(d = shaft_d, $fn = fn);
				cut_depth = shaft_d - shaft_d_minus_cut;
				translate([shaft_d / 2 - cut_depth, -shaft_d / 2]) square(shaft_d);
			}
		}
	}
	linear_extrude(height = wheel_thickness) {
		difference() {
			circle(d = wheel_d, $fn = fn);
			circle(d = wheel_d - 2 * tire_width, $fn = fn);
		}
	}
	linear_extrude(height = spoke_thickness) {
		intersection() {
			for(i = [0: spoke_count - 1]) {
				rotate(i * 360 / spoke_count) translate([shaft_d / 2 + spoke_width, 0]) square([spoke_width, 1000], center = true);
			}
			circle(d = wheel_d - tire_width / 2, $fn = fn);
		}
	}
}

wheel_d();
