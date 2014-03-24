# Module Documentation
## Module Graphics.Canvas

### Types

    type Arc  = { end :: Prim.Number, start :: Prim.Number, r :: Prim.Number, cy :: Prim.Number, cx :: Prim.Number }

    data Canvas :: !

    data CanvasElement :: *

    data Context2D :: *

    type Rectangle  = { h :: Prim.Number, w :: Prim.Number, y :: Prim.Number, x :: Prim.Number }

    type ScaleTransform  = { scaleY :: Prim.Number, scaleX :: Prim.Number }

    type Transform  = { m32 :: Prim.Number, m31 :: Prim.Number, m22 :: Prim.Number, m21 :: Prim.Number, m12 :: Prim.Number, m11 :: Prim.Number }

    type TranslateTransform  = { translateY :: Prim.Number, translateX :: Prim.Number }


### Type Classes


### Type Class Instances


### Values

    arc :: forall eff. Context2D -> Arc -> Eff (canvas :: Canvas | eff) Context2D

    beginPath :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

    clearRect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D

    clip :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

    fill :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

    fillPath :: forall eff a. Context2D -> Eff (canvas :: Canvas | eff) a -> Eff (canvas :: Canvas | eff) a

    fillRect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D

    getContext2D :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) Context2D

    lineTo :: forall eff. Context2D -> Prim.Number -> Prim.Number -> Eff (canvas :: Canvas | eff) Context2D

    moveTo :: forall eff. Context2D -> Prim.Number -> Prim.Number -> Eff (canvas :: Canvas | eff) Context2D

    rect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D

    restore :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

    rotate :: forall eff. Prim.Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    save :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

    scale :: forall eff. ScaleTransform -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    setFillStyle :: forall eff. Prim.String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    setLineWidth :: forall eff. Prim.Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    setShadowBlur :: forall eff. Prim.Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    setShadowColor :: forall eff. Prim.String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    setShadowOffsetX :: forall eff. Prim.Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    setShadowOffsetY :: forall eff. Prim.Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    setStrokeStyle :: forall eff. Prim.String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    stroke :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

    strokePath :: forall eff a. Context2D -> Eff (canvas :: Canvas | eff) a -> Eff (canvas :: Canvas | eff) a

    strokeRect :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D

    transform :: forall eff. Transform -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    translate :: forall eff. TranslateTransform -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

    withContext :: forall eff a. Context2D -> Eff (canvas :: Canvas | eff) a -> Eff (canvas :: Canvas | eff) a



