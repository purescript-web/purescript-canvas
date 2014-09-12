module Graphics.Canvas where

import Control.Monad.Eff

foreign import data Canvas :: !

foreign import data CanvasElement :: *

foreign import data Context2D :: *

foreign import data ImageData :: *

foreign import data CanvasPixelArray :: *

foreign import getCanvasElementById
  "function getCanvasElementById(id) {\
  \  return function() {\
  \    return document.getElementById(id);\
  \  };\
  \}" :: forall eff. String -> Eff (canvas :: Canvas | eff) CanvasElement 

foreign import getContext2D 
  "function getContext2D(c) {\
  \  return function() {\
  \    return c.getContext('2d');\
  \  };\
  \}" :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) Context2D 

foreign import getCanvasWidth
  "function getCanvasWidth(canvas){\
  \  return function(){\
  \    return canvas.width;\ 
  \  };\
  \};" :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) Number

foreign import getCanvasHeight
  "function getCanvasHeight(canvas){\
  \  return function(){\ 
  \    return canvas.height;\ 
  \  };\
  \};" :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) Number

foreign import setCanvasWidth
  "function setCanvasWidth(width){\
  \   return function(canvas){\ 
  \      return function(){\
  \        canvas.width = width;\ 
  \        return canvas;\
  \      };\
  \    };\
  \};" :: forall eff. Number -> CanvasElement -> Eff (canvas :: Canvas | eff) CanvasElement

foreign import setCanvasHeight
  "function setCanvasHeight(height){\
  \   return function(canvas){\ 
  \      return function(){\
  \         canvas.height = height;\ 
  \         return canvas; \
  \      };\
  \    };\
  \};" :: forall eff. Number -> CanvasElement -> Eff (canvas :: Canvas | eff) CanvasElement

type Dimensions = {width :: Number, height :: Number}

getCanvasDimensions :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) Dimensions
getCanvasDimensions ce = do
  w <- getCanvasWidth  ce
  h <- getCanvasHeight ce
  return {width : w, height : h}

setCanvasDimensions :: forall eff. Dimensions -> CanvasElement -> Eff (canvas :: Canvas | eff) CanvasElement
setCanvasDimensions d ce = setCanvasHeight d.height ce >>= setCanvasWidth d.width

foreign import canvasToDataURL
  "function canvasToDataURL(canvas) {\
  \   return function(){\
  \     return canvas.toDataURL();\
  \   };\
  \};" :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) String

-- |
-- Context Properties
--

foreign import setLineWidth
  "function setLineWidth(width) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.lineWidth = width;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import setFillStyle
  "function setFillStyle(style) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.fillStyle = style;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import setStrokeStyle
  "function setStrokeStyle(style) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.strokeStyle = style;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import setShadowColor
  "function setShadowColor(color) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.shadowColor = color;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import setShadowBlur
  "function setShadowBlur(blur) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.shadowBlur = blur;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import setShadowOffsetX
  "function setShadowOffsetX(offsetX) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.shadowOffsetX = offsetX;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import setShadowOffsetY
  "function setShadowOffsetY(offsetY) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.shadowOffsetY = offsetY;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

data LineCap = Round | Square | Butt

foreign import setLineCapImpl
  "function setLineCapImpl(cap){\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.lineCap = cap;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

setLineCap :: forall eff. LineCap -> Context2D -> Eff (canvas :: Canvas | eff) Context2D
setLineCap Round  = setLineCapImpl "round"
setLineCap Square = setLineCapImpl "square" 
setLineCap Butt   = setLineCapImpl "butt"

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

instance showComposite :: Show Composite where
  show SourceOver      = "source-over"
  show SourceIn        = "source-in"
  show SourceOut       = "source-out"
  show SourceAtop      = "source-atop"
  show DestinationOver = "destination-over"
  show DestinationIn   = "destination-in"
  show DestinationOut  = "destination-out"
  show DestinationAtop = "destination-atop"
  show Lighter         = "lighter"
  show Copy            = "copy"
  show Xor             = "xor"

foreign import setGlobalCompositeOperationImpl
  "function setGlobalCompositeOperationImpl(ctx) {\
  \  return function(op) {\
  \    return function() {\
  \      ctx.globalCompositeOperation = op;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> String -> Eff (canvas :: Canvas | eff) Context2D

setGlobalCompositeOperation :: forall eff. Context2D -> Composite -> Eff (canvas :: Canvas | eff) Context2D
setGlobalCompositeOperation ctx composite = setGlobalCompositeOperationImpl ctx (show composite)

