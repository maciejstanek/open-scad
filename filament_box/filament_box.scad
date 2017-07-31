///// Parameters /////

rod_diameter = 8;
holder_thickness = 5;
holder_length = 20;
holder_extension = 5;
base_size = 20;
base_thickness = 4;
ngon_count = 6;
screws_count = 3;
screws_diameter = 3;
screws_distance = base_size - 4;
screw_head_thickness = base_thickness - 2.5;
screw_head_size = screws_diameter + 2;
font = "Ubuntu Mono";
text_back = "3D";
filament_thickness = 2;
tube_side_thickness = 3;
tube_base_radius = 9;
tube_height = 20;
tube_polygon_count = 100;

///// Submodules /////

module holder_slice() {
  translate([rod_diameter / 2 + holder_thickness / 2, 0, 0]) circle(d = holder_thickness, $fn = 100);
  translate([rod_diameter / 2, 0, 0]) square([holder_thickness , holder_length]);
}

module holder_template() {
  sphere(d = holder_thickness, center = true, $fn = 100);
  cylinder(h = holder_length, d = holder_thickness, $fn = 100);
}

module tube_slice() {
  translate([tube_height - tube_side_thickness / 2, tube_side_thickness / 2, 0]) circle(d = tube_side_thickness, $fn = 100);
  square([tube_height - tube_side_thickness / 2, tube_side_thickness]);
  translate([0, tube_side_thickness, 0]) difference() {
    square(tube_base_radius);
    translate([tube_base_radius, tube_base_radius, 0]) circle(r = tube_base_radius, $fn = 100);
  }
}

module base_plate(holes) {
  difference() {
    // Plate
    hull() for(i = [0:ngon_count-1]) rotate(360 / ngon_count * i, [0, 0, 1]) translate([base_size, 0, 0]) union() {
      translate([0, 0, base_thickness - 1]) sphere(d = 2, center = true, $fn = 16);
      cylinder(h = base_thickness - 1, d = 2, $fn = 16);
    }
    // Screw holes
    for(m = [0:screws_count-1]) rotate(360 / screws_count * m, [0, 0, 1]) translate([-screws_distance, 0, -1]) {
      cylinder(h = base_thickness + 2, d = screws_diameter, $fn = 100);
      if(holes == true) translate([0, 0, base_thickness + 2]) rotate([180, 0, 0]) cylinder(h = screw_head_thickness + 1, d = screw_head_size, $fn = 6);
    }
  }
}

///// Main Modules /////

module the_rod_holder_front() {
  base_plate();
  translate([0, 0, holder_length + base_thickness]) rotate([180, 0, 0]) {
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
    base_plate(holes = true);
    translate([0, 0, base_thickness - 1]) rotate([0, 0, -90]) linear_extrude(height = 2) text(text_back, 0.7 * base_size, font, $fn = 6, valign = "center", halign = "center", $fn = 100);
  }
}

module the_filament_output_front() {
  translate([0, 0, base_thickness]) rotate_extrude($fn = 100, convexity = 10) translate([filament_thickness / 2, 0, 0]) rotate([180, 0, 90]) tube_slice();
  difference() {
    base_plate(holes = true);
    translate([0, 0, -1]) cylinder(h = base_thickness + 2, d = filament_thickness, $fn = 100);
  }
}

module the_filament_output_back() {
  difference() {
    base_plate();
    translate([0, 0, base_thickness]) rotate_extrude($fn = 100) rotate([180, 0, 270]) {
      translate([-1, 0, 0]) square([1, base_thickness + filament_thickness / 2]);
      difference() {
        square([base_thickness, base_thickness + filament_thickness / 2]);
        translate([base_thickness, base_thickness + filament_thickness / 2]) circle(r = base_thickness, $fn = 100);
      }
      translate([base_thickness - 1, 0, 0]) square([2, filament_thickness / 2]);
    }
  }
}

///// Instances /////

spread = 2.5 * base_size;
translate([spread, 0, 0]) the_rod_holder_back();
translate([spread, spread, 0]) the_rod_holder_front();
translate([0, spread, 0]) the_filament_output_back();
the_filament_output_front();
