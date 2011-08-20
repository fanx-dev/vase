//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.fwt.Graphics.prototype.drawImage2 = function(image, x, y)
{
  this.cx.drawImage(image.getImage(), 0, 0);
  return this;
}

fan.fwt.Graphics.prototype.copyImage2 = function(Image2 image, Rect src, Rect dest)
{
  var jsImg = fan.fwt.FwtEnvPeer.loadImage(fanImg);
  if (jsImg.width > 0 && jsImg.height > 0)
    this.cx.drawImage(jsImg, src.m_x, src.m_y, src.m_w, src.m_h, dst.m_x, dst.m_y, dst.m_w, dst.m_h)
  return this;
}

fan.fwt.Graphics.prototype.drawPath = function(path)
{
  fan.fwt.Graphics.doJsPath(this.cx, path);
  this.cx.stroke();
  return this;
}

fan.fwt.Graphics.prototype.fillPath = function(path)
{
  fan.fwt.Graphics.doJsPath(this.cx, path);
  this.cx.fill();
  return this;
}

fan.fwt.Graphics.prototype.drawPolyline2 = function(p)
{
  this.cx.beginPath();
  var size = p.size();
  var x;
  var y;
  for (var i=0; i < size; i+=2)
  {
    x = p.get(i);
    y = p.get(i+1);
    if (i == 0) this.cx.moveTo(x, y);
    else this.cx.lineTo(x, y);
  }
  this.cx.stroke();
  return this;
}

fan.fwt.Graphics.prototype.fillPolygon2 = function(p)
{
  this.cx.beginPath();
  var size = p.size();
  var x;
  var y;
  for (var i=0; i < size; i+=2)
  {
    x = p.get(i);
    y = p.get(i+1);
    if (i == 0) this.cx.moveTo(x, y);
    else this.cx.lineTo(x, y);
  }
  this.cx.closePath();
  this.cx.fill();
  return this;
}

fan.fwt.Graphics.prototype.setTransform = function(trans)
{
  fan.fwt.Graphics.doJsTransform(this.cs, trans);
  return this;
}

fan.fwt.Graphics.prototype.setClipping = function(path)
{
  fan.fwt.Graphics.doJsPath(this.cx, path);
  this.cx.clip();
  return this;
}


//////////////////////////////////////////////////////////////////////////
// Util
//////////////////////////////////////////////////////////////////////////

fan.fwt.Graphics.doJsPath = function(cx, path)
{
  var size = path.steps().size();
  cx.beginPath();

  for (var i =0; i < size; ++i)
  {
    var step = path.steps().get(i);

    if (step instanceof fan.gfx2.PathMoveTo)
    {
      cx.moveTo(s.x, s.y);
    }
    else if (step instanceof fan.gfx2.PathLineTo)
    {
      cx.lineTo(s.x, s.y);
    }
    else if (step instanceof fan.gfx2.PathQuadTo)
    {
      cx.quadraticCurveTo(s.cx, s.cy, s.x, s.y);
    }
    else if (step instanceof fan.gfx2.PathCubicTo)
    {
      cx.bezierCurveTo(s.cx1, s.cy1, s.cx2, s.cy2, s.x, s.y);
    }
    else if (step instanceof fan.gfx2.PathClose)
    {
      cs.closePath();
    }
    else
    {
      throw fan.sys.Err.make("unreachable");
    }
  }
}

fan.fwt.Graphics.doJsTransform = function(cx, trans)
{
  cx.setTransform(
       trans.get(0,0),
       trans.get(1,0),
       trans.get(0,1),
       trans.get(1,1),
       trans.get(2,0),
       trans.get(2,1)
     );
}