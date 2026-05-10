include<params.scad>;

module clampHead() {
   $fn = 50;
   boltDiam = 7.8;

   difference() {
       sphere(d = boltDiam + 3);
       cylinder(h = boltDiam, d = boltDiam);
   }

   difference() {
       translate([0,0,-boltDiam - tolerance *2])
       cylinder(h = boltDiam + 4, d1 = boltDiam * 4, d2 = boltDiam * 2);
       sphere(d = boltDiam + 3 + tolerance * 3);
   }
}

module renderClampHead() {
    clampHead();
}
