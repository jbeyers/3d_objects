$fn=48;
base_l = 32; // outside length. Default to 4 X 4 lego brick size
base_h = 9.6; // Default to lego brick height. Add 1/2 r to the individual height to allow for nesting when stacked.
r = 3.2; // Radius of the edges, but also determines some other things. Do NOT change!

w = 3; // So many base_l units wide
l = 1; // So many base_l units long
h = 2; // So many base_h units high.


// A truncated pyramid, pointing down. Base for the waffle grid
module pyramid() {
    hull() {
        translate([r, r, 0]) cylinder(r/2.0, r/2.0, r);
        translate([base_l-r, r, 0]) cylinder(r/2.0, r/2.0, r);
        translate([base_l-r, base_l-r, 0]) cylinder(r/2.0, r/2.0, r);
        translate([r, base_l-r, 0]) cylinder(r/2.0, r/2.0, r);
    }
}

// Storage box
module box(w, l, h, r) {
    x = w * base_l;
    y = l * base_l;
    z = h * base_h;
    hr = r/2.0;
    difference() {
        // Main body
        hull() {
            translate([r, r, hr]) cylinder(z-0.4, r, r);
            translate([x-r, r, hr]) cylinder(z-0.4, r, r);
            translate([x-r, y-r, hr]) cylinder(z-0.4, r, r);
            translate([r, y-r, hr]) cylinder(z-0.4, r, r);
        };
        // Cut out waffle pattern at the top
        for (a = [1: 1: w]) {
            for (b = [1: 1: l]) {
                translate([(a-1)*base_l,(b-1)*base_l,0]) {
                    translate([0,0,z]) pyramid();
                }
            }
        };
        // Cut out the waffle connecting lines at the top
        hull() {
            translate([r, r, r]) cylinder(z, hr, hr);
            translate([x-r, r, r]) cylinder(z, hr, hr);
            translate([x-r, y-r, r]) cylinder(z, hr, hr);
            translate([r, y-r, r]) cylinder(z, hr, hr);
        };
        
    }
    // Add waffle pattern at the bottom
    for (a = [1: 1: w]) {
        for (b = [1: 1: l]) {
            translate([(a-1)*base_l,(b-1)*base_l,0]) {
                pyramid();
            }
        }
    }
}
box(w, l, h, r);