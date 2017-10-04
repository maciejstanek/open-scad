use <../wheels/wheel_d.scad>;
use <../motors/HL149.scad>;
use <../wheels/encoder_wheel.scad>;

module lf(chassis_only = true) {
	// TODO: Prepare a place for encoders
	// TODO: Add PCB case
	// TODO: Figure out how to fix the motor on its back

	filament_color = "DarkOrange";
	wheels_distance = 150;
	motor_d = 27.8;
	wall_thickness = 3;
	width = motor_d + 2 * wall_thickness;
	front_thickness = 4.4;
	d_holes_place = 19.6;
	d_holes = 3;
	platform_height = 5;
	shaft_hole_d = 9.4;
	wheel_d = 50;
	encoders_cutout_width = 36;
	echo(bottom_clearance = (wheel_d / 2 - motor_d / 2 - platform_height));
	core_length = 40;
	core_width = 80;

	module lf_motor_handle(chassis_only = chassis_only) {
		wheel_on_shaft_distance = 7.5;
		encoder_wheel_dictance = wheels_distance / 2 - 11;
		translate([0, wheels_distance / 2, 0]) union() {
			color(filament_color) rotate([-90, 0, 0]) linear_extrude(front_thickness) difference() {
				circle(d = width, $fn = 100);
				circle(d = shaft_hole_d, $fn = 100);
				translate([d_holes_place / 2, 0, 0]) circle(d = d_holes, $fn = 100);
				translate([-d_holes_place / 2, 0, 0]) circle(d = d_holes, $fn = 100);
			}
			if(!chassis_only) {
				color("Silver") HL149();
				rotate([270, 0, 0]) {
					color(filament_color) translate([0, 0, wheel_on_shaft_distance]) wheel_d(wheel_d);
					color("DimGray") translate([0, 0, -encoder_wheel_dictance]) encoder_wheel();
				}
			}
		}
	}

	union() {
		translate([-width / 2, -wheels_distance / 2 - front_thickness, 0]) difference() {
			color(filament_color) union() {
				difference() {
					cube([width, wheels_distance + 2 * front_thickness, platform_height + motor_d / 2]);
					translate([width / 2, 0, platform_height + motor_d / 2]) rotate([270, 0, 0]) translate([0, 0, -1]) cylinder(d = motor_d, h = 2 * (wheels_distance + front_thickness + 1), $fn = 100);
					translate([wall_thickness, front_thickness + wheels_distance / 2 - encoders_cutout_width / 2, platform_height]) difference() {
						cube([width, encoders_cutout_width, motor_d + 1]);
						// translate([-1, -1, 0]) cube([2, encoders_cutout_width + 2, 1 + 1]);
					}
				}
				translate([width, core_width / 2, 0]) cube([core_length, core_width, platform_height]);
			}
		}
		translate([0, 0, motor_d / 2 + platform_height]) {
			lf_motor_handle();
			mirror([0, 1, 0]) lf_motor_handle();
		}
	}
}

lf(chassis_only = false);
translate([0, 0, -100]) lf();

