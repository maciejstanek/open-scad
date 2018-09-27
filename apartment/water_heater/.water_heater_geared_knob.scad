external_d=42;
internal_d=38.5;
total_h=14;
fill_h=4.5;
separator_h=total_h-fill_h;
inner_axis_d=9.5;
fin_w=1.5;
fin_n=3;

difference() {
  union() {
    difference() {
      cylinder(d=internal_d,h=separator_h+fill_h,$fn=100);
      for(i=[1:fin_n]) {
        rotate([0,0,i*360/fin_n]) {
          translate([0,internal_d/4,0]) {
            cube([fin_w,internal_d/2+1,2*total_h+1],center=true);
          }
        }
      }
    }
    cylinder(d=external_d,h=separator_h,$fn=100);
  }
  translate([0,0,-1]) {
    cylinder(d=inner_axis_d,h=separator_h+fill_h+2,$fn=50);
  }
}
