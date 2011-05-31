//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

//************************************************************************
// GlEnumPeer
//************************************************************************

fan.fogl.GlEnumPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.GlEnumPeer.prototype.$ctor = function(self) {}
fan.fogl.GlEnumPeer.prototype.m_val = null;

fan.fogl.GlEnumPeer.prototype.mix = function(self, e)
{
  e2 = GlEnum.make();
  e2.peer.m_val = this.m_val | e.peer.m_val
  return e2;
}

//************************************************************************
// GlEnumFactoryPeer
//************************************************************************

fan.fogl.GlEnumFactoryPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.GlEnumFactoryPeer.prototype.$ctor = function(self) {}

fan.fogl.GlEnumFactoryPeer.prototype.deepTest = function(self)
{
  e = GlEnum.make();
  e.peer.m_val = self.m_gl.DEPTH_TEST;
  return e;
}