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
import Effect.Uncurried ( EffectFn1, EffectFn2, EffectFn3, EffectFn4, EffectFn5, EffectFn6, EffectFn8, EffectFn10
                        , runEffectFn1, runEffectFn2, runEffectFn3, runEffectFn4, runEffectFn5, runEffectFn6, runEffectFn8, runEffectFn10)
import Effect.Exception.Unsafe (unsafeThrow)
import Data.ArrayBuffer.Types (Uint8ClampedArray)
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
  :: forall r. EffectFn3 String (CanvasElement -> r) r r

-- | Get a canvas element by ID, or `Nothing` if the element does not exist.
getCanvasElementById :: String -> Effect (Maybe CanvasElement)
getCanvasElementById elId = runEffectFn3 getCanvasElementByIdImpl elId Just Nothing


foreign import getContext2DImpl :: EffectFn1 CanvasElement Context2D

-- | Get the 2D graphics context for a canvas element.
getContext2D :: CanvasElement -> Effect Context2D
getContext2D el = runEffectFn1 getContext2DImpl el

foreign import getCanvasWidthImpl :: EffectFn1 CanvasElement Number

-- | Get the canvas width in pixels.
getCanvasWidth :: CanvasElement -> Effect Number
getCanvasWidth el = runEffectFn1 getCanvasWidthImpl el

foreign import getCanvasHeightImpl :: EffectFn1 CanvasElement Number

-- | Get the canvas height in pixels.
getCanvasHeight :: CanvasElement -> Effect Number
getCanvasHeight el = runEffectFn1 getCanvasHeightImpl el

foreign import setCanvasWidthImpl :: EffectFn2 CanvasElement Number Unit

-- | Set the canvas width in pixels.
setCanvasWidth :: CanvasElement -> Number -> Effect Unit
setCanvasWidth el w = runEffectFn2 setCanvasWidthImpl el w

foreign import setCanvasHeightImpl :: EffectFn2 CanvasElement Number Unit

-- | Set the canvas height in pixels.
setCanvasHeight :: CanvasElement -> Number -> Effect Unit
setCanvasHeight el w = runEffectFn2 setCanvasHeightImpl el w

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

foreign import canvasToDataURLImpl :: EffectFn1 CanvasElement String

-- | Create a data URL for the current canvas contents
canvasToDataURL :: CanvasElement -> Effect String
canvasToDataURL el = runEffectFn1 canvasToDataURLImpl el

foreign import setLineWidthImpl :: EffectFn2 Context2D Number Unit

-- | Set the current line width.
setLineWidth :: Context2D -> Number -> Effect Unit
setLineWidth ctx w = runEffectFn2 setLineWidthImpl ctx w

foreign import setLineDashImpl :: EffectFn2 Context2D (Array Number) Unit

-- | Set the current line dash pattern.
setLineDash :: Context2D -> Array Number -> Effect Unit
setLineDash ctx arr = runEffectFn2 setLineDashImpl ctx arr

foreign import setFillStyleImpl :: EffectFn2 Context2D String Unit

-- | Set the current fill style/color.
setFillStyle :: Context2D -> String -> Effect Unit
setFillStyle ctx style = runEffectFn2 setFillStyleImpl ctx style

foreign import setStrokeStyleImpl :: EffectFn2 Context2D String Unit

-- | Set the current stroke style/color.
setStrokeStyle :: Context2D -> String -> Effect Unit
setStrokeStyle ctx style = runEffectFn2 setStrokeStyleImpl ctx style

foreign import setShadowColorImpl :: EffectFn2 Context2D String Unit

-- | Set the current shadow color.
setShadowColor :: Context2D -> String -> Effect Unit
setShadowColor ctx color = runEffectFn2 setShadowColorImpl ctx color 

foreign import setShadowBlurImpl :: EffectFn2 Context2D Number Unit

-- | Set the current shadow blur radius.
setShadowBlur :: Context2D -> Number -> Effect Unit
setShadowBlur ctx radius = runEffectFn2 setShadowBlurImpl ctx radius 

