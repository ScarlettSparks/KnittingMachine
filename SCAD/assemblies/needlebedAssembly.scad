include<../parts/needleBed.scad>;
include<../parts/backCover.scad>;
include<../parts/spongeBar.scad>;
include<../parts/carriageRest.scad>;
include<../parts/clampUnit.scad>;

/* 
Full bed assembly for layout and debugging
See individual files to export models
*/

module renderNeedlebedAssembly(
    cfaRenderNeedlebedPart = true,
    cfaRenderBackCoverPart = true,
    cfaRenderSpongeBarPart = true,
    cfaRenderCarriageRestsPart = true,
    cfaRenderClampUnitPart = true
) {
    if (cfaRenderNeedlebedPart) {
        renderNeedlebed();
    }

    if (cfaRenderBackCoverPart) {
        renderBackCover();
    }

    if (cfaRenderSpongeBarPart) {
        renderSpongeBar();
    }

    if (cfaRenderCarriageRestsPart) {
        renderCarriageRests();
    }

    if (cfaRenderClampUnitPart) {
        renderClampUnit();
    }
}
