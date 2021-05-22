// Parametric holder to affix a sliding bush to a flat platform, hanging off the side of the platform, with the bearing top in line with the platform. Designed to snap onto the bearing, and to be printed on its side to maximise strength.

// a is the base 'plate'
// b is the bush
// c is the upright spacer to offset the bush from the chipboard
// d is the cable tie slot
// h is screw dimensions
// f is the side flanges to locate the bearing
$fn=48;
a1 = 24.0; // Holder flat part width (Just to the chipboard edge)
a3 = 4.0; // Holder flat part thickness
bo = 13.0; // Bush OD
bi = 8; // Bush ID
b3 = 15; // Bush length
zl = 0.8; // Shaft clearances.
c1 = 3.2; // Bush offset from chipboard. Multiple of 0.4, just enough to clear cable tie
d1 = 1.6; // Cable tie slot depth
d2 = 5; // Cable tie slot width
hi = 4.2; // Screw hole id
ho = 8; // Screw countersink hole size
l = 1; // Screw hole guide size
f2 = 1.6; // Bush side holding flange
f3 = 2.2; // Bush side holding flange
p1 = 8; // hole 1 distance
p2 = 19.2; // hole 2 distance

a2 = b3 + f2*2 + zl*2;

module screw_hole(d1, d2, h1, h2) {
    // d1: hole id
    // d2: countersink hole id
    // h2: Total hole length
    union() {
        // Small hole all the way through
        cylinder(h2, d=d1);
        translate([0,0,h1]) cylinder((d2-d1)/2, d1=d1, d2=d2);
        translate([0,0,h1+(d2-d1)/2]) cylinder(h2-h1-(d2-d1)/2, d=d2);
    }
}

difference() {
    // Base block
    cube([a1+c1+bo/2,a2,a3+bo/2]);
    // Cutout for chipboard
    translate([0,0,a3]) cube([a1,a2,bo/2]);
    // Bush
    translate([a1+c1,f2+zl,a3]) cube([bo,b3,bo]);
    // bush end stops/shaft clearance
    translate([a1+c1,0,a3+f3]) cube([bo,a2,bo]);
    // Slots for cable ties
    translate([a1,(a2-d2)/2,0]) cube([d1,d2,a3+bo/2]);
    // Screw holes
    translate([a1-p1,a2/2,a3]) rotate([180, 0, 0]) screw_hole(hi,ho, 1.4, a3);
    translate([a1-p2,a2/2,a3]) rotate([180, 0, 0]) screw_hole(hi,ho, 1.4, a3);
    // Cutout for the mounting/alignment screw
    translate([a1-12,a2-21,0]) cylinder(a3,r=7);
}