spool_inner_diameter = 51;
spool_outer_diameter = 56.5;
axis_diameter = 8;
walls_thickness = 3;
spool_width = 80;
number_of_rays = 9;
hook_gap_angle = 47;
hook_depth = walls_thickness + 5;
ring_diameter = 24;
ring_thickness = 2;
ray_width = 6;

module cutout_fan() {
  for(a = [0, 90, 180, 270]) polygon([[0, 0], [9999 * sin(a), 9999 * cos(a)], [9999 * sin(hook_gap_angle + a), 9999 * cos(hook_gap_angle + a)]]);
}

rotate([0, 0, hook_gap_angle / 2]) difference() {
	union() {
	  linear_extrude(hook_depth, $fn = 100) union() {
      difference() {
        circle(d = spool_outer_diameter + 2 * walls_thickness);
        circle(d = spool_outer_diameter);
	    	cutout_fan();
      }
      difference() {
        circle(d = spool_inner_diameter);
        circle(d = spool_inner_diameter - 2 * walls_thickness);
      }
	  	difference() {
	  		circle(d = axis_diameter + 2 * walls_thickness);
	  		circle(d = axis_diameter);
	  	}
	  }
	  linear_extrude(walls_thickness, $fn = 100) union() {
	  	difference() {
        circle(d = spool_outer_diameter + 2 * walls_thickness);
       	circle(d = spool_inner_diameter);
    		cutout_fan();
    	}
    	rotate([0, 0, -hook_gap_angle / 2]) intersection() {
    		difference() {
    			for(a = [0, 90, 180, 270]) rotate([0, 0, a]) translate([0, -ray_width / 2, 0]) square([100, ray_width]);
    			circle(d = ring_diameter + 2 * walls_thickness - 1);
    		}
    		circle(d = spool_inner_diameter - 1);
    	}
	  }
	  linear_extrude(walls_thickness + ring_thickness, $fn = 100) difference() {
	  	circle(d = ring_diameter + 2 * walls_thickness);
	  	circle(d = axis_diameter);
	  }
	}
	translate([0, 0, -1]) linear_extrude(ring_thickness + 1, $fn = 100) circle(d = ring_diameter);
}

