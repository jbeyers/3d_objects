a = 5; // bed thickness
d = 5; //diameter of rounding
h = 60; // bed height
w = 60; // bed width

$fs=0.05;
$fa=1;
difference() {
    union() {
        cube([a,w,h], center=true);
        translate([a/2,(w-d)/2,0]) cylinder(h, d=d,center=true);
        translate([a/2,-(w-d)/2,0]) cylinder(h, d=d,center=true);
    }
    hull() {
        translate([a/2,(w-3*d)/2,(h-d)/2]) sphere(d=d,center=true);
        translate([a/2,-(w-3*d)/2,(h-d)/2]) sphere(d=d,center=true);
        translate([a/2,(w-3*d)/2,-(h-d)/2]) sphere(d=d,center=true);
        translate([a/2,-(w-3*d)/2,-(h-d)/2]) sphere(d=d,center=true);
    }
}
