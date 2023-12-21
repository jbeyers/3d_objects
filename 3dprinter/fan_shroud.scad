// Parametric fan shroud and holder for a square fan.

$fn=48;

fw = 30; // fan square outside width
fd = 28.2; // Fan duct diameter. Manipulated to get 0.8 wall thickness
fh = 10.5; // Fan depth
fcd = 6; // fan corner diameter

sh = 33; // shroud height
swt = 0.8; // shroud wall thickness
sfh = 0.8; // shroud 'foot' height
stw = 5; // shroud tip outside width
stl = 20; // shroud tip outside length
std = 3; // shroud tip corner od
ste = 1; // shroud tip extends
sx = 22.5; // shroud x offset
sy = 0; // shroud y offset

be = 15; // Bracket extends past sides of the fan by this much.

module screw_hole(d1, d2, h1, h2) {
    // d1: hole id
    // d2: countersink hole id
    // h2: Total hole length
    union() {
        // Small hole all the way through
        cylinder(h2, d=d1);
        translate([0,0,h1]) cylinder((d2-d1)/2, d1=d1, d2=d2);
        translate([0,0,h1+(d2-d1)/2]) cylinder(h2-h1-(d2-d1)/2, d=d2);
    }
}

module rounded_rectangle(w,l,h,d) {
    x = (w-d)/2;
    y = (l-d)/2;
    hull() {
        translate([x,y,0]) cylinder(h, d=d);
        translate([-x,y,0]) cylinder(h, d=d);
        translate([-x,-y, 0]) cylinder(h, d=d);
        translate([x,-y, 0]) cylinder(h, d=d);

    };
};

// shroud
// translate ([fw+8,0,0]) {
// difference() {
//     union () {
//         rounded_rectangle(fw,fw,sfh,fcd);
//         hull() {
//             translate([0,0, sfh]) cylinder(0.2, d=fw);
//             translate([sx,sy,sfh+sh-0.2]) rounded_rectangle(stw,stl,0.2, std);
//         };
//         translate([sx,sy,sfh+sh]) rounded_rectangle(stw,stl,ste, std);
//         };
//     cylinder(sfh, d=fw-2*swt);
//     hull() {
//         translate([0,0, sfh]) cylinder(0.2, d=fw-2*swt);
//         translate([sx,sy,sfh+sh-0.2]) rounded_rectangle(stw-2*swt,stl-2*swt,0.2, std-2*swt);
//     };
//     translate([sx,sy,sfh+sh]) rounded_rectangle(stw-2*swt,stl-2*swt,ste, std-2*swt);
// };
// };

//holder
holder_height = fh+sfh+2*swt+0.6;
fwa =fw+1.2; // Adjust the fan size to allow for overextrusion.
echo(holder_height);
echo(fwa);
difference(){
    union() {
        rounded_rectangle(fwa+2*swt,fwa+2*swt,holder_height, fcd+2*swt);
        translate([-fwa/2-swt,-fwa/2-swt-be,0]) cube([swt+fcd/2,fwa+2*swt+2*be, holder_height]);
    }
    cylinder(holder_height, d=fwa);
    hull(){
        rounded_rectangle(fwa-2*swt,fwa-2*swt,holder_height, fcd+2*swt);
        translate([0,0,swt+0.1,]) rounded_rectangle(fwa,fwa,holder_height-2*swt, fcd);
    };
    translate([fwa/2, 0, holder_height/2]) cube([fwa, fwa-12, holder_height], true);
    translate([-fwa/2-swt,-fwa/2-swt-be/2,holder_height/2]) rotate([0,90,0]) screw_hole(4.2,8,2,swt+fcd/2);
    translate([-fwa/2-swt,fwa/2+swt+be/2,holder_height/2]) rotate([0,90,0]) screw_hole(4.2,8,2,swt+fcd/2);
};