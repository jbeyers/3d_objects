a = 6.35; // hex bit size
b = 0.4; // Wall thickness.
c = 15; // Height
t = 0.25; // tolerance for wall thickness 
l = a*tan(30);


module hexa(a,h) {
    l = a*tan(30);
    echo(l);
    union() {
        cube([a, l, h], center=true);
        rotate([0,0,60])
        cube([a, l, h], center=true);
        rotate([0,0,120])
        cube([a, l, h], center=true);
    }
}
module row(size, spacing, bits, h) {
face = size*tan(30);
for( i= [1:bits]) {
    translate([i*(size+spacing), 0, 0]) hexa(size,h);
}
translate([size,-face/2,0]) cube([bits*size,face,h]);
}


f = a+2*t;
face = f*tan(30);
spacing = face + b/2*tan(30);
difference() {
    cube([8*f, 14*spacing,c]);
    for(i=[0:5]) {
        translate([0, (3*i-0.5)*(face+b/2*tan(30)), 0]) row(f,b, 8, c*3);
}
}
