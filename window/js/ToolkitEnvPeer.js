//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanvasWindow.ToolkitEnvPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanvasWindow.ToolkitEnvPeer.prototype.$ctor = function(self) {}

fan.fanvasWindow.ToolkitEnvPeer.init = function() {
   fan.concurrent.Actor.locals().set("fanvasGraphics.env", new fan.fanvasWindow.GfxEnv());
   fan.concurrent.Actor.locals().set("fanvasWindow.env", new fan.fanvasWindow.Toolkit());
}

fan.fanvasWindow.Toolkit.prototype.window = function(view) {
  if (view) {
   this.m_curWindow = fan.fanvasWindow.WtkWindow.make(view);
   this.m_curWindow.show(null);
  }
  return this.m_curWindow;
}

fan.fanvasWindow.Toolkit.prototype.name = function() {
  return "HTML5"
}

fan.fanvasWindow.Toolkit.prototype.$name = function() {
  return "HTML5"
}

fan.fanvasWindow.Toolkit.prototype.callLater = function(delay, callback)
{
  window.setTimeout(function(){ callback.call(); }, delay);
}