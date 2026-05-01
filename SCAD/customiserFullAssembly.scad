cfaTolerance = 0.2;

/* [Screw Options] */
cfaShowScrewPreview = false;
cfaScrewPreset = "4-40"; // [4-40, M3, Custom]
cfaScrewDiam = 2.79;
cfaScrewHeadDiam = 5.21;
cfaScrewHeadHeight = 2.41;
cfaNutHeight = 2.8;

/* [Insert Options] */
cfaUseThreadedInserts = false;
cfaInsertOuterDiam = 4.6;
cfaInsertLength = 4.0;
cfaInsertLeadInDiam = 5.2;
cfaInsertLeadInDepth = 1.2;

/* [Needlebed Options] */
cfaRenderNeedlebedAssembly = true;
cfaRenderNeedlebedPart = true;
cfaRenderBackCoverPart = true;
cfaRenderSpongeBarPart = true;
cfaGauge = 4.5; // [4.5:Standard, 6.5:Mid, 9.0:Bulky]
cfaNumNeedles = 25;
cfaScrewPlacement = 3;

/* [Carriage Rest Options] */
cfaRenderCarriageRestsPart = true;

/* [Clamp Unit Options] */
cfaRenderClampUnitPart = true;

/* [Yarn Carrier Options] */
cfaRenderYarnCarrierAssembly = true;

include <assemblies/needlebedAssembly.scad>;
include <assemblies/yarnCarrierAssembly.scad>;

module renderIf(enabled) {
    if (enabled) {
        children();
    }
}

renderIf(cfaRenderNeedlebedAssembly)
renderNeedlebedAssembly(
    cfaRenderNeedlebedPart = cfaRenderNeedlebedPart,
    cfaRenderBackCoverPart = cfaRenderBackCoverPart,
    cfaRenderSpongeBarPart = cfaRenderSpongeBarPart,
    cfaRenderCarriageRestsPart = cfaRenderCarriageRestsPart,
    cfaRenderClampUnitPart = cfaRenderClampUnitPart
);

renderIf(cfaRenderYarnCarrierAssembly)
renderYarnCarrierAssembly();
