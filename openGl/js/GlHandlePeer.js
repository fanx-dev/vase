//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.vaseOpenGl.GlHandlePeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.vaseOpenGl.GlHandlePeer.prototype.$ctor = function(self) {}
fan.vaseOpenGl.GlHandlePeer.prototype.value = null;
fan.vaseOpenGl.GlHandlePeer.prototype.val = function(self){ return this.value; }

fan.vaseOpenGl.GlHandlePeer.prototype.getValue = function(){ return this.value; }
fan.vaseOpenGl.GlHandlePeer.prototype.setValue = function(v){ this.value = v; }

