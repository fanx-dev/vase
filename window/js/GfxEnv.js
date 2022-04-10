//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.vaseWindow.GfxEnv = fan.sys.Obj.$extend(fan.vaseGraphics.GfxEnv);
fan.vaseWindow.GfxEnv.prototype.$ctor = function() {}

fan.vaseWindow.GfxEnv.m_instance = new fan.vaseWindow.GfxEnv();

fan.vaseWindow.GfxEnv.prototype.fromUri = function(uri, options, onLoaded)
{
  return fan.vaseWindow.Image.fromUri(uri, options, onLoaded);
}

fan.vaseWindow.GfxEnv.prototype.makeImage = function(w, h)
{
  return fan.vaseWindow.Image.make(w, h);
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