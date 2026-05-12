include<../modules/params.scad>;
include<../modules/camplate_coords_mk2.scad>;
include<../modules/utils.scad>;
use<../modules/backCover.scad>;
use<../modules/spongeBar.scad>;
include<../modules/tPointer.scad>;
include<../modules/carriageScrews.scad>;
use<../modules/tCam.scad>;
include<../modules/backPlate.scad>;


/* 
Full camplate assembly for layout and debugging
See individual files to export models
*/


// --- LAYOUT: CAMS ---

translate(tCamCoords)
tCam();
translate(flip(tCamCoords))
mirror([1,0,0])
tCam();

translate(tPivotCoords)
tPivot(solid = true);
translate(flip(tPivotCoords))
mirror([1,0,0])
tPivot(solid = true); 
