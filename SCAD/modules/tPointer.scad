include<params.scad>;
include<camplate_coords_mk2.scad>;

module tPointer() {
    difference() {
        translate(tPointerCoord)
        linear_extrude(2)
        import("../../SVG/TPointer.svg");
        translate(tPivotCoords)
        cylinder(camPlateHeight*4, d = screwDiam, center = true, $fn = 20);
    }
}

module renderTPointer() {
    tPointer();
}
