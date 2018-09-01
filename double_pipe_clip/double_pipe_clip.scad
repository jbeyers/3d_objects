a = 20; // Pipe diameter
b = 3.2; // Thickness of clip
c = 8; // Height of clip

$fs=0.05;
$fa=1;
module ring () {
    cube([10,10+b/2,c], center=true);
    translate([0,(a+b/2)/2+5, 0])
        rotate([0,0,45])
        difference() {
            cylinder(c, d=a+b,center=true);
            cylinder(c, d=a,center=true);
            translate([0,0,-a/2]) cube([a,a,a]);
        }
}

ring();
mirror([0,1,0]) ring();
