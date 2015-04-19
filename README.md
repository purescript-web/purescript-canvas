# Module Documentation

## Module Graphics.Canvas

#### `Canvas`

``` purescript
data Canvas :: !
```


#### `CanvasElement`

``` purescript
data CanvasElement :: *
```


#### `Context2D`

``` purescript
data Context2D :: *
```


#### `ImageData`

``` purescript
data ImageData :: *
```


#### `CanvasPixelArray`

``` purescript
type CanvasPixelArray = Uint8ClampedArray
```


#### `getCanvasElementById`

``` purescript
getCanvasElementById :: forall eff. String -> Eff (canvas :: Canvas | eff) (Maybe CanvasElement)
```


#### `getContext2D`

``` purescript
getContext2D :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) Context2D
```


#### `getCanvasWidth`

``` purescript
getCanvasWidth :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) Number
```


#### `getCanvasHeight`

``` purescript
getCanvasHeight :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) Number
```


#### `setCanvasWidth`

``` purescript
setCanvasWidth :: forall eff. Number -> CanvasElement -> Eff (canvas :: Canvas | eff) CanvasElement
```


#### `setCanvasHeight`

``` purescript
setCanvasHeight :: forall eff. Number -> CanvasElement -> Eff (canvas :: Canvas | eff) CanvasElement
```


#### `Dimensions`

``` purescript
type Dimensions = { height :: Number, width :: Number }
```


#### `getCanvasDimensions`

``` purescript
getCanvasDimensions :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) Dimensions
```


#### `setCanvasDimensions`

``` purescript
setCanvasDimensions :: forall eff. Dimensions -> CanvasElement -> Eff (canvas :: Canvas | eff) CanvasElement
```


#### `canvasToDataURL`

``` purescript
canvasToDataURL :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) String
```


#### `setLineWidth`

``` purescript
setLineWidth :: forall eff. Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```

#### `setFillStyle`

``` purescript
setFillStyle :: forall eff. String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `setStrokeStyle`

``` purescript
setStrokeStyle :: forall eff. String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `setShadowColor`

``` purescript
setShadowColor :: forall eff. String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `setShadowBlur`

``` purescript
setShadowBlur :: forall eff. Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `setShadowOffsetX`

``` purescript
setShadowOffsetX :: forall eff. Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `setShadowOffsetY`

``` purescript
setShadowOffsetY :: forall eff. Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `LineCap`

``` purescript
data LineCap
  = Round 
  | Square 
  | Butt 
```


#### `setLineCap`

``` purescript
setLineCap :: forall eff. LineCap -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


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
```


#### `showComposite`

``` purescript
instance showComposite :: Show Composite
```


#### `setGlobalCompositeOperation`

``` purescript
setGlobalCompositeOperation :: forall eff. Context2D -> Composite -> Eff (canvas :: Canvas | eff) Context2D
```


#### `setGlobalAlpha`

``` purescript
setGlobalAlpha :: forall eff. Context2D -> Number -> Eff (canvas :: Canvas | eff) Context2D
```


#### `beginPath`

``` purescript
beginPath :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D
```

#### `stroke`

``` purescript
stroke :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `fill`

``` purescript
fill :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `clip`

``` purescript
clip :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `lineTo`

``` purescript
lineTo :: forall eff. Context2D -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D
```


#### `moveTo`

``` purescript
moveTo :: forall eff. Context2D -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D
```


#### `closePath`

``` purescript
closePath :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `strokePath`

``` purescript
strokePath :: forall eff a. Context2D -> Eff (canvas :: Canvas | eff) a -> Eff (canvas :: Canvas | eff) a
```


#### `fillPath`

``` purescript
fillPath :: forall eff a. Context2D -> Eff (canvas :: Canvas | eff) a -> Eff (canvas :: Canvas | eff) a
```


#### `Arc`

``` purescript
type Arc = { end :: Number, start :: Number, r :: Number, y :: Number, x :: Number }
```

