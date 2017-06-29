-- | This module defines foreign types and functions for working with the 2D
-- | Canvas API.

module Graphics.Canvas
  ( CANVAS
  , CanvasElement
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

  , textAlign
  , setTextAlign
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

import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Exception.Unsafe (unsafeThrow)
import Data.ArrayBuffer.Types (Uint8ClampedArray)
import Data.Function.Uncurried (Fn3, runFn3)
import Data.Maybe (Maybe(..))

-- | The `Canvas` effect denotes computations which read/write from/to the canvas.
foreign import data CANVAS :: Effect

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
  :: forall eff
   . String
  -> Eff (canvas :: CANVAS | eff) Unit
  -> (CanvasImageSource -> Eff (canvas :: CANVAS | eff) Unit)
  -> Eff (canvas :: CANVAS | eff) Unit

-- | Asynchronously load an image file by specifying its path.
tryLoadImage
  :: forall eff
   . String
  -> (Maybe CanvasImageSource -> Eff (canvas :: CANVAS | eff) Unit)
  -> Eff (canvas :: CANVAS | eff) Unit
tryLoadImage path k = tryLoadImageImpl path (k Nothing) (k <<< Just)

foreign import getCanvasElementByIdImpl ::
  forall r eff. Fn3 String
                    (CanvasElement -> r)
                    r
                    (Eff (canvas :: CANVAS | eff) r)

-- | Get a canvas element by ID, or `Nothing` if the element does not exist.
getCanvasElementById :: forall eff. String -> Eff (canvas :: CANVAS | eff) (Maybe CanvasElement)
getCanvasElementById elId = runFn3 getCanvasElementByIdImpl elId Just Nothing

-- | Get the 2D graphics context for a canvas element.
foreign import getContext2D :: forall eff. CanvasElement -> Eff (canvas :: CANVAS | eff) Context2D

-- | Get the canvas width in pixels.
foreign import getCanvasWidth :: forall eff. CanvasElement -> Eff (canvas :: CANVAS | eff) Number

-- | Get the canvas height in pixels.
foreign import getCanvasHeight :: forall eff. CanvasElement -> Eff (canvas :: CANVAS | eff) Number

-- | Set the canvas width in pixels.
foreign import setCanvasWidth :: forall eff. Number -> CanvasElement -> Eff (canvas :: CANVAS | eff) CanvasElement

-- | Set the canvas height in pixels.
foreign import setCanvasHeight :: forall eff. Number -> CanvasElement -> Eff (canvas :: CANVAS | eff) CanvasElement

-- | Canvas dimensions (width and height) in pixels.
type Dimensions = { width :: Number, height :: Number }

-- | Get the canvas dimensions in pixels.
getCanvasDimensions :: forall eff. CanvasElement -> Eff (canvas :: CANVAS | eff) Dimensions
getCanvasDimensions ce = do
  w <- getCanvasWidth  ce
  h <- getCanvasHeight ce
  pure {width : w, height : h}

-- | Set the canvas dimensions in pixels.
setCanvasDimensions :: forall eff. Dimensions -> CanvasElement -> Eff (canvas :: CANVAS | eff) CanvasElement
setCanvasDimensions d ce = setCanvasHeight d.height ce >>= setCanvasWidth d.width

-- | Create a data URL for the current canvas contents
foreign import canvasToDataURL :: forall eff. CanvasElement -> Eff (canvas :: CANVAS | eff) String

-- | Set the current line width.
foreign import setLineWidth :: forall eff. Number -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set the current fill style/color.
foreign import setFillStyle :: forall eff. String -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set the current stroke style/color.
foreign import setStrokeStyle :: forall eff. String -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set the current shadow color.
foreign import setShadowColor :: forall eff. String -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set the current shadow blur radius.
foreign import setShadowBlur :: forall eff. Number -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set the current shadow x-offset.
foreign import setShadowOffsetX :: forall eff. Number -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set the current shadow y-offset.
foreign import setShadowOffsetY :: forall eff. Number -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set the current miter limit.
foreign import setMiterLimit :: forall eff. Number -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Enumerates the different types of line cap.
data LineCap = Round | Square | Butt

derive instance eqLineCap :: Eq LineCap

foreign import setLineCapImpl :: forall eff. String -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set the current line cap type.
setLineCap :: forall eff. LineCap -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D
setLineCap Round  = setLineCapImpl "round"
setLineCap Square = setLineCapImpl "square"
setLineCap Butt   = setLineCapImpl "butt"

-- Note that we can't re-use `Round` from LineCap, so I've added `Join` to all of these

-- | Enumerates the different types of line join
data LineJoin = BevelJoin | RoundJoin | MiterJoin

foreign import setLineJoinImpl :: forall eff. String -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set the current line join type.
setLineJoin :: forall eff. LineJoin -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D
setLineJoin BevelJoin = setLineJoinImpl "bevel"
setLineJoin RoundJoin = setLineJoinImpl "round"
setLineJoin MiterJoin = setLineJoinImpl "miter"

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

foreign import setGlobalCompositeOperationImpl :: forall eff. Context2D -> String -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set the current composite operation.
setGlobalCompositeOperation :: forall eff. Context2D -> Composite -> Eff (canvas :: CANVAS | eff) Context2D
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
foreign import setGlobalAlpha :: forall eff. Context2D -> Number -> Eff (canvas :: CANVAS | eff) Context2D

-- | Begin a path object.
foreign import beginPath :: forall eff. Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Stroke the current object.
foreign import stroke :: forall eff. Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Fill the current object.
foreign import fill :: forall eff. Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Clip to the current object.
foreign import clip :: forall eff. Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Move the path to the specified coordinates, drawing a line segment.
foreign import lineTo  :: forall eff. Context2D -> Number -> Number -> Eff (canvas :: CANVAS | eff) Context2D

-- | Move the path to the specified coordinates, without drawing a line segment.
foreign import moveTo  :: forall eff. Context2D -> Number -> Number -> Eff (canvas :: CANVAS | eff) Context2D

-- | Close the current path.
foreign import closePath  :: forall eff. Context2D -> Eff (canvas :: CANVAS | eff) Context2D

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
strokePath :: forall eff a. Context2D -> Eff (canvas :: CANVAS | eff) a -> Eff (canvas :: CANVAS | eff) a
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
fillPath :: forall eff a. Context2D -> Eff (canvas :: CANVAS | eff) a -> Eff (canvas :: CANVAS | eff) a
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
type Arc =
  { x :: Number
  , y :: Number
  , r :: Number
  , start :: Number
  , end   :: Number
  }

-- | Render an arc object.
foreign import arc :: forall eff. Context2D -> Arc -> Eff (canvas :: CANVAS | eff) Context2D

-- | A type representing a rectangle object:
-- |
-- | - The top-left corner coordinates `x` and `y`,
-- | - The width and height `w` and `h`.
type Rectangle =
  { x :: Number
  , y :: Number
  , w :: Number
  , h :: Number
  }

-- | Render a rectangle.
foreign import rect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: CANVAS | eff) Context2D

