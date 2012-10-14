//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fgfxWtk.GfxEnv = fan.sys.Obj.$extend(fan.fgfx2d.GfxEnv);
fan.fgfxWtk.GfxEnv.prototype.$ctor = function() {}

fan.fgfxWtk.GfxEnv.prototype.fromUri = function(uri, onLoaded)
{
  return fan.fgfxWtk.Image.fromUri(uri, onLoaded);
}

fan.fgfxWtk.GfxEnv.prototype.makeConstImage = function(uri)
{
  var p = new fan.fgfxWtk.ConstImage();
  p.m_uri = uri;
  var image = new Image();
  p.m_image = image;

  fan.fgfxWtk.GfxUtil.addEventListener(image, "load", function(){
    p.m_size = fan.fgfx2d.Size.make(image.width, image.height);
    p.m_isLoaded = true;
  });
  image.src = fan.fgfxWtk.GfxUtil.uriToImageSrc(p.m_uri);
  return p;
}

fan.fgfxWtk.GfxEnv.prototype.makeImage = function(size)
{
  return fan.fgfxWtk.Image.make(size);
}

fan.fgfxWtk.GfxEnv.prototype.contains = function(path, x, y)
{
  var canvas = document.createElement("canvas");
  var cx = canvas.getContext("2d");
  fan.fgfxWtk.GfxUtil.doJsPath(cx, path);
  return cx.isPointInPath(x, y);
}

fan.fgfxWtk.GfxEnv.prototype.makeFont = function(func)
{
  var font = new fan.fgfx2d.Font();
  func.call(font);
  return font;
}

fan.fgfxWtk.GfxEnv.prototype.makePointArray = function(func)
{
  return fan.fgfxWtk.PointArray.make();
}