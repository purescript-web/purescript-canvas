-- | This module defines foreign types and functions for working with the 2D
-- | Canvas API.

module Graphics.Canvas
  ( CanvasElement
  , Context2D
  , ImageData
  , CanvasImageSource
  , Arc
  , Composite(..)
  , Dimensions
  , LineCap(..)
  , LineJoin(..)
  , Rectangle
  , ScaleTransform
  , TextMetrics
  , Transform
  , TranslateTransform
  , TextAlign(..)
  , TextBaseline(..)
  , CanvasPattern
  , PatternRepeat(..)
  , CanvasGradient
  , LinearGradient
  , RadialGradient
  , QuadraticCurve
  , BezierCurve

  , getCanvasElementById
  , getContext2D
  , getCanvasWidth
  , setCanvasWidth
  , getCanvasHeight
  , setCanvasHeight
  , getCanvasDimensions
  , setCanvasDimensions
  , canvasToDataURL

  , setLineWidth
  , setLineDash
  , setFillStyle
  , setStrokeStyle
  , setShadowBlur
  , setShadowOffsetX
  , setShadowOffsetY
  , setShadowColor
  , setMiterLimit

  , setLineCap
  , setLineJoin
  , setGlobalCompositeOperation
  , setGlobalAlpha

  , beginPath
  , stroke
  , fill
  , clip
  , lineTo
  , moveTo
  , closePath
  , strokePath
  , fillPath

  , arc

  , rect
  , fillRect
  , strokeRect
  , clearRect

  , scale
  , rotate
  , translate
  , transform
  , setTransform

  , textAlign
  , setTextAlign
  , textBaseline
  , setTextBaseline
  , font
  , setFont
  , fillText
  , strokeText
  , measureText

  , save
  , restore
  , withContext

  , tryLoadImage
  , getImageData
  , putImageData
  , putImageDataFull
  , createImageData
  , createImageDataCopy
  , createImageDataWith
  , imageDataWidth
  , imageDataHeight
  , imageDataBuffer

  , canvasElementToImageSource
  , drawImage
  , drawImageScale
  , drawImageFull

  , createPattern
  , setPatternFillStyle

  , createLinearGradient
  , createRadialGradient
  , addColorStop
  , setGradientFillStyle

  , quadraticCurveTo
  , bezierCurveTo
  ) where

import Prelude

import Effect (Effect)
import Effect.Exception.Unsafe (unsafeThrow)
import Data.ArrayBuffer.Types (Uint8ClampedArray)
import Data.Function.Uncurried (Fn3, runFn3)
import Data.Maybe (Maybe(..))

-- | A canvas HTML element.
foreign import data CanvasElement :: Type

-- | A 2D graphics context.
foreign import data Context2D :: Type

-- | An image data object, used to store raster data outside the canvas.
foreign import data ImageData :: Type

-- | Opaque object for drawing elements and things to the canvas.
foreign import data CanvasImageSource :: Type

-- | Opaque object describing a pattern.
foreign import data CanvasPattern :: Type

-- | Opaque object describing a gradient.
foreign import data CanvasGradient :: Type

foreign import canvasElementToImageSource :: CanvasElement -> CanvasImageSource

foreign import tryLoadImageImpl
  :: String
  -> Effect Unit
  -> (CanvasImageSource -> Effect Unit)
  -> Effect Unit

-- | Asynchronously load an image file by specifying its path.
tryLoadImage
  :: String
  -> (Maybe CanvasImageSource -> Effect Unit)
  -> Effect Unit
tryLoadImage path k = tryLoadImageImpl path (k Nothing) (k <<< Just)

foreign import getCanvasElementByIdImpl
  :: forall r
   . Fn3 String
         (CanvasElement -> r)
         r
         (Effect r)

-- | Get a canvas element by ID, or `Nothing` if the element does not exist.
getCanvasElementById :: String -> Effect (Maybe CanvasElement)
getCanvasElementById elId = runFn3 getCanvasElementByIdImpl elId Just Nothing

