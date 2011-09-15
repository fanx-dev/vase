//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

//head file
fan.gfx2Imp.FwtEnv2 = fan.sys.Obj.$extend(fan.gfx2.GfxEnv2);
fan.gfx2Imp.FwtEnv2.prototype.$ctor = function(self) {}

fan.gfx2Imp.Gfx2Peer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.gfx2Imp.Gfx2Peer.prototype.$ctor = function(self) {}

fan.gfx2Imp.Gfx2Peer.getEngine = function(name)
{
  if (fan.gfx2Imp.Gfx2Peer.env) return fan.gfx2Imp.Gfx2Peer.env;
  fan.gfx2Imp.Gfx2Peer.env = new fan.fwt.FwtEnv();
  return fan.gfx2Imp.Gfx2Peer.env;
}
fan.gfx2Imp.Gfx2Peer.getEngine2 = function(name)
{
  if (fan.gfx2Imp.Gfx2Peer.env2) return fan.gfx2Imp.Gfx2Peer.env2;
  fan.gfx2Imp.Gfx2Peer.env2 = new fan.gfx2Imp.FwtEnv2();
  return fan.gfx2Imp.Gfx2Peer.env2;
}