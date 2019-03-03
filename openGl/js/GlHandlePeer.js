//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fanvasOpenGl.GlHandlePeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanvasOpenGl.GlHandlePeer.prototype.$ctor = function(self) {}
fan.fanvasOpenGl.GlHandlePeer.prototype.value = null;
fan.fanvasOpenGl.GlHandlePeer.prototype.val = function(self){ return this.value; }

fan.fanvasOpenGl.GlHandlePeer.prototype.getValue = function(){ return this.value; }
fan.fanvasOpenGl.GlHandlePeer.prototype.setValue = function(v){ this.value = v; }

