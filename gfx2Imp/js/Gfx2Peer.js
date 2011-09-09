//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-20  Jed Young  Creation
//

fan.gfx2Imp.Gfx2Peer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.gfx2Imp.Gfx2Peer.prototype.$ctor = function(self) {}

fan.gfx2Imp.Gfx2Peer.env = new FwtEnv2();

fan.gfx2Imp.Gfx2Peer.getEngine = function(name)
{
  return fan.gfx2Imp.Gfx2Peer.env;
}
fan.gfx2Imp.Gfx2Peer.getEngine2 = function(name)
{
  return fan.gfx2Imp.Gfx2Peer.env;
}