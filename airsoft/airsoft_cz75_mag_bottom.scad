$fs=0.002;
difference() {

    union() {
        minkowski() {
            intersection() {
                cylinder(11, r=30);
                color("red", 1)
                    translate([-4.25,0,0])
                    cube([8.5,30, 11]);
            }
            cylinder(3, r=10);
        }
        translate([-14.25,-20,0])
            cube([28.5,20,14]);
    }

    intersection() {
        minkowski() {
            intersection() {
                cylinder(2, r=30);
                translate([-4.25,0,0])
                    cube([8.5,30, 2]);
            }
            cylinder(1, r=9);
        }
        translate([-25,18,0])
            cube([50,30, 3]);
    }

    intersection() {
        minkowski() {
            intersection() {
                cylinder(11, r=30);
                translate([-4.25,0,0])
                    cube([8.5,30, 11]);
            }
            cylinder(1, r=9);
        }
        translate([-9,-20,0])
            cube([18,120, 120]);
    }
    rotate([20,0,0]) {
        translate([-50,-100,0])
            cube([100,100,100]);
    }
    translate([19.8/2.0,31,0])
        cylinder(100, r=1);
    translate([-19.8/2.0,31,0])
        cylinder(100, r=1);
    translate([19.8/2.0,23,0])
        cylinder(100, r=1);
    translate([-19.8/2.0,23,0])
        cylinder(100, r=1);
}
