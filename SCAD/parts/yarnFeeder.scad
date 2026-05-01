include<../modules/params.scad>;
use<../modules/carriageScrews.scad>;
use<../parts/stripperPlate.scad>;

module yarnFeeder() {
    difference() {
        // yarn guide
        translate([0,YARN_DEPOSIT_Y,YARN_DEPOSIT_Z + 1.5 + tolerance])
        rotate([0,0,-90 + 15])
        rotate_extrude(convexity = 10, $fn = 100)
        translate([3, 0, 0])
        hull() {
            circle(r = 1.5, $fn = 100);
            translate([6,6,0])
            circle(r = 1.5, $fn = 100);
        }
        // lowest surface of guide should hit at jussst the right spot, but subtract the surface of the stripper plate to get correct angle in case yarn guide shape dips too low
        translate([0,-NEEDLE_BED_DEPTH - NEEDLE_EXTENSION - tolerance * 2,-needleSlotHeight + HOOK_DIAM])
        stripperPlate();
    }
}

module yarnSlot() {
    difference() {
        translate([CAM_PLATE_WIDTH/2,YARN_DEPOSIT_Y-15,0])
        cube([1.5,30,20], center = true);
    }
}

module yarnFeederPlate() {
    difference() {
        translate([0,0,2])
        color("red") {
            union() {
                translate([55/2,YARN_DEPOSIT_Y + 2 + tolerance,camPlateHeight/2])
                cube([55, (NEEDLE_BED_DEPTH + NEEDLE_EXTENSION + camPlateHeight*1.5)-(NEEDLE_BED_DEPTH - COMB + 6 + tolerance), camPlateHeight], center = true);
            translate([CAM_PLATE_WIDTH - 55/2,YARN_DEPOSIT_Y + 2 + tolerance,camPlateHeight/2])
                cube([55, (NEEDLE_BED_DEPTH + NEEDLE_EXTENSION + camPlateHeight*1.5)-(NEEDLE_BED_DEPTH - COMB + 6 + tolerance), camPlateHeight], center = true);
                hull() {
                    translate([CAM_PLATE_WIDTH/2,-(NEEDLE_BED_DEPTH - COMB + 11 + tolerance),camPlateHeight/2])
                    cube([CAM_PLATE_WIDTH/2, 10, camPlateHeight], center = true);
                        translate([CAM_PLATE_WIDTH/2,YARN_DEPOSIT_Y,camPlateHeight/2])
                    cylinder(h= camPlateHeight, d = 25 , center = true);
                }
            }
        }
        translate([CAM_PLATE_WIDTH/2,YARN_DEPOSIT_Y,2])
        cylinder(h= (5)*2, d = 19 , center = true);
    }
}

module renderYarnFeeder() {
    translate([CAM_PLATE_WIDTH/2,0,0])
    difference() {
        yarnFeeder();
        translate([-CAM_PLATE_WIDTH/2,0,0])
        yarnSlot();
    }

    difference() {
        yarnFeederPlate();
        yarnSlot();
        carriageScrews();
    }
}
