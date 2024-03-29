//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.vaseWindow.Image = fan.sys.Obj.$extend(fan.vaseGraphics.Image);
fan.vaseWindow.Image.prototype.$ctor = function() {}
fan.vaseWindow.Image.prototype.$typeof = function()
{
  return fan.vaseGraphics.Image.$type;
}

//field
fan.vaseWindow.Image.prototype.m_canvas = null;

//cache field
fan.vaseWindow.Image.prototype.m_imageData = null; //image data
fan.vaseWindow.Image.prototype.m_image = null; //image element
fan.vaseWindow.Image.prototype.m_context  = null; //canvas rendering context

//loaded info
fan.vaseWindow.Image.prototype.m_isLoaded = false;
fan.vaseWindow.Image.prototype.isLoaded = function() { return this.m_isLoaded; }
fan.vaseWindow.Image.prototype.isReady = function() { return this.m_isLoaded; }
fan.vaseWindow.Image.prototype.m_uri = null;

//image data pixcel be modify
fan.vaseWindow.Image.prototype.m_imageChanged = false;

//size
fan.vaseWindow.Image.prototype.m_w = null;
fan.vaseWindow.Image.prototype.m_h = null;
fan.vaseWindow.Image.prototype.size = function() { return fan.vaseGraphics.Size.make(this.m_w, this.m_h); }
fan.vaseWindow.Image.prototype.width = function() { return this.m_w; }
fan.vaseWindow.Image.prototype.height = function() { return this.m_h; }

//////////////////////////////////////////////////////////////////////////
// Image Load
//////////////////////////////////////////////////////////////////////////

fan.vaseWindow.Image.prototype.getImage = function()
{
  if (this.m_canvas)
  {
    this.flush();
    return this.m_canvas;
  }
  return this.m_image;
}

fan.vaseWindow.Image.prototype.initCanvas = function()
{
  if (this.m_canvas) return this.m_canvas;
  if (!this.m_isLoaded) return null;

  this.m_canvas = document.createElement("canvas");
  //if (!this.m_size) this.m_size = fan.vaseGraphics.Size.make(this.m_image.width, this.m_image.height);
  this.m_canvas.width = this.width();
  this.m_canvas.height = this.height();

  if (!this.m_uri) this.m_uri = this.m_canvas.toDataURL();

  this.m_context = this.m_canvas.getContext("2d");
  if (this.m_image) this.m_context.drawImage(this.m_image, 0, 0);
  return this.m_canvas;
}

fan.vaseWindow.Image.fromUri = function(uri, options, onLoaded)
{
  var p = new fan.vaseWindow.Image();
  p.m_uri = uri;
  p.m_isLoaded = false;
  var image = new Image();
  p.m_image = image;
  p.m_w = 0;
  p.m_h = 0;

  fan.vaseWindow.GfxUtil.addEventListener(image, "load", function(){
    //p.initFromImage(image);
    p.m_w = p.m_image.width;
    p.m_h = p.m_image.height;
    p.m_isLoaded = true;
    if (onLoaded) onLoaded.call(p);
  });
  image.src = fan.vaseWindow.GfxUtil.uriToImageSrc(p.m_uri);
  return p;
}

//////////////////////////////////////////////////////////////////////////
// Pixel of Image Data
//////////////////////////////////////////////////////////////////////////

fan.vaseWindow.Image.prototype.flush = function()
{
  if (this.m_imageData && this.m_imageChanged)
  {
    this.context().putImageData(this.m_imageData, 0, 0);
    this.m_imageChanged = false;
  }
}

fan.vaseWindow.Image.prototype.getImageData = function()
{
  if (!this.m_imageData)
  {
    this.m_imageData = this.context().getImageData(0, 0, this.width(), this.height());
  }
  return this.m_imageData;
}

fan.vaseWindow.Image.prototype.getPixel = function(x, y)
{
  if (!this.m_isLoaded) return 0;
  var index = (y * this.getImageData().width + x)*4;
  var r = this.getImageData().data[index];
  var g = this.getImageData().data[index +1];
  var b = this.getImageData().data[index +2];
  var a = this.getImageData().data[index +3];
  //return fan.gfx.Color.makeArgb(a, r, g, b);
  return (a << 24) | (r << 16) | (g << 8) | b
}

fan.vaseWindow.Image.prototype.setPixel = function(x, y, value)
{
  if (!this.m_isLoaded) return;
  var index = (y * this.getImageData().width + x)*4;
  var r = (value >> 16) & 0xff;
  var g = (value >> 8) & 0xff;
  var b = value & 0xff;
  var a = (value >> 24) & 0xff;
  this.getImageData().data[index]   = r
  this.getImageData().data[index+1] = g
  this.getImageData().data[index+2] = b
  this.getImageData().data[index+3] = a;

  this.m_imageChanged = true;
}

//////////////////////////////////////////////////////////////////////////
// Graphics
//////////////////////////////////////////////////////////////////////////

fan.vaseWindow.Image.prototype.context = function()
{
  this.initCanvas();
  return this.m_context;
}

fan.vaseWindow.Image.make = function(w, h)
{
  var p = new fan.vaseWindow.Image();
  p.m_w = w;
  p.m_h = h;
  p.m_isLoaded = true;
  p.initCanvas();
  return p;
}

fan.vaseWindow.Image.prototype.createGraphics = function()
{
  if (!this.m_isLoaded) return null;
  this.initCanvas();
  this.flush();

  //reset context
  this.m_context.resetTransform();

  //create cx
  var g = new fan.vaseWindow.WtkGraphics();
  var rect = new fan.vaseGraphics.Rect.make(0,0, this.width(), this.height());
  g.init(this.context(), rect);
  g.push();
  g.m_needPop = true;
  return g;
}

//////////////////////////////////////////////////////////////////////////
// Other
//////////////////////////////////////////////////////////////////////////


fan.vaseWindow.Image.prototype.save = function(out, format)
{
  //TODO
}


