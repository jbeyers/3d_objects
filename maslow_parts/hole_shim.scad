
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

$fn=60;

difference() {
    cylinder(r=m6+nozzle, h=16);
}
