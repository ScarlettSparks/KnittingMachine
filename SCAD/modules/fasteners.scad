include<params.scad>;

// Shared fastener helpers.
// These are intentionally face-based so insert pockets can stay flush with the
// local mating face instead of assuming one global part thickness.

module fastenerThroughHole(
    holeDepth,
    holeDiam = screwDiam,
    holeCenter = true
) {
    cylinder(h = holeDepth, d = holeDiam, center = holeCenter, $fn = 30);
}

module fastenerCounterboreFromFace(
    faceZ,
    boreDepth = screwHeadHeight + tolerance,
    boreDiam = screwHeadDiam,
    direction = -1
) {
    translate([0,0,faceZ + direction * boreDepth/2])
    cylinder(h = boreDepth + 0.01, d = boreDiam, center = true, $fn = 30);
}

module fastenerInsertPocketFromFace(
    faceZ,
    pocketDepth = insertLength,
    pocketDiam = insertOuterDiam,
    direction = -1,
    includeLeadIn = true
) {
    translate([0,0,faceZ + direction * pocketDepth/2])
    cylinder(h = pocketDepth + 0.01, d = pocketDiam, center = true, $fn = 40);

    if (includeLeadIn && insertLeadInDepth > 0) {
        translate([0,0,faceZ + direction * insertLeadInDepth/2])
        cylinder(h = insertLeadInDepth + 0.01, d = insertLeadInDiam, center = true, $fn = 40);
    }
}

module fastenerInsertReadyHole(
    throughDepth,
    faceZ,
    direction = -1,
    throughDiam = screwDiam,
    pocketDepth = insertLength,
    pocketDiam = insertOuterDiam,
    includeLeadIn = true
) {
    fastenerThroughHole(throughDepth, holeDiam = throughDiam);
    fastenerInsertPocketFromFace(
        faceZ = faceZ,
        pocketDepth = pocketDepth,
        pocketDiam = pocketDiam,
        direction = direction,
        includeLeadIn = includeLeadIn
    );
}
