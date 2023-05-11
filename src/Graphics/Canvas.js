export function canvasElementToImageSource(e) {
  return e;
}

export function tryLoadImageImpl(src, e, f) {
  var img = new Image();
  img.src = src;
  img.addEventListener("load", function() {
    f(img)();
  }, false);
  img.addEventListener("error", function() {
    e();
  }, false);
}

export function getCanvasElementByIdImpl(id, Just, Nothing) {
  var el = document.getElementById(id);
  if (el && el instanceof HTMLCanvasElement) {
    return Just(el);
  } else {
    return Nothing;
  }
}

export function getContext2DImpl(c) {
  return c.getContext("2d");
}

export function getCanvasWidthImpl(canvas) {
  return canvas.width;
}

export function getCanvasHeightImpl(canvas) {
  return canvas.height;
}

export function setCanvasWidthImpl(canvas, width) {
  canvas.width = width;
}

export function setCanvasHeightImpl(canvas, height) {
  canvas.height = height;
}

export function canvasToDataURLImpl(canvas) {
  return canvas.toDataURL();
}

export function setLineWidthImpl(ctx, width) {
  ctx.lineWidth = width;
}

export function setLineDashImpl(ctx, dash) {
  ctx.setLineDash(dash);
}

export function setFillStyleImpl(ctx, style) {
  ctx.fillStyle = style;
}

export function setStrokeStyleImpl(ctx, style) {
  ctx.strokeStyle = style;
}

export function setShadowColorImpl(ctx, color) {
  ctx.shadowColor = color;
}

export function setShadowBlurImpl(ctx, blur) {
  ctx.shadowBlur = blur;
}

export function setShadowOffsetXImpl(ctx, offsetX) {
  ctx.shadowOffsetX = offsetX;
}

export function setShadowOffsetYImpl(ctx, offsetY) {
  ctx.shadowOffsetY = offsetY;
}

export function setMiterLimitImpl(ctx, limit) {
  ctx.miterLimit = limit;
}

export function setLineCapImpl(ctx, cap) {
  ctx.lineCap = cap;
}

export function setLineJoinImpl(ctx, join) {
  ctx.lineJoin = join;
}

export function setGlobalCompositeOperationImpl(ctx, op) {
  ctx.globalCompositeOperation = op;
}

export function setGlobalAlphaImpl(ctx, alpha) {
  ctx.globalAlpha = alpha;
}

export function beginPathImpl(ctx) {
  ctx.beginPath();
}

export function strokeImpl(ctx) {
  ctx.stroke();
}

export function fillImpl(ctx) {
  ctx.fill();
}

export function clipImpl(ctx) {
  ctx.clip();
}

export function lineToImpl(ctx, x, y) {
  ctx.lineTo(x, y);
}

export function moveToImpl(ctx, x, y) {
  ctx.moveTo(x, y);
}

export function closePathImpl(ctx) {
  ctx.closePath();
}

export function arcImpl(ctx, a) {
  ctx.arc(a.x, a.y, a.radius, a.start, a.end, a.useCounterClockwise);
}

export function rectImpl(ctx, r) {
  ctx.rect(r.x, r.y, r.width, r.height);
}

export function fillRectImpl(ctx, r) {
  ctx.fillRect(r.x, r.y, r.width, r.height);
}

export function strokeRectImpl(ctx, r) {
  ctx.strokeRect(r.x, r.y, r.width, r.height);
}

export function clearRectImpl(ctx, r) {
  ctx.clearRect(r.x, r.y, r.width, r.height);
}

export function scaleImpl(ctx, t) {
  ctx.scale(t.scaleX, t.scaleY);
}

export function rotateImpl(ctx, angle) {
  ctx.rotate(angle);
}

export function translateImpl(ctx, t) {
  ctx.translate(t.translateX, t.translateY);
}

export function transformImpl(ctx, t) {
  ctx.transform(t.a, t.b, t.c, t.d, t.e, t.f);
}

export function setTransformImpl(ctx, t) {
  ctx.setTransform(t.a, t.b, t.c, t.d, t.e, t.f);
}

export function textAlignImpl(ctx) {
  return ctx.textAlign;
}

export function setTextAlignImpl(ctx, textAlign) {
  ctx.textAlign = textAlign;
}

export function textBaselineImpl(ctx) {
  return ctx.textBaseline;
}

export function setTextBaselineImpl(ctx, textBaseline) {
  ctx.textBaseline = textBaseline;
}

export function fontImpl(ctx) {
  return ctx.font;
}

export function setFontImpl(ctx, fontspec) {
  ctx.font = fontspec;
}

export function fillTextImpl(ctx, text, x, y) {
  ctx.fillText(text, x, y);
}

export function strokeTextImpl(ctx, text, x, y) {
  ctx.strokeText(text, x, y);
}

export function measureTextImpl(ctx, text) {
  return ctx.measureText(text);
}

export function saveImpl(ctx) {
  ctx.save();
}

export function restoreImpl(ctx) {
  ctx.restore();
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

export function getImageDataImpl(ctx, x, y, w, h) {
  return ctx.getImageData(x, y, w, h);
}

export function putImageDataFullImpl(ctx, image_data, x, y, dx, dy, dw, dh) {
  ctx.putImageData(image_data, x, y, dx, dy, dw, dh);
}

export function putImageDataImpl(ctx, image_data, x, y) {
  ctx.putImageData(image_data, x, y);
}

export function createImageDataImpl(ctx, sw, sh) {
  return ctx.createImageData(sw, sh);
}

export function createImageDataCopyImpl(ctx, image_data) {
  return ctx.createImageData(image_data);
}

export function createImageDataWithImpl(arr, sw) {
  return new ImageData(arr, sw);
}

export function drawImageImpl(ctx, image_source, dx, dy) {
  ctx.drawImage(image_source, dx, dy);
}

export function drawImageScaleImpl(ctx, image_source, dx, dy, dWidth, dHeight) {
  ctx.drawImage(image_source, dx, dy, dWidth, dHeight);
}

export function drawImageFullImpl(ctx, image_source, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight) {
  ctx.drawImage(image_source, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight);
}

export function createPatternImpl(ctx, img, repeat) {
  return ctx.createPattern(img, repeat);
}

export function setPatternFillStyleImpl(ctx, pattern) {
  ctx.fillStyle = pattern;
}

export function createLinearGradientImpl(ctx, linearGradient) {
  return ctx.createLinearGradient(linearGradient.x0, linearGradient.y0, linearGradient.x1, linearGradient.y1);
}

export function createRadialGradientImpl(ctx, radialGradient) {
  return ctx.createRadialGradient(radialGradient.x0, radialGradient.y0, radialGradient.r0, radialGradient.x1, radialGradient.y1, radialGradient.r1);
}

export function addColorStopImpl(gradient, stop, color) {
  gradient.addColorStop(stop, color);
}

export function setGradientFillStyleImpl(ctx, gradient) {
  ctx.fillStyle = gradient;
}

export function quadraticCurveToImpl(ctx, qCurve) {
  ctx.quadraticCurveTo(qCurve.cpx, qCurve.cpy, qCurve.x, qCurve.y);
}

export function bezierCurveToImpl(ctx, bCurve) {
  ctx.bezierCurveTo(bCurve.cp1x, bCurve.cp1y, bCurve.cp2x, bCurve.cp2y, bCurve.x, bCurve.y);
}
