//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.gfx2Imp.PixmapImp = fan.sys.Obj.$extend(fan.sys.Obj);
fan.gfx2Imp.PixmapImp.prototype.$ctor = function() {}

fan.gfx2Imp.PixmapImp.prototype.$typeof = function()
{
  return fan.gfx2.Pixmap.$type;
}

fan.gfx2Imp.PixmapImp.prototype.m_imageData = null;
fan.gfx2Imp.PixmapImp.prototype.m_image = null;
fan.gfx2Imp.PixmapImp.prototype.m_isImageData = false;
fan.gfx2Imp.PixmapImp.prototype.m_uri = null;

fan.gfx2Imp.PixmapImp.prototype.m_size = null;
fan.gfx2Imp.PixmapImp.prototype.size = function() { return this.m_size; }

fan.gfx2Imp.PixmapImp.prototype.getImage = function(f)
{
  if (this.m_image)
  {
    f.call();
    return;
  }

  var canvas = this.getCanvas();
  this.m_cx = canvas.getContext("2d");
  this.m_cx.putImageData(m_imageData, 0, 0);
  this.m_uri = canvas.toDataURL();

  var image = new Image();
  image.onload = function()
  {
    f.call();
  }
  this.m_image = image;
  image.src = this.m_uri;
}

fan.gfx2Imp.PixmapImp.prototype.getImageData = function()
{
  if (this.m_imageData) return this.m_imageData;

  var canvas = this.getCanvas();
  this.m_cx = canvas.getContext("2d");
  if (this.m_image) this.m_cx.drawImage(this.m_image, 0, 0);
  this.m_imageData = this.m_cx.getImageData(0, 0, this.m_size.m_w, this.m_size.m_h);
  return this.m_imageData;
}

fan.gfx2Imp.PixmapImp.make = function(size)
{
  var p = new fan.gfx2Imp.PixmapImp();
  p.m_size = size;
  p.m_canvas = document.createElement("canvas");
  p.m_canvas.width = size.m_w;
  p.m_canvas.height = size.m_h;
  p.m_cx = canvas.getContext("2d");
  p.m_imageData = cx.getImageData(0, 0, size.m_w, size.m_h);
  p.m_isImageData = true;
  return p;
}

fan.gfx2Imp.PixmapImp.prototype.getPixel = function(x, y)
{
  var index = x * this.getImageData().width + y;
  var rgba = this.m_imageData.data[index];

  var a = rgba & 0xff;
  var rgb = rgba >> 8;
  var argb = (a << 24) | rgb;
  return fan.gfx.Color.makeArgb(argb);
}

fan.gfx2Imp.PixmapImp.prototype.setPixel = function(x, y, value)
{
  var argb = value.m_argb;
  var aMask = 0xff << 24;
  var a = aMask & argb;
  var rgb = (~aMask) & argb
  var rgba = (rgb << 8) | a;

  var index = x * this.getImageData().width + y;
  var rgba = this.getImageData().data[index] = rgba;
}

fan.gfx2Imp.PixmapImp.prototype.toImage = function()
{
  throw fan.sys.UnsupportedErr.make();
}

fan.gfx2Imp.PixmapImp.prototype.getCanvas = function()
{
  if (!this.m_canvas)
  {
    this.m_canvas = document.createElement("canvas");
    this.m_canvas.width = this.m_size.m_w;
    this.m_canvas.height = this.m_size.m_h;
  }
  return this.m_canvas;
}

fan.gfx2Imp.PixmapImp.prototype.graphics = function()
{
  var canvas = this.getCanvas();
  var g = new fan.gfx2Imp.Graphics2();
  var isImageData = this.m_isImageData;
  var image = this.m_isImageData ? this.m_imageData : this.m_image;
  g.paint(canvas, fan.gfx.Rect.make(0, 0, this.m_size.m_w, this.m_size.m_h), function()
  {
    if (isImageData)
     g.putImageData(image, 0, 0);
    else
     g.drawImage(image, 0, 0);
  });
  return g;
}

fan.gfx2Imp.PixmapImp.prototype.save = function(out, format)
{
  //TODO
}

fan.gfx2Imp.PixmapImp.prototype.load = function(f)
{
  if (this.m_isImageData) { f.call(this); return; }

  var image = new Image();
  var p = this;
  image.onload = function()
  {
    p.m_size = fan.gfx.Size.make(image.width, image.height);
    f.call(this);
  }
  this.m_image = image;
  image.src = fan.fwt.WidgetPeer.uriToImageSrc(this.m_uri);
}