foreign import setShadowOffsetXImpl :: EffectFn2 Context2D Number Unit

-- | Set the current shadow x-offset.
setShadowOffsetX :: Context2D -> Number -> Effect Unit
setShadowOffsetX ctx x = runEffectFn2 setShadowOffsetXImpl ctx x

foreign import setShadowOffsetYImpl :: EffectFn2 Context2D Number Unit

-- | Set the current shadow x-offset.
setShadowOffsetY :: Context2D -> Number -> Effect Unit
setShadowOffsetY ctx y = runEffectFn2 setShadowOffsetYImpl ctx y

foreign import setMiterLimitImpl :: EffectFn2 Context2D Number Unit

-- | Set the current miter limit.
setMiterLimit :: Context2D -> Number -> Effect Unit
setMiterLimit ctx limit = runEffectFn2 setMiterLimitImpl ctx limit

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

foreign import setGlobalCompositeOperationImpl :: EffectFn2 Context2D String Unit

-- | Set the current composite operation.
setGlobalCompositeOperation :: Context2D -> Composite -> Effect Unit
setGlobalCompositeOperation ctx composite = runEffectFn2 setGlobalCompositeOperationImpl ctx (toString composite)
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

foreign import setGlobalAlphaImpl :: EffectFn2 Context2D Number Unit

-- | Set the current global alpha level.
setGlobalAlpha :: Context2D -> Number -> Effect Unit
setGlobalAlpha ctx level = runEffectFn2 setGlobalAlphaImpl ctx level

foreign import beginPathImpl :: EffectFn1 Context2D Unit

-- | Begin a path object.
beginPath :: Context2D -> Effect Unit
beginPath ctx = runEffectFn1 beginPathImpl ctx

foreign import strokeImpl :: EffectFn1 Context2D Unit

-- | Stroke the current object.
stroke :: Context2D -> Effect Unit
stroke ctx = runEffectFn1 strokeImpl ctx

foreign import fillImpl :: EffectFn1 Context2D Unit

-- | Fill the current object.
fill :: Context2D -> Effect Unit
fill ctx = runEffectFn1 fillImpl ctx

foreign import clipImpl :: EffectFn1 Context2D Unit

-- | Clip to the current object.
clip :: Context2D -> Effect Unit
clip ctx = runEffectFn1 clipImpl ctx

foreign import lineToImpl :: EffectFn3 Context2D Number Number Unit

-- | Move the path to the specified coordinates, drawing a line segment.
lineTo :: Context2D -> Number -> Number -> Effect Unit
lineTo ctx x y = runEffectFn3 lineToImpl ctx x y

foreign import moveToImpl :: EffectFn3 Context2D Number Number Unit

-- | Move the path to the specified coordinates, without drawing a line segment.
moveTo :: Context2D -> Number -> Number -> Effect Unit
moveTo ctx x y = runEffectFn3 moveToImpl ctx x y

foreign import closePathImpl :: EffectFn1 Context2D Unit

-- | Close the current path.
closePath :: Context2D -> Effect Unit
closePath ctx = runEffectFn1 closePathImpl ctx

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

foreign import arcImpl :: EffectFn2 Context2D Arc Unit

-- | Render an arc object.
arc :: Context2D -> Arc -> Effect Unit
arc ctx a = runEffectFn2 arcImpl ctx a

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

foreign import rectImpl :: EffectFn2 Context2D Rectangle Unit

-- | Render a rectangle.
rect :: Context2D -> Rectangle -> Effect Unit
rect ctx r = runEffectFn2 rectImpl ctx r

foreign import fillRectImpl :: EffectFn2 Context2D Rectangle Unit

-- | Fill a rectangle.
fillRect :: Context2D -> Rectangle -> Effect Unit
fillRect ctx r = runEffectFn2 fillRectImpl ctx r

foreign import strokeRectImpl :: EffectFn2 Context2D Rectangle Unit

-- | Stroke a rectangle.
strokeRect :: Context2D -> Rectangle -> Effect Unit
strokeRect ctx r = runEffectFn2 strokeRectImpl ctx r

