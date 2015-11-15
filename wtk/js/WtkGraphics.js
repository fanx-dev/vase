//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   12 Jun 09  Brian Frank  Creation
//

/**
 * FwtGraphics implements gfx::Graphics using HTML5 canvas.
 */

fan.fgfxWtk.WtkGraphics = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxWtk.WtkGraphics.prototype.$ctor = function() {}
fan.fgfxWtk.WtkGraphics.prototype.$typeof = function()
{
  return fan.fgfxGraphics.Graphics.$type;
}

fan.fgfxWtk.WtkGraphics.prototype.widget = null;
fan.fgfxWtk.WtkGraphics.prototype.size = null;
fan.fgfxWtk.WtkGraphics.prototype.cx = null;
fan.fgfxWtk.WtkGraphics.prototype.m_clip = null;

// canvas - <canvas> element
// bounds - fan.gfx.Rect
// f - JS function(fan.fgfxWtk.WtkGraphics)
fan.fgfxWtk.WtkGraphics.prototype.init = function(cx, bounds)
{
  this.size = bounds.size();
  this.m_clip = bounds;
  this.cx = cx;
  //this.cx.save();
  //this.cx.lineWidth = 1;
  this.cx.lineCap = "square";
  //this.cx.lineJoin = "miter";
  //this.cx.textBaseline = "top";
  //this.cx.font = fan.fgfxWtk.GfxUtil.fontToCss(fan.fwt.DesktopPeer.$sysFont);

  this.brush$(fan.fgfxGraphics.Color.m_black);
  this.pen$(fan.fgfxGraphics.Pen.m_defVal);
  //this.font$(fan.fwt.Desktop.sysFont());
  //f(this);
  //this.cx.restore();
}

// Brush brush
fan.fgfxWtk.WtkGraphics.prototype.m_brush = null
fan.fgfxWtk.WtkGraphics.prototype.brush   = function() { return this.m_brush }
fan.fgfxWtk.WtkGraphics.prototype.brush$  = function(b)
{
  this.m_brush = b;
  if (b instanceof fan.fgfxGraphics.Color)
  {
    var style = b.toCss();
    this.cx.fillStyle = style;
    this.cx.strokeStyle = style;
  }
  else if (b instanceof fan.fgfxGraphics.Gradient)
  {
    var x1 = b.m_x1;
    var y1 = b.m_y1;
    var x2 = b.m_x2;
    var y2 = b.m_y2;

    // handle percent
    if (b.m_x1Unit.symbol() == "%") x1 = this.size.m_w * (x1 / 100);
    if (b.m_y1Unit.symbol() == "%") y1 = this.size.m_h * (y1 / 100);
    if (b.m_x2Unit.symbol() == "%") x2 = this.size.m_w * (x2 / 100);
    if (b.m_y2Unit.symbol() == "%") y2 = this.size.m_h * (y2 / 100);

    // add stops
    var style = this.cx.createLinearGradient(x1, y1, x2, y2);
    var stops = b.m_stops;
    for (var i=0; i<stops.size(); i++)
    {
      var s = stops.get(i);
      style.addColorStop(s.m_pos, s.m_color.toCss());
    }

    this.cx.fillStyle = style;
    this.cx.strokeStyle = style;
  }
  else if (b instanceof fan.fgfxGraphics.Pattern)
  {
    var jsImg = b.m_image.getImage();
    if (!image.isLoaded())
    {
      fan.fgfxWtk.WtkGraphics.loadImage(this, jsImg);
    }

    var style = (jsImg.width > 0 && jsImg.height > 0)
      ? this.cx.createPattern(jsImg, 'repeat')
      : "rgba(0,0,0,0)";
    this.cx.fillStyle = style;
    this.cx.strokeStyle = style;
  }
  else
  {
    fan.sys.ObjUtil.echo("ERROR: unknown brush type: " + b);
  }
}

// Pen pen
fan.fgfxWtk.WtkGraphics.prototype.m_pen = null
fan.fgfxWtk.WtkGraphics.prototype.pen   = function() { return this.m_pen }
fan.fgfxWtk.WtkGraphics.prototype.pen$  = function(p)
{
  this.m_pen = p;
  this.cx.lineWidth = p.m_width;
  this.cx.lineCap   = p.capToStr();
  this.cx.lineJoin  = p.joinToStr();
  // dashes not supported
}

// Font font
fan.fgfxWtk.WtkGraphics.prototype.m_font = null
fan.fgfxWtk.WtkGraphics.prototype.font   = function() { return this.m_font }
fan.fgfxWtk.WtkGraphics.prototype.font$  = function(f)
{
  this.m_font = f;
  this.cx.font = fan.fgfxWtk.GfxUtil.fontToCss(f);
}

