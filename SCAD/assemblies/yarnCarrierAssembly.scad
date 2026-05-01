include<../modules/params.scad>;
include<../parts/stripperPlate.scad>;
include<../parts/yarnCarrierCover.scad>;
include<../parts/yarnFeeder.scad>;

/* 
Full yarn carrier (fairing) assembly for layout and debugging
See individual files to export models
*/

module renderYarnCarrierAssembly() {
    renderStripperPlate();
    renderYarnCarrierCover();
    renderYarnFeeder();
}
