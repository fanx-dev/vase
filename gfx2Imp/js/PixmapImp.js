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
fan.gfx2Imp.PixmapImp.prototype.m_isLoaded = false;
fan.gfx2Imp.PixmapImp.prototype.m_uri = null;
fan.gfx2Imp.PixmapImp.prototype.m_imageChanged = false;
fan.gfx2Imp.PixmapImp.prototype.m_painted = false;

fan.gfx2Imp.PixmapImp.prototype.m_size = null;
fan.gfx2Imp.PixmapImp.prototype.size = function() { return this.m_size; }

fan.gfx2Imp.PixmapImp.prototype.getImage = function(widget)
{
  if (this.m_image && !this.m_imageChanged)
  {
    this.m_imageChanged = false;
    return this.m_image;
  }

  if (!this.m_isImageData && !this.m_isLoaded)
  {
    fan.fwt.FwtEnvPeer.loadImage(this, widget);
    return;
  }

  var canvas = this.getCanvas();
  if(!this.m_painted)
  {
    this.m_cx = canvas.getContext("2d");
    this.m_cx.putImageData(this.m_imageData, 0, 0);
    this.m_painted = false;
  }
  this.m_uri = fan.sys.Uri.fromStr(canvas.toDataURL());

  this.m_image = fan.fwt.FwtEnvPeer.loadImage(this, widget);
  return this.m_image;
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
  p.m_cx = p.m_canvas.getContext("2d");
  p.m_imageData = p.m_cx.getImageData(0, 0, size.m_w, size.m_h);
  p.m_isImageData = true;
  p.m_isLoaded = true;
  return p;
}

fan.gfx2Imp.PixmapImp.prototype.getPixel = function(x, y)
{
  var index = (y * this.getImageData().width + x)*4;
  var r = this.getImageData().data[index];
  var g = this.getImageData().data[index +1];
  var b = this.getImageData().data[index +2];
  var a = this.getImageData().data[index +3];
  return fan.gfx.Color.makeArgb(a, r, g, b);
}

fan.gfx2Imp.PixmapImp.prototype.setPixel = function(x, y, value)
{
  var index = (y * this.getImageData().width + x)*4;
  this.getImageData().data[index] = value.r();
  this.getImageData().data[index+1] = value.g();
  this.getImageData().data[index+2] = value.b();
  this.getImageData().data[index+3] = value.a();

  this.m_imageChanged = true;
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
  var imageData = this.m_imageData;
  var image = this.m_image;
  g.paint(canvas, fan.gfx.Rect.make(0, 0, this.m_size.m_w, this.m_size.m_h), function()
  {
    if (imageData)
     g.cx.putImageData(imageData, 0, 0);
    else if(image)
     g.cx.drawImage(image, 0, 0);
  });
  this.m_painted = true;
  this.m_imageChanged = true;
  return g;
}

fan.gfx2Imp.PixmapImp.prototype.flush = function()
{
  this.m_uri = fan.sys.Uri.fromStr(canvas.toDataURL());
  this.m_image = fan.fwt.FwtEnvPeer.loadImage(this, widget);
}

fan.gfx2Imp.PixmapImp.prototype.save = function(out, format)
{
  //TODO
}

fan.gfx2Imp.PixmapImp.prototype.isLoaded = function() { return this.m_isLoaded; }

