a = 0.4; // wall thickness
b = 0.2; // Inset for looseness
c = 6.0; // height of chamfer
d = 3.0; // width of chamfer
e = 3.0; // Gap for pegs
f = 32; // Base unit of width and length

l = 2*f-b; // outside length
w = 1*f-b; // outside width
h = 1*f; // height


hull() {
    translate([d,d,0]) cube([l-2*d,w-2*d,1]);
    translate([e,0,c]) cube([l-2*e,w,1]);
    translate([0,e,c]) cube([l,w-2*e,1]);
    translate([d-a,d-a,h-c-1]) cube([l-2*(d-a),w-2*(d-a),1]);
}
hull() {
    translate([d-a,d-a,h-c]) cube([l-2*(d-a),w-2*(d-a),1]);
    translate([0,0,h-0.1]) cube([l,w,0.1]);
}
