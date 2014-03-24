module Canvas where

import Control.Monad.Eff

foreign import data Canvas :: !

foreign import data CanvasElement :: *

foreign import data Context2D :: *

foreign import getContext2D 
  "function getContext2D(c) {\
  \  return function() {\
  \    return c.getContext('2d');\
  \  };\
  \}" :: forall eff. CanvasElement -> Eff (canvas :: Canvas | eff) Context2D 

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
  "function setShadowOffsetX(offset) {\
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
  { cx :: Number
  , cy :: Number
  , r  :: Number
  , start :: Number
  , end   :: Number
  }

foreign import arc
  "function arc(ctx) {\
  \  return function(a) {\
  \    return function() {\
  \      ctx.arc(a.cx, a.cy, a.r, a.start, a.end);\
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

