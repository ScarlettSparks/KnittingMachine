include<../modules/params.scad>;
use<../modules/needlebedScrews.scad>;
use<../modules/roundedRail.scad>;


module spongeBar(width = gauge) { 
            translate([0,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, -1])
            cube([width,SPONGE_BAR - tolerance*2,2], center = true);
}

module frontRail(width = gauge, rounded = false, tolerance = tolerance) {
    translate([0,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, railHeight/2]) {
        if (rounded) {
            roundedRail(width, railDepth - tolerance*2, railHeight);
        } else {
            cube([width, railDepth - tolerance*2, railHeight], center = true);
        }
    }
}



difference() {
    union() {
        translate([(gauge*numNeedles)/2 - gauge/2, 0, 0]) {
        frontRail(width = (numNeedles) * gauge, rounded = true);
        }
                    translate([gauge*numNeedles/2 - gauge/2, 0, 0])

            spongeBar(width = numNeedles*gauge);
    }
        translate([-needleSlotWidth,0,0]) needleBedScrews();
}

