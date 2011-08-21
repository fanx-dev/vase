//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.gfx2Imp.FwtEnv2Peer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.gfx2Imp.FwtEnv2Peer.prototype.$ctor = function(self) {}

fan.gfx2Imp.FwtEnv2Peer.prototype.fromUri = function(self, uri)
{
  var p = new fan.gfx2Imp.PixmapImp();
  p.m_uri = uri;
  return p;
}
fan.gfx2Imp.FwtEnv2Peer.prototype.makePixmap = function(self, size)
{
  var p = new fan.gfx2Imp.PixmapImp();
  p.m_size = size;
  return p;
}
fan.gfx2Imp.FwtEnv2Peer.prototype.contains = function(self, path, x, y)
{
  var canvas = document.createElement("canvas");
  var cx = canvas.getContext("2d");
  fan.gfx2Imp.Graphics2.doJsPath(cx, path);
  return cx.isPointInPath(x, y);
}