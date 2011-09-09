//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.gfx2Imp.FwtEnv2 = fan.sys.Obj.$extend(fan.sys.GfxEnv2);
fan.gfx2Imp.FwtEnv2.prototype.$ctor = function(self) {}

fan.gfx2Imp.FwtEnv2.prototype.fromUri = function(uri, onLoaded)
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
fan.gfx2Imp.FwtEnv2.prototype.makePixmap = function(size)
{
  return fan.gfx2Imp.PixmapImp.make(size);
}
fan.gfx2Imp.FwtEnv2.prototype.contains = function(path, x, y)
{
  var canvas = document.createElement("canvas");
  var cx = canvas.getContext("2d");
  fan.gfx2Imp.Graphics2.doJsPath(cx, path);
  return cx.isPointInPath(x, y);
}