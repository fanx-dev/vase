//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.fanvasWindow.Image = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanvasWindow.Image.prototype.$ctor = function() {}
fan.fanvasWindow.Image.prototype.$typeof = function()
{
  return fan.fanvasGraphics.BufImage.$type;
}

//field
fan.fanvasWindow.Image.prototype.m_canvas = null;

//cache field
fan.fanvasWindow.Image.prototype.m_imageData = null; //image data
fan.fanvasWindow.Image.prototype.m_image = null; //image element
fan.fanvasWindow.Image.prototype.m_context  = null; //canvas rendering context
fan.fanvasWindow.Image.prototype.m_graphics = null; //fanvasGraphics graphics context

//loaded info
fan.fanvasWindow.Image.prototype.m_isLoaded = false;
fan.fanvasWindow.Image.prototype.isLoaded = function() { return this.m_isLoaded; }
fan.fanvasWindow.Image.prototype.m_uri = null;

//image data pixcel be modify
fan.fanvasWindow.Image.prototype.m_imageChanged = false;

//size
fan.fanvasWindow.Image.prototype.m_size = null;
fan.fanvasWindow.Image.prototype.size = function() { return this.m_size; }

//////////////////////////////////////////////////////////////////////////
// Image Load
//////////////////////////////////////////////////////////////////////////

fan.fanvasWindow.Image.prototype.getImage = function()
{
  if (!this.m_isLoaded)
  {
    return this.m_image;
  }

  this.flush();
  return this.m_canvas;
}

fan.fanvasWindow.Image.prototype.initFromImage = function(image)
{
  this.m_canvas = document.createElement("canvas");
  this.m_size = fan.fanvasGraphics.Size.make(image.width, image.height);
  this.m_canvas.width = this.m_size.m_w;
  this.m_canvas.height = this.m_size.m_h;

  this.context().drawImage(this.m_image, 0, 0);
  this.m_isLoaded = true;
}

fan.fanvasWindow.Image.fromUri = function(uri, onLoaded)
{
  var p = new fan.fanvasWindow.Image();
  p.m_uri = uri;
  p.m_isLoaded = false;
  var image = new Image();
  p.m_image = image;

  fan.fanvasWindow.GfxUtil.addEventListener(image, "load", function(){
    p.initFromImage(image);
    onLoaded.call(p);
  });
  image.src = fan.fanvasWindow.GfxUtil.uriToImageSrc(p.m_uri);
  return p;
}

//////////////////////////////////////////////////////////////////////////
// Pixel of Image Data
//////////////////////////////////////////////////////////////////////////

fan.fanvasWindow.Image.prototype.flush = function()
{
  if (this.m_imageData && this.m_imageChanged)
  {
    this.context().putImageData(this.m_imageData, 0, 0);
    this.m_imageChanged = false;
  }
}

fan.fanvasWindow.Image.prototype.getImageData = function()
{
  if (!this.m_imageData)
  {
    this.m_imageData = this.context().getImageData(0, 0, this.m_size.m_w, this.m_size.m_h);
  }
  return this.m_imageData;
}

fan.fanvasWindow.Image.prototype.getPixel = function(x, y)
{
  var index = (y * this.getImageData().width + x)*4;
  var r = this.getImageData().data[index];
  var g = this.getImageData().data[index +1];
  var b = this.getImageData().data[index +2];
  var a = this.getImageData().data[index +3];
  //return fan.gfx.Color.makeArgb(a, r, g, b);
  return (a << 24) | (r << 16) | (g << 8) | b
}

fan.fanvasWindow.Image.prototype.setPixel = function(x, y, value)
{
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

fan.fanvasWindow.Image.prototype.context = function()
{
  if (!this.m_context)
  {
    this.m_context = this.m_canvas.getContext("2d");
  }
  return this.m_context;
}

fan.fanvasWindow.Image.make = function(size)
{
  var p = new fan.fanvasWindow.Image();
  p.m_size = size;
  p.m_canvas = document.createElement("canvas");
  p.m_canvas.width = size.m_w;
  p.m_canvas.height = size.m_h;
  p.m_isLoaded = true;
  p.m_uri = p.m_canvas.toDataURL();
  return p;
}

fan.fanvasWindow.Image.prototype.graphics = function()
{
  this.flush();
  if (!this.m_graphics)
  {
    //create cx
    var g = new fan.fanvasWindow.WtkGraphics();
    var rect = new fan.fanvasGraphics.Rect.make(0,0, this.m_size.m_w, this.m_size.m_h);
    g.init(this.context(), rect);
    this.m_graphics = g;
  }
  return this.m_graphics;
}

//////////////////////////////////////////////////////////////////////////
// Other
//////////////////////////////////////////////////////////////////////////

fan.fanvasWindow.Image.prototype.toConst = function()
{
  throw fan.sys.UnsupportedErr.make();
}

fan.fanvasWindow.Image.prototype.save = function(out, format)
{
  //TODO
}


