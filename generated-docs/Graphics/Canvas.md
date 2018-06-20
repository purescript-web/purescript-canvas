## Module Graphics.Canvas

This module defines foreign types and functions for working with the 2D
Canvas API.

#### `CanvasElement`

``` purescript
data CanvasElement :: Type
```

A canvas HTML element.

#### `Context2D`

``` purescript
data Context2D :: Type
```

A 2D graphics context.

#### `ImageData`

``` purescript
data ImageData :: Type
```

An image data object, used to store raster data outside the canvas.

#### `CanvasImageSource`

``` purescript
data CanvasImageSource :: Type
```

Opaque object for drawing elements and things to the canvas.

#### `Arc`

``` purescript
type Arc = { x :: Number, y :: Number, radius :: Number, start :: Number, end :: Number }
```

A type representing an arc object:

- The center coordinates `x` and `y`,
- The radius `r`,
- The starting and ending angles, `start` and `end`.

#### `Composite`

``` purescript
data Composite
  = SourceOver
  | SourceIn
  | SourceOut
  | SourceAtop
  | DestinationOver
  | DestinationIn
  | DestinationOut
  | DestinationAtop
  | Lighter
  | Copy
  | Xor
  | Multiply
  | Screen
  | Overlay
  | Darken
  | Lighten
  | ColorDodge
  | ColorBurn
  | HardLight
  | SoftLight
  | Difference
  | Exclusion
  | Hue
  | Saturation
  | Color
  | Luminosity
```

Enumerates the different types of composite operations and blend modes.

##### Instances
``` purescript
Show Composite
```

#### `Dimensions`

``` purescript
type Dimensions = { width :: Number, height :: Number }
```

Canvas dimensions (width and height) in pixels.

#### `LineCap`

``` purescript
data LineCap
  = Round
  | Square
  | Butt
```

Enumerates the different types of line cap.

##### Instances
``` purescript
Eq LineCap
```

#### `LineJoin`

``` purescript
data LineJoin
  = BevelJoin
  | RoundJoin
  | MiterJoin
```

Enumerates the different types of line join

#### `Rectangle`

``` purescript
type Rectangle = { x :: Number, y :: Number, width :: Number, height :: Number }
```

A type representing a rectangle object:

- The top-left corner coordinates `x` and `y`,
- The width and height `w` and `h`.

#### `ScaleTransform`

``` purescript
type ScaleTransform = { scaleX :: Number, scaleY :: Number }
```

An object representing a scaling transform:

- The scale factors in the `x` and `y` directions, `scaleX` and `scaleY`.

#### `TextMetrics`

``` purescript
type TextMetrics = { width :: Number }
```

Text metrics:

- The text width in pixels.

#### `Transform`

``` purescript
type Transform = { m11 :: Number, m12 :: Number, m21 :: Number, m22 :: Number, m31 :: Number, m32 :: Number }
```

An object representing a general transformation as a homogeneous matrix.

#### `TranslateTransform`

``` purescript
type TranslateTransform = { translateX :: Number, translateY :: Number }
```

An object representing a translation:

- The translation amounts in the `x` and `y` directions, `translateX` and `translateY`.

#### `TextAlign`

``` purescript
data TextAlign
  = AlignLeft
  | AlignRight
  | AlignCenter
  | AlignStart
  | AlignEnd
```

Enumerates types of text alignment.

##### Instances
``` purescript
Show TextAlign
```

#### `CanvasPattern`

``` purescript
data CanvasPattern :: Type
```

Opaque object describing a pattern.

#### `PatternRepeat`

``` purescript
data PatternRepeat
  = Repeat
  | RepeatX
  | RepeatY
  | NoRepeat
```

Enumerates the different types of pattern repetitions.

##### Instances
``` purescript
Show PatternRepeat
```

#### `CanvasGradient`

``` purescript
data CanvasGradient :: Type
```

Opaque object describing a gradient.

#### `LinearGradient`

``` purescript
type LinearGradient = { x0 :: Number, y0 :: Number, x1 :: Number, y1 :: Number }
```

