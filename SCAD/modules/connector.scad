include<params.scad>;
//include<needlebed.scad>;

//testPrintM();

module testPrintF() {
    difference() {
        translate([0,-25/2,0])
        cube(25);
        translate([-tolerance, 0, -tolerance])
        // female
        connector();
    }
}

module testPrintM() { 
    union() {
        translate([-(25+tolerance),-25/2,0])
        cube(25);
        translate([-tolerance,0,0])
        // male
        connector(tolerance = tolerance);
    }
}


module connector(top = needleBedHeight - (needleSlotHeight + 3), diam = 3, pinWidth = 4, plugDiam = 6, tolerance = 0) {
    union() {
        hull() {
            translate([(pinWidth + tolerance*2)/2 + 0.25,0,(top - tolerance) - (plugDiam - tolerance*2)/2])
            rotate([0,90,0])
            cylinder(h = pinWidth + tolerance*2 + 0.5, d = diam - tolerance*3, center = true, $fn = 25);
            translate([(pinWidth + tolerance*2)/2 + 0.25,0,(diam - tolerance*2)/2])
            cube([pinWidth + tolerance*2 + 0.5,diam - tolerance*2,diam - tolerance*2], center = true);    
        }
        hull() {
            translate([pinWidth/4 + (pinWidth - tolerance/4),0,(top - tolerance) - (plugDiam - tolerance*2)/2])
            rotate([0,90,0])
            cylinder(h = pinWidth/2 - tolerance*2, d = plugDiam - tolerance*3, center = true, $fn = 25);
            translate([pinWidth/4 + (pinWidth - tolerance/4),0,1])
            cube([pinWidth/2 - tolerance*2,plugDiam - tolerance*2,2], center = true);    
        }
}
}
