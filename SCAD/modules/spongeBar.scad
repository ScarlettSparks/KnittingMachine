include<params.scad>;
include<needlebedScrews.scad>;
include<roundedRail.scad>;
include<fasteners.scad>;

module spongeBar(width = gauge) {
    translate([0,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, -1])
    cube([width,SPONGE_BAR - tolerance*2,2], center = true);
}

module frontRail(width = gauge, rounded = false, railTolerance = tolerance) {
    translate([0,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, railHeight/2]) {
        if (rounded) {
            roundedRail(width, railDepth - railTolerance*2, railHeight);
        } else {
            cube([width, railDepth - railTolerance*2, railHeight], center = true);
        }
    }
}

module renderSpongeBar() {
    difference() {
        union() {
            translate([(gauge*numNeedles)/2 - gauge/2, 0, 0]) {
                frontRail(width = numNeedles * gauge, rounded = true);
            }
            translate([gauge*numNeedles/2 - gauge/2, 0, 0])
            spongeBar(width = numNeedles*gauge);
        }
        screwPreview()
        needleBedScrewPositions(side = "both")
        fastenerScrewCutout(
            throughDepth = screwHeight,
            headZ = railHeight,
            headDepth = screwHeadHeight + tolerance
        );
    }
}
