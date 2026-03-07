include<../modules/params.scad>;
include<../modules/camplate_coords_mk2.scad>;
include<../modules/utils.scad>;
//include<../modules/camPinHoles.scad>;

module tCam() {
    // adjustable tension cams 
    translate(tCamCoords)
    difference() {
            linear_extrude(camHeight - (camClearance + tolerance))
            import("../../SVG/tCam.svg");
        
        translate([nutCoords[0] - tCamCoords[0], nutCoords[1] - tCamCoords[1], camHeight - (1 + tolerance*2) - nutHeight]) {
            linear_extrude(nutHeight + tolerance*2 + 1)
            hexNut();
            adjustmentHole();  
        }
    }
    tPivot(solid = true);
}

module tPivot(tol = 0, solid = false) {
     // pivot 
    difference() {
        translate(tPivotCoords)
        cylinder(camPlateHeight + 3, d = 8 + tol , center = true);
        if(solid) {
//            translate([0,0,camPlateHeight/2])
//            cylinder(camPlateHeight, d = screwDiamSm , center = true);
            pivotHole();
        }     
    }
}

module hexNut() {
    // d = 1.155 should produce a regular hexagon with 1mm between the flats, which we can then scale according to our actual hardware size
    rotate([0,0,nutRotation])
    circle(d=1.155*(nutWidthSm + 3*tolerance), $fn=6); 
}

module pivotHole(tol=0) {  
    translate(tPivotCoords)
    translate([0,0,1])
    cylinder(camPlateHeight*2, d = screwDiamSm + tol, center = true, $fn = 20);
}

module adjustmentHole() {
    // hole is oversized compared to other screw holes to give plenty of clearance behind the nut
            cylinder(camHeight * 2, d = screwDiamSm + tolerance*2, center = true);  
}


// print 2, mirrored

//translate(tCamCoords)
tCam();

////translate(tPivotCoords)
//tPivot(solid = true);


