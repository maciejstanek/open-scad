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

	rotate([-90, 0, 0]) translate([0, 0, -l3456]) difference() {
		rotate_extrude($fn = 50) rotate([180, 0, 90]) polygon(points = [
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
			[l123456, 0],
		]);
		translate([d1_cut - d1 / 2, -d1 / 2, l123456 - l_cut]) cube([d1, d1, l_cut + 1]);
		translate([d_holes_place/2, 0, l3456 - 1]) cylinder(h = 2, d = d_holes, $fn = 50);
		translate([-d_holes_place/2, 0, l3456 - 1]) cylinder(h = 2, d = d_holes, $fn = 50);
	}
}

module HL149_stand() {

	cube(123);
}

HL149_stand();
HL149();