A type representing a linear gradient.
 -  Starting point coordinates: (`x0`, `y0`)
 -  Ending point coordinates: (`x1`, `y1`)

#### `RadialGradient`

``` purescript
type RadialGradient = { x0 :: Number, y0 :: Number, r0 :: Number, x1 :: Number, y1 :: Number, r1 :: Number }
```

A type representing a radial gradient.
 -  Starting circle center coordinates: (`x0`, `y0`)
 -  Starting circle radius: `r0`
 -  Ending circle center coordinates: (`x1`, `y1`)
 -  Ending circle radius: `r1`

#### `QuadraticCurve`

``` purescript
type QuadraticCurve = { cpx :: Number, cpy :: Number, x :: Number, y :: Number }
```

A type representing a quadratic Bézier curve.
 - Bézier control point: (`cpx`, `cpy`)
 - Ending point coordinates: (`x`, `y`)

#### `BezierCurve`

``` purescript
type BezierCurve = { cp1x :: Number, cp1y :: Number, cp2x :: Number, cp2y :: Number, x :: Number, y :: Number }
```

A type representing a cubic Bézier curve.
 - First Bézier control point: (`cp1x`, `cp1y`)
 - Second Bézier control point: (`cp2x`, `cp2y`)
 - Ending point: (`x`, `y`)

#### `getCanvasElementById`

``` purescript
getCanvasElementById :: String -> Effect (Maybe CanvasElement)
```

Get a canvas element by ID, or `Nothing` if the element does not exist.

#### `getContext2D`

``` purescript
getContext2D :: CanvasElement -> Effect Context2D
```

Get the 2D graphics context for a canvas element.

#### `getCanvasWidth`

``` purescript
getCanvasWidth :: CanvasElement -> Effect Number
```

Get the canvas width in pixels.

#### `setCanvasWidth`

``` purescript
setCanvasWidth :: CanvasElement -> Number -> Effect Unit
```

Set the canvas width in pixels.

#### `getCanvasHeight`

``` purescript
getCanvasHeight :: CanvasElement -> Effect Number
```

Get the canvas height in pixels.

#### `setCanvasHeight`

``` purescript
setCanvasHeight :: CanvasElement -> Number -> Effect Unit
```

Set the canvas height in pixels.

#### `getCanvasDimensions`

``` purescript
getCanvasDimensions :: CanvasElement -> Effect Dimensions
```

Get the canvas dimensions in pixels.

#### `setCanvasDimensions`

``` purescript
setCanvasDimensions :: CanvasElement -> Dimensions -> Effect Unit
```

Set the canvas dimensions in pixels.

#### `canvasToDataURL`

``` purescript
canvasToDataURL :: CanvasElement -> Effect String
```

Create a data URL for the current canvas contents

#### `setLineWidth`

``` purescript
setLineWidth :: Context2D -> Number -> Effect Unit
```

Set the current line width.

#### `setLineDash`

``` purescript
setLineDash :: Context2D -> Array Number -> Effect Unit
```

Set the current line dash pattern.

#### `setFillStyle`

``` purescript
setFillStyle :: Context2D -> String -> Effect Unit
```

Set the current fill style/color.

#### `setStrokeStyle`

``` purescript
setStrokeStyle :: Context2D -> String -> Effect Unit
```

Set the current stroke style/color.

#### `setShadowBlur`

``` purescript
setShadowBlur :: Context2D -> Number -> Effect Unit
```

Set the current shadow blur radius.

#### `setShadowOffsetX`

``` purescript
setShadowOffsetX :: Context2D -> Number -> Effect Unit
```

Set the current shadow x-offset.

#### `setShadowOffsetY`

``` purescript
setShadowOffsetY :: Context2D -> Number -> Effect Unit
```

Set the current shadow y-offset.

#### `setShadowColor`

``` purescript
setShadowColor :: Context2D -> String -> Effect Unit
```

Set the current shadow color.

#### `setMiterLimit`

``` purescript
setMiterLimit :: Context2D -> Number -> Effect Unit
```

Set the current miter limit.

#### `setLineCap`