-- | Get the 2D graphics context for a canvas element.
foreign import getContext2D :: CanvasElement -> Effect Context2D

-- | Get the canvas width in pixels.
foreign import getCanvasWidth :: CanvasElement -> Effect Number

-- | Get the canvas height in pixels.
foreign import getCanvasHeight :: CanvasElement -> Effect Number

-- | Set the canvas width in pixels.
foreign import setCanvasWidth :: CanvasElement -> Number -> Effect Unit

-- | Set the canvas height in pixels.
foreign import setCanvasHeight :: CanvasElement -> Number -> Effect Unit

-- | Canvas dimensions (width and height) in pixels.
type Dimensions = { width :: Number, height :: Number }

-- | Get the canvas dimensions in pixels.
getCanvasDimensions :: CanvasElement -> Effect Dimensions
getCanvasDimensions ce = do
  w <- getCanvasWidth  ce
  h <- getCanvasHeight ce
  pure {width : w, height : h}

-- | Set the canvas dimensions in pixels.
setCanvasDimensions :: CanvasElement -> Dimensions -> Effect Unit
setCanvasDimensions ce d = setCanvasHeight ce d.height *> setCanvasWidth ce d.width

-- | Create a data URL for the current canvas contents
foreign import canvasToDataURL :: CanvasElement -> Effect String

-- | Set the current line width.
foreign import setLineWidth :: Context2D -> Number -> Effect Unit

-- | Set the current line dash pattern.
foreign import setLineDash :: Context2D -> Array Number -> Effect Unit

-- | Set the current fill style/color.
foreign import setFillStyle :: Context2D -> String -> Effect Unit

-- | Set the current stroke style/color.
foreign import setStrokeStyle :: Context2D -> String -> Effect Unit

-- | Set the current shadow color.
foreign import setShadowColor :: Context2D -> String -> Effect Unit

-- | Set the current shadow blur radius.
foreign import setShadowBlur :: Context2D -> Number -> Effect Unit

-- | Set the current shadow x-offset.
foreign import setShadowOffsetX :: Context2D -> Number -> Effect Unit

-- | Set the current shadow y-offset.
foreign import setShadowOffsetY :: Context2D -> Number -> Effect Unit

-- | Set the current miter limit.
foreign import setMiterLimit :: Context2D -> Number -> Effect Unit

-- | Enumerates the different types of line cap.
data LineCap = Round | Square | Butt

derive instance eqLineCap :: Eq LineCap

foreign import setLineCapImpl :: Context2D -> String -> Effect Unit

-- | Set the current line cap type.
setLineCap :: Context2D -> LineCap -> Effect Unit
setLineCap context Round  = setLineCapImpl context "round"
setLineCap context Square = setLineCapImpl context "square"
setLineCap context Butt   = setLineCapImpl context "butt"

-- Note that we can't re-use `Round` from LineCap, so I've added `Join` to all of these

-- | Enumerates the different types of line join
data LineJoin = BevelJoin | RoundJoin | MiterJoin

derive instance eqLineJoin :: Eq LineJoin

foreign import setLineJoinImpl :: Context2D -> String -> Effect Unit

-- | Set the current line join type.
setLineJoin :: Context2D -> LineJoin -> Effect Unit
setLineJoin context BevelJoin = setLineJoinImpl context "bevel"
setLineJoin context RoundJoin = setLineJoinImpl context "round"
setLineJoin context MiterJoin = setLineJoinImpl context "miter"

-- | Enumerates the different types of composite operations and blend modes.
data Composite
  -- Composite Operations
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

   -- Blend Modes
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

derive instance eqComposite :: Eq Composite

