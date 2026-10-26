thickness = 1;
hole_spacing = 32;
hole_diameter = 3.5;
cutout_x = 26.4;
cutout_y = 10.2;
offset_width = 18.4;
offset_length = 2.5;
edge_margin = 5;

$fn = 96;

plate_length = hole_spacing + hole_diameter + 2 * edge_margin;
plate_width = max(hole_diameter, cutout_y + offset_length) + 2 * edge_margin;

assert(thickness > 0, "Thickness must be positive.");
assert(hole_diameter > 0, "Hole diameter must be positive.");
assert(cutout_x > 0 && cutout_y > 0, "Cutout dimensions must be positive.");
assert(edge_margin > 0, "Edge margin must be positive.");
assert(cutout_x < hole_spacing - hole_diameter,
       "The rectangular cutout must fit between the holes.");
assert(offset_width > 0 && offset_width < cutout_x,
    "Offset width must be positive and narrower than the cutout.");
assert(offset_length > 0, "Offset length must be positive.");

linear_extrude(height = thickness)
    difference() {
        square([plate_length, plate_width], center = true);

        for (hole_x = [-hole_spacing / 2, hole_spacing / 2])
            translate([hole_x, 0])
                circle(d = hole_diameter);

        union() {
            square([cutout_x, cutout_y], center = true);
            translate([0, cutout_y / 2 + offset_length / 2])
                square([offset_width, offset_length], center = true);
        }
    }