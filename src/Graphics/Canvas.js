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
            return {};
        };
    };
};

exports.setCanvasHeight = function(height) {
    return function(canvas) {
        return function() {
            canvas.height = height;
            return {};
        };
    };
};

exports.canvasToDataURL = function(canvas) {
    return function() {
        return canvas.toDataURL();
    };
};

exports.setLineWidth = function(ctx) {
    return function(width) {
        return function() {
            ctx.lineWidth = width;
            return {};
        };
    };
};

exports.setFillStyle = function(ctx) {
    return function(style) {
        return function() {
            ctx.fillStyle = style;
            return {};
        };
    };
};

exports.setStrokeStyle = function(ctx) {
    return function(style) {
        return function() {
            ctx.strokeStyle = style;
            return {};
        };
    };
};

exports.setShadowColor = function(ctx) {
    return function(color) {
        return function() {
            ctx.shadowColor = color;
            return {};
        };
    };
};

exports.setShadowBlur = function(ctx) {
    return function(blur) {
        return function() {
            ctx.shadowBlur = blur;
            return {};
        };
    };
};

exports.setShadowOffsetX = function(ctx) {
    return function(offsetX) {
        return function() {
            ctx.shadowOffsetX = offsetX;
            return {};
        };
    };
};

exports.setShadowOffsetY = function(ctx) {
    return function(offsetY) {
        return function() {
            ctx.shadowOffsetY = offsetY;
            return {};
        };
    };
};

exports.setMiterLimit = function(ctx) {
    return function(limit) {
        return function() {
            ctx.miterLimit = limit;
            return {};
        };
    };
};

exports.setLineCapImpl = function(ctx) {
    return function(cap) {
        return function() {
            ctx.lineCap = cap;
            return {};
        };
    };
};

exports.setLineJoinImpl = function(ctx) {
    return function(join) {
        return function() {
            ctx.lineJoin = join;
            return {};
        };
    };
};

exports.setGlobalCompositeOperationImpl = function(ctx) {
    return function(op) {
        return function() {
            ctx.globalCompositeOperation = op;
            return {};
        };
    };
};

exports.setGlobalAlpha = function(ctx) {
    return function(alpha) {
        return function() {
            ctx.globalAlpha = alpha;
            return {};
        };
    };
};

exports.beginPath = function(ctx) {
    return function() {
        ctx.beginPath();
        return {};
    };
};

exports.stroke = function(ctx) {
    return function() {
        ctx.stroke();
        return {};
    };
};

exports.fill = function(ctx) {
    return function() {
        ctx.fill();
        return {};
    };
};

exports.clip = function(ctx) {
    return function() {
        ctx.clip();
        return {};
    };
};

exports.lineTo = function(ctx) {
    return function(x) {
        return function(y) {
            return function() {
                ctx.lineTo(x, y);
                return {};
            };
        };
    };
};

exports.moveTo = function(ctx) {
    return function(x) {
        return function(y) {
            return function() {
                ctx.moveTo(x, y);
                return {};
            };
        };
    };
};

exports.closePath = function(ctx) {
    return function() {
        ctx.closePath();
        return {};
    };
};

exports.arc = function(ctx) {
    return function(a) {
        return function() {
            ctx.arc(a.x, a.y, a.r, a.start, a.end);
            return {};
        };
    };
};

exports.rect = function(ctx) {
    return function(r) {
        return function() {
            ctx.rect(r.x, r.y, r.w, r.h);
            return {};
        };
    };
};

exports.fillRect = function(ctx) {
    return function(r) {
        return function() {
            ctx.fillRect(r.x, r.y, r.w, r.h);
            return {};
        };
    };
};

exports.strokeRect = function(ctx) {
    return function(r) {
        return function() {
            ctx.strokeRect(r.x, r.y, r.w, r.h);
            return {};
        };
    };
};

exports.clearRect = function(ctx) {
    return function(r) {
        return function() {
            ctx.clearRect(r.x, r.y, r.w, r.h);
            return {};
        };
    };
};

exports.scale = function(ctx) {
    return function(t) {
        return function() {
            ctx.scale(t.scaleX, t.scaleY);
            return {};
        };
    };
};

exports.rotate = function(ctx) {
    return function(angle) {
        return function() {
            ctx.rotate(angle);
            return {};
        };
    };
};

exports.translate = function(ctx) {
    return function(t) {
        return function() {
            ctx.translate(t.translateX, t.translateY);
            return {};
        };
    };
};

exports.transform = function(ctx) {
    return function(t) {
        return function() {
            ctx.transform(t.m11, t.m12, t.m21, t.m22, t.m31, t.m32);
            return {};
        };
    };
};

exports.setTransform = function(ctx) {
    return function(t) {
        return function() {
            ctx.setTransform(t.m11, t.m12, t.m21, t.m22, t.m31, t.m32);
            return {};
        };
    };
};

exports.clearRect = function(ctx) {
    return function(r) {
        return function() {
            ctx.clearRect(r.x, r.y, r.w, r.h);
            return {};
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
            return {};
        }
    }
};

exports.font = function(ctx) {
    return function() {
        return ctx.font;
    };
};

exports.setFont = function(ctx) {
    return function(fontspec) {
        return function() {
            ctx.font = fontspec;
            return {};
        };
    };
};

exports.fillText = function(ctx) {
    return function(text) {
        return function(x) {
            return function(y) {
                return function() {
                    ctx.fillText(text, x, y);
                    return {};
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
                    return {};
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
        return {};
    };
};

exports.restore = function(ctx) {
    return function() {
        ctx.restore();
        return {};
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
                                    return {};
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
                    return {};
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
                    return {};
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
                            return {};
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
                                            return {};
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

exports.createPatternImpl = function(ctx) {
    return function(img) {
        return function(repeat) {
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
            return {};
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
            return {};
        };
    };
};

exports.quadraticCurveTo = function(qCurve) {
    return function(ctx) {
        return function() {
            ctx.quadraticCurveTo(qCurve.cpx, qCurve.cpy, qCurve.x, qCurve.y);
            return {};
        };
    };
};

exports.bezierCurveTo = function(bCurve) {
    return function(ctx) {
        return function() {
            ctx.bezierCurveTo(bCurve.cp1x, bCurve.cp1y, bCurve.cp2x, bCurve.cp2y, bCurve.x, bCurve.y);
            return {};
        };
    };
};