``` purescript
setLineCap :: Context2D -> LineCap -> Effect Unit
```

Set the current line cap type.

#### `setLineJoin`

``` purescript
setLineJoin :: Context2D -> LineJoin -> Effect Unit
```

Set the current line join type.

#### `setGlobalCompositeOperation`

``` purescript
setGlobalCompositeOperation :: Context2D -> Composite -> Effect Unit
```

Set the current composite operation.

#### `setGlobalAlpha`

``` purescript
setGlobalAlpha :: Context2D -> Number -> Effect Unit
```

Set the current global alpha level.

#### `beginPath`

``` purescript
beginPath :: Context2D -> Effect Unit
```

Begin a path object.

#### `stroke`

``` purescript
stroke :: Context2D -> Effect Unit
```

Stroke the current object.

#### `fill`

``` purescript
fill :: Context2D -> Effect Unit
```

Fill the current object.

#### `clip`

``` purescript
clip :: Context2D -> Effect Unit
```

Clip to the current object.

#### `lineTo`

``` purescript
lineTo :: Context2D -> Number -> Number -> Effect Unit
```

Move the path to the specified coordinates, drawing a line segment.

#### `moveTo`

``` purescript
moveTo :: Context2D -> Number -> Number -> Effect Unit
```

Move the path to the specified coordinates, without drawing a line segment.

#### `closePath`

``` purescript
closePath :: Context2D -> Effect Unit
```

Close the current path.

#### `strokePath`

``` purescript
strokePath :: forall a. Context2D -> Effect a -> Effect a
```

A convenience function for drawing a stroked path.

For example:

```purescript
strokePath ctx $ do
  moveTo ctx 10.0 10.0
  lineTo ctx 20.0 20.0
  lineTo ctx 10.0 20.0
  closePath ctx
```

#### `fillPath`

``` purescript
fillPath :: forall a. Context2D -> Effect a -> Effect a
```

A convenience function for drawing a filled path.

For example:

```purescript
fillPath ctx $ do
  moveTo ctx 10.0 10.0
  lineTo ctx 20.0 20.0
  lineTo ctx 10.0 20.0
  closePath ctx
```

#### `arc`

``` purescript
arc :: Context2D -> Arc -> Effect Unit
```

Render an arc object.

#### `rect`

``` purescript
rect :: Context2D -> Rectangle -> Effect Unit
```

Render a rectangle.

#### `fillRect`

``` purescript
fillRect :: Context2D -> Rectangle -> Effect Unit
```

Fill a rectangle.

#### `strokeRect`

``` purescript
strokeRect :: Context2D -> Rectangle -> Effect Unit
```

Stroke a rectangle.

#### `clearRect`

``` purescript
clearRect :: Context2D -> Rectangle -> Effect Unit
```

Clear a rectangle.

#### `scale`

``` purescript
scale :: Context2D -> ScaleTransform -> Effect Unit
```

Apply a scaling transform.

#### `rotate`

``` purescript
rotate :: Context2D -> Number -> Effect Unit
```

Apply a rotation.

#### `translate`

``` purescript
translate :: Context2D -> TranslateTransform -> Effect Unit
```

Apply a translation

#### `transform`

``` purescript
transform :: Context2D -> Transform -> Effect Unit
```

Apply a general transformation to the current transformation matrix

#### `setTransform`

``` purescript
setTransform :: Context2D -> Transform -> Effect Unit
```

Set the transformation matrix

#### `textAlign`

``` purescript
textAlign :: Context2D -> Effect TextAlign
```

Get the current text alignment.

#### `setTextAlign`

``` purescript
setTextAlign :: Context2D -> TextAlign -> Effect Unit
```

Set the current text alignment.

#### `font`

``` purescript
font :: Context2D -> Effect String
```

Get the current font.

#### `setFont`

``` purescript
setFont :: Context2D -> String -> Effect Unit
```

Set the current font.

#### `fillText`

``` purescript
fillText :: Context2D -> String -> Number -> Number -> Effect Unit
```

Fill some text.

#### `strokeText`