instance showComposite :: Show Composite where
  show SourceOver      = "SourceOver"
  show SourceIn        = "SourceIn"
  show SourceOut       = "SourceOut"
  show SourceAtop      = "SourceAtop"
  show DestinationOver = "DestinationOver"
  show DestinationIn   = "DestinationIn"
  show DestinationOut  = "DestinationOut"
  show DestinationAtop = "DestinationAtop"
  show Lighter         = "Lighter"
  show Copy            = "Copy"
  show Xor             = "Xor"
  show Multiply        = "Multiply"
  show Screen          = "Screen"
  show Overlay         = "Overlay"
  show Darken          = "Darken"
  show Lighten         = "Lighten"
  show ColorDodge      = "ColorDodge"
  show ColorBurn       = "ColorBurn"
  show HardLight       = "HardLight"
  show SoftLight       = "SoftLight"
  show Difference      = "Difference"
  show Exclusion       = "Exclusion"
  show Hue             = "Hue"
  show Saturation      = "Saturation"
  show Color           = "Color"
  show Luminosity      = "Luminosity"

foreign import setGlobalCompositeOperationImpl :: Context2D -> String -> Effect Unit

-- | Set the current composite operation.
setGlobalCompositeOperation :: Context2D -> Composite -> Effect Unit
setGlobalCompositeOperation ctx composite = setGlobalCompositeOperationImpl ctx (toString composite)
  where
    toString SourceOver      = "source-over"
    toString SourceIn        = "source-in"
    toString SourceOut       = "source-out"
    toString SourceAtop      = "source-atop"
    toString DestinationOver = "destination-over"
    toString DestinationIn   = "destination-in"
    toString DestinationOut  = "destination-out"
    toString DestinationAtop = "destination-atop"
    toString Lighter         = "lighter"
    toString Copy            = "copy"
    toString Xor             = "xor"
    toString Multiply        = "multiply"
    toString Screen          = "screen"
    toString Overlay         = "overlay"
    toString Darken          = "darken"
    toString Lighten         = "lighten"
    toString ColorDodge      = "color-dodge"
    toString ColorBurn       = "color-burn"
    toString HardLight       = "hard-light"
    toString SoftLight       = "soft-light"
    toString Difference      = "difference"
    toString Exclusion       = "exclusion"
    toString Hue             = "hue"
    toString Saturation      = "saturation"
    toString Color           = "color"
    toString Luminosity      = "luminosity"

-- | Set the current global alpha level.
foreign import setGlobalAlpha :: Context2D -> Number -> Effect Unit

-- | Begin a path object.
foreign import beginPath :: Context2D -> Effect Unit

-- | Stroke the current object.
foreign import stroke :: Context2D -> Effect Unit

-- | Fill the current object.
foreign import fill :: Context2D -> Effect Unit

-- | Clip to the current object.
foreign import clip :: Context2D -> Effect Unit

-- | Move the path to the specified coordinates, drawing a line segment.
foreign import lineTo  :: Context2D -> Number -> Number -> Effect Unit

-- | Move the path to the specified coordinates, without drawing a line segment.
foreign import moveTo  :: Context2D -> Number -> Number -> Effect Unit

-- | Close the current path.
foreign import closePath  :: Context2D -> Effect Unit

-- | A convenience function for drawing a stroked path.
-- |
-- | For example:
-- |
-- | ```purescript
-- | strokePath ctx $ do
-- |   moveTo ctx 10.0 10.0
-- |   lineTo ctx 20.0 20.0
-- |   lineTo ctx 10.0 20.0
-- |   closePath ctx
-- | ```
strokePath :: forall a. Context2D -> Effect a -> Effect a
strokePath ctx path = do
  _ <- beginPath ctx
  a <- path
  _ <- stroke ctx
  pure a

-- | A convenience function for drawing a filled path.
-- |
-- | For example:
-- |
-- | ```purescript
-- | fillPath ctx $ do
-- |   moveTo ctx 10.0 10.0
-- |   lineTo ctx 20.0 20.0
-- |   lineTo ctx 10.0 20.0
-- |   closePath ctx
-- | ```
fillPath :: forall a. Context2D -> Effect a -> Effect a
fillPath ctx path = do
  _ <- beginPath ctx
  a <- path
  _ <- fill ctx
  pure a

