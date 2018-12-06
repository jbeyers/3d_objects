// Flexure for pen holder
mat_th = 39;
z = mat_th*3;
x = 100;
y = 90;
oilite_d = 11;
oilite_l = 15;
// Flexure constraints
flex_r = 4.25;
flex_l = 40;
flex_t = 6;
flex_h = 1;

flex_spacing = 9;

servo_w = 12.3;
servo_h = 27.5;

module flexcut() {
    translate([0,flex_r+flex_h/2,0]) {
        translate([flex_r,0,0]) cylinder(h=x,r=flex_r);
        translate([flex_l-flex_r,0,0]) cylinder(h=x,r=flex_r);
    }
    translate([flex_r, flex_t/2, 0]) cube([flex_l-2*flex_r, flex_r*2 + flex_h - flex_t, z]);
    mirror([0,1,0]) {
    translate([0,flex_r+flex_h/2,0]) {
        translate([flex_r,0,0]) cylinder(h=x,r=flex_r);
        translate([flex_l-flex_r,0,0]) cylinder(h=x,r=flex_r);
    }
    translate([flex_r, flex_t/2, 0]) cube([flex_l-2*flex_r, flex_r*2 + flex_h - flex_t, z]);
    }
}

module flexure() {
difference () {
    translate([0,0,z/3]) cube([x, y, z/3]);
    translate([20,4.5,0])
    {
    flexcut();
    translate([0,12,0]) flexcut();
    translate([0,24,0]) flexcut();
    translate([0,36,0]) flexcut();
    translate([0,-7,0]) cube([flex_l+10,2,z]);
    translate([0,5,0]) cube([flex_l+10,2,z]);
    translate([0,17,0]) cube([flex_l+10,2,z]);
    translate([0,29,0]) cube([flex_l+10,2,z]);
    translate([0,41,0]) cube([flex_l+10,4,z]);
    translate([0,41,0]) cube([16,20+servo_w,z]);
    translate([16,61,0]) cube([servo_h,servo_w,z]);
    translate([10,61,0]) cube([10,20,z]);
    }
    translate([64,-4.5,0])
    {
    cube([6,6,z]);
    translate([0,12,0]) cube([6,6,z]);
    translate([0,24,0]) cube([6,6,z]);
    translate([0,36,0]) cube([6,6,z]);
    translate([0,48,0]) cube([6,6,z]);
    }
    translate([67,1.5,0])
    {
    cube([6,6,z]);
    translate([0,12,0]) cube([6,6,z]);
    translate([0,24,0]) cube([6,6,z]);
    translate([0,36,0]) cube([6,6,z]);
    }
    translate([90,20,0]) cylinder(h=z, r=6);
    translate([90,16,0]) cube([20,8,z]);
}
}

difference() {
translate([-5,-5,0]) cube([110,100,1]);
translate([0,0,-z/2]) flexure();
}
