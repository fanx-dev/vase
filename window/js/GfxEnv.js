//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.vaseWindow.GfxEnv = fan.sys.Obj.$extend(fan.vaseGraphics.GfxEnv);
fan.vaseWindow.GfxEnv.prototype.$ctor = function() {}

fan.vaseWindow.GfxEnv.prototype.fromUri = function(uri, onLoaded)
{
  return fan.vaseWindow.Image.fromUri(uri, onLoaded);
}

fan.vaseWindow.GfxEnv.prototype.makeConstImage = function(uri)
{
  var p = new fan.vaseWindow.ConstImage();
  p.m_uri = uri;
  var image = new Image();
  p.m_image = image;

  fan.vaseWindow.GfxUtil.addEventListener(image, "load", function(){
    p.m_size = fan.vaseGraphics.Size.make(image.width, image.height);
    p.m_isLoaded = true;
  });
  image.src = fan.vaseWindow.GfxUtil.uriToImageSrc(p.m_uri);
  return p;
}

fan.vaseWindow.GfxEnv.prototype.makeImage = function(size)
{
  return fan.vaseWindow.Image.make(size);
}

fan.vaseWindow.GfxEnv.prototype.contains = function(path, x, y)
{
  var canvas = document.createElement("canvas");
  var cx = canvas.getContext("2d");
  fan.vaseWindow.GfxUtil.doJsPath(cx, path);
  return cx.isPointInPath(x, y);
}

fan.vaseWindow.GfxEnv.prototype.makeFont = function(func)
{
  var font = new fan.vaseGraphics.Font();
  func.call(font);
  return font;
}

fan.vaseWindow.GfxEnv.prototype.makePointArray = function(size)
{
  return fan.vaseWindow.PointArray.make(size);
}