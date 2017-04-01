/* global exports */
"use strict";

exports.canvasElementToImageSource = function(e) {
    return e;
};

exports.tryLoadImageImpl = function (src) {
  return function(e) {
        return function(f) {
            return function () {
                var img = new Image();
                img.src = src;
                img.addEventListener("load", function() {
                    f(img)();
                }, false);
                img.addEventListener("error", function(error) {
                    e();
                }, false);

                return {};
            }
        }
    };
};

exports.getCanvasElementByIdImpl = function(id, Just, Nothing) {
    return function() {
        var el = document.getElementById(id);
        if (el && el instanceof HTMLCanvasElement) {
            return Just(el);
        } else {
            return Nothing;
        }
    };
};

exports.getContext2D = function(c) {
    return function() {
        return c.getContext('2d');
    };
};

exports.getCanvasWidth = function(canvas) {
    return function() {
        return canvas.width;
    };
};

exports.getCanvasHeight = function(canvas) {
    return function() {
        return canvas.height;
    };
};

exports.setCanvasWidth = function(width) {
    return function(canvas) {
        return function() {
            canvas.width = width;
            return canvas;
        };
    };
};

exports.setCanvasHeight = function(height) {
    return function(canvas) {
        return function() {
            canvas.height = height;
            return canvas;
        };
    };
};

exports.canvasToDataURL = function(canvas) {
    return function() {
        return canvas.toDataURL();
    };
};

exports.setLineWidth = function(width) {
    return function(ctx) {
        return function() {
            ctx.lineWidth = width;
            return ctx;
        };
    };
};

exports.setFillStyle = function(style) {
    return function(ctx) {
        return function() {
            ctx.fillStyle = style;
            return ctx;
        };
    };
};

exports.setStrokeStyle = function(style) {
    return function(ctx) {
        return function() {
            ctx.strokeStyle = style;
            return ctx;
        };
    };
};

exports.setShadowColor = function(color) {
    return function(ctx) {
        return function() {
            ctx.shadowColor = color;
            return ctx;
        };
    };
};

exports.setShadowBlur = function(blur) {
    return function(ctx) {
        return function() {
            ctx.shadowBlur = blur;
            return ctx;
        };
    };
};

exports.setShadowOffsetX = function(offsetX) {
    return function(ctx) {
        return function() {
            ctx.shadowOffsetX = offsetX;
            return ctx;
        };
    };
};

exports.setShadowOffsetY = function(offsetY) {
    return function(ctx) {
        return function() {
            ctx.shadowOffsetY = offsetY;
            return ctx;
        };
    };
};

exports.setMiterLimit = function(limit) {
    return function(ctx) {
        return function() {
            ctx.miterLimit = limit;
            return ctx;
        };
    };
};

exports.setLineCapImpl = function(cap) {
    return function(ctx) {
        return function() {
            ctx.lineCap = cap;
            return ctx;
        };
    };
};

exports.setLineJoinImpl = function(join) {
    return function(ctx) {
        return function() {
            ctx.lineJoin = join;
            return ctx;
        };
    };
};

exports.setGlobalCompositeOperationImpl = function(ctx) {
    return function(op) {
        return function() {
            ctx.globalCompositeOperation = op;
            return ctx;
        };
    };
};

exports.setGlobalAlpha = function(ctx) {
    return function(alpha) {
        return function() {
            ctx.globalAlpha = alpha;
            return ctx;
        };
    };
};

exports.beginPath = function(ctx) {
    return function() {
        ctx.beginPath();
        return ctx;
    };
};

exports.stroke = function(ctx) {
    return function() {
        ctx.stroke();
        return ctx;
    };
};

exports.fill = function(ctx) {
    return function() {
        ctx.fill();
        return ctx;
    };
};

exports.clip = function(ctx) {
    return function() {
        ctx.clip();
        return ctx;
    };
};

exports.lineTo = function(ctx) {
    return function(x) {
        return function(y) {
            return function() {
                ctx.lineTo(x, y);
                return ctx;
            };
        };
    };
};

exports.moveTo = function(ctx) {
    return function(x) {
        return function(y) {
            return function() {
                ctx.moveTo(x, y);
                return ctx;
            };
        };
    };
};

exports.closePath = function(ctx) {
    return function() {
        ctx.closePath();
        return ctx;
    };
};

exports.arc = function(ctx) {
    return function(a) {
        return function() {
            ctx.arc(a.x, a.y, a.r, a.start, a.end);
            return ctx;
        };
    };
};

exports.rect = function(ctx) {
    return function(r) {
        return function() {
            ctx.rect(r.x, r.y, r.w, r.h);
            return ctx;
        };
    };
};

exports.fillRect = function(ctx) {
    return function(r) {
        return function() {
            ctx.fillRect(r.x, r.y, r.w, r.h);
            return ctx;
        };
    };
};

exports.strokeRect = function(ctx) {
    return function(r) {
        return function() {
            ctx.strokeRect(r.x, r.y, r.w, r.h);
            return ctx;
        };
    };
};

exports.scale = function(t) {
    return function(ctx) {
        return function() {
            ctx.scale(t.scaleX, t.scaleY);
            return ctx;
        };
    };
};

exports.rotate = function(angle) {
    return function(ctx) {
        return function() {
            ctx.rotate(angle);
            return ctx;
        };
    };
};