-- | A type representing an arc object:
-- |
-- | - The center coordinates `x` and `y`,
-- | - The radius `r`,
-- | - The starting and ending angles, `start` and `end`.
-- | - Whether to draw the arc counter-clockwise (true) or clockwise (false) direction.
-- |   Normally, this value is `false`.
type Arc =
  { x :: Number
  , y :: Number
  , radius :: Number
  , start :: Number
  , end   :: Number
  , useCounterClockwise :: Boolean
  }

-- | Render an arc object.
foreign import arc :: Context2D -> Arc -> Effect Unit

-- | A type representing a rectangle object:
-- |
-- | - The top-left corner coordinates `x` and `y`,
-- | - The width and height `w` and `h`.
type Rectangle =
  { x :: Number
  , y :: Number
  , width :: Number
  , height :: Number
  }

-- | Render a rectangle.
foreign import rect :: Context2D -> Rectangle -> Effect Unit

-- | Fill a rectangle.
foreign import fillRect :: Context2D -> Rectangle -> Effect Unit

-- | Stroke a rectangle.
foreign import strokeRect :: Context2D -> Rectangle -> Effect Unit

-- | Clear a rectangle.
foreign import clearRect :: Context2D -> Rectangle -> Effect Unit

-- | An object representing a scaling transform:
-- |
-- | - The scale factors in the `x` and `y` directions, `scaleX` and `scaleY`.
type ScaleTransform =
  { scaleX :: Number
  , scaleY :: Number
  }

-- | Apply a scaling transform.
foreign import scale  :: Context2D -> ScaleTransform -> Effect Unit

-- | Apply a rotation.
foreign import rotate :: Context2D -> Number -> Effect Unit

-- | An object representing a translation:
-- |
-- | - The translation amounts in the `x` and `y` directions, `translateX` and `translateY`.
type TranslateTransform =
  { translateX :: Number
  , translateY :: Number
  }

-- | Apply a translation
foreign import translate :: Context2D -> TranslateTransform -> Effect Unit

-- | An object representing a general transformation as a homogeneous matrix.
type Transform =
  { a :: Number
  , b :: Number
  , c :: Number
  , d :: Number
  , e :: Number
  , f :: Number
  }

-- | Apply a general transformation to the current transformation matrix
foreign import transform :: Context2D -> Transform -> Effect Unit

-- | Set the transformation matrix
foreign import setTransform :: Context2D -> Transform -> Effect Unit

-- | Enumerates types of text alignment.
data TextAlign
  = AlignLeft | AlignRight | AlignCenter | AlignStart | AlignEnd

derive instance eqTextAlign :: Eq TextAlign

instance showTextAlign :: Show TextAlign where
  show AlignLeft = "AlignLeft"
  show AlignRight = "AlignRight"
  show AlignCenter = "AlignCenter"
  show AlignStart = "AlignStart"
  show AlignEnd = "AlignEnd"

foreign import textAlignImpl :: Context2D -> Effect String

-- | Get the current text alignment.
textAlign :: Context2D -> Effect TextAlign
textAlign ctx = unsafeParseTextAlign <$> textAlignImpl ctx
  where
  unsafeParseTextAlign :: String -> TextAlign
  unsafeParseTextAlign "left" = AlignLeft
  unsafeParseTextAlign "right" = AlignRight
  unsafeParseTextAlign "center" = AlignCenter
  unsafeParseTextAlign "start" = AlignStart
  unsafeParseTextAlign "end" = AlignEnd
  unsafeParseTextAlign align = unsafeThrow $ "invalid TextAlign: " <> align
  -- ^ dummy to silence compiler warnings

foreign import setTextAlignImpl :: Context2D -> String -> Effect Unit

-- | Set the current text alignment.
setTextAlign :: Context2D -> TextAlign -> Effect Unit
setTextAlign ctx textalign =
  setTextAlignImpl ctx (toString textalign)
  where
    toString AlignLeft = "left"
    toString AlignRight = "right"
    toString AlignCenter = "center"
    toString AlignStart = "start"
    toString AlignEnd = "end"

-- | Enumerates types of text baseline.
data TextBaseline
  = BaselineTop
  | BaselineHanging
  | BaselineMiddle
  | BaselineAlphabetic
  | BaselineIdeographic
  | BaselineBottom

