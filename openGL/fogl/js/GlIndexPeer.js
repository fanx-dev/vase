//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.GlIndexPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.GlIndexPeer.prototype.$ctor = function(self) {}
fan.fogl.GlIndexPeer.prototype.value = null;
fan.fogl.GlIndexPeer.prototype.val = function(self){ return this.value; }

fan.fogl.GlIndexPeer.prototype.getValue = function(){ return this.value; }
fan.fogl.GlIndexPeer.prototype.setValue = function(v){ this.value = v; }

