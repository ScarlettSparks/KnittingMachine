include<../modules/params.scad>;
include<../modules/needlebedScrews.scad>;
include<../modules/roundedRail.scad>;

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

module renderBackCover() {
    difference() {
        translate([gauge*numNeedles/2 - gauge/2, 0, 0])
        backCover(width = numNeedles*gauge);
        needleBedScrews();
    }

    translate([(gauge*numNeedles)/2 - gauge/2, 0, 0]) 
    backRail(width = numNeedles * gauge, rounded = true);
}
     
