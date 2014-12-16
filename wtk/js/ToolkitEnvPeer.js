//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fgfxWtk.ToolkitEnvPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxWtk.ToolkitEnvPeer.prototype.$ctor = function(self) {}

fan.fgfxWtk.ToolkitEnvPeer.init = function() {
   fan.concurrent.Actor.locals().set("fgfxGraphics.env", new fan.fgfxWtk.GfxEnv());
   fan.concurrent.Actor.locals().set("fgfxWtk.env", new fan.fgfxWtk.Toolkit());
}

fan.fgfxWtk.Toolkit.prototype.build = function() {
   var win = new fan.fgfxWtk.JsWindow();
   fan.fgfxWtk.ToolkitEnvPeer.win = win;
   return win;
}

fan.fgfxWtk.Toolkit.prototype.name = function() {
  return "HTML5"
}

fan.fgfxWtk.Toolkit.prototype.$name = function() {
  return "HTML5"
}

fan.fgfxWtk.Toolkit.prototype.callLater = function(delay, callback)
{
  window.setTimeout(function(){ callback.call(); }, delay);
}