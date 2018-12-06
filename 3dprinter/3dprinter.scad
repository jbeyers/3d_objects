// Some measurements:

// Line thickness
// 20 turns of Viper Double X 30 50lb uhmwpe line: 7.25 mm
l_th = 7.25/20;

// Printer shaft length and outside diameter
shaft_l = 400;
shaft_od = 8;

// ratio of line sideways movement over distance
incline = 7.25/(20*3.1415*shaft_od);

// mdf sheet thickness
mdf_th = 16;

// 608 bearing inside diameter, outside diameter, thickness (width)
608_id = 8;
608_od = 22;
608_th = 7;
608_shoulder = 2;

// Stepper motor dimensions
stepper_shaft_od = 5;
stepper_shaft_l = 20;
stepper_shoulder_th = 2;
stepper_shoulder_od = 22;
stepper_dim = 42;

// Some chosen design sizes
shaft_drive_l = 20; // Shaft drive needs this much space.
shaft_track_l = 10; // Shaft needs to overhang for tracking line.
alignment_gap = 1; // Gap from shaft end to alignment guides.
track_width = mdf_th + 9; // Width of the track that the shafts rest on. Works out to 25mm, which is easy. Not critical.
// The overhang is the size of the flat part outside the upright.
// Overhangs should be wide enough to have motor and drive mounts.
// TODO: Tweaking this might make the max length board 610mm, which is how these are sold.
bed_side = 110;
// Gap between upright part and side of the bed.
// Gap should be enough to have the tensioners not interfere. Too big, and the usable area is too small.
gap = mdf_th;
// The higher track layer 2 should not be the full width.
high_layer_2_width = 100;
// We cut one of the shafts into 4, and we need about 20mm to couple it to the motor. Overhang on the idler side is fine.
drive_shaft_width = shaft_l/4 - 20;
// Carriage bushes outside width. Further for stability, closer for larger build volume.
carriage_width = 80;
// Adjustment setup overhang
adjustment_overhang = stepper_dim*2 + 40;

// Computed sizes
//
// Distance between bed sides. Wide as possible given the shaft lengths.
bed_opening = shaft_l - 2*track_width - (shaft_drive_l + shaft_track_l*2);
narrow_gutter = shaft_track_l + alignment_gap; //Shaft overhang on narrow side.
wide_gutter = shaft_track_l + shaft_drive_l + alignment_gap; //Shaft overhang on narrow side.

// Showing sizes
echo("bed opening:", bed_opening);
echo("Build volume width and length:", bed_opening - carriage_width - 2*shaft_track_l);


// Standard function to get radius from diameter
function rfd(d) = d / 2;

// Get color from single number
function col(n) = [n/10, n/10, n/10];

// Computed part sizes
layer1 = [0,bed_opening + 2*bed_side, mdf_th];
layer2 = [0,bed_opening,mdf_th];
layer3 = [track_width,bed_opening, mdf_th];

// Bearing and motor holders


module bed_section(w, gutter_w, layer2_w, overhang)
{
    translate([bed_opening/2,0,0]) {
    translate([(w)/2,-overhang/2,mdf_th/2]) color(col(3)) cube(layer1 + [w,overhang,0], center=true);
    translate([(layer2_w)/2,0,3*mdf_th/2]) color(col(4)) cube(layer2 + [layer2_w,0,0], center=true);
    translate([(track_width)/2,0,5*mdf_th/2]) color(col(5)) cube(layer3, center=true);
    translate([track_width + gutter_w + (mdf_th)/2, 0, 2*mdf_th + (track_width/2)]) color(col(6)) cube([mdf_th,bed_opening,track_width], center=true);
    echo("Flat part:", layer1 + [w,overhang,0]);
    }
}

module bed()
{
    w = bed_side;
    bed_section(w, wide_gutter, w, adjustment_overhang);
    rotate([0,0,180]) bed_section(w, narrow_gutter, w, 0);
    rotate([0,0,90]) translate([0,0,mdf_th]) bed_section(w, narrow_gutter, high_layer_2_width, 0);
    rotate([0,0,90]) translate([0,0,mdf_th]) mirror([1,0,0]) bed_section(w, wide_gutter, high_layer_2_width, adjustment_overhang);
}

module shaft()
{
    translate([shaft_drive_l/2,0,3*mdf_th+l_th+rfd(shaft_od)]) rotate([0,90,0]) cylinder(h=shaft_l, r = rfd(shaft_od), center=true);
}

