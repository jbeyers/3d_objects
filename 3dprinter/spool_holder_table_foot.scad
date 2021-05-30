a = 36; // Foot dimension
b = 1.2; // Wall thickness.
c = 8; // Shaft diameter
d = -4.6; // Angle 

// Todo: Cap can be smaller than the full width
// TODO: Make it customizable and upload to thingiverse
// TODO: Rounded/chamfered corners

difference() {
    cube([a + 2*b, a + 2*b, a + b + c], center=false);
    translate([b,b,0]) cube([a, a, a], center=false);
    translate([a/2 + b,a/2 + b,a + b + c/2]) {
        rotate([0,90,d]) cylinder(a + 2*b + 10, c/2,c/2,center=true);
        translate([0,0,c/2]) rotate([0,0,d]) cube([a + 2*b + 10, c, c], center=true);
    }
}
