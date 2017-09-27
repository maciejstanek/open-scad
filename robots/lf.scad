use <../wheels/wheel_d.scad>;
use <../motors/HL149.scad>;

module drive() {
	rotate([90, 0, 0]) {
		wheel_d();
		translate([0, 0, -72]) HL149();
	}
}

wheels_distance = 150;

translate([0, wheels_distance, 0]) rotate([0, 0, 180]) drive();
drive();
