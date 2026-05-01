include<../modules/params.scad>;
use<../modules/carriageScrews.scad>;

module stripperPlate(col = "blue") {
    $fn = 50;
    color(col)
    hull() {
        // outer L
        translate([-CAM_PLATE_WIDTH/2,NEEDLE_EXTENSION-4,-camPlateHeight])
         sphere(d = camPlateHeight/2);
        
        // mid L
         translate([-camPlateHeight * 2.5,NEEDLE_EXTENSION-camPlateHeight/2,-camPlateHeight])
         sphere(d = camPlateHeight/2);
        
        // inner L
        translate([-camPlateHeight * 1.5 - 0.5,NEEDLE_EXTENSION-camPlateHeight * 1.5 -2,-camPlateHeight])
         cylinder(h = camPlateHeight/2, d = camPlateHeight*3, center = true);
        
//        front rounded edge
        translate([-CAM_PLATE_WIDTH/2 + 55/2, -(camPlateHeight)/2, -(camPlateHeight + 1)/2])
    rotate([0,90,0])
        cylinder(55, d = camPlateHeight + 1, center = true, $fn = 30);
    }
}

//stripperPlate("lime");

module stripperPlateNose() {
    color("blue")
    hull () {
//        translate([0, -(camPlateHeight)/2, -(camPlateHeight + 1)/2])
//        rotate([0,90,0])
//        cylinder(CAM_PLATE_WIDTH, d = camPlateHeight + 1, center = true, $fn = 30);
        
        translate([-CAM_PLATE_WIDTH/2 + 55/2, -(camPlateHeight)/2, -(camPlateHeight + 1)/2])
    rotate([0,90,0])
        cylinder(55, d = camPlateHeight + 1, center = true, $fn = 30);
    
        
        // line up with front edge of yarn carrier
        translate([-CAM_PLATE_WIDTH/2 + 55/2,-(camPlateHeight + 1.5),needleSlotHeight + 2])
        rotate([0,90,0])
        cylinder(55, d = needleSlotHeight + 2.5, center = true, $fn = 50);
    }
}

module yarnCarrierCutout() {
        hull() {
//            translate([CAM_PLATE_WIDTH/2,0,0])
//            yarnFeeder();
            
            // back
            translate([CAM_PLATE_WIDTH/2,YARN_DEPOSIT_Y,(camHeight + camPlateHeight*2)])
            cylinder(h = 40, r = 29, center = true);
             
         // wide cone front   
            translate([CAM_PLATE_WIDTH/2,YARN_DEPOSIT_Y - 35,(camHeight + camPlateHeight)/2])
            cylinder(h = camHeight + camPlateHeight, r = (CAM_PLATE_WIDTH - 55*2)/2, center = true);
                
//            // small frontmost
//            translate([CAM_PLATE_WIDTH/2,YARN_DEPOSIT_Y - 35,-camPlateHeight])
//            cylinder(h = camHeight + camPlateHeight*2, r = 10, center = true);
        }
}
module stripperPlateHalf() {
    difference() {
        translate([CAM_PLATE_WIDTH/2,-NEEDLE_BED_DEPTH - NEEDLE_EXTENSION - tolerance * 2,-needleSlotHeight]) {
            union() {
                stripperPlate();
                stripperPlateNose();
            }
        }
        translate([-1,-tolerance, -tolerance])
        // flat edge
        translate([0,-(NEEDLE_BED_DEPTH + NEEDLE_EXTENSION + camPlateHeight + 2), 2])
        cube([CAM_PLATE_WIDTH + 4, camPlateHeight + 2, camPlateHeight + 2], center = false);
        yarnCarrierCutout();
        carriageScrews();
    }
}

module renderStripperPlate() {
    stripperPlateHalf();

    translate([CAM_PLATE_WIDTH, 0, 0])
    mirror([1,0,0])
    stripperPlateHalf();
}