foreign import setGlobalAlpha
  "function setGlobalAlpha(ctx) {\
  \  return function(alpha) {\
  \    return function() {\
  \      ctx.setGlobalAlpha = alpha;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> Number -> Eff (canvas :: Canvas | eff) Context2D

-- |
-- Paths
--

foreign import beginPath
  "function beginPath(ctx) {\
  \  return function() {\
  \    ctx.beginPath();\
  \    return ctx;\
  \  };\
  \}" :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import stroke
  "function stroke(ctx) {\
  \  return function() {\
  \    ctx.stroke();\
  \    return ctx;\
  \  };\
  \}" :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import fill
  "function fill(ctx) {\
  \  return function() {\
  \    ctx.fill();\
  \    return ctx;\
  \  };\
  \}" :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import clip 
  "function clip(ctx) {\
  \  return function() {\
  \    ctx.clip();\
  \    return ctx;\
  \  };\
  \}" :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import lineTo 
  "function lineTo(ctx) {\
  \  return function(x) {\
  \    return function(y) {\
  \      return function() {\
  \        ctx.lineTo(x, y);\
  \        return ctx;\
  \      };\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D

foreign import moveTo 
  "function moveTo(ctx) {\
  \  return function(x) {\
  \    return function(y) {\
  \      return function() {\
  \        ctx.moveTo(x, y);\
  \        return ctx;\
  \      };\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D

foreign import closePath 
  "function closePath(ctx) {\
  \  return function() {\
  \    ctx.closePath();\
  \    return ctx;\
  \  };\
  \}" :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

strokePath :: forall eff a. Context2D -> Eff (canvas :: Canvas | eff) a -> Eff (canvas :: Canvas | eff) a 
strokePath ctx path = do
  beginPath ctx
  a <- path
  stroke ctx
  return a

fillPath :: forall eff a. Context2D -> Eff (canvas :: Canvas | eff) a -> Eff (canvas :: Canvas | eff) a 
fillPath ctx path = do
  beginPath ctx
  a <- path
  fill ctx
  return a

-- |
-- Arcs
--

type Arc =
  { x :: Number
  , y :: Number
  , r :: Number
  , start :: Number
  , end   :: Number
  }

foreign import arc
  "function arc(ctx) {\
  \  return function(a) {\
  \    return function() {\
  \      ctx.arc(a.x, a.y, a.r, a.start, a.end);\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> Arc -> Eff (canvas :: Canvas | eff) Context2D

-- |
-- Rectangles
--

type Rectangle = 
  { x :: Number
  , y :: Number
  , w :: Number
  , h :: Number
  }

foreign import rect
  "function rect(ctx) {\
  \  return function(r) {\
  \    return function() {\
  \      ctx.rect(r.x, r.y, r.w, r.h);\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D

foreign import fillRect
  "function fillRect(ctx) {\
  \  return function(r) {\
  \    return function() {\
  \      ctx.fillRect(r.x, r.y, r.w, r.h);\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D

foreign import strokeRect
  "function strokeRect(ctx) {\
  \  return function(r) {\
  \    return function() {\
  \      ctx.strokeRect(r.x, r.y, r.w, r.h);\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D

foreign import clearRect
  "function clearRect(ctx) {\
  \  return function(r) {\
  \    return function() {\
  \      ctx.clearRect(r.x, r.y, r.w, r.h);\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> Rectangle -> Eff (canvas :: Canvas | eff) Context2D

-- |
-- Transformations
--

type ScaleTransform =
  { scaleX :: Number
  , scaleY :: Number
  }

foreign import scale 
  "function scale(t) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.scale(t.scaleX, t.scaleY);\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. ScaleTransform -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import rotate
  "function rotate(angle) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.rotate(angle);\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Number -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

type TranslateTransform =
  { translateX :: Number
  , translateY :: Number
  }

foreign import translate 
  "function translate(t) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.translate(t.translateX, t.translateY);\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. TranslateTransform -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

type Transform =
  { m11 :: Number
  , m12 :: Number
  , m21 :: Number
  , m22 :: Number
  , m31 :: Number
  , m32 :: Number
  }

foreign import transform
  "function transform(t) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.transform(t.m11, t.m12, t.m21, t.m22, t.m31, t.m32);\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. Transform -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

-- |
-- Text
--

type TextMetrics = { width :: Number }

