include<params.scad>;

function needleBedSpongeBarInsertOffset() =
    (railHeight + 2 + spongeBarThickness + spongeThickness) - (screwHeadHeight + (tolerance *2));

function needleBedBackCoverInsertOffset() =
    (railHeight + tolerance) - (screwHeadHeight) + needleSlotHeight;

module needleBedSpongeBarScrewHoleLocations(side = "both") {
    if (side == "left" || side == "both") {
        translate([gauge/2,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, 0])
        children();
    }

    if (side == "right" || side == "both") {
        translate([-gauge/2,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, 0])
        children();
    }
}

module needleBedBackCoverScrewHoleLocations(side = "both") {
    if (side == "left" || side == "both") {
        translate([gauge/2, -BACK_COVER/2, 0])
        children();
    }

    if (side == "right" || side == "both") {
        translate([-gauge/2, -BACK_COVER/2, 0])
        children();
    }
}

module needleBedScrewPositionColumns(side = "both") {
    for(i = [0:numNeedles-1]) {
        if (i==screwPlacement || i==numNeedles-screwPlacement) {
            if (side == "right" || side == "both") {
                translate([gauge*i, 0, 0])
                children();
            }
        } else if (i == screwPlacement - 1 || i==numNeedles-(screwPlacement + 1)) {
            if (side == "left" || side == "both") {
                translate([gauge*i, 0, 0])
                children();
            }
        }
    }
}

module needleBedSpongeBarScrewPositions(side = "both") {
    if (side == "left" || side == "both") {
        needleBedScrewPositionColumns(side = "left")
        needleBedSpongeBarScrewHoleLocations(side = "left")
        children();
    }

    if (side == "right" || side == "both") {
        needleBedScrewPositionColumns(side = "right")
        needleBedSpongeBarScrewHoleLocations(side = "right")
        children();
    }
}

module needleBedBackCoverScrewPositions(side = "both") {
    if (side == "left" || side == "both") {
        needleBedScrewPositionColumns(side = "left")
        needleBedBackCoverScrewHoleLocations(side = "left")
        children();
    }

    if (side == "right" || side == "both") {
        needleBedScrewPositionColumns(side = "right")
        needleBedBackCoverScrewHoleLocations(side = "right")
        children();
    }
}

module needleBedScrewPositions(side = "both") {
    needleBedSpongeBarScrewPositions(side = side)
    children();

    needleBedBackCoverScrewPositions(side = side)
    children();
}