exports.translate = function(t) {
    return function(ctx) {
        return function() {
            ctx.translate(t.translateX, t.translateY);
            return ctx;
        };
    };
};

exports.transform = function(t) {
    return function(ctx) {
        return function() {
            ctx.transform(t.m11, t.m12, t.m21, t.m22, t.m31, t.m32);
            return ctx;
        };
    };
};

exports.clearRect = function(ctx) {
    return function(r) {
        return function() {
            ctx.clearRect(r.x, r.y, r.w, r.h);
            return ctx;
        };
    };
};

exports.textAlignImpl = function(ctx) {
    return function() {
        return ctx.textAlign;
    }
};

exports.setTextAlignImpl = function(ctx) {
    return function(textAlign) {
        return function() {
            ctx.textAlign = textAlign;
            return ctx;
        }
    }
};

exports.font = function(ctx) {
    return function() {
        return ctx.font;
    };
};

exports.setFont = function(fontspec) {
    return function(ctx) {
        return function() {
            ctx.font = fontspec;
            return ctx;
        };
    };
};

exports.fillText = function(ctx) {
    return function(text) {
        return function(x) {
            return function(y) {
                return function() {
                    ctx.fillText(text, x, y);
                    return ctx;
                };
            };
        };
    };
};

exports.strokeText = function(ctx) {
    return function(text) {
        return function(x) {
            return function(y) {
                return function() {
                    ctx.strokeText(text, x, y);
                    return ctx;
                };
            };
        };
    };
};

exports.measureText = function(ctx) {
    return function(text) {
        return function() {
            return ctx.measureText(text);
        };
    };
};

exports.save = function(ctx) {
    return function() {
        ctx.save();
        return ctx;
    };
};

exports.restore = function(ctx) {
    return function() {
        ctx.restore();
        return ctx;
    };
};

exports.imageDataWidth = function(image) {
    return image.width;
};

exports.imageDataHeight = function(image) {
    return image.height;
};

exports.imageDataBuffer = function(image) {
    return image.data;
};

exports.getImageData = function(ctx) {
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
};

exports.putImageDataFull = function(ctx) {
    return function(image_data) {
        return function(x) {
            return function(y) {
                return function(dx) {
                    return function(dy) {
                        return function(dw) {
                            return function(dh) {
                                return function() {
                                    ctx.putImageData(image_data, x, y, dx, dy, dw, dh);
                                    return ctx;
                                };
                            };
                        };
                    };
                };
            };
        };
    };
};

exports.putImageData = function(ctx) {
    return function(image_data) {
        return function(x) {
            return function(y) {
                return function() {
                    ctx.putImageData(image_data, x, y);
                    return ctx;
                };
            };
        };
    };
};

exports.createImageData = function(ctx) {
    return function(sw) {
        return function(sh) {
            return function() {
                return ctx.createImageData(sw, sh);
            };
        };
    };
};

exports.createImageDataCopy = function(ctx) {
    return function(image_data) {
        return function() {
            return ctx.createImageData(image_data);
        };
    };
};

exports.drawImage = function(ctx) {
    return function(image_source) {
        return function(dx) {
            return function(dy) {
                return function() {
                    ctx.drawImage(image_source, dx, dy);
                    return ctx;
                };
            };
        };
    };
};

exports.drawImageScale = function(ctx) {
    return function(image_source) {
        return function(dx) {
            return function(dy) {
                return function(dWidth) {
                    return function(dHeight) {
                        return function() {
                            ctx.drawImage(image_source, dx, dy, dWidth, dHeight);
                            return ctx;
                        };
                    };
                };
            };
        };
    };
};

exports.drawImageFull = function(ctx) {
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
                                            return ctx;
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
};

exports.createPatternImpl = function(img) {
    return function(repeat) {
        return function(ctx) {
            return function() {
                return ctx.createPattern(img, repeat);
            };
        };
    };
};

exports.setPatternFillStyle = function(pattern) {
    return function(ctx) {
        return function() {
            ctx.fillStyle = pattern;
            return ctx;
        };
    };
};

exports.createLinearGradient = function(linearGradient) {
    return function(ctx) {
        return function() {
            return ctx.createLinearGradient(linearGradient.x0, linearGradient.y0, linearGradient.x1, linearGradient.y1);
        };
    };
};

exports.createRadialGradient = function(radialGradient) {
    return function(ctx) {
        return function() {
            return ctx.createRadialGradient(radialGradient.x0, radialGradient.y0, radialGradient.r0, radialGradient.x1, radialGradient.y1, radialGradient.r1);
        };
    };
};

exports.addColorStop = function(stop) {
    return function(color) {
        return function(gradient) {
            return function() {
                gradient.addColorStop(stop, color);
                return gradient;
            };
        };
    };
};

exports.setGradientFillStyle = function(gradient) {
    return function(ctx) {
        return function() {
            ctx.fillStyle = gradient;
            return ctx;
        };
    };
};

exports.quadraticCurveTo = function(qCurve) {
    return function(ctx) {
        return function() {
            ctx.quadraticCurveTo(qCurve.cpx, qCurve.cpy, qCurve.x, qCurve.y);
            return ctx;
        };
    };
};

exports.bezierCurveTo = function(bCurve) {
    return function(ctx) {
        return function() {
            ctx.bezierCurveTo(bCurve.cp1x, bCurve.cp1y, bCurve.cp2x, bCurve.cp2y, bCurve.x, bCurve.y);
            return ctx;
        };
    };
};
