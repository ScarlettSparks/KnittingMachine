include<../modules/params.scad>;
use<../parts/needleBed.scad>;
include<../modules/fasteners.scad>;

clampWidth = 50;
clampDepth = NEEDLE_BED_DEPTH-clampWidth/2; 
clampThickness = 6;
clampHollow = 85; // adjust this for your table thickness

module clampScrewPositions() {
    $fn = 50;
    translate([-CAM_PLATE_WIDTH/2,0,-needleBedHeight]) {
        translate([0,-(NEEDLE_BED_DEPTH-clampWidth),0]) {
            translate([- clampWidth/2 + screwHeadDiam*1.5, 0, 0])
            translate([ + clampWidth/2 - screwHeadDiam*1.5, 0, 0])
            children();
        }
        translate([0,-clampWidth*2/3,0]) {
            translate([- clampWidth/2 + screwHeadDiam*1.5, 0, 0])
            translate([ + clampWidth/2 - screwHeadDiam*1.5, 0, 0])
            children();
        }
    }
}

module carriageRestClampScrews() {
    clampScrewPositions() {
        screwPreview()
        cylinder(screwHeight*2, d = screwDiam, center = true);

        screwPreview()
        cylinder((screwHeadHeight + tolerance)*2, d = screwHeadDiam, center = true);
    }
}

module clampUnitClampScrews() {
    topFaceZ = 0;
    topThickness = clampThickness - tolerance;

    clampScrewPositions() {
        if (useThreadedInserts) {
            screwPreview()
            fastenerInsertReadyHole(
                throughDepth = topThickness + 1,
                faceZ = topFaceZ,
                direction = 1,
                throughDiam = screwDiam,
                pocketDepth = min(insertLength, topThickness),
                pocketDiam = insertOuterDiam,
                includeLeadIn = true
            );
        } else {
            screwPreview()
            cylinder(screwHeight*2, d = screwDiam, center = true);

            screwPreview()
            cylinder((screwHeadHeight + tolerance)*2, d = screwHeadDiam, center = true);
        }
    }
}

module clampUnit() {
    difference() {
        // top
        translate([-CAM_PLATE_WIDTH/2 , -NEEDLE_BED_DEPTH + clampDepth/2, -needleBedHeight + clampThickness/2])
            cube([clampWidth - tolerance*2, clampDepth - tolerance, clampThickness-tolerance], center = true); 
        clampUnitClampScrews();
        for(i = [0:ceil(CAM_PLATE_WIDTH/gauge)]) {
           translate([-gauge*i, 0, 0])
           frontAngle(CAM_PLATE_WIDTH + 10);
        }
    }
    // front
    hull () {
        translate([-CAM_PLATE_WIDTH/2 , -NEEDLE_BED_DEPTH + clampThickness/2 + 12, -(needleBedHeight - tolerance) - clampHollow/2]) {
                cube([clampWidth - tolerance*2, clampThickness, clampHollow], center = true);
            
            // rounded edge
            translate([0,0,-(clampHollow + clampThickness)/2])
            rotate([0,90,0])
            cylinder(clampWidth - tolerance*2, d = clampThickness, center = true, $fn = 30);
        }  
    }
    difference() {
        // bottom
        translate([-CAM_PLATE_WIDTH/2 , -NEEDLE_BED_DEPTH + clampDepth/2 +  clampThickness/2, -(needleBedHeight - tolerance) - clampHollow - clampThickness/2 ])
        cube([clampWidth - tolerance*2, clampDepth - 25, clampThickness], center = true);
        
        
        translate([-CAM_PLATE_WIDTH/2,-clampWidth*2/3 - 18,-(needleBedHeight - tolerance) - clampHollow - clampThickness/2]) {
            // bolt hole
            cylinder(h = clampThickness*2, d = 8, center = true, $fn = 50);
            
            // nut cutout
            translate([-14.491/2,-12.55/2,clampThickness/2]) // use w/h specs from svg
            screwPreview()
            linear_extrude(6.75, center = true)
            import("../SVG/HexNut.svg");
        }        
    }
}

module renderClampUnit() {
    translate([-gauge,0,0])
    clampUnit();
}
