include<../modules/needlebed.scad>;
include<../modules/backCover.scad>;
include<../modules/spongeBar.scad>;
include<../modules/carriageRest.scad>;
include<../modules/clampUnit.scad>;

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
