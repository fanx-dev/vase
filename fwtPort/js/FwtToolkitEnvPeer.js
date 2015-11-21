//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanvasFwt.FwtToolkitEnvPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanvasFwt.FwtToolkitEnvPeer.prototype.$ctor = function(self) {}

fan.fanvasFwt.FwtToolkitEnvPeer.initGfxEnv = function() {
   fan.concurrent.Actor.locals().set("fanvasGraphics.env", new fan.fanvasWindow.GfxEnv());
}

fan.fanvasFwt.FwtToolkitEnvPeer.toGraphics = function(fg) {
  var g = new fan.fanvasWindow.Graphics();
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