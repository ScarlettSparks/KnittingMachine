include<../modules/params.scad>;
use<../modules/needlebedScrews.scad>;
use<../modules/connector.scad>;
use<needlebed.scad>;

holeCutout = poleHeight - 2;
bedCentreX = gauge * (numNeedles - 1) / 2;
edgeLength = (wallThickness * 2) + poleDiameter;
base = 0 - needleBedHeight;

module poleMount() {
    translate([bedCentreX, edgeLength / 2, base +(poleHeight / 2)])
    cube([edgeLength, edgeLength, poleHeight], center = true);
    
    translate([bedCentreX, edgeLength / 2, base / 2 ])
    cube([poleHeight, edgeLength, needleBedHeight], center = true);
}

module poleMountHole() {
    translate([bedCentreX, edgeLength / 2, base + 2])
    cylinder(h = holeCutout, d = poleDiameter, $fn = 40);
}

module poleMountSlot() {
    translate([bedCentreX, edgeLength / 2, (holeCutout / 2) + base + 2])
    cube([knotchWidth, knotchDepth, holeCutout], center = true);
}

module poleMountSupport() {
    translate([bedCentreX - (poleHeight / 2) , edgeLength, 0])
    rotate([90, 0, 0])
    linear_extrude(height = edgeLength)
    polygon(points = [[0, 0],[poleHeight / 2, poleHeight + base],[60, 0]]);
}

union() {
    difference() {
        union() {
            needleBed();
            poleMountSupport();
            poleMount();
        }
        #poleMountHole();
        #poleMountSlot();
        translate([-gauge/2 - tolerance,-connectorOffset,-needleBedHeight-tolerance])
        #connector();
        translate([-gauge/2 - tolerance,-(NEEDLE_BED_DEPTH-connectorOffset),-needleBedHeight - tolerance])
        #connector();
        needleBedScrews();
    }
    translate([gauge*(numNeedles-1)+gauge/2,-connectorOffset,-needleBedHeight])
                connector(tolerance = tolerance);
                translate([gauge*(numNeedles-1)+gauge/2,-(NEEDLE_BED_DEPTH-connectorOffset),-needleBedHeight])
                connector(tolerance = tolerance);
}    