// Bool antialias
fan.fgfxWtk.WtkGraphics.prototype.m_antialias = true;
fan.fgfxWtk.WtkGraphics.prototype.antialias   = function() { return this.m_antialias }
fan.fgfxWtk.WtkGraphics.prototype.antialias$  = function(aa)
{
  // Note: canvas has no control over anti-aliasing (Jun 09)
  this.m_antialias = aa;
}

// Int alpha
fan.fgfxWtk.WtkGraphics.prototype.m_alpha = 255;
fan.fgfxWtk.WtkGraphics.prototype.alpha   = function() { return this.m_alpha}
fan.fgfxWtk.WtkGraphics.prototype.alpha$  = function(a)
{
  this.m_alpha = a;
  this.cx.globalAlpha = a / 255;
}

// This drawLine(Int x1, Int y1, Int x2, Int y2)
fan.fgfxWtk.WtkGraphics.prototype.drawLine = function(x1, y1, x2, y2)
{
  this.cx.beginPath();
  this.cx.moveTo(x1+0.5, y1+0.5);
  this.cx.lineTo(x2+0.5, y2+0.5);
  this.cx.closePath();
  this.cx.stroke();
  return this;
}


// This drawPolygon(Point[] p)
fan.fgfxWtk.WtkGraphics.prototype.drawPolygon = function(p)
{
  this.cx.beginPath();
  var size = p.size();
  var x;
  var y;
  for (var i=0; i<size; i++)
  {
    var x = p.getX(i);
    var y = p.getY(i);
    if (i == 0) this.cx.moveTo(x, y);
    else this.cx.lineTo(x, y);
  }
  this.cx.closePath();
  this.cx.stroke();
  return this;
}

// This drawRect(Int x, Int y, Int w, Int h)
fan.fgfxWtk.WtkGraphics.prototype.drawRect = function(x, y, w, h)
{
  this.cx.strokeRect(x+0.5, y+0.5, w, h);
  return this;
}

// This fillRect(Int x, Int y, Int w, Int h)
fan.fgfxWtk.WtkGraphics.prototype.fillRect = function(x, y, w, h)
{
  this.cx.fillRect(x, y, w, h);
  return this;
}

fan.fgfxWtk.WtkGraphics.prototype.clearRect = function(x, y, w, h)
{
  this.cx.clearRect(x, y, w, h);
  return this;
}

// This drawRoundRect(Int x, Int y, Int w, Int h, Int wArc, Int hArc)
fan.fgfxWtk.WtkGraphics.prototype.drawRoundRect = function(x, y, w, h, wArc, hArc)
{
  this.pathRoundRect(x+0.5, y+0.5, w, h, wArc*1.1, hArc*1.1)
  this.cx.stroke();
  return this;
}

// This fillRoundRect(Int x, Int y, Int w, Int h, Int wArc, Int hArc)
fan.fgfxWtk.WtkGraphics.prototype.fillRoundRect = function(x, y, w, h, wArc, hArc)
{
  this.pathRoundRect(x, y, w, h, wArc*1.1, hArc*1.1)
  this.cx.fill();
  return this;
}

// generate path for a rounded rectangle
fan.fgfxWtk.WtkGraphics.prototype.pathRoundRect = function(x, y, w, h, wArc, hArc)
{
  this.cx.beginPath();
  this.cx.moveTo(x + wArc, y);
  this.cx.lineTo(x + w - wArc, y);
  this.cx.quadraticCurveTo(x + w, y, x + w, y + hArc);
  this.cx.lineTo(x + w, y + h - hArc);
  this.cx.quadraticCurveTo(x + w, y + h , x + w - wArc, y + h);
  this.cx.lineTo(x + wArc, y + h);
  this.cx.quadraticCurveTo(x, y + h , x, y + h - hArc);
  this.cx.lineTo(x, y + hArc);
  this.cx.quadraticCurveTo(x, y, x + wArc, y);
}

// helper
fan.fgfxWtk.WtkGraphics.prototype.oval = function(x, y, w, h)
{
  // Public Domain by Christopher Clay - http://canvaspaint.org/blog/
  var kappa = 4 * ((Math.sqrt(2) -1) / 3);
  var rx = w/2;
  var ry = h/2;
  var cx = x+rx+0.5;
  var cy = y+ry+0.5;

  this.cx.beginPath();
  this.cx.moveTo(cx, cy - ry);
  this.cx.bezierCurveTo(cx + (kappa * rx), cy - ry,  cx + rx, cy - (kappa * ry), cx + rx, cy);
  this.cx.bezierCurveTo(cx + rx, cy + (kappa * ry), cx + (kappa * rx), cy + ry, cx, cy + ry);
  this.cx.bezierCurveTo(cx - (kappa * rx), cy + ry, cx - rx, cy + (kappa * ry), cx - rx, cy);
  this.cx.bezierCurveTo(cx - rx, cy - (kappa * ry), cx - (kappa * rx), cy - ry, cx, cy - ry);
  this.cx.closePath();
}