module bb_holder(l) {
    // 608 ball bearing holder, centered on the center of the base flush with the side where the bearing sits.
    // l is the length of the block.
    bb_holder_block = [l,l,mdf_th];
    echo("bb holder:", bb_holder_block);
    translate([0,0,l/2])
    rotate([0,270,0])
    difference() {
        translate([0,0,mdf_th/2]) cube(bb_holder_block, center=true);
        cylinder(h=608_th, r = rfd(608_od));
        cylinder(h=mdf_th, r = rfd(608_od - 608_shoulder));
    }
    translate([0,0,l/2])
    rotate([0,270,0])
    color("lightSteelBlue") difference() {
        cylinder(h=608_th, r = rfd(608_od));
        cylinder(h=608_th, r = rfd(8));
    }
}

module drive_shaft_holder(l,l2) {
    // bb drive shaft holder with 2 bb holder blocks
    // Centered on shaft centerline projected on block base
    // l: bb holder dimension
    // l2: outside distance of bb holders from each other
    rotate([0,0,90]) color(col(8)) translate([(l2)/2,0,0]) bb_holder(stepper_dim);
    rotate([0,0,270]) color(col(8)) translate([(l2)/2,0,0]) bb_holder(stepper_dim);
    color("lightSteelBlue")
    translate([0,(l2+20)/2,l/2])
    rotate([90,0,0])
    cylinder(h=l2+20, r = rfd(8));
}

module drive()
{
    drive_base_pos = [bed_opening/2 + mdf_th*2, bed_opening/2 + mdf_th + bed_side - stepper_dim/2,mdf_th*2];
    //translate(drive_base_pos) bb_holder(stepper_dim);
    translate(drive_base_pos + [mdf_th + 20, 0,0]) bb_holder(stepper_dim);
    //drive_base_block = [70 + 3*mdf_th + stepper_dim,stepper_dim, mdf_th];
    //echo("drive base block:", drive_base_block);
    //translate(drive_base_pos-[50+stepper_dim+2*mdf_th,stepper_dim/2,mdf_th]) cube(drive_base_block);
    mirror([0,1,0]) translate(drive_base_pos) bb_holder(stepper_dim);
    mirror([0,1,0]) translate(drive_base_pos + [mdf_th + 20, 0,0]) bb_holder(stepper_dim);
    //echo("drive base block:", drive_base_block);
    //mirror([0,1,0]) translate(drive_base_pos-[50+stepper_dim+2*mdf_th,stepper_dim/2,mdf_th]) cube(drive_base_block);

    // rotate([0,0,90]) mirror([0,1,0]) translate(drive_base_pos - [0,40,0]) bb_holder(stepper_dim);
    
}

bed();
color("LightSteelBlue") {
    shaft();
    translate([0,0,mdf_th]) rotate([0,0,270]) shaft();
}

translate([bed_opening/2 + track_width + wide_gutter/2, 0, 2*mdf_th])
rotate([0,0,90])
{
    translate([bed_opening/2 + bed_side - stepper_dim/2, 0, 0])
    drive_shaft_holder(stepper_dim,drive_shaft_width); 

    translate([-bed_opening/2 - bed_side - stepper_dim/2, 0, 0])
    drive_shaft_holder(stepper_dim,drive_shaft_width); 
}

rotate([0,0,180])
translate([0, bed_opening/2 + track_width + wide_gutter/2, 3*mdf_th])
{
    translate([bed_opening/2 + bed_side - stepper_dim/2, 0, 0])
    drive_shaft_holder(stepper_dim,drive_shaft_width); 

    translate([-bed_opening/2 - bed_side - stepper_dim/2, 0, 0])
    drive_shaft_holder(stepper_dim,drive_shaft_width); 
}

//drive();
//mirror([0,1,0]) translate([0,0,mdf_th]) rotate([0,0,90]) drive();

// Z axis sides
side_panel_height = shaft_l + 6 + mdf_th +stepper_dim;
side_panel = [side_panel_height, bed_opening, mdf_th];
echo("side panel:", side_panel);
rotate([0,90,90]) translate([-mdf_th, -bed_opening/2, side_panel_height/2]) cube(side_panel);
rotate([90,90,0]) translate([-mdf_th, -bed_opening/2, side_panel_height/2]) cube(side_panel);
rotate([90,0,270]) translate([-side_panel_height/2, - side_panel_height + mdf_th*2 + stepper_dim, bed_opening/2 - mdf_th]) cube(side_panel);

