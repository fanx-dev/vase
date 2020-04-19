//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.vaseWindow.ToolkitEnvPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.vaseWindow.ToolkitEnvPeer.prototype.$ctor = function(self) {}

fan.vaseWindow.ToolkitEnvPeer.init = function() {
   fan.concurrent.Actor.locals().set("vaseGraphics.env", new fan.vaseWindow.GfxEnv());
   fan.concurrent.Actor.locals().set("vaseWindow.env", new fan.vaseWindow.Toolkit());
}

fan.vaseWindow.Toolkit.prototype.window = function(view) {
  if (view) {
   this.m_curWindow = fan.vaseWindow.WtkWindow.make(view);
   this.m_curWindow.show(null);
  }
  return this.m_curWindow;
}

fan.vaseWindow.Toolkit.prototype.name = function() {
  return "HTML5"
}

fan.vaseWindow.Toolkit.prototype.$name = function() {
  return "HTML5"
}

// fan.vaseWindow.Toolkit.prototype.dpi = function() {
//   if (window.devicePixelRatio) {
//     return window.devicePixelRatio * 135;
//   }
//   return 135;
// }

fan.vaseWindow.Toolkit.prototype.density = function() {
  return 0.5;
}

fan.vaseWindow.Toolkit.prototype.callLater = function(delay, callback)
{
  window.setTimeout(function(){ callback.call(); }, delay);
}

fan.vaseWindow.Toolkit.prototype.clipboard = function()
{
  if (!fan.vaseWindow.Toolkit.m_clipboard) {
    fan.vaseWindow.Toolkit.m_clipboard = new fan.vaseWindow.JSClipboard();
  } 
  return fan.vaseWindow.Toolkit.m_clipboard;
}