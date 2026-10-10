# Changelog

Notable changes to this project are documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

Breaking changes:
- Changed types of width and height from Number to Int. The API guarantees that these values are integers as is, and even silently rounds non-integers if given.

New features:
- Added `imageSmoothingEnabled` to toggle the image smoothing of a `Context2D`.

Bugfixes:

Other improvements:

## [v6.0.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v6.0.0) - 2022-04-27

Breaking changes:
- Migrate FFI to ES modules (#85 by @JordanMartinez)
- Support arcs that are drawn counter-clockwise (#58, #83 by @karljs and @JordanMartinez)
- The `Transform` type now uses the field names `a`, `b`, `c`, `d`, `e` and `f`, instead of `m11`, `m12`, `m21`, `m22`, `m31` and `m32` (#86 by @artemisSystem)

New features:
- Added `createImageDataWith` (#81)

Bugfixes:

Other improvements:
- Added ESLint config and fixed the resulting linter issues (#82)

## [v5.0.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v5.0.0) - 2021-02-26

Breaking changes:
- Added support for PureScript 0.14 and dropped support for all previous versions (#71)

New features:
- Added `Eq` instances for `LineJoin`, `Composite`, `TextAlign`, and `PatternRepeat` (#67)
- Added `TextBaseline` (#66)

Bugfixes:
- Fixed order of arguments in `withContext` documentation example (#69) 

Other improvements:
- Migrated CI to GitHub Actions and updated installation instructions to use Spago (#70)
- Added a CHANGELOG.md file and pull request template (#73, #74)

## [v4.0.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v4.0.0) - 2018-06-20

- Updated for 0.12 compiler (@sharno)
- The `Rectangle` and `Arc` types now use the field names `width`, `height` and `radius`, instead of `w`, `h` and `r`.

## [v3.3.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v3.3.0) - 2017-11-19

- Exported `setTransform` (@yilinwei)

## [v3.2.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v3.2.0) - 2017-10-05

- Added `setTransform` (@yilinwei)

## [v3.1.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v3.1.0) - 2017-06-29

- Add an `Eq` instance for `LineCap` (#48, @ijks)

## [v3.0.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v3.0.0) - 2017-04-03

- Updated for 0.11 (@jasonzoladz)

## [v1.0.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v1.0.0) - 2016-06-11

- Updated for 1.0 core libraries and 0.9.1 compiler. This library will not work with compiler versions < 0.9.1. (@soupi)
- Changed `Canvas` effect to use uppercase (`CANVAS`)

## [v0.5.4](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.5.4) - 2016-05-11

- Added `setLineJoin` (@rgrempel)

## [v0.5.3](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.5.3) - 2016-04-10

- Fixed `setGlobalAlpha` (@igagen)

## [v0.5.2](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.5.2) - 2016-03-11

- Added new blend modes (@igagen)

## [v0.5.1](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.5.1) - 2016-03-10

- Added support for patterns (@igagen)

## [v0.5.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.5.0) - 2016-03-08

- Changed `withImage` to `tryLoadImage` (@igagen)

## [v0.4.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.4.0) - 2015-12-17

- Made changes to `ImageData`.

## [v0.3.5](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.3.5) - 2015-12-11

- Fixed compiler warnings (@jotrk)

## [v0.3.4](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.3.4) - 2015-11-02

- Added `withImage` (@izgzhen)

## [v0.3.3](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.3.3) - 2015-09-13

- Added support for Bezier curves (@jasonzoladz)

## [v0.3.2](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.3.2) - 2015-09-07

- Added gradient support (@jasonzoladz)

## [v0.3.1](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.3.1) - 2015-08-14

- Added `drawImage` (@puffnfresh)

## [v0.3.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.3.0) - 2015-06-30

- This release works with versions 0.7.\* of the PureScript compiler. It will not work with older versions. If you are using an older version, you should require an older, compatible version of this library.

## [v0.3.0-rc.1](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.3.0-rc.1) - 2015-06-17

- Initial candidate release for 0.7 compiler.

## [v0.2.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.2.0) - 2014-12-03

- `getCanvasElementById` has been made safe, this is a breaking change as the result is now `Maybe CanvasElement` (@hdgarrood)
- `strokeText` is now fixed, previously was filling text (@hdgarrood)
- Added `TextAlign`, `setTextAlign` and `textAlign` (@hdgarrood)

## [v0.1.6](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.1.6) - 2014-10-28

- Added global composite and alpha functions (#6, @jdeseno)

## [v0.1.5](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.1.5) - 2014-08-30

- Added methods for dealing with text (#3, @waterson)

## [v0.1.4](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.1.4) - 2014-08-20

- Added line cap and dimensions bindings (#1, @fresheyeball)

## [v0.1.3](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.1.3) - 2014-08-16

- Fixed shadow offset method

## [v0.1.2](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.1.2) - 2014-08-13

- Added `closePath`

## [v0.1.1](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.1.1) - 2014-08-13

- Updated documentation

## [v0.1.0](https://github.com/purescript-web/purescript-canvas/releases/tag/v0.1.0) - 2014-08-13

- Initial release

