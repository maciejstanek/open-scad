module adapter_template(pipe_inner_diameter, outlet_outer_diameter, wall_thickness, slope_length, section_length) {
	polygon([
		[outlet_outer_diameter / 2, 0],
		[outlet_outer_diameter / 2, section_length] ,
		[pipe_inner_diameter / 2 - wall_thickness, section_length + slope_length],
		[pipe_inner_diameter / 2 - wall_thickness, 2 * section_length + slope_length],
		[pipe_inner_diameter / 2, 2 * section_length + slope_length - wall_thickness],
		[pipe_inner_diameter / 2, section_length + slope_length],
		[outlet_outer_diameter / 2 + wall_thickness, section_length] ,
		[outlet_outer_diameter / 2 + wall_thickness, 0],
	]);
}

color("white") rotate_extrude($fn = 100) adapter_template(4.6, 7.6, 0.6, 3, 6);
