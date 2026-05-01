/*

Values in `camelCase` are user-variable (within reason); 
values like numNeedles and screwDiam, etc.,  can be modified to
accommodate user preference or hardware subsitution. 

Values in `ALL_CAPS` should be considered CONSTANTS and should
only be modified with *extreme caution* as they will affect the 
relationship between the needles and the cams, which could
prevent stitches from forming correctly.

I recommend only modifying these constants if you are also 
making changes to the cam design in the technical sketch.
*/

$fn = 50;

defaultGauge = 4.5;
defaultNumNeedles = 25;
defaultTolerance = 0.2;
defaultScrewPlacement = 3;
defaultShowScrewPreview = false;
defaultScrewPreset = "4-40";
defaultCustomScrewDiam = 2.79;
defaultCustomScrewHeadDiam = 5.21;
defaultCustomScrewHeadHeight = 2.41;
defaultCustomNutHeight = 2.8;
defaultUseThreadedInserts = false;
defaultInsertOuterDiam = 4.6;
defaultInsertLength = 4.0;
defaultInsertLeadInDiam = 5.2;
defaultInsertLeadInDepth = 1.2;

screwPreset = is_undef(cfaScrewPreset) ? defaultScrewPreset : cfaScrewPreset;

gauge = is_undef(cfaGauge) ? defaultGauge : cfaGauge; // I recommend using one of the predefined gauges above
numNeedles = is_undef(cfaNumNeedles) ? defaultNumNeedles : cfaNumNeedles;
tolerance = is_undef(cfaTolerance) ? defaultTolerance : cfaTolerance; // allows a bit of room for parts that have to fit together; adjust according to your printer's precision
screwPlacement = is_undef(cfaScrewPlacement) ? defaultScrewPlacement : cfaScrewPlacement; // how many needles from edge of bed; min 2, max floor(numNeedles/2)
showScrewCutouts = is_undef(cfaShowScrewPreview) ? defaultShowScrewPreview : cfaShowScrewPreview;
useThreadedInserts = is_undef(cfaUseThreadedInserts) ? defaultUseThreadedInserts : cfaUseThreadedInserts;

customScrewDiam = is_undef(cfaScrewDiam) ? defaultCustomScrewDiam : cfaScrewDiam;
customScrewHeadDiam = is_undef(cfaScrewHeadDiam) ? defaultCustomScrewHeadDiam : cfaScrewHeadDiam;
customScrewHeadHeight = is_undef(cfaScrewHeadHeight) ? defaultCustomScrewHeadHeight : cfaScrewHeadHeight;
customNutHeight = is_undef(cfaNutHeight) ? defaultCustomNutHeight : cfaNutHeight;
insertOuterDiam = is_undef(cfaInsertOuterDiam) ? defaultInsertOuterDiam : cfaInsertOuterDiam;
insertLength = is_undef(cfaInsertLength) ? defaultInsertLength : cfaInsertLength;
insertLeadInDiam = is_undef(cfaInsertLeadInDiam) ? defaultInsertLeadInDiam : cfaInsertLeadInDiam;
insertLeadInDepth = is_undef(cfaInsertLeadInDepth) ? defaultInsertLeadInDepth : cfaInsertLeadInDepth;

// ---
// Hardware dimensions 
// (actual measurements, no tolerances)

FIXED_SCREW_LENGTH = 14.62;

// - pan head 4-40 machine screws (M3 should also work where these are used)
screwDiam =
    screwPreset == "M3" ? 2.8 :
    screwPreset == "Custom" ? customScrewDiam :
    2.79;
// Keep printed bed height stable across hardware choices and later reprints.
screwHeight = FIXED_SCREW_LENGTH;
screwHeadHeight =
    (screwPreset == "M3" ? 2.4 :
    screwPreset == "Custom" ? customScrewHeadHeight :
    2.41) + tolerance * 2;
screwHeadDiam =
    (screwPreset == "M3" ? 7 :
    screwPreset == "Custom" ? customScrewHeadDiam :
    5.21) + tolerance * 2;
nutHeight =
    screwPreset == "M3" ? 2.4 :
    screwPreset == "Custom" ? customNutHeight :
    2.8;

// ---
// Needle dimensions
// - Brother needles
BUTT_HEIGHT = 15;
NEEDLE_WIDTH = 1.25;
NEEDLE_LEG_HEIGHT = 1.85;
HOOK_DIAM = 3.5;

// ---
// Needle Bed Zones
BACK_COVER = 45;
OOW_TRACK = 8;
B_TRACK = 42; // will divvy up working tracks (B & C position) later
C_TRACK = 0;
WORKING_TRACK = B_TRACK + C_TRACK;
HOLD_TRACK = 8;
SPONGE_BAR = 12;
COMB = 29;
NEEDLE_EXTENSION = 34.5;

// ---
// Needle bed dimensions
NEEDLE_BED_DEPTH = BACK_COVER + OOW_TRACK + WORKING_TRACK + HOLD_TRACK + SPONGE_BAR + COMB;
needleBedHeight = screwHeight + 2;
needleSlotHeight = NEEDLE_LEG_HEIGHT * 2 + screwHeadHeight;
needleSlotWidth = NEEDLE_WIDTH + 0.25; // add a small amount of clearance
combWidth = gauge*2/3; // width of cutouts for stitch formation; this gives room for the thickness of the yarn looped around the needle when it pulls back into the slot, but has to balance leaving enough material for the remaining "teeth" to not be too fragile
spongeThickness = 2.5;
spongeBarThickness = needleSlotHeight - NEEDLE_LEG_HEIGHT - spongeThickness;
YARN_DEPOSIT_Y = -155.1;
YARN_DEPOSIT_Z = -needleSlotHeight + HOOK_DIAM;
connectorOffset = 20;

// ---
// Carriage dimensions
// refer to technical sketch
camHeight = BUTT_HEIGHT; // thickness of the tracks the needles ride along
camPlateHeight = 4; // plate behind the cams
CAM_PLATE_WIDTH = 91 * 2; 
CAM_PLATE_DEPTH = NEEDLE_BED_DEPTH - COMB + 6;

railDepth = 8;
railHeight = 8; // ???
xOffset = 16.5;
//vCamScrews = [[34-xOffset, -90.25, 0],[58-xOffset, -74.25, 0],[86-xOffset,-90.25, 0]];

module screwPreview() {
    if (showScrewCutouts) {
        #children();
    } else {
        children();
    }
}



