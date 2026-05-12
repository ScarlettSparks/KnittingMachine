# CHANGELOG

## 10/05/26 - Compared with `main`

Summary of functional changes in the working tree:

### TLDR:
- Parts were moved into `SCAD/modules/` and `SCAD/parts/` now acts as render/debug wrappers.
- Screw geometry was centralized in shared fastener helpers; screw-location files now control positions only.
- Initial needlebed insert support was added and tuned per screw group.
- README customiser and fastener documentation was corrected and expanded.

### 1. Part/module structure reorganized
- Moved reusable part implementations into `SCAD/modules/`.
- Converted `SCAD/parts/` files into thin render/debug entry points.
- Updated assemblies to include or use module files directly:
  - [SCAD/assemblies/needlebedAssembly.scad](SCAD/assemblies/needlebedAssembly.scad)
  - [SCAD/assemblies/camplate.scad](SCAD/assemblies/camplate.scad)
  - [SCAD/assemblies/yarnCarrierAssembly.scad](SCAD/assemblies/yarnCarrierAssembly.scad)
- Added standalone debug wrapper for [SCAD/parts/needlebedScrews.scad](SCAD/parts/needlebedScrews.scad).

### 2. Screw and fastener refactor
- Expanded [SCAD/modules/fasteners.scad](SCAD/modules/fasteners.scad) with shared screw-cut helpers:
  - `fastenerCounterbore(...)`
  - `fastenerScrewCutout(...)`
  - `fastenerScrewCutoutWithInsert(...)`
- Reduced [SCAD/modules/needlebedScrews.scad](SCAD/modules/needlebedScrews.scad) and [SCAD/modules/carriageScrews.scad](SCAD/modules/carriageScrews.scad) to position-only responsibilities.
- Rewired needlebed, sponge bar, back cover, and carriage-related modules to combine position modules with shared fastener geometry instead of bundled screw emitters.
- Corrected screw-head recess depth/placement so the head preview sits flush with the part top face.
- Set the screw through-hole length to use the configured `screwHeight`.

### 3. Needlebed screw layout and insert work
- Simplified the needlebed screw layout to two Y zones:
  - sponge bar
  - back rail / back cover
- Removed the older extra rear/back-cover screw positions.
- Split needlebed screw groups into sponge-bar and back-cover position helpers so insert handling can vary by group.
- Added per-group insert-offset logic in [SCAD/modules/needlebedScrews.scad](SCAD/modules/needlebedScrews.scad).
- Tuned sponge-bar and back-cover insert offsets using existing model dimensions instead of only ad hoc constants.
- Restored correct handed pairing so there are four screw positions rather than duplicated left/right offsets at each end.

### 4. Back cover and needlebed alignment adjustments
- Moved back cover implementation to [SCAD/modules/backCover.scad](SCAD/modules/backCover.scad) and left [SCAD/parts/backCover.scad](SCAD/parts/backCover.scad) as a render wrapper.
- Updated back-cover screw handling to use the shared needlebed screw-position and fastener pipeline.
- Kept screw-location logic centralized in [SCAD/modules/needlebedScrews.scad](SCAD/modules/needlebedScrews.scad) rather than in individual receiving parts.

### 5. Documentation
- Removed README wording that incorrectly implied screw lengths are customiser-controlled.
- Expanded README documentation to include the currently exposed customiser parameters from [SCAD/customiserFullAssembly.scad](SCAD/customiserFullAssembly.scad).

## Files added
- [SCAD/modules/backCover.scad](SCAD/modules/backCover.scad)
- [SCAD/modules/backPlate.scad](SCAD/modules/backPlate.scad)
- [SCAD/modules/carriageRest.scad](SCAD/modules/carriageRest.scad)
- [SCAD/modules/clampHead.scad](SCAD/modules/clampHead.scad)
- [SCAD/modules/clampUnit.scad](SCAD/modules/clampUnit.scad)
- [SCAD/modules/needlebed.scad](SCAD/modules/needlebed.scad)
- [SCAD/modules/spongeBar.scad](SCAD/modules/spongeBar.scad)
- [SCAD/modules/stripperPlate.scad](SCAD/modules/stripperPlate.scad)
- [SCAD/modules/tCam.scad](SCAD/modules/tCam.scad)
- [SCAD/modules/tPointer.scad](SCAD/modules/tPointer.scad)
- [SCAD/modules/yarnCarrierCover.scad](SCAD/modules/yarnCarrierCover.scad)
- [SCAD/modules/yarnFeeder.scad](SCAD/modules/yarnFeeder.scad)
- [SCAD/parts/needlebedScrews.scad](SCAD/parts/needlebedScrews.scad)



