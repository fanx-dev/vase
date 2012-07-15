//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanWt.ToolkitEnvPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanWt.ToolkitEnvPeer.prototype.$ctor = function(self) {}

fan.fanWt.ToolkitEnvPeer.init = function() {
   fan.concurrent.Actor.locals().set("fan2d.env", new fan.fanWt.GfxEnv());
   fan.concurrent.Actor.locals().set("fanWt.env", new fan.fanWt.Toolkit());
}

fan.fanWt.Toolkit.prototype.build = function(view) {
   var win = new fan.fanWt.JsWindow();
   win.view = view;
   return win;
}