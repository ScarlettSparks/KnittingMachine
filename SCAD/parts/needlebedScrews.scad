include<../modules/fasteners.scad>;
use<../modules/needlebedScrews.scad>;

screwPreview()
if (useThreadedInserts) {
    needleBedSpongeBarScrewPositions(side = "both")
    fastenerScrewCutoutWithInsert(
        throughDepth = screwHeight,
        headZ = railHeight,
        headDepth = screwHeadHeight + tolerance,
        insertOffsetBelowHead = needleBedSpongeBarInsertOffset(),
        pocketDepth = insertLength,
        pocketDiam = insertOuterDiam,
        includeLeadIn = true
    );

    needleBedBackCoverScrewPositions(side = "both")
    fastenerScrewCutoutWithInsert(
        throughDepth = screwHeight,
        headZ = railHeight,
        headDepth = screwHeadHeight + tolerance,
        insertOffsetBelowHead = needleBedBackCoverInsertOffset(),
        pocketDepth = insertLength,
        pocketDiam = insertOuterDiam,
        includeLeadIn = true
    );
} else {
    needleBedScrewPositions(side = "both")
    fastenerScrewCutout(
        throughDepth = screwHeight,
        headZ = railHeight,
        headDepth = screwHeadHeight + tolerance
    );
}