#### `arc`

``` purescript
arc :: forall eff. Context2D -> Arc -> Eff (canvas :: Canvas | eff) Context2D
```


#### `Rectangle`

``` purescript
type Rectangle = { h :: Number, w :: Number, y :: Number, x :: Number }
```

#### `rect`

``` purescript
rect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D
```


#### `fillRect`

``` purescript
fillRect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D
```


#### `strokeRect`

``` purescript
strokeRect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D
```


#### `clearRect`

``` purescript
clearRect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D
```


#### `ScaleTransform`

``` purescript
type ScaleTransform = { scaleY :: Number, scaleX :: Number }
```

#### `scale`

``` purescript
scale :: forall eff. ScaleTransform -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `rotate`

``` purescript
rotate :: forall eff. Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `TranslateTransform`

``` purescript
type TranslateTransform = { translateY :: Number, translateX :: Number }
```


#### `translate`

``` purescript
translate :: forall eff. TranslateTransform -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `Transform`

``` purescript
type Transform = { m32 :: Number, m31 :: Number, m22 :: Number, m21 :: Number, m12 :: Number, m11 :: Number }
```


#### `transform`

``` purescript
transform :: forall eff. Transform -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `TextAlign`

``` purescript
data TextAlign
  = AlignLeft 
  | AlignRight 
  | AlignCenter 
  | AlignStart 
  | AlignEnd 
```

#### `showTextAlign`

``` purescript
instance showTextAlign :: Show TextAlign
```


#### `textAlign`

``` purescript
textAlign :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) TextAlign
```


#### `setTextAlign`

``` purescript
setTextAlign :: forall eff. Context2D -> TextAlign -> Eff (canvas :: Canvas | eff) Context2D
```


#### `TextMetrics`

``` purescript
type TextMetrics = { width :: Number }
```


#### `font`

``` purescript
font :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) String
```


#### `setFont`

``` purescript
setFont :: forall eff. String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `fillText`

``` purescript
fillText :: forall eff. Context2D -> String -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D
```


#### `strokeText`

``` purescript
strokeText :: forall eff. Context2D -> String -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D
```


#### `measureText`

``` purescript
measureText :: forall eff. Context2D -> String -> Eff (canvas :: Canvas | eff) TextMetrics
```


#### `save`

``` purescript
save :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D
```

#### `restore`

``` purescript
restore :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D
```


#### `withContext`

``` purescript
withContext :: forall eff a. Context2D -> Eff (canvas :: Canvas | eff) a -> Eff (canvas :: Canvas | eff) a
```


#### `getImageData`

``` purescript
getImageData :: forall eff. Context2D -> Number -> Number -> Number -> Number -> Eff (canvas :: Canvas | eff) ImageData
```


#### `putImageDataFull`

``` purescript
putImageDataFull :: forall eff. Context2D -> ImageData -> Number -> Number -> Number -> Number -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D
```


#### `putImageData`

``` purescript
putImageData :: forall eff. Context2D -> ImageData -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D
```


#### `createImageData`

``` purescript
createImageData :: forall eff. Context2D -> Number -> Number -> Eff (canvas :: Canvas | eff) ImageData
```


#### `createImageDataCopy`

``` purescript
createImageDataCopy :: forall eff. Context2D -> ImageData -> Eff (canvas :: Canvas | eff) ImageData
```


#### `getImageDataWidth`

``` purescript
getImageDataWidth :: forall eff. ImageData -> Eff (canvas :: Canvas | eff) Number
```


#### `getImageDataHeight`

``` purescript
getImageDataHeight :: forall eff. ImageData -> Eff (canvas :: Canvas | eff) Number
```


#### `getImageDataPixelArray`

``` purescript
getImageDataPixelArray :: forall eff. ImageData -> Eff (canvas :: Canvas | eff) CanvasPixelArray
```