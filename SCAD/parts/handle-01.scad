include<../modules/params.scad>;
use<../modules/carriageScrews.scad>;
use<../parts/stripperPlate.scad>;

/* [Parameters] */
Show_cutaway = false;
/* [Hidden] */


Delta = 0.1;  // tiny adj for neater boolean subtractions


module handle_part() {
	width = SPONGE_BAR + 8;
	difference() {
		// handle outer shape
		hull() {
			cube([CAM_PLATE_WIDTH, width, camPlateHeight]);
			rotate([-90,0,0]) {
				// left edge
				translate([camPlateHeight/2,-camPlateHeight,width/2])
					cylinder(width, d=camPlateHeight,  center=true, $fn=cylres30);
				// right edge
				translate([CAM_PLATE_WIDTH-camPlateHeight/2,-camPlateHeight,width/2])
					cylinder(width, d=camPlateHeight,  center=true, $fn=cylres30);
				// middle 2
				translate([CAM_PLATE_WIDTH*0.8-camPlateHeight/2,-camPlateHeight*8,width/2])
					cylinder(width, d=camPlateHeight,  center=true, $fn=cylres30);
				translate([CAM_PLATE_WIDTH*0.2-camPlateHeight/2,-camPlateHeight*8,width/2])
					cylinder(width, d=camPlateHeight,  center=true, $fn=cylres30);
			}
		}
		// void in middle of handle
		hull() {
			rotate([-90,0,0]) {
				// bottom pair
				translate([CAM_PLATE_WIDTH*0.8-camPlateHeight/2,-camPlateHeight*2,width/2])
					cylinder(width+Delta*2, d=camPlateHeight,  center=true, $fn=cylres30);
				translate([CAM_PLATE_WIDTH*0.2-camPlateHeight/2,-camPlateHeight*2,width/2])
					cylinder(width+Delta*2, d=camPlateHeight,  center=true, $fn=cylres30);
				// top pair
				translate([CAM_PLATE_WIDTH*0.8-camPlateHeight/2,-camPlateHeight*6,width/2])
					cylinder(width+Delta*2, d=camPlateHeight,  center=true, $fn=cylres30);
				translate([CAM_PLATE_WIDTH*0.2-camPlateHeight/2,-camPlateHeight*6,width/2])
					cylinder(width+Delta*2, d=camPlateHeight,  center=true, $fn=cylres30);
			}
		}
	}
}

// clip away all but middle screw so can lower it for recess in handle
module middle_screw() {
	difference() {
	translate([0,0,-1])
		carriageScrews();
		// block left hole
		translate([0,-140,0])
			cube([60,60,40]);
		translate([CAM_PLATE_WIDTH-30,-140,0])
			cube([60,60,40]);
		}
}

module handle() {
	difference() {
		color("PowderBlue")
		translate([0,-(NEEDLE_BED_DEPTH - COMB + 8),camHeight + camPlateHeight*2])
			handle_part();
		// outer screws
		translate([0,0,-5])
		scale([1,1,1.5])
			carriageScrews();
		// inner screw recess
		middle_screw();
	}
}

if (Show_cutaway) {
    difference() {
        handle();
        color("Red") {
        translate([-10,-109,10])
            cube([20,30,30]);
        }
    }
} else
    handle();