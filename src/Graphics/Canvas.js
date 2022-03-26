export function canvasElementToImageSource(e) {
  return e;
}

export function tryLoadImageImpl(src) {
  return function(e) {
    return function(f) {
      return function () {
        var img = new Image();
        img.src = src;
        img.addEventListener("load", function() {
          f(img)();
        }, false);
        img.addEventListener("error", function() {
          e();
        }, false);
      };
    };
  };
}

export function getCanvasElementByIdImpl(id, Just, Nothing) {
  return function() {
    var el = document.getElementById(id);
    if (el && el instanceof HTMLCanvasElement) {
      return Just(el);
    } else {
      return Nothing;
    }
  };
}

export function getContext2D(c) {
  return function() {
    return c.getContext("2d");
  };
}

export function getCanvasWidth(canvas) {
  return function() {
    return canvas.width;
  };
}

export function getCanvasHeight(canvas) {
  return function() {
    return canvas.height;
  };
}

export function setCanvasWidth(canvas) {
  return function(width) {
    return function() {
      canvas.width = width;
    };
  };
}

export function setCanvasHeight(canvas) {
  return function(height) {
    return function() {
      canvas.height = height;
    };
  };
}

export function canvasToDataURL(canvas) {
  return function() {
    return canvas.toDataURL();
  };
}

export function setLineWidth(ctx) {
  return function(width) {
    return function() {
      ctx.lineWidth = width;
    };
  };
}

export function setLineDash(ctx) {
  return function(dash) {
    return function() {
      ctx.setLineDash(dash);
    };
  };
}

export function setFillStyle(ctx) {
  return function(style) {
    return function() {
      ctx.fillStyle = style;
    };
  };
}

export function setStrokeStyle(ctx) {
  return function(style) {
    return function() {
      ctx.strokeStyle = style;
    };
  };
}

export function setShadowColor(ctx) {
  return function(color) {
    return function() {
      ctx.shadowColor = color;
    };
  };
}

export function setShadowBlur(ctx) {
  return function(blur) {
    return function() {
      ctx.shadowBlur = blur;
    };
  };
}

export function setShadowOffsetX(ctx) {
  return function(offsetX) {
    return function() {
      ctx.shadowOffsetX = offsetX;
    };
  };
}

export function setShadowOffsetY(ctx) {
  return function(offsetY) {
    return function() {
      ctx.shadowOffsetY = offsetY;
    };
  };
}

export function setMiterLimit(ctx) {
  return function(limit) {
    return function() {
      ctx.miterLimit = limit;
    };
  };
}

export function setLineCapImpl(ctx) {
  return function(cap) {
    return function() {
      ctx.lineCap = cap;
    };
  };
}

export function setLineJoinImpl(ctx) {
  return function(join) {
    return function() {
      ctx.lineJoin = join;
    };
  };
}

export function setGlobalCompositeOperationImpl(ctx) {
  return function(op) {
    return function() {
      ctx.globalCompositeOperation = op;
    };
  };
}

export function setGlobalAlpha(ctx) {
  return function(alpha) {
    return function() {
      ctx.globalAlpha = alpha;
    };
  };
}

export function beginPath(ctx) {
  return function() {
    ctx.beginPath();
  };
}

export function stroke(ctx) {
  return function() {
    ctx.stroke();
  };
}

export function fill(ctx) {
  return function() {
    ctx.fill();
  };
}

export function clip(ctx) {
  return function() {
    ctx.clip();
  };
}

export function lineTo(ctx) {
  return function(x) {
    return function(y) {
      return function() {
        ctx.lineTo(x, y);
      };
    };
  };
}

export function moveTo(ctx) {
  return function(x) {
    return function(y) {
      return function() {
        ctx.moveTo(x, y);
      };
    };
  };
}

export function closePath(ctx) {
  return function() {
    ctx.closePath();
  };
}

export function arc(ctx) {
  return function(a) {
    return function() {
      ctx.arc(a.x, a.y, a.radius, a.start, a.end, a.useCounterClockwise);
    };
  };
}

export function rect(ctx) {
  return function(r) {
    return function() {
      ctx.rect(r.x, r.y, r.width, r.height);
    };
  };
}

export function fillRect(ctx) {
  return function(r) {
    return function() {
      ctx.fillRect(r.x, r.y, r.width, r.height);
    };
  };
}

export function strokeRect(ctx) {
  return function(r) {
    return function() {
      ctx.strokeRect(r.x, r.y, r.width, r.height);
    };
  };
}

export function clearRect(ctx) {
  return function(r) {
    return function() {
      ctx.clearRect(r.x, r.y, r.width, r.height);
    };
  };
}

export function scale(ctx) {
  return function(t) {
    return function() {
      ctx.scale(t.scaleX, t.scaleY);
    };
  };
}

export function rotate(ctx) {
  return function(angle) {
    return function() {
      ctx.rotate(angle);
    };
  };
}

export function translate(ctx) {
  return function(t) {
    return function() {
      ctx.translate(t.translateX, t.translateY);
    };
  };
}

export function transform(ctx) {
  return function(t) {
    return function() {
      ctx.transform(t.a, t.b, t.c, t.d, t.e, t.f);
    };
  };
}

export function setTransform(ctx) {
  return function(t) {
    return function() {
      ctx.setTransform(t.a, t.b, t.c, t.d, t.e, t.f);
    };
  };
}

