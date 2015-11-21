//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanvasWindow.GfxEnv = fan.sys.Obj.$extend(fan.fanvasGraphics.GfxEnv);
fan.fanvasWindow.GfxEnv.prototype.$ctor = function() {}

fan.fanvasWindow.GfxEnv.prototype.fromUri = function(uri, onLoaded)
{
  return fan.fanvasWindow.Image.fromUri(uri, onLoaded);
}

fan.fanvasWindow.GfxEnv.prototype.makeConstImage = function(uri)
{
  var p = new fan.fanvasWindow.ConstImage();
  p.m_uri = uri;
  var image = new Image();
  p.m_image = image;

  fan.fanvasWindow.GfxUtil.addEventListener(image, "load", function(){
    p.m_size = fan.fanvasGraphics.Size.make(image.width, image.height);
    p.m_isLoaded = true;
  });
  image.src = fan.fanvasWindow.GfxUtil.uriToImageSrc(p.m_uri);
  return p;
}

fan.fanvasWindow.GfxEnv.prototype.makeImage = function(size)
{
  return fan.fanvasWindow.Image.make(size);
}

fan.fanvasWindow.GfxEnv.prototype.contains = function(path, x, y)
{
  var canvas = document.createElement("canvas");
  var cx = canvas.getContext("2d");
  fan.fanvasWindow.GfxUtil.doJsPath(cx, path);
  return cx.isPointInPath(x, y);
}

fan.fanvasWindow.GfxEnv.prototype.makeFont = function(func)
{
  var font = new fan.fanvasGraphics.Font();
  func.call(font);
  return font;
}

fan.fanvasWindow.GfxEnv.prototype.makePointArray = function(size)
{
  return fan.fanvasWindow.PointArray.make(size);
}