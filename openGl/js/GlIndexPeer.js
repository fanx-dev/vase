//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fanvasOpenGl.GlIndexPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fanvasOpenGl.GlIndexPeer.prototype.$ctor = function(self) {}
fan.fanvasOpenGl.GlIndexPeer.prototype.value = null;
fan.fanvasOpenGl.GlIndexPeer.prototype.val = function(self){ return this.value; }

fan.fanvasOpenGl.GlIndexPeer.prototype.getValue = function(){ return this.value; }
fan.fanvasOpenGl.GlIndexPeer.prototype.setValue = function(v){ this.value = v; }