// This drawOval(Int x, Int y, Int w, Int h)
fan.fgfxWtk.WtkGraphics.prototype.drawOval = function(x, y, w, h)
{
  this.oval(x, y, w, h)
  this.cx.stroke();
  return this;
}

// This fillOval(Int x, Int y, Int w, Int h)
fan.fgfxWtk.WtkGraphics.prototype.fillOval = function(x, y, w, h)
{
  this.oval(x, y, w, h)
  this.cx.fill();
  return this;
}

// This drawArc(Int x, Int y, Int w, Int h, Int startAngle, Int arcAngle)
fan.fgfxWtk.WtkGraphics.prototype.drawArc = function(x, y, w, h, startAngle, arcAngle)
{
  // TODO FIXIT: support for elliptical arc curves
  var cx  = x + (w/2);
  var cy  = y + (h/2);
  var rad = Math.min(w/2, h/2);
  var sa  = Math.PI / 180 * startAngle;
  var ea  = Math.PI / 180 * (startAngle + arcAngle);

  this.cx.beginPath();
  this.cx.arc(cx, cy, rad, -sa, -ea, true);
  this.cx.stroke();
  return this;
}

// This fillArc(Int x, Int y, Int w, Int h, Int startAngle, Int arcAngle)
fan.fgfxWtk.WtkGraphics.prototype.fillArc = function(x, y, w, h, startAngle, arcAngle)
{
  // TODO FIXIT: support for elliptical arc curves
  var cx = x + (w/2);
  var cy = y + (h/2);
  var radius = Math.min(w/2, h/2);

  var startRads = Math.PI / 180 * startAngle;
  var x1 = cx + (Math.cos(-startRads) * radius);
  var y1 = cy + (Math.sin(-startRads) * radius);

  var endRads = Math.PI / 180 * (startAngle + arcAngle);
  var x2 = cx + (Math.cos(-endRads) * radius);
  var y2 = cy + (Math.sin(-endRads) * radius);

  this.cx.beginPath();
  this.cx.moveTo(cx, cy);
  this.cx.lineTo(x1, y1);
  this.cx.arc(cx, cy, radius, -startRads, -endRads, true);
  this.cx.lineTo(x2, y2);
  this.cx.closePath();
  this.cx.fill();
  return this;
}

// This drawText(Str s, Int x, Int y)
fan.fgfxWtk.WtkGraphics.prototype.drawText = function (s, x, y)
{
  this.cx.fillText(s, x, y)
  return this;
}

// This clip(Rect r)
fan.fgfxWtk.WtkGraphics.prototype.clip = function (rect)
{
  this.m_clip = this.m_clip.intersection(rect);
  this.cx.beginPath();
  this.cx.moveTo(rect.m_x, rect.m_y);
  this.cx.lineTo(rect.m_x+rect.m_w, rect.m_y);
  this.cx.lineTo(rect.m_x+rect.m_w, rect.m_y+rect.m_h);
  this.cx.lineTo(rect.m_x, rect.m_y+rect.m_h);
  this.cx.closePath();
  this.cx.clip();
  return this
}

// Rect clipBounds()
fan.fgfxWtk.WtkGraphics.prototype.clipBounds = function ()
{
  return this.m_clip;
}

// Void push()
fan.fgfxWtk.WtkGraphics.prototype.push = function ()
{
  this.cx.save();
  var state = new Object();
  state.brush     = this.m_brush;
  state.pen       = this.m_pen;
  state.font      = this.m_font;
  state.antialias = this.m_antialias;
  state.alpha     = this.m_alpha;
  state.clip      = this.m_clip;
  //state.transform = this.m_transform.clone();
  this.stack.push(state);
}

// Void pop()
fan.fgfxWtk.WtkGraphics.prototype.pop = function ()
{
  this.cx.restore();
  var state = this.stack.pop();
  this.m_brush     = state.brush;
  this.m_pen       = state.pen;
  this.m_font      = state.font;
  this.m_antialias = state.antialias;
  this.m_alpha     = state.alpha;
  this.m_clip      = state.clip;
  //this.m_transform = state.transform;
}

// Void dispose()
fan.fgfxWtk.WtkGraphics.prototype.dispose = function ()
{
  // no-op
}

// state for fields in push/pop
fan.fgfxWtk.WtkGraphics.prototype.stack = new Array();



//************************************************************************
//************************************************************************
//   2011-08-20  Jed Young  Creation
//

fan.fgfxWtk.WtkGraphics.prototype.drawImage = function(image, x, y)
{
  var jsImg = image.getImage();
  if (image.isLoaded() && jsImg.width > 0 && jsImg.height > 0)
    this.cx.drawImage(jsImg, x, y);
  else
  {
    fan.fgfxWtk.WtkGraphics.loadImage(this, jsImg);
  }
  return this;
}

