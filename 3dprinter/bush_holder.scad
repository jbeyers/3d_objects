// Parametric holder to affix a sliding bush to a flat platform, hanging off the side of the platform, with the bearing top in line with the platform. Designed to snap onto the bearing, and to be printed on its side to maximise strength.

$fn=48;
a = 24.0; // Holder flat part width
b = 4.0; // Holder flat part thickness
c = 80.0; // Holder flat part length
d = 0.8; // Shaft clearances.
e = 13.0; // Bush OD
f = 8; // Bush ID
g = 15; // Bush length + 2
h = 3.2; // Bush offset from chipboard. Multiple of 0.4, just enough to clear cable tie
i = 4; // Cable tie slot width
j = 4.2; // Screw hole id
k = 8; // Screw countersink hole size
l = 1; // Screw hole guide size
m = 1.2; // Bush side holding flange
p1 = 8; // hole 1 distance
p2 = 19.2; // hole 2 distance

holder_w = m*2+g;

module screw_hole(d1, d2, h1, h2) {
    union() {
        cylinder(h2, d=d1);
        translate([0,0,h1]) cylinder((d2-d1)/2, d1=d1, d2=d2);
        translate([0,0,h1+(d2-d1)/2]) cylinder(h2-h1-(d2-d1)/2, d=d2);
    }
}

difference() {
    // Base block
    cube([a+h+e/2+d,holder_w,b+e/2]);
    // Cutout for chipboard
    translate([0,0,b]) cube([a,holder_w,e/2]);
    // Bush
    translate([a+h,m,b]) cube([e,g,e]);
    // bush end stops/shaft clearance
    translate([a+h+2,0,b]) cube([e,holder_w,e]);
    // Slots for cable ties
    translate([a,m+g/2-i/2,0]) cube([1.6,h,b+e/2]);
    // Screw holes
    translate([a-p1,holder_w/2,b]) rotate([180, 0, 0]) screw_hole(j,8, 0.2, 15);
    translate([a-p2,holder_w/2,b]) rotate([180, 0, 0]) screw_hole(j,8, 0.2, 15);
    // Cutout for the mounting/alignment screw
    translate([13,holder_w-21,0]) cylinder(b,r=7);
}