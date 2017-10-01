use <../libs/utils.scad>;

module HL149() {
	d1 = 4;
	d1_cut = 3.4;
	d2 = 8.8;
	d3 = 26.6;
	d4 = 27.4;
	d5 = 13.8;
	d6 = 2.2;
	d_holes_place = 19.6;
	d_holes = 2.6;

	l123456 = 80.6;
	l23456 = 69;
	l12345_cut = 64.8;
	l12345 = 73.6;
	l2345 = 62;
	l34 = 56.4;
	l345 = 57.6;
	l3 = 17.8;
	l1 = l123456 - l23456;
	l_cut = l12345 - l12345_cut;
	l2 = l2345 - l345;
	l5 = l345 - l34;
	l6 = l123456 - l12345;
	l4 = l34 - l3;
	l56 = l5 + l6;
	l456 = l4 + l56;
	l3456 = l3 + l456;
	echo(l1 = l1,
		l_cut = l_cut,
		l2 = l2,
		l3 = l3,
		l4 = l4,
		l5 = l5,
		l6 = l6
	);

	rotate([-90, 0, 0]) translate([0, 0, -l3456]) difference() {
		rotate_extrude($fn = 100) rotate([180, 0, 90]) polygon(points = [
			[0, 0],
			[0, d6 / 2],
			[l6, d6 / 2],
			[l6, d5 / 2],
			[l56, d5 / 2],
			[l56, d4 / 2],
			[l456, d4 / 2],
			[l456, d3 / 2],
			[l3456, d3 / 2],
			[l3456, d2 / 2],
			[l23456, d2 / 2],
			[l23456, d1 / 2],
			[l123456, d1 / 2],
			[l123456, 0]
		]);
		translate([d1_cut - d1 / 2, -d1 / 2, l123456 - l_cut]) cube([d1, d1, l_cut + 1]);
		translate([d_holes_place/2, 0, l3456 - 1]) cylinder(h = 2, d = d_holes, $fn = 50);
		translate([-d_holes_place/2, 0, l3456 - 1]) cylinder(h = 2, d = d_holes, $fn = 50);
	}
}

module HL149_stand_screw() {
	head_d = 4;
	head_h = 1.2;
	head_cut_depth = 0.4;
	head_cut_width = 0.8;
	total_d = 2.2;
	total_h = 9.6;

	translate([0, 0, -head_h]) difference() {
		cylinder(h = head_h, d = head_d, $fn = 100);
		cube([head_cut_width, head_d + 1, 2 * head_cut_depth], center = true);
	}
	cylinder(h = total_h - head_h, d = total_d, $fn = 100);
}

module HL149_stand_nut() {
	total_d = 4.8;
	inner_d = 2.2;
	total_h = 1.6;

	linear_extrude(total_h) {
		circle(d = total_d, $fn = 6);
		circle(d = inner_d, $fn = 100);
	}
}

module HL149_stand() {
	length = 57;
	motor_d = 27.8;
	width = motor_d + 6;
	front_thickness = 4.4;
	d_holes_place = 19.6;
	d_holes = 3;
	platform_height = 5;
	shaft_hole_d = 9.4;

	rotate([-90, 0, 0]) linear_extrude(front_thickness) difference() {
		circle(d = width, $fn = 100);
		circle(d = shaft_hole_d, $fn = 100);
		copy_mirror([1, 0, 0]) translate([d_holes_place / 2, 0, 0]) circle(d = d_holes, $fn = 100);
	}
	difference() {
		translate([-width / 2, -length, -motor_d / 2 - platform_height]) cube([width, length + front_thickness, motor_d / 2 + platform_height]);
		translate([0, front_thickness + 1, 0]) rotate([0, 90, -90]) cylinder(d = motor_d, h = length + length + 2, $fn = 100);
	}
	// TODO: Add a place for encoders
	// TODO: Add a encoder wheel
}

translate([0, 0, 18.9]) color("Lime") HL149_stand();
translate([0, 0, 18.9]) color("Red") HL149();
color("Gray") translate([0, -70.6, -0.5]) cube([150, 150, 1], center = true);
// color("Blue") {
// 	translate([0, 0, 5]) HL149_stand_nut();
// 	HL149_stand_screw();
// }
