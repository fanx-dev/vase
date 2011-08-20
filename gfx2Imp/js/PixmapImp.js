//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.gfx2Imp.PixmapImp = fan.sys.Obj.$extend(fan.sys.Obj);
fan.gfx2Imp.PixmapImp.prototype.$ctor = function() {}

fan.gfx2Imp.PixmapImp.prototype.imageData = null;
fan.gfx2Imp.PixmapImp.prototype.image = null;
fan.gfx2Imp.PixmapImp.prototype.loaded = false;

fan.gfx2Imp.PixmapImp.prototype.m_size = null;
fan.gfx2Imp.PixmapImp.prototype.size = function() { return m_size; }

fan.gfx2Imp.PixmapImp.prototype.getImage = function()
{
  return image;
}

fan.gfx2Imp.PixmapImp.prototype.getPixel = function(x, y)
{
  var index = x * this.imageData.width + y;
  var rgba = this.imageData.data[index];

  var a = rgba & 0xff;
  var rgb = rgba >> 8;
  var argb = (a << 24) | rgb;
  return fan.gfx.Color.makeArgb(argb);
}

fan.gfx2Imp.PixmapImp.prototype.setPixel = function(x, y, value)
{
  var argb = value.argb();
  var aMask = 0xff << 24;
  var a = aMask & argb;
  var rgb = (~aMask) & argb
  var rgba = (rgb << 8) | a;

  var index = x * this.imageData.width + y;
  var rgba = this.imageData.data[index] = rgba;
}

fan.gfx2Imp.PixmapImp.prototype.toImage = function()
{
  throw fan.sys.UnsupportedErr.make();
}

fan.gfx2Imp.PixmapImp.fromUri = function(uri)
{
  var p = new fan.gfx2Imp.PixmapImp();
  p.image = new Image();
  p.image.onload = function()
  {
    loaded = true;
  }
  p.image.src = self.m_uri.toStr();
}

fan.gfx2Imp.PixmapImp.make = function(size)
{
  var p = new fan.gfx2Imp.PixmapImp();
  p.m_size = size;
  return p;
}

fan.gfx2Imp.PixmapImp.graphics = function()
{
  var canvas = document.createElement("canvas");
  canvas.width = this.m_size.m_w;
  canvas.height = this.m_size.m_h;

  var g = new fan.fwt.Graphics();
  g.paint(canvas, fan.gfx.Rect.make(0, 0, this.m_size.m_w, this.m_size.m_h), function() {})
  return g;
}

fan.gfx2Imp.PixmapImp.prototype.save = function(out, format)
{
  //TODO
}