//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

fan.fanWt.ToolkitEnvPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanWt.ToolkitEnvPeer.prototype.$ctor = function(self) {}

fan.fanWt.ToolkitEnvPeer.prototype.build = function(self, view) {
   var win = new fan.fanWt.Window();
   win.view = view;
   return win;
}