foreign import clearRectImpl :: EffectFn2 Context2D Rectangle Unit

-- | Clear a rectangle.
clearRect :: Context2D -> Rectangle -> Effect Unit
clearRect ctx r = runEffectFn2 clearRectImpl ctx r

-- | An object representing a scaling transform:
-- |
-- | - The scale factors in the `x` and `y` directions, `scaleX` and `scaleY`.
type ScaleTransform =
  { scaleX :: Number
  , scaleY :: Number
  }

foreign import scaleImpl :: EffectFn2 Context2D ScaleTransform Unit

-- | Apply a scaling transform.
scale :: Context2D -> ScaleTransform -> Effect Unit
scale ctx tr = runEffectFn2 scaleImpl ctx tr

foreign import rotateImpl :: EffectFn2 Context2D Number Unit

-- | Apply a rotation.
rotate :: Context2D -> Number -> Effect Unit
rotate ctx angle = runEffectFn2 rotateImpl ctx angle

-- | An object representing a translation:
-- |
-- | - The translation amounts in the `x` and `y` directions, `translateX` and `translateY`.
type TranslateTransform =
  { translateX :: Number
  , translateY :: Number
  }

foreign import translateImpl :: EffectFn2 Context2D TranslateTransform Unit

-- | Apply a translation
translate :: Context2D -> TranslateTransform -> Effect Unit
translate ctx tr = runEffectFn2 translateImpl ctx tr

-- | An object representing a general transformation as a homogeneous matrix.
type Transform =
  { a :: Number
  , b :: Number
  , c :: Number
  , d :: Number
  , e :: Number
  , f :: Number
  }

foreign import transformImpl :: EffectFn2 Context2D Transform Unit

-- | Apply a general transformation to the current transformation matrix
transform :: Context2D -> Transform -> Effect Unit
transform ctx tr = runEffectFn2 transformImpl ctx tr


foreign import setTransformImpl :: EffectFn2 Context2D Transform Unit

-- | Set the transformation matrix
setTransform :: Context2D -> Transform -> Effect Unit
setTransform ctx tr = runEffectFn2 setTransformImpl ctx tr

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

foreign import textAlignImpl :: EffectFn1 Context2D String

-- | Get the current text alignment.
textAlign :: Context2D -> Effect TextAlign
textAlign ctx = unsafeParseTextAlign <$> runEffectFn1 textAlignImpl ctx
  where
  unsafeParseTextAlign :: String -> TextAlign
  unsafeParseTextAlign "left" = AlignLeft
  unsafeParseTextAlign "right" = AlignRight
  unsafeParseTextAlign "center" = AlignCenter
  unsafeParseTextAlign "start" = AlignStart
  unsafeParseTextAlign "end" = AlignEnd
  unsafeParseTextAlign align = unsafeThrow $ "invalid TextAlign: " <> align
  -- ^ dummy to silence compiler warnings

foreign import setTextAlignImpl :: EffectFn2 Context2D String Unit

-- | Set the current text alignment.
setTextAlign :: Context2D -> TextAlign -> Effect Unit
setTextAlign ctx textalign =
  runEffectFn2 setTextAlignImpl ctx (toString textalign)
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

foreign import textBaselineImpl :: EffectFn1 Context2D String

-- | Get the current text baseline.
textBaseline :: Context2D -> Effect TextBaseline
textBaseline ctx = unsafeParseTextBaseline <$> runEffectFn1 textBaselineImpl ctx
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

foreign import fontImpl :: EffectFn1 Context2D String

-- | Get the current font.
font :: Context2D -> Effect String
font ctx = runEffectFn1 fontImpl ctx

foreign import setFontImpl :: EffectFn2 Context2D String Unit

-- | Set the current font.
setFont :: Context2D -> String -> Effect Unit
setFont ctx f = runEffectFn2 setFontImpl ctx f


foreign import fillTextImpl :: EffectFn4 Context2D String Number Number Unit

-- | Fill some text.
fillText :: Context2D -> String -> Number -> Number -> Effect Unit
fillText ctx text x y = runEffectFn4 fillTextImpl ctx text x y

