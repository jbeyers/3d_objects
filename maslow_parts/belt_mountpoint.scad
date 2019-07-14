nozzle = 0.4; // Extrusion nozzle width
m6 = 3; // radius of holes.
peg = m6+3*nozzle; // Radius of pegs. We want the walls to be x times extrusion width
mounting_distance = 30; // Center to center distance between holes
belt_above_surface = 11.8; // Height of belt above surface.
side_support_offset = 12.5; // side support offset
lock_tab_r = 1.2; // Thickness of the locking strip

$fn=60;
belt_width = 6.2; // Belt width
belt_thickness = 1.5; // Belt thickness
belt_thickness_meshed = 2.3; // Thickness of 2 intermeshing belts
min_radius = min(1, belt_above_surface);
cyl_height = belt_above_surface + belt_width;
lock_tab_offset = peg + belt_thickness_meshed + lock_tab_r;
peg_2 = peg+belt_thickness_meshed-belt_thickness; // The second peg is slightly bigger.

module support(peg) {
hull() {
    cylinder(r=peg, h=belt_above_surface);
    translate([0,side_support_offset - min_radius, 0]) cylinder(r=min_radius, h=min_radius);
    translate([0,- lock_tab_offset, 0]) cylinder(r=lock_tab_r, h=belt_above_surface);
}
}

module base() {
    // The support structure
    hull () {
        support(peg);
        translate([mounting_distance,0, 0]) support(peg); 
    }

    // The second peg is bigger.
    translate([mounting_distance,0, 0]) support(peg_2); 

    // The belt mesh support
    hull () {
        cylinder(r=peg, h=cyl_height);
        translate([mounting_distance - 3*peg, 0,0]) cylinder(r=peg, h=cyl_height);
    }
    translate([mounting_distance,0,0]) cylinder(r=peg_2, h=belt_above_surface + belt_width);
    hull() {
        translate([0,0 - lock_tab_offset, 0]) cylinder(r=lock_tab_r, h=cyl_height);
        translate([mounting_distance,0 - lock_tab_offset, 0]) cylinder(r=lock_tab_r, h=cyl_height);
    }
}


difference() {
    base();
    cylinder(r=m6, h=cyl_height);
    translate([mounting_distance,0,0]) cylinder(r=m6, h=cyl_height);
}
