include<../modules/params.scad>;
use<../modules/carriageScrews.scad>;
use<../parts/stripperPlate.scad>;

/* [Parameters] */
Show_cutaway = false;
/* [Hidden] */


Delta = 0.1;  // tiny adj for neater boolean subtractions
resSimple = 30;  // simplify the curves in this file

// calcs to position holes in handle based on carriage_screws
xposScrewLeft = screwHeadDiam*1.5;
xposScrewMid = CAM_PLATE_WIDTH/2;
xposScrewRight = CAM_PLATE_WIDTH - screwHeadDiam*1.5;
yposScrew = -(NEEDLE_BED_DEPTH - COMB - 6);
zposScrew = camHeight + camPlateHeight*2;


module handle_screws() {
	width = SPONGE_BAR + 8;
	recessHeight = 10;
	carriageScrews();
	// left
	translate([xposScrewLeft, yposScrew, zposScrew])
		cylinder(h=recessHeight, d=7, center=true, $fn=resSimple);
	// right
	translate([xposScrewRight, yposScrew, zposScrew])
		cylinder(h=recessHeight, d=7, center=true, $fn=resSimple);
	// middle
	translate([xposScrewMid, yposScrew, zposScrew])
		cylinder(h=recessHeight, d=7, center=true, $fn=resSimple);
}


module handle_part() {
	width = SPONGE_BAR + 8;
	difference() {
		// handle outer shape
		hull() {
			cube([CAM_PLATE_WIDTH, width, camPlateHeight]);
			rotate([-90,0,0]) {
				// left edge
				translate([camPlateHeight/2,-camPlateHeight,width/2])
					cylinder(width, d=camPlateHeight,  center=true, $fn=resSimple);
				// right edge
				translate([CAM_PLATE_WIDTH-camPlateHeight/2,-camPlateHeight,width/2])
					cylinder(width, d=camPlateHeight,  center=true, $fn=resSimple);
				// middle 2
				translate([CAM_PLATE_WIDTH*0.8-camPlateHeight/2,-camPlateHeight*8,width/2])
					cylinder(width, d=camPlateHeight,  center=true, $fn=resSimple);
				translate([CAM_PLATE_WIDTH*0.2-camPlateHeight/2,-camPlateHeight*8,width/2])
					cylinder(width, d=camPlateHeight,  center=true, $fn=resSimple);
			}
		}
		// void in middle of handle
		hull() {
			rotate([-90,0,0]) {
				// bottom pair
				translate([CAM_PLATE_WIDTH*0.8-camPlateHeight/2,-camPlateHeight*2,width/2])
					cylinder(width+Delta*2, d=camPlateHeight,  center=true, $fn=resSimple);
				translate([CAM_PLATE_WIDTH*0.2-camPlateHeight/2,-camPlateHeight*2,width/2])
					cylinder(width+Delta*2, d=camPlateHeight,  center=true, $fn=resSimple);
				// top pair
				translate([CAM_PLATE_WIDTH*0.8-camPlateHeight/2,-camPlateHeight*6,width/2])
					cylinder(width+Delta*2, d=camPlateHeight,  center=true, $fn=resSimple);
				translate([CAM_PLATE_WIDTH*0.2-camPlateHeight/2,-camPlateHeight*6,width/2])
					cylinder(width+Delta*2, d=camPlateHeight,  center=true, $fn=resSimple);
			}
		}
	}
}

// clip away all but middle screw so can lower it for recess in handle
module middle_screw() {
	width = SPONGE_BAR + 8;
	difference() {
	translate([0,0,0])
		handle_screws();
		// crudely block left/right hole with big cubes
		translate([0, yposScrew-width*2, 0])
			cube([60,60,40]);
		translate([xposScrewRight-width, yposScrew-width*2, 0])
			cube([60,60,40]);
		}
}

module handle() {
	width = SPONGE_BAR + 8;
	difference() {
		color("PowderBlue")
		translate([0, yposScrew-width/2, zposScrew])
			handle_part();
		// outer screws
		translate([0,0,-1])
		scale([1,1,1.5])
			handle_screws();
		// inner screw recess
		middle_screw();
	}
}

if (Show_cutaway) {
	cutawayBlock = 20;
    difference() {
        handle();
        color("Red") {
        translate([xposScrewLeft-cutawayBlock, yposScrew, zposScrew-Delta])
            cube([cutawayBlock,cutawayBlock,cutawayBlock]);
        }
    }
} else
    handle();