---

## 01/05/26 — Compared with `main`

Summary of functional changes in the working tree:

### TLDR: 
- No longer edit the params file for changes.
- Parts are now modules.
- Modules are pulled together into assemblies.
- Assemblies are accessed from one central file with relevent customiser options.

### 1. Customiser added and reorganized
- Added [SCAD/customiserFullAssembly.scad](SCAD/customiserFullAssembly.scad) as a top-level customiser entry point.
- Grouped render toggles for the needlebed and yarn-carrier assemblies.
- Added per-part toggles for needlebed.
- Standardized customiser-owned names to the `cfa...` convention.
- Added screw preview options and initial threaded-insert options.

### 2. Needlebed moved to assembly-driven rendering
- [SCAD/assemblies/needlebedAssembly.scad](SCAD/assemblies/needlebedAssembly.scad) now exposes `renderNeedlebedAssembly(...)` instead of being an include stub.
- Converted needlebed part files into module-based render targets:
  - [SCAD/parts/needlebed.scad](SCAD/parts/needlebed.scad)
  - [SCAD/parts/backCover.scad](SCAD/parts/backCover.scad)
  - [SCAD/parts/spongeBar.scad](SCAD/parts/spongeBar.scad)
- Fixed scoping issues around parameter defaults and customiser-fed values in [SCAD/modules/params.scad](SCAD/modules/params.scad).
- Fixed `backRail`/`frontRail` tolerance parameter shadowing.

### 3. Yarn carrier cleaned into its own assembly
- Added [SCAD/assemblies/yarnCarrierAssembly.scad](SCAD/assemblies/yarnCarrierAssembly.scad) with `renderYarnCarrierAssembly()`.
- Converted yarn carrier parts to explicit render modules:
  - [SCAD/parts/stripperPlate.scad](SCAD/parts/stripperPlate.scad)
  - [SCAD/parts/yarnCarrierCover.scad](SCAD/parts/yarnCarrierCover.scad)
  - [SCAD/parts/yarnFeeder.scad](SCAD/parts/yarnFeeder.scad)

### 4. Carriage rest and clamp refactor
- Added [SCAD/parts/clampUnit.scad](SCAD/parts/clampUnit.scad) as a separate module.
- Refactored [SCAD/parts/carriageRest.scad](SCAD/parts/carriageRest.scad):
  - Use helper modules for left/right connector placement.
  - Restore the top rails.
  - Stop owning clamp geometry directly.
- Split clamp screw handling into driver-side vs clamp-side behavior to support inserts.
- Separated carriage rests and clamp so they can be rendered independently.

### 5. Screw and fastener infrastructure refactor
- Added [SCAD/modules/fasteners.scad](SCAD/modules/fasteners.scad) with reusable helpers for:
  - through holes
  - counterbores from a face
  - insert pockets from a face
  - combined insert-ready holes
- [SCAD/modules/needlebedScrews.scad](SCAD/modules/needlebedScrews.scad) now exposes reusable screw-position modules instead of monolithic hole geometry.
- [SCAD/modules/carriageScrews.scad](SCAD/modules/carriageScrews.scad) was split into reusable position groups.
- Screw preview highlighting is toggleable from the customiser instead of being hard-coded.
- Updated [SCAD/parts/tCam.scad](SCAD/parts/tCam.scad) to use the shared screw preview control.

### 6. Threaded insert groundwork and first implementation
- Added insert-option plumbing in the customiser and [SCAD/modules/params.scad](SCAD/modules/params.scad).
- Implemented the first insert-capable path for the clamp unit:
  - With inserts off: clamp uses existing screw/counterbore behavior.
  - With inserts on: clamp receiver side uses a face-based insert pocket.

### 7. Documentation
- Documented the `cfa...` customiser naming convention.

## Files renamed
- [SCAD/assemblies/yarnCarrier.scad](SCAD/assemblies/yarnCarrier.scad) -> [SCAD/assemblies/yarnCarrierAssembly.scad](SCAD/assemblies/yarnCarrierAssembly.scad)

## Files added
- [AGENTS.md](AGENTS.md) - AI use transparency 
- [SCAD/customiserFullAssembly.scad](SCAD/customiserFullAssembly.scad)
- [SCAD/modules/fasteners.scad](SCAD/modules/fasteners.scad)
- [SCAD/parts/clampUnit.scad](SCAD/parts/clampUnit.scad)
- [SCAD/assemblies/yarnCarrierAssembly.scad](SCAD/assemblies/yarnCarrierAssembly.scad)

## Files removed
