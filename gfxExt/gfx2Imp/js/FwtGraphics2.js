//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.gfx2Imp.Graphics2 = fan.sys.Obj.$extend(fan.fwt.Graphics);
fan.gfx2Imp.Graphics2.prototype.$ctor = function() {}

fan.gfx2Imp.Graphics2.prototype.$typeof = function()
{
  return fan.gfx2.Graphics2.$type;
}

fan.gfx2Imp.Graphics2.prototype.drawImage2 = function(image, x, y)
{
  var jsImg = image.getImage(this.widget);
  if (jsImg.width > 0 && jsImg.height > 0)
    this.cx.drawImage(jsImg, x, y)
  return this;
}

fan.gfx2Imp.Graphics2.prototype.copyImage2 = function(image, src, dest)
{
  var jsImg = image.getImage(this.widget);
  if (jsImg.width > 0 && jsImg.height > 0)
    this.cx.drawImage(jsImg, src.m_x, src.m_y, src.m_w, src.m_h, dst.m_x, dst.m_y, dst.m_w, dst.m_h)
  return this;
}

fan.gfx2Imp.Graphics2.prototype.drawPath = function(path)
{
  fan.gfx2Imp.Graphics2.doJsPath(this.cx, path);
  this.cx.stroke();
  return this;
}

fan.gfx2Imp.Graphics2.prototype.fillPath = function(path)
{
  fan.gfx2Imp.Graphics2.doJsPath(this.cx, path);
  this.cx.fill();
  return this;
}

fan.gfx2Imp.Graphics2.prototype.drawPolyline2 = function(p)
{
  this.cx.beginPath();
  var size = p.size();
  var x;
  var y;
  for (var i=0; i < size; i+=2)
  {
    x = p.getInt(i);
    y = p.getInt(i+1);
    if (i == 0) this.cx.moveTo(x, y);
    else this.cx.lineTo(x, y);
  }
  this.cx.stroke();
  return this;
}

fan.gfx2Imp.Graphics2.prototype.fillPolygon2 = function(p)
{
  this.cx.beginPath();
  var size = p.size();
  var x;
  var y;
  for (var i=0; i < size; i+=2)
  {
    x = p.getInt(i);
    y = p.getInt(i+1);
    if (i == 0) this.cx.moveTo(x, y);
    else this.cx.lineTo(x, y);
  }
  this.cx.closePath();
  this.cx.fill();
  return this;
}

fan.gfx2Imp.Graphics2.prototype.m_transform = fan.fgfxMath.Transform2D.make();
fan.gfx2Imp.Graphics2.prototype.transform = function() { return this.m_transform; }
fan.gfx2Imp.Graphics2.prototype.transform$ = function(trans)
{
  fan.gfx2Imp.Graphics2.doJsTransform(this.cx, trans);
  m_transform = trans.clone();
  return this;
}


fan.gfx2Imp.Graphics2.prototype.clipPath = function(path)
{
  fan.gfx2Imp.Graphics2.doJsPath(this.cx, path);
  this.cx.clip();
  return this;
}

//////////////////////////////////////////////////////////////////////////
// Util
//////////////////////////////////////////////////////////////////////////

fan.gfx2Imp.Graphics2.doJsPath = function(cx, path)
{
  var size = path.steps().size();
  cx.beginPath();
  for (var i =0; i < size; ++i)
  {
    var s = path.steps().get(i);

    if (s instanceof fan.gfx2.PathMoveTo)
    {
      cx.moveTo(s.m_x, s.m_y);
    }
    else if (s instanceof fan.gfx2.PathLineTo)
    {
      cx.lineTo(s.m_x, s.m_y);
    }
    else if (s instanceof fan.gfx2.PathQuadTo)
    {
      cx.quadraticCurveTo(s.m_cx, s.m_cy, s.m_x, s.m_y);
    }
    else if (s instanceof fan.gfx2.PathCubicTo)
    {
      cx.bezierCurveTo(s.m_cx1, s.m_cy1, s.m_cx2, s.m_cy2, s.m_x, s.m_y);
    }
    else if (s instanceof fan.gfx2.PathClose)
    {
      cx.closePath();
    }
    else
    {
      throw fan.sys.Err.make("unreachable");
    }
  }
}

fan.gfx2Imp.Graphics2.doJsTransform = function(cx, trans)
{
  cx.setTransform(
       trans.get(0,0),
       trans.get(0,1),
       trans.get(1,0),
       trans.get(1,1),
       trans.get(2,0),
       trans.get(2,1)
     );
}