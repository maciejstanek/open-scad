#!/usr/bin/env python3
import argparse
import math

parser = argparse.ArgumentParser(description="Generate pot mold OpenSCAD description to the standard output")
parser.add_argument('--sides', type=int, default=16, help="Number of sides of the shape")
parser.add_argument('--height', type=float, default=100, help="Total height of the pot")
parser.add_argument('--diameter', type=float, default=120, help="Diameter of the pot")
parser.add_argument('--levels', type=int, default=5, help="Number of bands on the pot")
parser.add_argument('--dent', type=float, default=10, help="Size of extra dents")
parser.add_argument('--wall', type=float, default=1.5, help="Mold wall thickness")
parser.add_argument('--hole-diameter', type=float, default=80, help="Plant hole diameter")
parser.add_argument('--hole-depth', type=float, default=80, help="Plant hole depth")
parser.add_argument('--component', type=str, default="mold", help="Component to select ('mold', 'vase')")
args = parser.parse_args()
for arg in vars(args):
    print("// {} = {}".format(arg, getattr(args, arg)))
print("")

def generate_main_shape():
    print("module main_shape() {")
    faces = []
    last_level_points = [0] * args.sides
    for level in range(0, args.levels + 2):
        if level <= args.levels:
            this_level_points = [level*args.sides + x + 1 for x in range(0, args.sides)]
        else:
            this_level_points = [last_level_points[-1] + 1] * args.sides
        c1 = last_level_points
        c2 = [last_level_points[-1]] + last_level_points[0:-1]
        c3 = [this_level_points[-1]] + this_level_points[0:-1]
        c4 = this_level_points
        new_faces = [[], []]
        new_faces[0] += list(zip(c1, c2, c4))
        new_faces[0] += list(zip(c2, c3, c4))
        new_faces[1] += list(zip(c1, c2, c3))
        new_faces[1] += list(zip(c1, c3, c4))
        faces += new_faces[level % 2 == 0][0::2]
        faces += new_faces[level % 2 == 1][1::2]
        last_level_points = this_level_points
    print("  faces = [");
    for face in faces:
        print("    [{}],".format(", ".join(str(x) for x in face)))
    print("  ];");
    points = []
    points.append((0.0, 0.0, 0.0))
    last_level_points = [0] * args.sides
    for level in range(0, args.levels + 1):
        for side in range(0, args.sides):
            angle = 2.0 * math.pi * float(side) / float(args.sides)
            dent = float(args.dent if side % 2 == level % 2 and level < args.levels and level > 0 else 0)
            x = (dent + args.diameter) / 2.0 * math.sin(angle)
            y = (dent + args.diameter) / 2.0 * math.cos(angle)
            z = float(level) / float(args.levels) * args.height
            points.append((x, y, z))
    points.append((0.0, 0.0, float(args.height)))
    print("  points = [");
    for point in points:
        print("    [{}],".format(", ".join("{0:.1f}".format(x) for x in point)))
    print("  ];");
    print("  polyhedron(points, faces);");
    print("}");
generate_main_shape()
print("")

def scale_factor(n=1):
    return (args.diameter + 2*n*args.wall) / args.diameter
mold_hold_distance = args.diameter/2.0 + args.dent
print("module generate_mold_side() {")
print("  difference() {")
print("    cube([2*{0:.2f}, {1:.2f}, {2:.2f}]);".format(args.wall, mold_hold_distance, args.height))
print("    union() {")
print("      intersection() {")
print("        difference() {")
print("          scale([{0:.6f}, {0:.6f}, 1]) {{".format(scale_factor(3)))
print("            main_shape();")
print("          }")
print("          scale([{0:.6f}, {0:.6f}, 1]) {{".format(scale_factor(2)))
print("            main_shape();")
print("          }")
print("        }")
print("        for(h=[{0:.2f}:5*{0:.2f}:{1:.2f}]) {{".format(args.wall, args.height))
print("          translate([0, 0, h]) {")
print("            cylinder(d=4*{0:.2f}, h={1:.2f}, $fn=6);".format(mold_hold_distance, args.wall))
print("          }")
print("        }")
print("      }")
print("    }")
print("  }")
print("  difference() {")
print("    translate([0, 0, -{0:.2f}]) {{".format(args.wall))
print("      cube([10*{0:.2f}, {1:.2f}, {0:.2f}]);".format(args.wall, mold_hold_distance))
print("    }")
print("    mirror([0, 0, 1]) {")
print("      main_shape();")
print("    }")
print("  }")
print("}")
print("")

print("module mold_half() {")
print("  difference() {")
print("    union() {")
print("      scale([{0:.6f}, {0:.6f}, 1]) {{".format(scale_factor()))
print("        main_shape();")
print("      }")
print("      generate_mold_side();")
print("      mirror([0, 1, 0]) {")
print("        generate_mold_side();")
print("      }")
print("    }")
print("    main_shape();")
print("    mirror([1, 0, 0]) {")
print("      translate([0, -{0:.2f}, 0]) {{".format(mold_hold_distance))
print("        cube([{0:.2f}, 2*{0:.2f}, {1:.2f}]);".format(mold_hold_distance, args.height))
print("      }")
print("    }")
print("  }")
print("  mirror([0, 0, 1]) {")
print("    difference() {")
print("      intersection() {")
print("        scale([{0:.6f}, {0:.6f}, 1]) {{".format(scale_factor()))
print("          main_shape();")
print("        }")
print("        cube([2*{0:.2f}, 2*{0:.2f}, 2*{1:.2f}], center=true);".format(mold_hold_distance, args.wall))
print("      }")
print("      mirror([1, 0, 0]) {")
print("        translate([0, -{0:.2f}, 0]) {{".format(mold_hold_distance))
print("          cube([{0:.2f}, 2*{0:.2f}, {1:.2f}]);".format(mold_hold_distance, args.height))
print("        }")
print("      }")
print("      cylinder(h=2*{0:.2f}, d={1:.2f}, $fn=100);".format(args.wall, args.hole_diameter))
print("    }")
print("  }")
print("}")
print("")

vase_rounding_radius = 10
print("module inner_vase() {")
print("  rotate_extrude($fn=200) {")
print("    square([{0:.2f}, {1:.2f}]);".format(args.hole_diameter/2 - vase_rounding_radius, args.hole_depth))
print("    square([{0:.2f}, {1:.2f}]);".format(args.hole_diameter/2, args.hole_depth - vase_rounding_radius))
print("    translate([{0:.2f}, {1:.2f}]) {{".format(args.hole_diameter/2 - vase_rounding_radius, args.hole_depth - vase_rounding_radius))
print("      circle(r={0:.2f}, $fn=50);".format(vase_rounding_radius))
print("    }")
print("  }")
print("}")
print("")

if args.component == "mold":
    print("mold_half();")
elif args.component == "vase":
    print("inner_vase();")
