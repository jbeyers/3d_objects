a = 5; // bed thickness
d = 5; //diameter of rounding
h = 60; // bed height
w = 60; // bed width
r = 10;

// Calculations
v_step = 10; // Rough vertical step size
r_step = 20;

$fs=2;
$fa=1;
v_offsets = rands(-3,3,r_step*v_step);
r_offsets = rands(-5,5,r_step*v_step);
difference() {
    translate([0,0,h/2]) cylinder(h, d=w*1.2,center=true);
    for (i=[0:r_step]) {
        for (j=[0:v_step]) {
            if (floor(j/2.0)==ceil(j/2.0)) {
                rotate(r_offsets[j+j*i] + 360*(i+0.5)/r_step, [0,0,1]) translate([w/2+5,0,v_offsets[j+j*i]+h*j/v_step]) sphere(r=r);
            } else {
                rotate(r_offsets[j+j*i] + 360*i/r_step, [0,0,1]) translate([w/2+5,0,v_offsets[j+j*i]+h*j/v_step]) sphere(r=r);
            }
        }
    }
}
