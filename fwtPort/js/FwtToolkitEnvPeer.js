//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fgfxFwt.FwtToolkitEnvPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxFwt.FwtToolkitEnvPeer.prototype.$ctor = function(self) {}

fan.fgfxFwt.FwtToolkitEnvPeer.initGfxEnv = function() {
   fan.concurrent.Actor.locals().set("fgfxGraphics.env", new fan.fgfxWtk.GfxEnv());
}

fan.fgfxFwt.FwtToolkitEnvPeer.toGraphics = function(fg) {
  var g = new fan.fgfxWtk.Graphics();
  g.widget = fg.widget;
  g.size = fg.size;
  g.cx = fg.cx;
  g.m_clip = fg.m_clip;
  g.cx.textBaseline = "alphabetic";
  fg.widget.invalid = function()
  {
    fan.fwt.FwtEnvPeer.$win = this;
    fan.fwt.FwtEnvPeer.$needRelayout = true;
  }
  return g;
}