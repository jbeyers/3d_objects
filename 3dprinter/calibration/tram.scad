
a = 120; // Square size
b = 10; // radius of corners
w = 0.4; // Width of line
h = 1.4; // Height of wall
$fn=36;

hull() {
    translate([3*b,b,0]) cylinder(h, r=b);
    translate([b,3*b,0]) cylinder(h, r=b);
    translate([a-3*b,b,0]) cylinder(h, r=b);
    translate([a-b,3*b,0]) cylinder(h, r=b);
    translate([3*b,a-b,0]) cylinder(h, r=b);
    translate([b,a-3*b,0]) cylinder(h, r=b);
    translate([a-3*b,a-b,0]) cylinder(h, r=b);
    translate([a-b,a-3*b,0]) cylinder(h, r=b);
}
