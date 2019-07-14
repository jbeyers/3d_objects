a = 6;
b = 8.4;
c = 6;
d = 1.5;
e = 2.3;
f = 45;
g = 0;
h = 12;
$fn=60;
difference() {
//    translate([-50,0,-50]) cube([100,100,100]);
    difference() {
        cylinder(r=b/2, h=h+c);
        cylinder(r=a/2, h=h+c);
    }
    rotate(a=[0,0,45]) translate([-1.5,5,-8]) cube([3,3,30]);
    rotate(a=[0,0,135]) translate([-1.5,5,-8]) cube([3,3,30]);
    rotate(a=[0,0,225]) translate([-1.5,5,-8]) cube([3,3,30]);
    rotate(a=[0,0,-45]) translate([-1.5,5,-8]) cube([3,3,30]);
}
translate([0,30,0])
difference() {
    import ("Maslow_Nut_Mount.stl");
//    translate([-50,0,-50]) cube([100,100,100]);
    cylinder(r=15.9/2, h=20);
    translate([0,0,10]) rotate(a=[0,90,0]) cylinder(r=1.5, h=28, center=true);
    translate([0,0,10]) rotate(a=[90,0,0]) cylinder(r=1.5, h=28, center=true);
}
