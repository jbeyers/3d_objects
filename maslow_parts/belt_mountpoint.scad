// The arms are designed to be spaced 18mm apart, using 25mm wide aluminium flat bar.
// This fits a 6mm belt with 6mm space between them.
// For that, print 4 blocks with the following dimensions:
// belt_above_surface = 11.8;
// side_support_offset = 12.5;
//
// For a 15mm lift from the sled surface (2.5mm thick alu bar plus 12.5mm clearance for the bolts):
//
// print 2 of these:
// belt_above_surface = 15;
// side_support_offset = 20;
//
// Also print 2 of these:
// Uncomment the mirroring
// belt_above_surface = 27; // 15mm plus belt height plus spacing inbetween
// side_support_offset = 30;
//
//
ooze = 0.15; // My machine has a wall ooze (extra width) of about 0.15mm.
nozzle = 0.4; // Extrusion nozzle width
m6 = 3 + ooze; // radius of holes.
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
lock_tab_offset = peg + belt_thickness_meshed + lock_tab_r + 2*ooze;
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

// Uncomment the mirror to get a mirror image of the mounting.
// mirror([0,1,0]) {
difference() {
    base();
    cylinder(r=m6, h=cyl_height);
    translate([mounting_distance,0,0]) cylinder(r=m6, h=cyl_height);
}
// }