instance showTextBaseline :: Show TextBaseline where
  show BaselineTop = "BaselineTop"
  show BaselineHanging = "BaselineHanging"
  show BaselineMiddle = "BaselineMiddle"
  show BaselineAlphabetic = "BaselineAlphabetic"
  show BaselineIdeographic = "BaselineIdeographic"
  show BaselineBottom = "BaselineBottom"

foreign import textBaselineImpl :: Context2D -> Effect String

-- | Get the current text baseline.
textBaseline :: Context2D -> Effect TextBaseline
textBaseline ctx = unsafeParseTextBaseline <$> textBaselineImpl ctx
  where
  unsafeParseTextBaseline :: String -> TextBaseline
  unsafeParseTextBaseline "top" = BaselineTop
  unsafeParseTextBaseline "hanging" = BaselineHanging
  unsafeParseTextBaseline "middle" = BaselineMiddle
  unsafeParseTextBaseline "alphabetic" = BaselineAlphabetic
  unsafeParseTextBaseline "ideographic" = BaselineIdeographic
  unsafeParseTextBaseline "bottom" = BaselineBottom
  unsafeParseTextBaseline align = unsafeThrow $ "invalid TextBaseline: " <> align
  -- ^ dummy to silence compiler warnings

foreign import setTextBaselineImpl :: Context2D -> String -> Effect Unit

-- | Set the current text baseline.
setTextBaseline :: Context2D -> TextBaseline -> Effect Unit
setTextBaseline ctx textbaseline =
  setTextBaselineImpl ctx (toString textbaseline)
  where
    toString BaselineTop = "top"
    toString BaselineHanging = "hanging"
    toString BaselineMiddle = "middle"
    toString BaselineAlphabetic = "alphabetic"
    toString BaselineIdeographic = "ideographic"
    toString BaselineBottom = "bottom"

-- | Text metrics:
-- |
-- | - The text width in pixels.
type TextMetrics = { width :: Number }

-- | Get the current font.
foreign import font :: Context2D -> Effect String

-- | Set the current font.
foreign import setFont :: Context2D -> String -> Effect Unit

-- | Fill some text.
foreign import fillText :: Context2D -> String -> Number -> Number -> Effect Unit

-- | Stroke some text.
foreign import strokeText :: Context2D -> String -> Number -> Number -> Effect Unit

-- | Measure some text.
foreign import measureText :: Context2D -> String -> Effect TextMetrics

-- | Save the current context.
foreign import save  :: Context2D -> Effect Unit

-- | Restore the previous context.
foreign import restore  :: Context2D -> Effect Unit

-- | A convenience function: run the action, preserving the existing context.
-- |
-- | For example, outside this block, the fill style is preseved:
-- |
-- | ```purescript
-- | withContext ctx $ do
-- |   setFillStyle ctx "red"
-- |   ...
-- | ```
withContext :: forall a. Context2D -> Effect a -> Effect a
withContext ctx action = do
  _ <- save ctx
  a <- action
  _ <- restore ctx
  pure a

-- | Get image data for a portion of the canvas.
foreign import getImageData :: Context2D -> Number -> Number -> Number -> Number -> Effect ImageData

-- | Set image data for a portion of the canvas.
foreign import putImageDataFull :: Context2D -> ImageData -> Number -> Number -> Number -> Number -> Number -> Number -> Effect Unit

-- | Set image data for a portion of the canvas.
foreign import putImageData :: Context2D -> ImageData -> Number -> Number -> Effect Unit

-- | Create an image data object.
foreign import createImageData :: Context2D -> Number -> Number -> Effect ImageData

-- | Create a copy of an image data object.
foreign import createImageDataCopy :: Context2D -> ImageData -> Effect ImageData

-- | Create an image data object given a `Uint8ClampedArray` containing the underlying pixel representation of the image.
-- | The height is inferred from the array's size and the given width.
foreign import createImageDataWith :: Uint8ClampedArray -> Int -> Effect ImageData

