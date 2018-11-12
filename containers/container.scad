a = 0.4; // wall thickness
b = 0.2; // Inset for looseness
c = 2.0; // height of chamfer
d = 0.4; // width of chamfer
e = 1.4; // Gap for pegs
f = 8; // Base unit of width and length
g = 9.6; // Base unit of height

l = 8*f-b; // outside length
w = 4*f-b; // outside width
h = 2*g; // height


hull() {
    translate([d,d,0]) cube([l-2*d,w-2*d,1]);
    translate([e,0,c]) cube([l-2*e,w,1]);
    translate([0,e,c]) cube([l,w-2*e,1]);
    translate([e,0,h-1]) cube([l-2*e,w,1]);
    translate([0,e,h-1]) cube([l,w-2*e,1]);
}