foreign import strokeTextImpl :: EffectFn4 Context2D String Number Number Unit

-- | Stroke some text.
strokeText :: Context2D -> String -> Number -> Number -> Effect Unit
strokeText ctx text x y = runEffectFn4 strokeTextImpl ctx text x y

foreign import measureTextImpl :: EffectFn2 Context2D String TextMetrics

-- | Measure some text.
measureText :: Context2D -> String -> Effect TextMetrics
measureText ctx text = runEffectFn2 measureTextImpl ctx text

foreign import saveImpl :: EffectFn1 Context2D Unit

-- | Save the current context.
save :: Context2D -> Effect Unit
save ctx = runEffectFn1 saveImpl ctx

foreign import restoreImpl :: EffectFn1 Context2D Unit

-- | Restore the previous context.
restore :: Context2D -> Effect Unit
restore ctx = runEffectFn1 restoreImpl ctx

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

foreign import getImageDataImpl :: EffectFn5 Context2D Number Number Number Number ImageData

-- | Get image data for a portion of the canvas.
getImageData :: Context2D -> Number -> Number -> Number -> Number -> Effect ImageData
getImageData ctx x y w h = runEffectFn5 getImageDataImpl ctx x y w h

foreign import putImageDataFullImpl :: EffectFn8 Context2D ImageData Number Number Number Number Number Number Unit

-- | Set image data for a portion of the canvas.
putImageDataFull :: Context2D -> ImageData -> Number -> Number -> Number -> Number -> Number -> Number -> Effect Unit
putImageDataFull ctx data_ x y dx dy dw dh = runEffectFn8 putImageDataFullImpl ctx data_ x y dx dy dw dh

foreign import putImageDataImpl :: EffectFn4 Context2D ImageData Number Number Unit

-- | Set image data for a portion of the canvas.
putImageData :: Context2D -> ImageData -> Number -> Number -> Effect Unit
putImageData ctx data_ x y = runEffectFn4 putImageDataImpl ctx data_ x y

foreign import createImageDataImpl :: EffectFn3 Context2D Number Number ImageData

-- | Create an image data object.
createImageData :: Context2D -> Number -> Number -> Effect ImageData
createImageData ctx sw sh = runEffectFn3 createImageDataImpl ctx sw sh

foreign import createImageDataCopyImpl :: EffectFn2 Context2D ImageData ImageData

-- | Create a copy of an image data object.
createImageDataCopy :: Context2D -> ImageData -> Effect ImageData
createImageDataCopy ctx img = runEffectFn2 createImageDataCopyImpl ctx img

foreign import createImageDataWithImpl :: EffectFn2 Uint8ClampedArray Int ImageData

-- | Create an image data object given a `Uint8ClampedArray` containing the underlying pixel representation of the image.
-- | The height is inferred from the array's size and the given width.
createImageDataWith :: Uint8ClampedArray -> Int -> Effect ImageData
createImageDataWith arr sw = runEffectFn2 createImageDataWithImpl arr sw

-- | Get the width of an `ImageData` object.
foreign import imageDataWidth :: ImageData -> Int

-- | Get the height of an `ImageData` object.
foreign import imageDataHeight :: ImageData -> Int

-- | Get the underlying buffer from an `ImageData` object.
foreign import imageDataBuffer :: ImageData -> Uint8ClampedArray

foreign import drawImageImpl :: EffectFn4 Context2D CanvasImageSource Number Number Unit

drawImage :: Context2D -> CanvasImageSource -> Number -> Number -> Effect Unit
drawImage ctx source dx dy = runEffectFn4 drawImageImpl ctx source dx dy

foreign import drawImageScaleImpl :: EffectFn6 Context2D CanvasImageSource Number Number Number Number Unit

drawImageScale :: Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Effect Unit
drawImageScale ctx source dx dy dw dh = runEffectFn6 drawImageScaleImpl ctx source dx dy dw dh

foreign import drawImageFullImpl :: EffectFn10 Context2D CanvasImageSource Number Number Number Number Number Number Number Number Unit