-- | Get the width of an `ImageData` object.
foreign import imageDataWidth :: ImageData -> Int

-- | Get the height of an `ImageData` object.
foreign import imageDataHeight :: ImageData -> Int

-- | Get the underlying buffer from an `ImageData` object.
foreign import imageDataBuffer :: ImageData -> Uint8ClampedArray

foreign import drawImage :: Context2D -> CanvasImageSource -> Number -> Number -> Effect Unit

foreign import drawImageScale :: Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Effect Unit

foreign import drawImageFull :: Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Effect Unit

-- | Enumerates the different types of pattern repetitions.
data PatternRepeat = Repeat | RepeatX | RepeatY | NoRepeat

derive instance eqPatternRepeat :: Eq PatternRepeat

instance showPatternRepeat :: Show PatternRepeat where
  show Repeat = "Repeat"
  show RepeatX = "RepeatX"
  show RepeatY = "RepeatY"
  show NoRepeat = "NoRepeat"

foreign import createPatternImpl :: Context2D -> CanvasImageSource -> String ->  Effect CanvasPattern

-- | Create a new canvas pattern (repeatable image).
createPattern :: Context2D -> CanvasImageSource -> PatternRepeat -> Effect CanvasPattern
createPattern context img repeat = createPatternImpl context img (toString repeat)
  where
    toString Repeat = "repeat"
    toString RepeatX = "repeat-x"
    toString RepeatY = "repeat-y"
    toString NoRepeat = "no-repeat"

-- | Set the Context2D fillstyle to the CanvasPattern.
foreign import setPatternFillStyle :: Context2D -> CanvasPattern -> Effect Unit

-- | A type representing a linear gradient.
-- |  -  Starting point coordinates: (`x0`, `y0`)
-- |  -  Ending point coordinates: (`x1`, `y1`)

type LinearGradient =
    { x0 :: Number
    , y0 :: Number
    , x1 :: Number
    , y1 :: Number
    }

-- | Create a linear CanvasGradient.
foreign import createLinearGradient :: Context2D -> LinearGradient -> Effect CanvasGradient

-- | A type representing a radial gradient.
-- |  -  Starting circle center coordinates: (`x0`, `y0`)
-- |  -  Starting circle radius: `r0`
-- |  -  Ending circle center coordinates: (`x1`, `y1`)
-- |  -  Ending circle radius: `r1`

type RadialGradient =
    { x0 :: Number
    , y0 :: Number
    , r0 :: Number
    , x1 :: Number
    , y1 :: Number
    , r1 :: Number
    }

-- | Create a radial CanvasGradient.
foreign import createRadialGradient :: Context2D -> RadialGradient -> Effect CanvasGradient

-- | Add a single color stop to a CanvasGradient.
foreign import addColorStop :: CanvasGradient -> Number -> String -> Effect Unit

-- | Set the Context2D fillstyle to the CanvasGradient.
foreign import setGradientFillStyle :: Context2D -> CanvasGradient -> Effect Unit

-- | A type representing a quadratic Bézier curve.
-- |  - Bézier control point: (`cpx`, `cpy`)
-- |  - Ending point coordinates: (`x`, `y`)

type QuadraticCurve =
    { cpx :: Number
    , cpy :: Number
    , x   :: Number
    , y   :: Number
    }

-- | Draw a quadratic Bézier curve.
foreign import quadraticCurveTo :: Context2D -> QuadraticCurve -> Effect Unit

-- | A type representing a cubic Bézier curve.
-- |  - First Bézier control point: (`cp1x`, `cp1y`)
-- |  - Second Bézier control point: (`cp2x`, `cp2y`)
-- |  - Ending point: (`x`, `y`)

type BezierCurve =
    { cp1x :: Number
    , cp1y :: Number
    , cp2x :: Number
    , cp2y :: Number
    , x    :: Number
    , y    :: Number
    }

-- | Draw a cubic Bézier curve.
foreign import bezierCurveTo :: Context2D -> BezierCurve -> Effect Unit