export function textAlignImpl(ctx) {
  return function() {
    return ctx.textAlign;
  };
}

export function setTextAlignImpl(ctx) {
  return function(textAlign) {
    return function() {
      ctx.textAlign = textAlign;
    };
  };
}

export function textBaselineImpl(ctx) {
  return function () {
    return ctx.textBaseline;
  };
}

export function setTextBaselineImpl(ctx) {
  return function (textBaseline) {
    return function () {
      ctx.textBaseline = textBaseline;
    };
  };
}

export function font(ctx) {
  return function() {
    return ctx.font;
  };
}

export function setFont(ctx) {
  return function(fontspec) {
    return function() {
      ctx.font = fontspec;
    };
  };
}

export function fillText(ctx) {
  return function(text) {
    return function(x) {
      return function(y) {
        return function() {
          ctx.fillText(text, x, y);
        };
      };
    };
  };
}

export function strokeText(ctx) {
  return function(text) {
    return function(x) {
      return function(y) {
        return function() {
          ctx.strokeText(text, x, y);
        };
      };
    };
  };
}

export function measureText(ctx) {
  return function(text) {
    return function() {
      return ctx.measureText(text);
    };
  };
}

export function save(ctx) {
  return function() {
    ctx.save();
  };
}

export function restore(ctx) {
  return function() {
    ctx.restore();
  };
}

export function imageDataWidth(image) {
  return image.width;
}

export function imageDataHeight(image) {
  return image.height;
}

export function imageDataBuffer(image) {
  return image.data;
}

export function getImageData(ctx) {
  return function(x) {
    return function(y) {
      return function(w) {
        return function(h) {
          return function() {
            return ctx.getImageData(x, y, w, h);
          };
        };
      };
    };
  };
}

export function putImageDataFull(ctx) {
  return function(image_data) {
    return function(x) {
      return function(y) {
        return function(dx) {
          return function(dy) {
            return function(dw) {
              return function(dh) {
                return function() {
                  ctx.putImageData(image_data, x, y, dx, dy, dw, dh);
                };
              };
            };
          };
        };
      };
    };
  };
}

export function putImageData(ctx) {
  return function(image_data) {
    return function(x) {
      return function(y) {
        return function() {
          ctx.putImageData(image_data, x, y);
        };
      };
    };
  };
}

export function createImageData(ctx) {
  return function(sw) {
    return function(sh) {
      return function() {
        return ctx.createImageData(sw, sh);
      };
    };
  };
}

export function createImageDataCopy(ctx) {
  return function(image_data) {
    return function() {
      return ctx.createImageData(image_data);
    };
  };
}

export function createImageDataWith(arr) {
  return function(sw) {
    return function() {
      return new ImageData(arr, sw);
    };
  };
}

export function drawImage(ctx) {
  return function(image_source) {
    return function(dx) {
      return function(dy) {
        return function() {
          ctx.drawImage(image_source, dx, dy);
        };
      };
    };
  };
}

export function drawImageScale(ctx) {
  return function(image_source) {
    return function(dx) {
      return function(dy) {
        return function(dWidth) {
          return function(dHeight) {
            return function() {
              ctx.drawImage(image_source, dx, dy, dWidth, dHeight);
            };
          };
        };
      };
    };
  };
}

export function drawImageFull(ctx) {
  return function(image_source) {
    return function(sx) {
      return function(sy) {
        return function(sWidth) {
          return function(sHeight) {
            return function(dx) {
              return function(dy) {
                return function(dWidth) {
                  return function(dHeight) {
                    return function() {
                      ctx.drawImage(image_source, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight);
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

export function createPatternImpl(ctx) {
  return function(img) {
    return function(repeat) {
      return function() {
        return ctx.createPattern(img, repeat);
      };
    };
  };
}

export function setPatternFillStyle(ctx) {
  return function(pattern) {
    return function() {
      ctx.fillStyle = pattern;
    };
  };
}

export function createLinearGradient(ctx) {
  return function(linearGradient) {
    return function() {
      return ctx.createLinearGradient(linearGradient.x0, linearGradient.y0, linearGradient.x1, linearGradient.y1);
    };
  };
}

export function createRadialGradient(ctx) {
  return function(radialGradient) {
    return function() {
      return ctx.createRadialGradient(radialGradient.x0, radialGradient.y0, radialGradient.r0, radialGradient.x1, radialGradient.y1, radialGradient.r1);
    };
  };
}

export function addColorStop(gradient) {
  return function(stop) {
    return function(color) {
      return function() {
        gradient.addColorStop(stop, color);
      };
    };
  };
}

export function setGradientFillStyle(ctx) {
  return function(gradient) {
    return function() {
      ctx.fillStyle = gradient;
    };
  };
}

export function quadraticCurveTo(ctx) {
  return function(qCurve) {
    return function() {
      ctx.quadraticCurveTo(qCurve.cpx, qCurve.cpy, qCurve.x, qCurve.y);
    };
  };
}

export function bezierCurveTo(ctx) {
  return function(bCurve) {
    return function() {
      ctx.bezierCurveTo(bCurve.cp1x, bCurve.cp1y, bCurve.cp2x, bCurve.cp2y, bCurve.x, bCurve.y);
    };
  };
}