drawImageFull :: Context2D -> CanvasImageSource -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Number -> Effect Unit
drawImageFull ctx source sx sy sw sh dx dy dw dh = runEffectFn10 drawImageFullImpl ctx source sx sy sw sh dx dy dw dh

-- | Enumerates the different types of pattern repetitions.
data PatternRepeat = Repeat | RepeatX | RepeatY | NoRepeat

derive instance eqPatternRepeat :: Eq PatternRepeat

instance showPatternRepeat :: Show PatternRepeat where
  show Repeat = "Repeat"
  show RepeatX = "RepeatX"
  show RepeatY = "RepeatY"
  show NoRepeat = "NoRepeat"

foreign import createPatternImpl :: EffectFn3 Context2D CanvasImageSource String CanvasPattern

-- | Create a new canvas pattern (repeatable image).
createPattern :: Context2D -> CanvasImageSource -> PatternRepeat -> Effect CanvasPattern
createPattern context img repeat = runEffectFn3 createPatternImpl context img (toString repeat)
  where
    toString Repeat = "repeat"
    toString RepeatX = "repeat-x"
    toString RepeatY = "repeat-y"
    toString NoRepeat = "no-repeat"

foreign import setPatternFillStyleImpl :: EffectFn2 Context2D CanvasPattern Unit

-- | Set the Context2D fillstyle to the CanvasPattern.
setPatternFillStyle :: Context2D -> CanvasPattern -> Effect Unit
setPatternFillStyle ctx pattern = runEffectFn2 setPatternFillStyleImpl ctx pattern

-- | A type representing a linear gradient.
-- |  -  Starting point coordinates: (`x0`, `y0`)
-- |  -  Ending point coordinates: (`x1`, `y1`)

type LinearGradient =
    { x0 :: Number
    , y0 :: Number
    , x1 :: Number
    , y1 :: Number
    }

foreign import createLinearGradientImpl :: EffectFn2 Context2D LinearGradient CanvasGradient

-- | Create a linear CanvasGradient.
createLinearGradient :: Context2D -> LinearGradient -> Effect CanvasGradient
createLinearGradient ctx grad = runEffectFn2 createLinearGradientImpl ctx grad

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

foreign import createRadialGradientImpl :: EffectFn2 Context2D RadialGradient CanvasGradient

-- | Create a radial CanvasGradient.
createRadialGradient :: Context2D -> RadialGradient -> Effect CanvasGradient
createRadialGradient ctx grad = runEffectFn2 createRadialGradientImpl ctx grad

foreign import addColorStopImpl :: EffectFn3 CanvasGradient Number String Unit

-- | Add a single color stop to a CanvasGradient.
addColorStop :: CanvasGradient -> Number -> String -> Effect Unit
addColorStop grad stop color = runEffectFn3 addColorStopImpl grad stop color

foreign import setGradientFillStyleImpl :: EffectFn2 Context2D CanvasGradient Unit

-- | Set the Context2D fillstyle to the CanvasGradient.
setGradientFillStyle :: Context2D -> CanvasGradient -> Effect Unit
setGradientFillStyle ctx gradient = runEffectFn2 setGradientFillStyleImpl ctx gradient

-- | A type representing a quadratic Bézier curve.
-- |  - Bézier control point: (`cpx`, `cpy`)
-- |  - Ending point coordinates: (`x`, `y`)

type QuadraticCurve =
    { cpx :: Number
    , cpy :: Number
    , x   :: Number
    , y   :: Number
    }

foreign import quadraticCurveToImpl :: EffectFn2 Context2D QuadraticCurve Unit

-- | Draw a quadratic Bézier curve.
quadraticCurveTo :: Context2D -> QuadraticCurve -> Effect Unit
quadraticCurveTo ctx curve = runEffectFn2 quadraticCurveToImpl ctx curve

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

foreign import bezierCurveToImpl :: EffectFn2 Context2D BezierCurve Unit

-- | Draw a cubic Bézier curve.
bezierCurveTo :: Context2D -> BezierCurve -> Effect Unit
bezierCurveTo ctx curve = runEffectFn2 bezierCurveToImpl ctx curve