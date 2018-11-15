module regular_polygon(order, r=1){
    angles=[ for (i = [0:order-1]) i*(360/order) ];
    coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
    polygon(coords);
}

difference() {
    hull() {
        translate([10,10,0]) cylinder(h=13, r=5);
        translate([10,30,0]) cylinder(h=13, r=5);
        translate([80,20,0]) cylinder(h=13, r=20);
        translate([150,10,0]) cylinder(h=13, r=5);
        translate([150,30,0]) cylinder(h=13, r=5);
    }
    //cube([160,40,13]);
    translate([10,10,0]) cube([20,20,25]);
    translate([130,10,0]) cube([20,20,25]);
    translate([80,20,0]) cylinder(h=50, r=11);
    translate([80,20,5]) linear_extrude(height=40) regular_polygon(6, r=18.5);
}
