// Anti-wobble linear shaft, drive shaft and 2020 aligner.

bush_od = 13;
bush_l = 15;
nut_od = 22;
nut_id = 14;
nut_pcd = 12.7;
nut_hole = 3.2;
clearance = 0.5;


$fn=48;

h = 10;
w = 50;
l = 100;

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

module rounded_rectangle(w,l,h,d) {
    x = (w-d)/2;
    y = (l-d)/2;
    hull() {
        translate([x,y,0]) cylinder(h, d=d);
        translate([-x,y,0]) cylinder(h, d=d);
        translate([-x,-y, 0]) cylinder(h, d=d);
        translate([x,-y, 0]) cylinder(h, d=d);

    };
};


module flexure_cut(l,w,h,d) {
    x = l/2;
    y = w/2;
    hull() {
        translate([x,y,0]) cylinder(h, d=d);
        translate([-x,y,0]) cylinder(h, d=d);
    };
    hull() {
        translate([x,y,0]) cylinder(h, d=d);
        translate([x,-y,0]) cylinder(h, d=d);
    };
    hull() {
        translate([x,-y,0]) cylinder(h, d=d);
        translate([-x,-y,0]) cylinder(h, d=d);
    };
};

module simple_flexure(l,w,h,d) {
    flexure_cut(l,w,h,d);
    translate([-d,0,0]) rotate(180,0,0) flexure_cut(l-d-d,w-d-d-0.75,h,d);
}

// Whole thing

difference() {
rounded_rectangle(l, w, h, 5);
simple_flexure(35, 35, h+1, 1);
rotate(90,0,0) simple_flexure(25,28, h+1, 1);
cylinder(h+1,d=nut_od);
}

