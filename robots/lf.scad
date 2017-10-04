use <../wheels/wheel_d.scad>;
use <../motors/HL149.scad>;

module lf(chassis_only = true) {
	filament_color = "DarkOrange";
	wheels_distance = 150;

	motor_d = 27.8;
	width = motor_d + 6;
	front_thickness = 4.4;
	d_holes_place = 19.6;
	d_holes = 3;
	platform_height = 5;
	shaft_hole_d = 9.4;
	wheel_d = 50;
	echo(bottom_clearance = (wheel_d / 2 - motor_d / 2 - platform_height));

	color(filament_color) translate([-width / 2, -wheels_distance / 2 - front_thickness, 0]) difference() {
		cube([width, wheels_distance + 2 * front_thickness, platform_height + motor_d / 2]);
		translate([width / 2, 0, platform_height + motor_d / 2]) rotate([270, 0, 0]) translate([0, 0, -1]) cylinder(d = motor_d, h = 2 * (wheels_distance + front_thickness + 1), $fn = 100);
	}

	module lf_motor_handle(chassis_only = chassis_only) {
		wheel_on_shaft_distance = 7.5;
		translate([0, wheels_distance / 2, 0]) union() {
			color(filament_color) rotate([-90, 0, 0]) linear_extrude(front_thickness) difference() {
				circle(d = width, $fn = 100);
				circle(d = shaft_hole_d, $fn = 100);
				translate([d_holes_place / 2, 0, 0]) circle(d = d_holes, $fn = 100);
				translate([-d_holes_place / 2, 0, 0]) circle(d = d_holes, $fn = 100);
			}
			if(!chassis_only) {
				color("Silver") HL149();
				color(filament_color) rotate([270, 0, 0]) translate([0, 0, wheel_on_shaft_distance]) wheel_d(wheel_d);
			}
		}
		// TODO: Add a place for encoders
		// TODO: Add a encoder wheel
	}

	translate([0, 0, motor_d / 2 + platform_height]) {
		lf_motor_handle();
		mirror([0, 1, 0]) lf_motor_handle();
	}
}

lf(chassis_only = false);
translate([0, 0, -100]) lf();

