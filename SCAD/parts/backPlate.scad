include<../modules/params.scad>;
include<../modules/camplate_coords_mk2.scad>;
include<../modules/utils.scad>;
use<backCover.scad>;
use<spongeBar.scad>;
use<tCam.scad>;
use<../modules/carriageScrews.scad>;

difference() {
    color("purple", 0.5)
    union() {
        backPlate();
        intersection () {
            hull() { // rounded leading edges
                translate([0,-CAM_PLATE_DEPTH,camHeight-camPlateHeight])
                cube([CAM_PLATE_WIDTH, CAM_PLATE_DEPTH, camPlateHeight]);
                
                translate([camHeight/2,-CAM_PLATE_DEPTH,0])
                cube([CAM_PLATE_WIDTH - camHeight, CAM_PLATE_DEPTH, camPlateHeight]);
                
                translate([camHeight/2,-CAM_PLATE_DEPTH/2,camHeight/2])
                rotate([90,0,0])
                cylinder(CAM_PLATE_DEPTH, d = camHeight, center = true, $fn = 50);
                
                translate([CAM_PLATE_WIDTH - camHeight/2,-CAM_PLATE_DEPTH/2,camHeight/2])
                rotate([90,0,0])
                cylinder(CAM_PLATE_DEPTH, d = camHeight, center = true, $fn = 50);
            }
            camRails();
        }
        translate(frontWallCoords)
        linear_extrude(camHeight)
        import("../../SVG/FrontWall_mk2.svg");  
        translate(flip(frontWallCoords))
        mirror([1,0,0])
        linear_extrude(camHeight)
        import("../../SVG/FrontWall_mk2.svg"); 
       
        translate(bumperCoords)
        linear_extrude(camHeight)
        import("../../SVG/BumperCam_mk2.svg");  
        translate(flip(bumperCoords))
        mirror([1,0,0])
        linear_extrude(camHeight)
        import("../../SVG/BumperCam_mk2.svg"); 
        
        translate(backWallCoords)
        linear_extrude(camHeight)
        import("../../SVG/BackWall_mk2.svg");  
        translate(flip(backWallCoords))
        mirror([1,0,0])
        linear_extrude(camHeight)
        import("../../SVG/BackWall_mk2.svg"); 
    }
    carriageScrews();
}

//!backPlate();

module backPlate() {
    color("magenta")
    difference() {
        translate([0,-CAM_PLATE_DEPTH,camHeight])
        cube([CAM_PLATE_WIDTH, CAM_PLATE_DEPTH, camPlateHeight]);
        
        translate(tPivotCoords)
        tSlots();
        
        translate(flip(tPivotCoords))
        mirror([1,0,0])
        tSlots();
           
        
//        translate(tPivotCoords)
        tPivot(tol = tolerance);
        translate([CAM_PLATE_WIDTH,0,0])
        mirror([1,0,0])
        tPivot(tol = tolerance);
        
        // tension adjustment marks
        translate([flip(tPivotCoords)[0],tPivotCoords[1],camHeight + camPlateHeight - 1 + tolerance]) {
            for (i = [0:2:8]) {
                mirror([1,0,0])
                rotate([0,0,360-30.06 - i*tensionAngleInc])
                translate([tensionMarksDist,0,0])               
                #cube([6,0.5,1], center = false); 
            }
        } 
        translate([tPivotCoords[0],tPivotCoords[1],camHeight + camPlateHeight - 1 + tolerance]) {
            for (i = [0:2:8]) {
                rotate([0,0,360-30.06 - i*tensionAngleInc])
                translate([tensionMarksDist,0,0])
                #cube([6,0.5,1], center = false); 
            }
        } 
    }
}

module camRails() {
    color("purple") {
        difference() {
            translate([0,-BACK_COVER,0.5])
            cube([CAM_PLATE_WIDTH,BACK_COVER, camHeight]);
            translate([0,-BACK_COVER/2, 0.5])
            camRailsInlet();
            translate([CAM_PLATE_WIDTH,-BACK_COVER/2, 0.5])
            mirror([1,0,0])
            camRailsInlet();
            backRail(width = CAM_PLATE_WIDTH*2 +1, tolerance = -tolerance);
        }
        
        difference() {
            translate([0,-CAM_PLATE_DEPTH,0.5])
            cube([CAM_PLATE_WIDTH,SPONGE_BAR + 6, camHeight]);
            translate([0,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, 0.5])
            camRailsInlet();
            translate([CAM_PLATE_WIDTH,-(NEEDLE_BED_DEPTH-COMB) + SPONGE_BAR/2, 0.5])
            mirror([1,0,0])
            camRailsInlet();
            frontRail(width = CAM_PLATE_WIDTH*2 +1, tolerance = -tolerance);
        }
    }
}


module tSlots() {
    // curved cutout for tension adjustment screws
    hull() {
        for (i = [0:9]) { 
            rotate([0,0,tensionMarksStartAngle - i*tensionAngleInc])
            translate([-tSlotDist,0,0])
            cylinder(camPlateHeight * 2, d = screwDiamSm + tolerance*2, center = true); 
        }
    }   
}

//camRailsInlet(); // uncomment to debug shape at origin

module camRailsInlet() {
    // cutout shape to round off entry to rail track
    difference() {
        cube([railDepth/2,railDepth*2, camHeight + railDepth/2], center = true);
        translate([railDepth/2,railDepth - tolerance * 2, 0])
        cylinder(h = camHeight + 8, d = railDepth, $fn = 50, center = true);
        translate([railDepth/2,-railDepth + tolerance*2, 0])
        cylinder(h = camHeight + 8, d = railDepth, $fn = 50, center = true);
        
        rotate([90,0,0])
        translate([railDepth/2 - tolerance, camHeight - railDepth/2, 0])
        cylinder(CAM_PLATE_DEPTH, d = railDepth + tolerance * 2, center = true, $fn = 50);
    }
}

