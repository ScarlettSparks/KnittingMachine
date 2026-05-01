include<params.scad>;
//include<needlebed.scad>;

module needleBedScrewHoleLocations(side = "both") {
    if (side == "left" || side == "both") {
        translate([gauge/2,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, 0])
        children();

        translate([gauge/2, -5, 0])
        children();

        translate([gauge/2, -BACK_COVER + 5, 0])
        children();
    }

    if (side == "right" || side == "both") {
        translate([-gauge/2,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, 0])
        children();

        translate([-gauge/2, -5, 0])
        children();

        translate([-gauge/2, -BACK_COVER + 5, 0])
        children();
    }
}

module screwHoles(screw) {
    side = screw > 0 ? "left" : "right";

    needleBedScrewHoleLocations(side = side) {
        cylinder(h = needleBedHeight*2 + 1, d = screwDiam, center = true, $fn = 25);
        if ($children > 0) {
            children();
        } else {
            translate([0,0,railHeight])
            cylinder(h = screwHeadHeight*2 + tolerance, d = screwHeadDiam, center = true, $fn = 25);
        }
    }
}

module needleBedScrewPositions(side = "both") {
    for(i = [0:numNeedles-1]) {
        if (i==screwPlacement || i==numNeedles-screwPlacement) {
            if (side == "right" || side == "both") {
                translate([gauge*i, 0, 0])
                needleBedScrewHoleLocations(side = "right")
                children();
            }
        } else if (i == screwPlacement - 1 || i==numNeedles-(screwPlacement + 1)) {
            if (side == "left" || side == "both") {
                translate([gauge*i, 0, 0])
                needleBedScrewHoleLocations(side = "left")
                children();
            }
        }
    }
}

module needleBedScrews() {
    screwPreview() {
        needleBedScrewPositions(side = "both")
        cylinder(h = needleBedHeight*2 + 1, d = screwDiam, center = true, $fn = 25);

        needleBedScrewPositions(side = "left")
        translate([0,0,railHeight])
        cylinder(h = screwHeadHeight*2 + tolerance, d = screwHeadDiam, center = true, $fn = 25);

        needleBedScrewPositions(side = "right")
        translate([0,0,railHeight])
        cylinder(h = screwHeadHeight*2 + tolerance, d = screwHeadDiam, center = true, $fn = 25);
    }
}
