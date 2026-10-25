thickness = 1;
hole_spacing = 51;
hole_diameter = 3.5;
cutout_x = 42.5;
cutout_y = 27.5;
chamfer_width = 5.5;
edge_margin = 5;

$fn = 96;

plate_length = hole_spacing + hole_diameter + 2 * edge_margin;
plate_width = max(hole_diameter, cutout_y) + 2 * edge_margin;

assert(thickness > 0, "Thickness must be positive.");
assert(hole_diameter > 0, "Hole diameter must be positive.");
assert(cutout_x > 0 && cutout_y > 0, "Cutout dimensions must be positive.");
assert(edge_margin > 0, "Edge margin must be positive.");
assert(cutout_x < hole_spacing - hole_diameter,
       "The rectangular cutout must fit between the holes.");
assert(chamfer_width >= 0 && chamfer_width < cutout_x &&
    2 * chamfer_width < cutout_y,
    "Chamfer width must be nonnegative and fit within the cutout.");

linear_extrude(height = thickness)
    difference() {
        square([plate_length, plate_width], center = true);

        for (hole_x = [-hole_spacing / 2, hole_spacing / 2])
            translate([hole_x, 0])
                circle(d = hole_diameter);

        if (chamfer_width == 0)
            square([cutout_x, cutout_y], center = true);
        else
            polygon(points = [
                [-cutout_x / 2, -cutout_y / 2],
                [cutout_x / 2 - chamfer_width, -cutout_y / 2],
                [cutout_x / 2, -cutout_y / 2 + chamfer_width],
                [cutout_x / 2, cutout_y / 2 - chamfer_width],
                [cutout_x / 2 - chamfer_width, cutout_y / 2],
                [-cutout_x / 2, cutout_y / 2]
            ]);
    }