foreign import font
  "function font(ctx) {\
  \  return function() {\
  \    return ctx.font;\
  \  };\
  \}" :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) String

foreign import setFont
  "function setFont(fontspec) {\
  \  return function(ctx) {\
  \    return function() {\
  \      ctx.font = fontspec;\
  \      return ctx;\
  \    };\
  \  };\
  \}" :: forall eff. String -> Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import fillText
  "function fillText(ctx) {\
  \  return function(text) {\
  \    return function(x) {\
  \      return function(y) {\
  \        return function() {\
  \          ctx.fillText(text, x, y);\
  \          return ctx;\
  \        };\
  \      };\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> String -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D

foreign import strokeText
  "function strokeText(ctx) {\
  \  return function(text) {\
  \    return function(x) {\
  \      return function(y) {\
  \        return function() {\
  \          ctx.fillText(text, x, y);\
  \          return ctx;\
  \        };\
  \      };\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> String -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D

foreign import measureText
  "function measureText(ctx) {\
  \  return function(text) {\
  \    return function() {\
  \      return ctx.measureText(text);\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> String -> Eff (canvas :: Canvas | eff) TextMetrics

-- |
-- Context
--

foreign import save 
  "function save(ctx) {\
  \  return function() {\
  \    ctx.save();\
  \    return ctx;\
  \  };\
  \}" :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

foreign import restore 
  "function restore(ctx) {\
  \  return function() {\
  \    ctx.restore();\
  \    return ctx;\
  \  };\
  \}" :: forall eff. Context2D -> Eff (canvas :: Canvas | eff) Context2D

withContext :: forall eff a. Context2D -> Eff (canvas :: Canvas | eff) a -> Eff (canvas :: Canvas | eff) a 
withContext ctx action = do
  save ctx
  a <- action
  restore ctx
  return a

foreign import getImageData
  "function getImageData(ctx) {\
  \  return function(x) {\
  \    return function(y) {\
  \      return function(w) {\
  \        return function(h) {\
  \          return function() { return ctx.getImageData(x, y, w, h); };\
  \        };\
  \      };\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> Number -> Number -> Number -> Number -> Eff (canvas :: Canvas | eff) ImageData

foreign import putImageDataFull
  "function putImageDataFull(ctx) {\
  \  return function(image_data) {\
  \    return function(x) {\
  \      return function(y) {\
  \        return function(dx) {\
  \          return function(dy) {\
  \            return function(dw) {\
  \              return function(dh) {\
  \                return function() {\
  \                  ctx.putImageData(image_data, x, y, dx, dy, dw, dh);\
  \                  return ctx;\
  \                };\
  \              };\
  \            };\
  \          };\
  \        };\
  \      };\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> ImageData -> Number -> Number -> Number -> Number -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D

foreign import putImageData
  "function putImageData(ctx) {\
  \  return function(image_data) {\
  \    return function(x) {\
  \      return function(y) {\
  \        return function() {\
  \          ctx.putImageData(image_data, x, y);\
  \          return ctx;\
  \        };\
  \      };\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> ImageData -> Number -> Number -> Eff (canvas :: Canvas | eff) Context2D

foreign import createImageData
  "function createImageData(ctx) {\
  \  return function(sw) {\
  \    return function(sh) {\
  \      return function() {\
  \        return ctx.createImageData(sw, sh);\
  \      };\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> Number -> Number -> Eff (canvas :: Canvas | eff) ImageData

foreign import createImageDataCopy
  "function createImageDataCopy(ctx) {\
  \  return function(image_data) {\
  \    return function() {\
  \      return ctx.createImageData(image_data);\
  \    };\
  \  };\
  \}" :: forall eff. Context2D -> ImageData-> Eff (canvas :: Canvas | eff) ImageData

foreign import getImageDataWidth
  "function getImageDataWidth(image_data) {\
  \  return function() {\
  \    return image_data.width;\
  \  };\
  \}" :: forall eff. ImageData -> Eff (canvas :: Canvas | eff) Number

foreign import getImageDataHeight
  "function getImageDataHeight(image_data) {\
  \  return function() {\
  \    return image_data.height;\
  \  };\
  \}" :: forall eff. ImageData -> Eff (canvas :: Canvas | eff) Number

foreign import getImageDataPixelArray
  "function getImageDataPixelArray(image_data) {\
  \  return function() {\
  \    return image_data.data;\
  \  };\
  \}" :: forall eff. ImageData -> Eff (canvas :: Canvas | eff) CanvasPixelArray

