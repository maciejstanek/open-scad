inf=9999999;
can_height=108;
can_diameter=74;
bottom_thickness=1;
walls_thickness=1;
base_height=3;
lower_band_height=2;

whole_diameter=can_diameter+2*walls_thickness;
whole_height=can_height+bottom_thickness+base_height;

module main_cup() {
  base_legs_count=6;
  base_legs_circumference_ratio=0.2;
  base_legs_thickness=3;
  bottom_hole_diameter=4;
  number_of_bottom_holes=70;

  base_legs_angle_per_segment=360/base_legs_count;
  base_legs_angle_per_leg=base_legs_circumference_ratio*base_legs_angle_per_segment;
  half_side_holes_count=ceil(sqrt(number_of_bottom_holes)/2);

  difference() {
    cylinder(h=whole_height,d=whole_diameter,$fn=100);
    translate([0,0,whole_height-can_height]) cylinder(h=inf,d=can_diameter,$fn=100);
    cylinder(h=base_height,d=whole_diameter-2*base_legs_thickness,$fn=100);
    for(i=[1:base_legs_count]) {
      start_angle=i*base_legs_angle_per_segment;
      end_angle=start_angle+base_legs_angle_per_leg;
  
      start_x=whole_diameter*cos(start_angle);
      start_y=whole_diameter*sin(start_angle);
      end_x=whole_diameter*cos(end_angle);
      end_y=whole_diameter*sin(end_angle);
      linear_extrude(height=base_height) polygon(points=[[0,0],[start_x,start_y],[end_x,end_y]]);
    }
    for(x=[-half_side_holes_count:half_side_holes_count]) {
      for(y=[-half_side_holes_count:half_side_holes_count]) {
        x_real=x*(whole_diameter/2)/half_side_holes_count;
        y_real=y*(whole_diameter/2)/half_side_holes_count;
        if(sqrt(x_real*x_real+y_real*y_real) < whole_diameter/2) {
          translate([x_real,y_real,0]) cylinder(d=bottom_hole_diameter,h=inf,$fn=20);
        }
      }
    }
  }
}

module binary_side_holes() {
  upper_band_height=4;
  number_of_slots=40;
  slots_circumference_ratio=0.4;
  bits_count=8;

  slots_height=can_height-upper_band_height-lower_band_height;
  one_slot_with_support_angle=360/number_of_slots;
  one_slot_angle=slots_circumference_ratio*one_slot_with_support_angle;
  bit_height=slots_height/bits_count;

  for(i=[0:number_of_slots-1]) {
      start_angle=i*one_slot_with_support_angle;
      end_angle=start_angle+one_slot_angle;
  
      start_x=whole_diameter*cos(start_angle);
      start_y=whole_diameter*sin(start_angle);
      end_x=whole_diameter*cos(end_angle);
      end_y=whole_diameter*sin(end_angle);
      for(b=[0:bits_count-1]) {
        if(rands(0,1,1)[0] > 0.7) {
          translate([0,0,b*bit_height]) linear_extrude(height=bit_height) {
            polygon(points=[[0,0],[start_x,start_y],[end_x,end_y]]);
          }
        }
      }
  }
}

difference() 
{
  side_holes_elevation=base_height+bottom_thickness+lower_band_height;
  main_cup();
  translate([0,0,side_holes_elevation]) binary_side_holes();
}
