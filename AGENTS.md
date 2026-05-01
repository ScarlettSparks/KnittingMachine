# Repository Guidelines

## Project Structure & Module Organization
`SCAD/` contains the editable OpenSCAD source. Use `SCAD/parts/` for reusable part geometry and explicit `render...` part modules, `SCAD/assemblies/` for multi-part render entry points such as `needlebedAssembly.scad` and `yarnCarrierAssembly.scad`, and `SCAD/modules/` for shared geometry, screw locations, coordinates, and parameters. `SCAD/customiserFullAssembly.scad` is the current top-level customiser entry point. `STL/` stores pre-exported printable models. `SVG/` holds 2D source shapes imported into SCAD, and `Technical sketches/` contains Illustrator and SVG reference drawings for cam geometry.

## Build, Test, and Development Commands
Open the `.scad` files in OpenSCAD for interactive editing and preview. Typical CLI exports:

```powershell
openscad -o STL\needlebed_std.stl SCAD\parts\needlebed.scad
openscad -o STL\backPlate_mk2.stl SCAD\parts\backPlate.scad
openscad -o preview.stl SCAD\assemblies\assembly.scad
```

Edit shared dimensions in `SCAD/modules/params.scad` first, then re-export the affected part files. Use assemblies to confirm fit before replacing checked-in STL outputs.

When validating the current customiser, prefer rendering `SCAD/customiserFullAssembly.scad`. Some part and assembly files are now module-only and will render an empty top level unless a `render...` module is called explicitly.

## Coding Style & Naming Conventions
Match the existing OpenSCAD style: top-level `include<...>;`, short section comments, and simple parameter-driven modules. User-tunable values use `camelCase` such as `numNeedles` and `screwDiam`; calibrated constants use `SCREAMING_SNAKE_CASE` such as `STANDARD_GAUGE` and `HOOK_DIAM`. Keep new filenames aligned with existing part names (`yarnFeeder.scad`, `backCover.scad`) and mirror exported asset names in `STL/` where practical.

For customiser-owned values, use a `cfa` prefix to avoid collisions with shared module names and geometry variables. Follow this pattern consistently:
- Options start with `cfa...`
- Part toggles start with `cfaRender...Part`
- Assembly toggles start with `cfaRender...Assembly`
- Render helper modules still start with `render...`

Prefer module-only part and assembly files over top-level geometry. Parts should generally expose `render...` modules, and assemblies should compose those render modules rather than relying on include side effects.

For fasteners, keep screw location logic separate from hole-shape logic when possible. Shared location modules belong in `SCAD/modules/`, while part-specific features such as counterbores or threaded-insert pockets should be cut from the receiving part using local face references.

## Testing Guidelines
There is no automated test suite in this repository. Validate changes by:

1. Rendering the edited part in OpenSCAD without warnings or missing imports.
2. Opening the relevant file in `SCAD/assemblies/` or `SCAD/customiserFullAssembly.scad` to check alignment with neighboring parts.
3. Re-exporting changed STL files and, for geometry changes, doing a print-fit check on the affected interface.

Be especially cautious when changing `SCAD/modules/params.scad` values, screw-location modules, or cam-related SVG/sketch assets; those changes can alter stitch formation or break multiple downstream parts at once.

## Commit & Pull Request Guidelines
Recent history uses short, imperative commit subjects such as `Update README.md` and `add other file types for tech sketch`. Follow that pattern: one concise line describing the visible change. Pull requests should state which parts or assemblies changed, whether STL exports were regenerated, and whether the change affects default gauge, needle count, or hardware compatibility. Include screenshots for assembly-view changes and link any relevant issue or design discussion.
