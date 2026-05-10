include<../modules/params.scad>;
include<../modules/stripperPlate.scad>;
include<../modules/yarnCarrierCover.scad>;
include<../modules/yarnFeeder.scad>;

/* 
Full yarn carrier (fairing) assembly for layout and debugging
See individual files to export models
*/

module renderYarnCarrierAssembly() {
    renderStripperPlate();
    renderYarnCarrierCover();
    renderYarnFeeder();
}
