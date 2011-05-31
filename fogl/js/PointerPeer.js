//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.PointerPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.PointerPeer.prototype.$ctor = function(self) {}
fan.fogl.PointerPeer.prototype.m_val = null;
fan.fogl.PointerPeer.prototype.val = function(self){ return "" + this.m_val; }
fan.fogl.PointerPeer.prototype.val$ = function(self, i) { this.m_val = i; }

