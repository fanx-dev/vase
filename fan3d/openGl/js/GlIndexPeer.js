//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fgfxOpenGl.GlIndexPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxOpenGl.GlIndexPeer.prototype.$ctor = function(self) {}
fan.fgfxOpenGl.GlIndexPeer.prototype.value = null;
fan.fgfxOpenGl.GlIndexPeer.prototype.val = function(self){ return this.value; }

fan.fgfxOpenGl.GlIndexPeer.prototype.getValue = function(){ return this.value; }
fan.fgfxOpenGl.GlIndexPeer.prototype.setValue = function(v){ this.value = v; }

