include<params.scad>;

module carriageBackPlateScrewPositions() {
    translate([screwHeadDiam*1.5,-6,camHeight + camPlateHeight/2]) 
    children();
    
    translate([CAM_PLATE_WIDTH/2,-6,camHeight + camPlateHeight/2]) 
    children();
    
    translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5,-6,camHeight + camPlateHeight/2]) 
    children();

    translate([screwHeadDiam*1.5,-(NEEDLE_BED_DEPTH - COMB - 6),camHeight + camPlateHeight/2]) 
    children();
    
    translate([CAM_PLATE_WIDTH/2,-(NEEDLE_BED_DEPTH - COMB - 6),camHeight + camPlateHeight/2]) 
    children();
    
    translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5,-(NEEDLE_BED_DEPTH - COMB - 6),camHeight + camPlateHeight/2]) 
    children();
}

module stripperPlateScrewPositions() {
    translate([0,-(NEEDLE_BED_DEPTH + NEEDLE_EXTENSION + camPlateHeight - 0.25),0]) {
        translate([0,0,2]) {
            translate([screwHeadDiam*1.5,0,0])
            children();
            
            translate([screwHeadDiam*1.5 + 35,0,0])
            children();
            
            translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5 - 35,0,0])
            children();
            
            translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5,0,0])
            children();
        }
    }
}

module stripperPlateCounterborePositions() {
    translate([0,-(NEEDLE_BED_DEPTH + NEEDLE_EXTENSION + camPlateHeight - 0.25),0]) {
        translate([0,0,6.5 + screwHeadHeight/2]) {
            translate([screwHeadDiam*1.5,0,0])
            children();
 
            translate([screwHeadDiam*1.5 + 35,0,0])
            children();

            translate([CAM_PLATE_WIDTH - screwHeadDiam *1.5 -35,0,0])
            children();

            translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5,0,0])
            children();
        }
    }
}

module yarnFeederPlateScrewPositions() {
    translate([0,-(NEEDLE_BED_DEPTH - COMB/2),0]) {
        translate([0,0,2 - tolerance]) {
            translate([screwHeadDiam*1.5,0,0])
            children();
            
            translate([screwHeadDiam*1.5 + 35,0,0])
            children();
            
            translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5 - 35,0,0])
            children();
            
            translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5,0,0])
            children();
        }
    }
}

module yarnFeederPlateCounterborePositions() {
    translate([0,-(NEEDLE_BED_DEPTH - COMB/2),0]) {
        translate([0,0,2 - tolerance]) {
            translate([screwHeadDiam*1.5,0,0])
            children();
 
            translate([screwHeadDiam*1.5 + 35,0,0])
            children();

            translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5 -35,0,0])
            children();

            translate([CAM_PLATE_WIDTH - screwHeadDiam*1.5,0,0])
            children();
        }
    }
}
