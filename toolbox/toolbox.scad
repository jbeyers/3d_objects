// Electronics project box. Guidelines:
// 1. Holds soldering station
// 2. Builtin power supply with 4mm binding posts and usb
// 3. Space for charger
// 4. mounting for light
// 5. power for usb gadgets without plugging in
// 6. space for third hand/pcb vise
// Some measurements:

// mdf sheet thickness
mdf_th = 16;
ply_th = 12;
hb_th = 3.2;
shaft_od = 20;


// Parts thicknesses
// Ice cream container, as seen from small end
icc_w = 162; // confirmed
icc_d = 225; // TODO: not sure
icc_h = 85; // confirmed
// higher ice cream container
icc_h2 = 100;

// soldering station, as seen from switch side TODO: confirm
ss_w = 200;
ss_d = 240;
ss_h = 100;

// Power supply, as seen from side with power plug TODO: confirm
ps_w = 150;
ps_h = 86;
ps_d = 150;

// Binding post holes TODO: confirm
bp_od = 6;
bp_spacing = 20; // center to center spacing
shelf_headroom = 20;

// Some design sizes
inside_w = 3*icc_w + 2;
inside_d = icc_d + 2;

module shelf() {
    cube([inside_w, inside_d, mdf_th]);
}

module bed_section()
{
    translate([bed_opening/2,0,0]) {
    translate([(bed_overhang+mdf_th)/2,0,mdf_th/2]) cube(flat_part, center=true);
    translate([mdf_th/2, 0, bed_h/2+mdf_th]) cube(upright, center=true);
    }

}

module bed()
{
    bed_section();
    rotate([0,0,180]) bed_section();
    rotate([0,0,90]) translaste([0,0,mdf_th]) bed_section();
    rotate([0,0,270]) translate([0,0,mdf_th]) bed_section();
}

module shaft()
{
    translate([shaft_drive_l/2,0,mdf_th+bed_h+l_th+rfd(shaft_od)]) rotate([0,90,0]) cylinder(h=shaft_l, r = rfd(shaft_od), center=true);
}

module bb_holder() {
    translate([0,0,stepper_dim/2])
    rotate([0,270,0])
    difference() {
        translate([0,0,mdf_th/2]) cube([stepper_dim,stepper_dim,mdf_th], center=true);
        cylinder(h=608_th, r = rfd(608_od));
        cylinder(h=mdf_th, r = rfd(608_od - 608_shoulder));
    }
    
}

module drive()
{
    drive_base_pos = [bed_opening/2 + mdf_th*2, bed_opening/2 + mdf_th + bed_overhang - stepper_dim/2,mdf_th*2];
    translate(drive_base_pos) bb_holder();
    translate(drive_base_pos + [mdf_th + 20, 0,0]) bb_holder();
    translate(drive_base_pos - [50 +  mdf_th, 0,0]) bb_holder();
    mirror([0,1,0]) translate(drive_base_pos) bb_holder();
    mirror([0,1,0]) translate(drive_base_pos + [mdf_th + 20, 0,0]) bb_holder();

    // rotate([0,0,90]) mirror([0,1,0]) translate(drive_base_pos - [0,40,0]) bb_holder();
    
}


shelf = [inside_w, inside_d, mdf_th];
cube(shelf);

shelf_1_spacing = ss_h + shelf_headroom;
shelf_1_tr = [0,0,shelf_1_spacing + mdf_th];
translate(shelf_1_tr) cube(shelf);

shelf_2_spacing = ps_h + shelf_headroom;
shelf_2_tr = [0,0,shelf_2_spacing + mdf_th];
translate(shelf_1_tr + shelf_2_tr) cube(shelf);

side = [mdf_th, inside_d, shelf_1_spacing + shelf_2_spacing + 3*mdf_th + 20];
translate([- mdf_th, 0, 0]) cube(side);
translate([inside_w, 0, 0]) cube(side);

echo("height: ", shelf_2_spacing + shelf_3_spacing);
// bed();
// color("LightSteelBlue") shaft();
// color("LightSteelBlue") translate([0,0,mdf_th]) rotate([0,0,90]) shaft();
// drive();
// mirror([0,1,0]) translate([0,0,mdf_th]) rotate([0,0,90]) drive();
// echo("Bed upright height:", bed_h);
