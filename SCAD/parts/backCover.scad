include<../modules/params.scad>;
use<../modules/needlebedScrews.scad>;
use<../modules/roundedRail.scad>;

module backCover(width = gauge) { 

            translate([0,-BACK_COVER/2, -((screwHeadHeight + 1) - tolerance)/2])
            cube([width, BACK_COVER - tolerance, (screwHeadHeight + 1) - tolerance], center = true);
}

module backRail(width = gauge, rounded = false, tolerance = tolerance) {
    translate([0,-BACK_COVER/2, railHeight/2]) {
        if (rounded) {
            roundedRail(width, railDepth - tolerance*2, railHeight);
        } else {
            cube([width, railDepth - tolerance*2, railHeight], center = true);
        }
    }
}

difference() {
    translate([gauge*numNeedles/2 - gauge/2, 0, 0])
    
    backCover(width = numNeedles*gauge);
    translate([-needleSlotWidth,0,0]) needleBedScrews();
}


translate([(gauge*numNeedles)/2 - gauge/2, 0, 0]) 
backRail(width = numNeedles * gauge, rounded = true);        
     