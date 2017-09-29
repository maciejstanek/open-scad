use <../wheels/wheel_d.scad>;
use <../motors/HL149.scad>;

filament_color = "GreenYellow";
wheels_distance = 150;

module drive() {
	color("Silver") rotate([0, 0, 180]) translate([0, -8, 0]) HL149();
	rotate([90, 0, 0]) color(filament_color) wheel_d();
}

translate([0, wheels_distance, 0]) rotate([0, 0, 180]) drive();
drive();
