//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.fgfxWtk.Image = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxWtk.Image.prototype.$ctor = function() {}
fan.fgfxWtk.Image.prototype.$typeof = function()
{
  return fan.fgfxGraphics.BufImage.$type;
}

//field
fan.fgfxWtk.Image.prototype.m_canvas = null;

//cache field
fan.fgfxWtk.Image.prototype.m_imageData = null; //image data
fan.fgfxWtk.Image.prototype.m_image = null; //image element
fan.fgfxWtk.Image.prototype.m_context  = null; //canvas rendering context
fan.fgfxWtk.Image.prototype.m_graphics = null; //fgfxGraphics graphics context

//loaded info
fan.fgfxWtk.Image.prototype.m_isLoaded = false;
fan.fgfxWtk.Image.prototype.isLoaded = function() { return this.m_isLoaded; }
fan.fgfxWtk.Image.prototype.m_uri = null;

//image data pixcel be modify
fan.fgfxWtk.Image.prototype.m_imageChanged = false;

//size
fan.fgfxWtk.Image.prototype.m_size = null;
fan.fgfxWtk.Image.prototype.size = function() { return this.m_size; }

//////////////////////////////////////////////////////////////////////////
// Image Load
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.Image.prototype.getImage = function()
{
  if (!this.m_isLoaded)
  {
    return this.m_image;
  }

  this.flush();
  return this.m_canvas;
}

fan.fgfxWtk.Image.prototype.initFromImage = function(image)
{
  this.m_canvas = document.createElement("canvas");
  this.m_size = fan.fgfxGraphics.Size.make(image.width, image.height);
  this.m_canvas.width = this.m_size.m_w;
  this.m_canvas.height = this.m_size.m_h;

  this.context().drawImage(this.m_image, 0, 0);
  this.m_isLoaded = true;
}

fan.fgfxWtk.Image.fromUri = function(uri, onLoaded)
{
  var p = new fan.fgfxWtk.Image();
  p.m_uri = uri;
  p.m_isLoaded = false;
  var image = new Image();
  p.m_image = image;

  fan.fgfxWtk.GfxUtil.addEventListener(image, "load", function(){
    p.initFromImage(image);
    onLoaded.call(p);
  });
  image.src = fan.fgfxWtk.GfxUtil.uriToImageSrc(p.m_uri);
  return p;
}

//////////////////////////////////////////////////////////////////////////
// Pixel of Image Data
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.Image.prototype.flush = function()
{
  if (this.m_imageData && this.m_imageChanged)
  {
    this.context().putImageData(this.m_imageData, 0, 0);
    this.m_imageChanged = false;
  }
}

fan.fgfxWtk.Image.prototype.getImageData = function()
{
  if (!this.m_imageData)
  {
    this.m_imageData = this.context().getImageData(0, 0, this.m_size.m_w, this.m_size.m_h);
  }
  return this.m_imageData;
}

fan.fgfxWtk.Image.prototype.getPixel = function(x, y)
{
  var index = (y * this.getImageData().width + x)*4;
  var r = this.getImageData().data[index];
  var g = this.getImageData().data[index +1];
  var b = this.getImageData().data[index +2];
  var a = this.getImageData().data[index +3];
  //return fan.gfx.Color.makeArgb(a, r, g, b);
  return (a << 24) | (r << 16) | (g << 8) | b
}

fan.fgfxWtk.Image.prototype.setPixel = function(x, y, value)
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

fan.fgfxWtk.Image.prototype.context = function()
{
  if (!this.m_context)
  {
    this.m_context = this.m_canvas.getContext("2d");
  }
  return this.m_context;
}

fan.fgfxWtk.Image.make = function(size)
{
  var p = new fan.fgfxWtk.Image();
  p.m_size = size;
  p.m_canvas = document.createElement("canvas");
  p.m_canvas.width = size.m_w;
  p.m_canvas.height = size.m_h;
  p.m_isLoaded = true;
  p.m_uri = p.m_canvas.toDataURL();
  return p;
}

fan.fgfxWtk.Image.prototype.graphics = function()
{
  this.flush();
  if (!this.m_graphics)
  {
    //create cx
    var g = new fan.fgfxWtk.WtkGraphics();
    var rect = new fan.fgfxGraphics.Rect.make(0,0, this.m_size.m_w, this.m_size.m_h);
    g.init(this.context(), rect);
    this.m_graphics = g;
  }
  return this.m_graphics;
}

//////////////////////////////////////////////////////////////////////////
// Other
//////////////////////////////////////////////////////////////////////////

fan.fgfxWtk.Image.prototype.toConst = function()
{
  throw fan.sys.UnsupportedErr.make();
}

fan.fgfxWtk.Image.prototype.save = function(out, format)
{
  //TODO
}


