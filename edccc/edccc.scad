// EDC Credit Card minimalist wallet

// CC size: 85.60 mm × 53.98 mm × 0.76 mm
// https://en.wikipedia.org/wiki/Credit_card#Dimensions
// corner radius: 3.175 mm
// The side scales are exact credit card dimensions.
include <BOSL2/std.scad>;
include <BOSL2/rounding.scad>;

$fn = $preview ? 32 : 128;

// Start with a CC sized block with rounded corners
cc_length = 85.60;
cc_width = 53.98;
cc_thickness = 0.76;
corner_radius = 3.175;
// Rounded corner height for roughly 45 degree bevel on edges for easy printing.
// Roughly sqrt(2) * corner_radius / 2 = 2.24
radiused_height = 2.3;

// module credit_card_block(length=cc_length, width=cc_width, h=cc_thickness, corner_radius=corner_radius, bottom_locator=true, top_locator=true) {
//     hull() {
//         translate([corner_radius, corner_radius, 0]) cylinder(h=h, r=corner_radius);
//         translate([length-corner_radius, corner_radius, 0]) cylinder(h=h, r=corner_radius);
//         translate([corner_radius, width-corner_radius, 0]) cylinder(h=h, r=corner_radius);
//         translate([length-corner_radius, width-corner_radius, 0]) cylinder(h=h, r=corner_radius);
//     }
// }

// module credit_card_block_chamfered(h1, h2) {
//     hd = h2 - h1;
//     hull() {
//         translate([corner_radius, corner_radius, 0]) cylinder(h=h1, r=corner_radius);
//         translate([cc_length-corner_radius, corner_radius, 0]) cylinder(h=h1, r=corner_radius);
//         translate([corner_radius, cc_width-corner_radius, 0]) cylinder(h=h1, r=corner_radius);
//         translate([cc_length-corner_radius, cc_width-corner_radius, 0]) cylinder(h=h1, r=corner_radius);

//         translate([corner_radius+hd, corner_radius+hd, 0]) cylinder(h=h2, r=corner_radius);
//         translate([cc_length-corner_radius-hd, corner_radius+hd, 0]) cylinder(h=h2, r=corner_radius);
//         translate([corner_radius+hd, cc_width-corner_radius-hd, 0]) cylinder(h=h2, r=corner_radius);
//         translate([cc_length-corner_radius-hd, cc_width-corner_radius-hd, 0]) cylinder(h=h2, r=corner_radius);
//     }
// }

// module credit_card_block_rounded() {
//     difference() {
//         hull() {
//             translate([corner_radius, corner_radius, 0]) sphere(h=cc_thickness+1, r=corner_radius);
//             translate([cc_length-corner_radius, corner_radius, 0]) sphere(h=cc_thickness+1, r=corner_radius);
//             translate([corner_radius, cc_width-corner_radius, 0]) sphere(h=cc_thickness+1, r=corner_radius);
//             translate([cc_length-corner_radius, cc_width-corner_radius, 0]) sphere(h=cc_thickness+1, r=corner_radius);
//         };
//         translate([0,0,-10]) cube([cc_length, cc_width, 10]);
//         translate([0,0,radiused_height]) cube([cc_length, cc_width, 10]);

//     }
// }

// credit_card_block_chamfered(0.6, 1.2);
// credit_card_block_rounded();
// credit_card_block();
// diff() {
//     // cuboid([cc_length, (cc_width - 11) / 2, 1.3], anchor = BOTTOM + LEFT + FRONT, rounding= corner_radius, edges= [LEFT + FRONT, RIGHT + FRONT])
//     cuboid([cc_length, (cc_width - 11) / 2, 1.3], anchor = BOTTOM + LEFT + FRONT)
//         edge_mask([LEFT + FRONT, RIGHT + FRONT]) rounding_edge_mask(r1=1.3, r2=corner_radius, h=1.3)
//         edge_profile([TOP + LEFT, TOP + FRONT, TOP + RIGHT]) mask2d_roundover(r=1.3);

// }
// back((cc_width -11) / 2) cuboid([cc_length, 11, 0.7], anchor = BOTTOM + LEFT + FRONT, rounding= 0.7, edges= [LEFT + TOP, RIGHT + TOP]);
// back((cc_width+11) / 2) cuboid([cc_length, (cc_width -11) / 2, 1.3], anchor = BOTTOM + LEFT + FRONT, rounding= corner_radius, edges= [LEFT + BACK, RIGHT + BACK]);

module donut(){
    rotate_extrude(convexity = 10)
        translate([corner_radius-1.3, 0, 0])
            circle(r = 1.3, $fn = 100);
    }

module cc_rounded_with_rubber_band_slot() {
    difference() {
        hull() {
            translate([corner_radius, corner_radius, 0]) donut();
            translate([cc_length-corner_radius, corner_radius, 0]) donut();
            translate([corner_radius, cc_width-corner_radius, 0]) donut();
            translate([cc_length-corner_radius, cc_width-corner_radius, 0]) donut();
        }
        down(3) cube([cc_length, cc_width, 3], anchor = BOTTOM + LEFT + FRONT);
        up(0.6) back((cc_width -11) / 2) cuboid([cc_length, 11, 0.7], anchor = BOTTOM + LEFT + FRONT);
        back((cc_width -11) / 2) left(10) cuboid([10, 11, 0.6], anchor = BOTTOM + LEFT + FRONT, rounding = -0.3, edges= [TOP + LEFT, TOP + RIGHT]);
        back((cc_width -11) / 2) right(cc_length) cuboid([10, 11, 0.6], anchor = BOTTOM + LEFT + FRONT, rounding = -0.3, edges= [TOP + LEFT, TOP + RIGHT]);
    }
}

module credit_card_block(length=cc_length, width=cc_width, h=cc_thickness, corner_radius=corner_radius, bottom_locator=true, top_locator=true) {
    cuboid([length, width, h], anchor = BOTTOM+LEFT+FRONT, rounding=corner_radius, edges=[FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT]);
    if (bottom_locator) {
        // Locator notch on bottom edge
        down(0.1) front(0.1) cube([15, 5, 0.2], anchor = BOTTOM+LEFT+FRONT);
    }
    if (top_locator) {
        // Locator notch on top edge
        up(h-0.1) back(0.1) cube([15, 5, 0.2], anchor = TOP+LEFT+BACK);
    }
    
}

hole_radius = 14.7/2;
module rolson() {
    intersection() {
        cube([89,45,2.1]);
        right(11) back(13) cylinder(h=2.1, r=(hole_radius + 57.8), $fn=64);
    }
    right(11) back(13) cylinder(h=2.1, r=(hole_radius + 8.5), $fn=64);
    back(46.2) left(5) cube([60,2.4,2.1]);
    back(45) right(55) cube([5,3.6,2.1]);
    back(45) cube([22,3.6,2.1]);
    back(15) left(5) cube([0.8,31.2,2.1]);
    // left(1.4) cube(11,11,2.1);
    left(1.9) cube([11,11,2.1]);
    hull() {
        back(25) left(5) cube([0.8,21.2,2.1]);
        back(46.2) left(5) cube([4,2.4,2.1]);
    }
}
module cc_cc_edc_holder() {

    difference() {
        rolson();
        right(11) back(13) cylinder(h=2.1, r=hole_radius, $fn=64);
    }
}

//  up(35) cc_rounded_with_rubber_band_slot();
// credit_card_block(bottom_locator=false, top_locator=false);
difference() {
    credit_card_block(h=2.6, bottom_locator=false, top_locator=false);
    up(0.5) right(7) cc_cc_edc_holder();
}
