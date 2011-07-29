//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.ImagePeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.ImagePeer.prototype.$ctor = function(self) {}

fan.fogl.ImagePeer.prototype.load = function(self, func)
{
  this.image = new Image();
  this.image.onload = function()
  {
    func.call(self);
  }
  this.image.src = self.m_uri.toStr();
}

