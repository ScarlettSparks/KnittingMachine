include <../modules/camplate_coords_mk2.scad>;
use <tCam.scad>; // get holes aligned

tPointer();

module tPointer() {
    difference() {
        translate(tPointerCoord)
        linear_extrude(2)
        import("../../SVG/TPointer.svg");
        
        translate([0,0,2])
        pivotHole(tol=tolerance*2);
        
        translate(nutCoords)
        translate([0,0,6])
        adjustmentHole();  
    }       
}
