function jsCreateCanvas(w, h, _) {
  var canvas = document.createElement("canvas")
  canvas.width = w
  canvas.height = h
  document.body.appendChild(canvas)
  return [1, 0, canvas]
}

function jsGlobalAlphaCtx(a, ctx, _) {
  ctx.globalAlpha = a
  return [1, 0]
}

function jsSaveState(ctx, _) {
  ctx.save()
  return [1, 0]
}

function jsRestoreState(ctx, _) {
  ctx.restore()
  return [1, 0]
}

function jsBeginPath(ctx, _) {
  ctx.beginPath()
  return [1, 0]
}

function jsClosePath(ctx, _) {
  ctx.closePath()
  return [1, 0]
}

function jsFill(ctx, _) {
  ctx.fill()
  return [1, 0]
}

function jsStroke(ctx, _) {
  ctx.stroke()
  return [1, 0]
}

function jsGetCtx2D(canvas, _) {
  return [1, 0, canvas.getContext("2d")]
}

function jsRect(x, y, w, h, ctx, _) {
  ctx.rect(x, y, w, h)
  return [1, 0]
}

function jsSetFillStyleC(col, ctx, _) {
  ctx.fillStyle = col
  return [1, 0]
}

function jsScale(sx, sy, ctx, _) {
  ctx.scale(sx, sy)
  return [1, 0]
}

function jsRotate(rad, ctx, _) {
  ctx.rotate(rad)
  return [1, 0]
}

function jsTranslate(x, y, ctx, _) {
  ctx.translate(x, y)
  return [1, 0]
}

function jsClearCtx(w, h, ctx, _) {
  ctx.save()
  ctx.setTransform(1, 0, 0, 1, 0, 0)
  ctx.clearRect(0, 0, w, h)
  ctx.restore()
  return [1, 0]
}

function jsDrawImage(x, y, img, ctx, _) {
    ctx.drawImage(img, x, y)
    return [1, 0]
}

function jsDrawSubImage(sx, sy, sw, sh, tx, ty, tw, th, img, ctx) {
    ctx.drawImage(img, sx, sy, sw, sh, tx, ty, tw, th)
    return [1, 0]
}
