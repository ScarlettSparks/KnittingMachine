include<../modules/params.scad>;
use<../parts/needleBed.scad>;
use<../parts/backCover.scad>;
use<../parts/spongeBar.scad>;
use<../modules/connector.scad>;
include<clampUnit.scad>;

module carriageRestConnectorPositions() {
    translate([0,-connectorOffset,0])
    children();

    translate([0,-(NEEDLE_BED_DEPTH-connectorOffset),0])
    children();
}

module carriageRestMaleConnectors() {
    carriageRestConnectorPositions()
    connector(tolerance = tolerance);
}

module carriageRestFemaleConnectorCutouts() {
    carriageRestConnectorPositions()
    connector();
}

module carriageRestBody(mirrored = false) {
    translate([mirrored ? gauge*numNeedles : -gauge, 0, 0]) {
        if (mirrored) {
            mirror([1,0,0])
            carriageRest();
        } else {
            carriageRest();
        }
    }
}

module renderCarriageRests() {
    union() {
        carriageRestBody();
        translate([-gauge/2,0,-needleBedHeight])
        carriageRestMaleConnectors();
    }

    difference() {
        carriageRestBody(mirrored = true);
        translate([gauge*numNeedles - gauge/2 - tolerance,0,-needleBedHeight - tolerance])
        carriageRestFemaleConnectorCutouts();
    }
}


module carriageRest() {
    union() {
        difference() {
            hull() {
                needleBase();   
                translate([-CAM_PLATE_WIDTH, -10, -needleBedHeight/2])
                cylinder(needleBedHeight, 10, 10, center = true); 
                
                translate([-CAM_PLATE_WIDTH, -NEEDLE_BED_DEPTH+10, -needleBedHeight/2])
                cylinder(needleBedHeight, 10, 10, center = true); 
            }
            for(i = [0:ceil(CAM_PLATE_WIDTH/gauge)]) {
               translate([-gauge*i, 0, 0])
               frontAngle(CAM_PLATE_WIDTH + 10);
            }
            // cutout for clamp
            translate([-CAM_PLATE_WIDTH/2, -NEEDLE_BED_DEPTH, -needleBedHeight])
                cube([clampWidth, clampDepth*2, clampThickness*2], center = true); 
            carriageRestClampScrews();
        }
        translate([gauge/2-CAM_PLATE_WIDTH/4,0,0]) {
            frontRail(CAM_PLATE_WIDTH/2, rounded = true);
            backRail(CAM_PLATE_WIDTH/2, rounded = true);
        }
    }
}
