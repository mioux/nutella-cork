include <springs.scad>

/* [Default data are size for a standard Nutella cork] */
// Height of cork and support
height = 12;

// Size of the bottle neck (diameter) / 78 for 350g / 83 for 1kg
inner_size = 83;

// Size of the cork (diameter) / 80 for 350g / 85 for 1kg
out_size = 85;

// Thickness of bottom
bottom_thickness = 1.5;

// Support size (diameter) / 65 for 350g / 69 for 1kg
support_size = 69;

// Thread thickness (diameter) / 1 is not enough
thr_thickness = 2;

// Thread total height (consider the center of the thread, not the edges)
thr_height = 4;

// Thread position in cork
thr_pos = bottom_thickness + 3;

// Windings. By default a little more than 1 turn
windings = 1.03;

/* [Hidden] */
// Set low (20 for example) for rendering and high for final outpul (1000 to be round. 100 is not enough for Cura to detect cork as round, and use the correct G command)
// DON'T SET HIGH GLOBALLY ! spring will fail !
fn_for_cylinders = 1000;

union()
{
    difference()
    {
        cylinder(d=out_size, h=height, $fn=fn_for_cylinders);
        translate([0, 0, bottom_thickness])
            cylinder(d=inner_size, h=height, $fn=fn_for_cylinders);
    }
    cylinder(d=support_size, h=height, $fn=fn_for_cylinders);

    difference()
    {
        translate([0, 0, thr_pos])
            spring(R=inner_size/2, r=thr_thickness/2, H=thr_height, windings=windings, center = false);
        difference()
        {
            cylinder(d=inner_size + thr_thickness, h = thr_pos + thr_height + thr_thickness, $fn=fn_for_cylinders);
            cylinder(d=inner_size, h = thr_pos + thr_height + thr_thickness, $fn=fn_for_cylinders);
        }
    }
}
