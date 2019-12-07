//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.vaseOpenGl.GlImagePeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.vaseOpenGl.GlImagePeer.prototype.$ctor = function(self) {}

fan.vaseOpenGl.GlImagePeer.prototype.load = function(self, func)
{
  this.image = new Image();
  this.image.onload = function()
  {
    func.call(self);
  }
  this.image.src = self.m_uri.toStr();
}

fan.vaseOpenGl.GlImagePeer.prototype.width = function(self)
{
  return self.peer.image.width;
}

fan.vaseOpenGl.GlImagePeer.prototype.height = function(self)
{
  return self.peer.image.height;
}