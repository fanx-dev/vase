//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.GlPointerPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.GlPointerPeer.prototype.$ctor = function(self) {}
fan.fogl.GlPointerPeer.prototype.value = null;
fan.fogl.GlPointerPeer.prototype.val = function(self){ return this.value; }

fan.fogl.GlPointerPeer.prototype.getValue = function(){ return this.value; }
fan.fogl.GlPointerPeer.prototype.setValue = function(v){ this.value = v; }

