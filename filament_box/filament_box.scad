///// Parameters /////

rod_diameter = 8;
holder_thickness = 5;
holder_length = 20;
holder_extension = 5;
base_size = 20;
base_thickness = 3;
ngon_count = 6;
screws_count = 3;
screws_diameter = 3;
screws_distance = base_size - 4;
screw_head_thickness = 1;
screw_head_size = screws_diameter + 2;
font = "Ubuntu Mono";
text_back = "3D";

///// Submodules /////

module holder_slice() union() {
  translate([rod_diameter / 2 + holder_thickness / 2, 0, 0]) circle(d = holder_thickness, center = true);
  translate([rod_diameter / 2, 0, 0]) square([holder_thickness , holder_length]);
}

module holder_template() union() {
  sphere(d = holder_thickness, center = true, $fn = 100);
  cylinder(h = holder_length, d = holder_thickness, $fn = 100);
}

module base_plate() difference() {
  // Plate
  hull() for(i = [0:ngon_count-1]) rotate(360 / ngon_count * i, [0, 0, 1]) translate([base_size, 0, 0]) union() {
    translate([0, 0, base_thickness - 1]) sphere(d = 2, center = true, $fn = 16);
    cylinder(h = base_thickness - 1, d = 2, $fn = 16);
  }
  // Screw holes
  for(m = [0:screws_count-1]) rotate(360 / screws_count * m, [0, 0, 1]) translate([-screws_distance, 0, -1]) {
    cylinder(h = base_thickness + 2, d = screws_diameter, $fn = 100);
    translate([0, 0, base_thickness + 2]) rotate([180, 0, 0]) cylinder(h = screw_head_thickness + 1, d = screw_head_size, $fn = 6);
  }
}

///// The box elements definition /////

module the_rod_holder_front() {
  base_plate();
  translate([0, 0, holder_length]) rotate([180, 0, 0]) {
    difference() {
      rotate_extrude($fn = 100) holder_slice();
      translate([50, 0, 0]) cube(100, center = true);
    }
    for(m = [-1,1]) translate([0, m * (rod_diameter / 2 + holder_thickness / 2), 0]) hull() {
      holder_template();
      translate([holder_extension, 0, 0]) holder_template();
    }
  }
}

module the_rod_holder_back() {
  difference() {
    base_plate();
    translate([0, 0, base_thickness - 1]) rotate([0, 0, -90]) linear_extrude(height = 2) text(text_back, 0.7 * base_size, font, $fn = 6, valign = "center", halign = "center", $fn = 100);
  }
}

module the_filament_output_front() {
  // TODO
}

module the_filament_output_back() {
  // TODO
}

///// Instances /////

translate([2 * base_size, 0, 0]) the_rod_holder_back();
translate([2 * base_size, 2 * base_size, 0]) the_rod_holder_front();
translate([0, 2 * base_size, 0]) the_filament_output_back();
the_filament_output_front();