-- | Fill a rectangle.
foreign import fillRect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: CANVAS | eff) Context2D

-- | Stroke a rectangle.
foreign import strokeRect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: CANVAS | eff) Context2D

-- | Clear a rectangle.
foreign import clearRect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: CANVAS | eff) Context2D

-- | An object representing a scaling transform:
-- |
-- | - The scale factors in the `x` and `y` directions, `scaleX` and `scaleY`.
type ScaleTransform =
  { scaleX :: Number
  , scaleY :: Number
  }

-- | Apply a scaling transform.
foreign import scale  :: forall eff. ScaleTransform -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Apply a rotation.
foreign import rotate :: forall eff. Number -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | An object representing a translation:
-- |
-- | - The translation amounts in the `x` and `y` directions, `translateX` and `translateY`.
type TranslateTransform =
  { translateX :: Number
  , translateY :: Number
  }

-- | Apply a translation
foreign import translate :: forall eff. TranslateTransform -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | An object representing a general transformation as a homogeneous matrix.
type Transform =
  { m11 :: Number
  , m12 :: Number
  , m21 :: Number
  , m22 :: Number
  , m31 :: Number
  , m32 :: Number
  }

-- | Apply a general transformation.
foreign import transform :: forall eff. Transform -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Enumerates types of text alignment.
data TextAlign
  = AlignLeft | AlignRight | AlignCenter | AlignStart | AlignEnd

instance showTextAlign :: Show TextAlign where
  show AlignLeft = "AlignLeft"
  show AlignRight = "AlignRight"
  show AlignCenter = "AlignCenter"
  show AlignStart = "AlignStart"
  show AlignEnd = "AlignEnd"

foreign import textAlignImpl :: forall eff. Context2D -> Eff (canvas :: CANVAS | eff) String

-- | Get the current text alignment.
textAlign :: forall eff. Context2D -> Eff (canvas :: CANVAS | eff) TextAlign
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

foreign import setTextAlignImpl :: forall eff. Context2D -> String -> (Eff (canvas :: CANVAS | eff) Context2D)

-- | Set the current text alignment.
setTextAlign :: forall eff. Context2D -> TextAlign -> Eff (canvas :: CANVAS | eff) Context2D
setTextAlign ctx textalign =
  setTextAlignImpl ctx (toString textalign)
  where
    toString AlignLeft = "left"
    toString AlignRight = "right"
    toString AlignCenter = "center"
    toString AlignStart = "start"
    toString AlignEnd = "end"

-- | Text metrics:
-- |
-- | - The text width in pixels.
type TextMetrics = { width :: Number }

-- | Get the current font.
foreign import font :: forall eff. Context2D -> Eff (canvas :: CANVAS | eff) String

