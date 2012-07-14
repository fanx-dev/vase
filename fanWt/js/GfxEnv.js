//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanWt.GfxEnv = fan.sys.Obj.$extend(fan.fan2d.GfxEnv);
fan.fanWt.GfxEnv.prototype.$ctor = function() {}

fan.fanWt.GfxEnv.prototype.fromUri = function(uri, onLoaded)
{
  var p = new fan.fanWt.Image();
  p.m_uri = uri;
  var image = new Image();
  p.m_image = image;

  fan.fanWt.GfxUtil.addEventListener(image, "load", function(){
    p.m_size = fan.gfx.Size.make(image.width, image.height);
    p.m_isLoaded = true;
    onLoaded.call(p);
  });
  image.src = fan.fanWt.GfxUtil.uriToImageSrc(p.m_uri);
  return p;
}

fan.fanWt.GfxEnv.prototype.makeImage = function(size)
{
  return fan.fanWt.Image.make(size);
}

fan.fanWt.GfxEnv.prototype.contains = function(path, x, y)
{
  var canvas = document.createElement("canvas");
  var cx = canvas.getContext("2d");
  fan.fanWt.GfxUtil.doJsPath(cx, path);
  return cx.isPointInPath(x, y);
}

fan.fanWt.GfxEnv.prototype.makeFont = function(func)
{
  var font = new fan.fan2d.Font();
  func.call(font);
  return font;
}

fan.fanWt.GfxEnv.prototype.makePointArray = function(func)
{
  return new fan.fanWt.PointArray();
}