``` purescript
strokeText :: Context2D -> String -> Number -> Number -> Effect Unit
```

Stroke some text.

#### `measureText`

``` purescript
measureText :: Context2D -> String -> Effect TextMetrics
```

Measure some text.

#### `save`

``` purescript
save :: Context2D -> Effect Unit
```

Save the current context.

#### `restore`

``` purescript
restore :: Context2D -> Effect Unit
```

Restore the previous context.

#### `withContext`

``` purescript
withContext :: forall a. Context2D -> Effect a -> Effect a
```

A convenience function: run the action, preserving the existing context.

For example, outside this block, the fill style is preseved:

```purescript
withContext ctx $ do
  setFillStyle "red" ctx
  ...
```

#### `tryLoadImage`

``` purescript
tryLoadImage :: String -> (Maybe CanvasImageSource -> Effect Unit) -> Effect Unit
```

Asynchronously load an image file by specifying its path.

#### `getImageData`

``` purescript
getImageData :: Context2D -> Number -> Number -> Number -> Number -> Effect ImageData
```

Get image data for a portion of the canvas.

#### `putImageData`

``` purescript
putImageData :: Context2D -> ImageData -> Number -> Number -> Effect Unit
```

Set image data for a portion of the canvas.

#### `putImageDataFull`

``` purescript
putImageDataFull :: Context2D -> ImageData -> Number -> Number -> Number -> Number -> Number -> Number -> Effect Unit
```

Set image data for a portion of the canvas.

#### `createImageData`

``` purescript
createImageData :: Context2D -> Number -> Number -> Effect ImageData
```

Create an image data object.

#### `createImageDataCopy`

``` purescript
createImageDataCopy :: Context2D -> ImageData -> Effect ImageData
```

Create a copy of an image data object.

#### `imageDataWidth`

``` purescript
imageDataWidth :: ImageData -> Int
```

Get the width of an `ImageData` object.

#### `imageDataHeight`

``` purescript
imageDataHeight :: ImageData -> Int
```

Get the height of an `ImageData` object.

#### `imageDataBuffer`

``` purescript
imageDataBuffer :: ImageData -> Uint8ClampedArray
```

Get the underlying buffer from an `ImageData` object.

#### `canvasElementToImageSource`

``` purescript
canvasElementToImageSource :: CanvasElement -> CanvasImageSource
```

#### `drawImage`

``` purescript
drawImage :: Context2D -> CanvasImageSource -> Number -> Number -> Effect Unit
```

#### `drawImageScale`

``` purescript
drawImageScale :: Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Effect Unit
```

#### `drawImageFull`

``` purescript
drawImageFull :: Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Effect Unit
```

#### `createPattern`

``` purescript
createPattern :: Context2D -> CanvasImageSource -> PatternRepeat -> Effect CanvasPattern
```

Create a new canvas pattern (repeatable image).

#### `setPatternFillStyle`

``` purescript
setPatternFillStyle :: Context2D -> CanvasPattern -> Effect Unit
```

Set the Context2D fillstyle to the CanvasPattern.

#### `createLinearGradient`

``` purescript
createLinearGradient :: Context2D -> LinearGradient -> Effect CanvasGradient
```

Create a linear CanvasGradient.

#### `createRadialGradient`

``` purescript
createRadialGradient :: Context2D -> RadialGradient -> Effect CanvasGradient
```

Create a radial CanvasGradient.

#### `addColorStop`

``` purescript
addColorStop :: CanvasGradient -> Number -> String -> Effect Unit
```

Add a single color stop to a CanvasGradient.

#### `setGradientFillStyle`

``` purescript
setGradientFillStyle :: Context2D -> CanvasGradient -> Effect Unit
```

Set the Context2D fillstyle to the CanvasGradient.

#### `quadraticCurveTo`

``` purescript
quadraticCurveTo :: Context2D -> QuadraticCurve -> Effect Unit
```

Draw a quadratic Bézier curve.

#### `bezierCurveTo`

``` purescript
bezierCurveTo :: Context2D -> BezierCurve -> Effect Unit
```

Draw a cubic Bézier curve.


