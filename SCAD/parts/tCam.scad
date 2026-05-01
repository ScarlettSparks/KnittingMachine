include<../modules/params.scad>;
include<../modules/camplate_coords_mk2.scad>;
include<../modules/utils.scad>;
//include<../modules/camPinHoles.scad>;

module tCam() {
    // adjustable tension cams 
    difference() {
            linear_extrude(camHeight - (camClearance + tolerance))
            import("../../SVG/TCam_mk2.svg");
        
        translate([nutCoords[0] - tCamCoords[0], nutCoords[1] - tCamCoords[1], camHeight - (1 + tolerance*2) - nutHeight])
            linear_extrude(nutHeight + tolerance*2 + 1)
            import("../../SVG/Hex_mk2.svg");    
    }
}

module tPivot(tol = 0, solid = false) {
     // pivot 
    difference() {
        cylinder(camPlateHeight + 3, d = 8 + tol , center = true);
        if(solid) {
            translate([0,0,camPlateHeight/2])
            screwPreview()
            cylinder(camPlateHeight, d = screwDiam , center = true);
        }     
    }
}


// print 2, mirrored

translate(tCamCoords)
tCam();

translate(tPivotCoords)
tPivot(solid = true);