//invalid widget to repaint on image loaded
fan.fgfxWtk.WtkGraphics.loadImage = function(self, jsImg)
{
  fan.fgfxWtk.GfxUtil.addEventListener(jsImg, "load",
    function(){ if(self.widget){ self.widget.invalid(); }; });
}

fan.fgfxWtk.WtkGraphics.prototype.copyImage = function(image, src, dst)
{
  var jsImg = image.getImage();
  if (image.isLoaded() && jsImg.width > 0 && jsImg.height > 0)
    this.cx.drawImage(jsImg, src.m_x, src.m_y, src.m_w, src.m_h, dst.m_x, dst.m_y, dst.m_w, dst.m_h)
  else
  {
    fan.fgfxWtk.WtkGraphics.loadImage(this, jsImg);
  }
  return this;
}

fan.fgfxWtk.WtkGraphics.prototype.drawPath = function(path)
{
  fan.fgfxWtk.GfxUtil.doJsPath(this.cx, path);
  this.cx.stroke();
  return this;
}

fan.fgfxWtk.WtkGraphics.prototype.fillPath = function(path)
{
  fan.fgfxWtk.GfxUtil.doJsPath(this.cx, path);
  this.cx.fill();
  return this;
}

fan.fgfxWtk.WtkGraphics.prototype.drawPolyline = function(p)
{
  this.cx.beginPath();
  var size = p.size();
  var x;
  var y;
  for (var i=0; i < size; i++)
  {
    x = p.getX(i);
    y = p.getY(i);
    if (i == 0) this.cx.moveTo(x, y);
    else this.cx.lineTo(x, y);
  }
  this.cx.stroke();
  return this;
}

fan.fgfxWtk.WtkGraphics.prototype.fillPolygon = function(p)
{
  this.cx.beginPath();
  var size = p.size();
  var x;
  var y;
  for (var i=0; i < size; i++)
  {
    x = p.getX(i);
    y = p.getY(i);
    if (i == 0) this.cx.moveTo(x, y);
    else this.cx.lineTo(x, y);
  }
  this.cx.closePath();
  this.cx.fill();
  return this;
}

//fan.fgfxWtk.WtkGraphics.prototype.m_transform = fan.fgfxMath.Transform2D.make();
//fan.fgfxWtk.WtkGraphics.prototype.transform = function() { return this.m_transform.clone(); }
fan.fgfxWtk.WtkGraphics.prototype.transform = function(trans)
{
  fan.fgfxWtk.GfxUtil.doJsTransform(this.cx, trans);
  //this.m_transform = trans.clone();
  return this;
}


fan.fgfxWtk.WtkGraphics.prototype.clipPath = function(path)
{
  fan.fgfxWtk.GfxUtil.doJsPath(this.cx, path);
  this.cx.clip();
  return this;
}

fan.fgfxWtk.WtkGraphics.prototype.m_composite = null;
fan.fgfxWtk.WtkGraphics.prototype.composite = function() { return this.m_composite; }
fan.fgfxWtk.WtkGraphics.prototype.composite$ = function(c)
{
  var cmp = "source-over";
  if (c.name = "srcAtop")
  {
    cmp = "source-atop";
  }
  else if (c.name = "srcIn")
  {
    cmp = "source-in";
  }
  else if (c.name = "srcOut")
  {
    cmp = "source-out";
  }
  else if (c.name = "dstAtop")
  {
    cmp = "destination-atop";
  }
  else if (c.name = "dstIn")
  {
    cmp = "destination-in";
  }
  else if (c.name = "dstOut")
  {
    cmp = "destination-out";
  }
  else if (c.name = "dstOver")
  {
    cmp = "destination-over";
  }
  else if (c.name = "lighter")
  {
    cmp = "lighter";
  }
  else if (c.name = "copy")
  {
    cmp = "source-over";
  }
  else if (c.name = "xor")
  {
    cmp = "xor";
  }

  this.cx.globalCompositeOperation = cmp
  this.m_composite = c;
}

fan.fgfxWtk.WtkGraphics.prototype.setShadow = function(shadow){
  if (shadow) {
    this.cx.shadowColor = shadow.m_color.toCss();
    this.cx.shadowBlur = shadow.m_blur;
    this.cx.shadowOffsetX = shadow.m_offsetX;
    this.cs.shadowOffsetY = shadow.m_offsetY;
  } else {
    this.cx.shadowColor = "rgba(0,0,0,0)";
    this.cx.shadowBlur = 0;
    this.cx.shadowOffsetX = 0;
    this.cs.shadowOffsetY = 0;
  }
  return this;
}