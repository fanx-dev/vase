//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.ArrayBufferPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.ArrayBufferPeer.prototype.$ctor = function(self) {}
fan.fogl.ArrayBufferPeer.prototype.data = null;

//////////////////////////////////////////////////////////////////////////
// ctor
//////////////////////////////////////////////////////////////////////////

fan.fogl.ArrayBufferPeer.makeFloat$ = function(self, list)
{
  var data = list.m_values
  self.peer.data = new Float32Array(data);
}
fan.fogl.ArrayBufferPeer.makeFloat = function(list)
{
  var self = fan.fogl.ArrayBuffer.make();
  fan.fogl.ArrayBufferPeer.makeFloat$(self, list);
  return self;
}

fan.fogl.ArrayBufferPeer.makeDouble$ = function(self, list)
{
  var data = list.m_values
  self.peer.data = new Float64Array(data);
}
fan.fogl.ArrayBufferPeer.makeDouble = function(list)
{
  var self = fan.fogl.ArrayBuffer.make();
  fan.fogl.ArrayBufferPeer.makeDouble$(self, list);
  return self;
}

fan.fogl.ArrayBufferPeer.makeInt$ = function(self, list)
{
  var data = list.m_values
  self.peer.data = new Int32Array(data);
}
fan.fogl.ArrayBufferPeer.makeInt = function(list)
{
  var self = fan.fogl.ArrayBuffer.make();
  fan.fogl.ArrayBufferPeer.makeInt$(self, list);
  return self;
}

fan.fogl.ArrayBufferPeer.makeShort$ = function(self, list)
{
  var data = list.m_values
  self.peer.data = new Int16Array(data);
}
fan.fogl.ArrayBufferPeer.makeShort = function(list)
{
  var self = fan.fogl.ArrayBuffer.make();
  fan.fogl.ArrayBufferPeer.makeShort$(self, list);
  return self;
}

fan.fogl.ArrayBufferPeer.makeByte$ = function(self, list)
{
  var data = list.m_values
  self.peer.data = new Int8Array(data);
}
fan.fogl.ArrayBufferPeer.makeByte = function(list)
{
  var self = fan.fogl.ArrayBuffer.make();
  fan.fogl.ArrayBufferPeer.makeByte$(self, list);
  return self;
}

//////////////////////////////////////////////////////////////////////////
// methods
//////////////////////////////////////////////////////////////////////////

fan.fogl.ArrayBufferPeer.prototype.getValue = function(){ return this.data; }