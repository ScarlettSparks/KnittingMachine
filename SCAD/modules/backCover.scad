include<params.scad>;
include<needlebedScrews.scad>;
include<roundedRail.scad>;
include<fasteners.scad>;

module backCover(width = gauge) {
    translate([0,-BACK_COVER/2, -((screwHeadHeight + 1) - tolerance)/2])
    cube([width, BACK_COVER - tolerance, (screwHeadHeight + 1) - tolerance], center = true);
}

module backRail(width = gauge, rounded = false, railTolerance = tolerance) {
    translate([0,-BACK_COVER/2, railHeight/2]) {
        if (rounded) {
            roundedRail(width, railDepth - railTolerance*2, railHeight);
        } else {
            cube([width, railDepth - railTolerance*2, railHeight], center = true);
        }
    }
}

module backCoverBody(width = numNeedles * gauge) {
    translate([gauge*numNeedles/2 - gauge/2, 0, 0]) {
        backCover(width = width);
        backRail(width = width, rounded = true);
    }
}

module renderBackCover() {
    difference() {
        backCoverBody();
        screwPreview()
        needleBedScrewPositions(side = "both")
        fastenerScrewCutout(
            throughDepth = screwHeight,
            headZ = railHeight,
            headDepth = screwHeadHeight + tolerance
        );
    }
}