-- | Set the current font.
foreign import setFont :: forall eff. String -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Fill some text.
foreign import fillText :: forall eff. Context2D -> String -> Number -> Number -> Eff (canvas :: CANVAS | eff) Context2D

-- | Stroke some text.
foreign import strokeText :: forall eff. Context2D -> String -> Number -> Number -> Eff (canvas :: CANVAS | eff) Context2D

-- | Measure some text.
foreign import measureText :: forall eff. Context2D -> String -> Eff (canvas :: CANVAS | eff) TextMetrics

-- | Save the current context.
foreign import save  :: forall eff. Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | Restore the previous context.
foreign import restore  :: forall eff. Context2D -> Eff (canvas :: CANVAS | eff) Context2D

-- | A convenience function: run the action, preserving the existing context.
-- |
-- | For example, outside this block, the fill style is preseved:
-- |
-- | ```purescript
-- | withContext ctx $ do
-- |   setFillStyle "red" ctx
-- |   ...
-- | ```
withContext :: forall eff a. Context2D -> Eff (canvas :: CANVAS | eff) a -> Eff (canvas :: CANVAS | eff) a
withContext ctx action = do
  _ <- save ctx
  a <- action
  _ <- restore ctx
  pure a

-- | Get image data for a portion of the canvas.
foreign import getImageData :: forall eff. Context2D -> Number -> Number -> Number -> Number -> Eff (canvas :: CANVAS | eff) ImageData

-- | Set image data for a portion of the canvas.
foreign import putImageDataFull :: forall eff. Context2D -> ImageData -> Number -> Number -> Number -> Number -> Number -> Number -> Eff (canvas :: CANVAS | eff) Context2D

-- | Set image data for a portion of the canvas.
foreign import putImageData :: forall eff. Context2D -> ImageData -> Number -> Number -> Eff (canvas :: CANVAS | eff) Context2D

-- | Create an image data object.
foreign import createImageData :: forall eff. Context2D -> Number -> Number -> Eff (canvas :: CANVAS | eff) ImageData

-- | Create a copy of an image data object.
foreign import createImageDataCopy :: forall eff. Context2D -> ImageData -> Eff (canvas :: CANVAS | eff) ImageData

-- | Get the width of an `ImageData` object.
foreign import imageDataWidth :: ImageData -> Int

-- | Get the height of an `ImageData` object.
foreign import imageDataHeight :: ImageData -> Int

-- | Get the underlying buffer from an `ImageData` object.
foreign import imageDataBuffer :: ImageData -> Uint8ClampedArray

foreign import drawImage :: forall eff. Context2D -> CanvasImageSource -> Number -> Number -> Eff (canvas :: CANVAS | eff) Context2D

foreign import drawImageScale :: forall eff. Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Eff (canvas :: CANVAS | eff) Context2D

foreign import drawImageFull :: forall eff. Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Eff (canvas :: CANVAS | eff) Context2D

-- | Enumerates the different types of pattern repetitions.
data PatternRepeat = Repeat | RepeatX | RepeatY | NoRepeat

instance showPatternRepeat :: Show PatternRepeat where
  show Repeat = "Repeat"
  show RepeatX = "RepeatX"
  show RepeatY = "RepeatY"
  show NoRepeat = "NoRepeat"

foreign import createPatternImpl :: forall eff. CanvasImageSource -> String -> Context2D -> Eff (canvas :: CANVAS | eff) CanvasPattern

-- | Create a new canvas pattern (repeatable image).
createPattern :: forall eff. CanvasImageSource -> PatternRepeat -> Context2D -> Eff (canvas :: CANVAS | eff) CanvasPattern
createPattern img repeat = createPatternImpl img (toString repeat)
  where
    toString Repeat = "repeat"
    toString RepeatX = "repeat-x"
    toString RepeatY = "repeat-y"
    toString NoRepeat = "no-repeat"

-- | Set the Context2D fillstyle to the CanvasPattern.
foreign import setPatternFillStyle :: forall eff. CanvasPattern -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

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
foreign import createLinearGradient :: forall eff. LinearGradient -> Context2D -> Eff (canvas :: CANVAS | eff) CanvasGradient

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
foreign import createRadialGradient :: forall eff. RadialGradient -> Context2D -> Eff (canvas :: CANVAS | eff) CanvasGradient

-- | Add a single color stop to a CanvasGradient.
foreign import addColorStop :: forall eff. Number -> String -> CanvasGradient -> Eff (canvas :: CANVAS | eff) CanvasGradient

-- | Set the Context2D fillstyle to the CanvasGradient.
foreign import setGradientFillStyle :: forall eff. CanvasGradient -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

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
foreign import quadraticCurveTo :: forall eff. QuadraticCurve -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D

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
foreign import bezierCurveTo :: forall eff. BezierCurve -> Context2D -> Eff (canvas :: CANVAS | eff) Context2D
