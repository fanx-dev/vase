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
  var p = new fan.gfx2Imp.PixmapImp();
  p.m_uri = uri;

  var image = new Image();
  image.onload = function()
  {
    p.m_image = image;
    p.m_size = fan.gfx.Size.make(image.width, image.height);
    p.m_isLoaded = true;
    onLoaded.call(p);
  }
  image.src = fan.fwt.WidgetPeer.uriToImageSrc(p.m_uri);
  return p;
}

fan.fanWt.GfxEnv.prototype.makeImage = function(size)
{
  return fan.gfx2Imp.PixmapImp.make(size);
}

fan.fanWt.GfxEnv.prototype.contains = function(path, x, y)
{
  var canvas = document.createElement("canvas");
  var cx = canvas.getContext("2d");
  fan.gfx2Imp.Graphics2.doJsPath(cx, path);
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

//////////////////////////////////////////////////////////////////////////
// Font
//////////////////////////////////////////////////////////////////////////
//   2 Jun 09  Andy Frank  Creation


