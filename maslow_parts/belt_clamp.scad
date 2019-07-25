ooze = 0.15; // My machine has a wall ooze (extra width) of about 0.15mm.
nozzle = 0.4; // Extrusion nozzle width
mounting_distance = 40; // Center to center distance between holes
belt_above_surface = 3; // Height of belt above surface.
lock_tab_r = 1.2; // Thickness of the locking strip

$fn=60;
belt_width = 15.2; // Belt width
belt_thickness_meshed = 4; // Thickness of 2 intermeshing belts

module side(h){
hull () {
    cylinder(r=lock_tab_r, h=h);
    translate([mounting_distance,0, 0]) cylinder(r=lock_tab_r, h=h);
}
}
// Uncomment the mirror to get a mirror image of the mounting.
// mirror([0,1,0]) {
sidy = lock_tab_r*2 + ooze*2 + belt_thickness_meshed;
union() {
    hull() {
        side(3);
        translate([0,sidy,0]) side(3);
    }
    side(3 + belt_width);
    translate([0,sidy,0]) side(3 + belt_width);
}
// }
