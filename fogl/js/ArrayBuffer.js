//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.ArrayBuffer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.ArrayBuffer.prototype.$ctor = function(self) {}
fan.fogl.ArrayBuffer.prototype.$typeof = function() { return fan.fogl.ArrayBuffer.$type; }
fan.fogl.ArrayBuffer.prototype.data = null;

//////////////////////////////////////////////////////////////////////////
// ctor
//////////////////////////////////////////////////////////////////////////

fan.fogl.ArrayBuffer.makeFloat$ = function(self, list)
{
  var data = list.m_values
  self.data = new Float32Array(data);
}
fan.fogl.ArrayBuffer.makeFloat = function(list)
{
  var self = new fan.fogl.ArrayBuffer();
  fan.fogl.ArrayBuffer.makeFloat$(self, list);
  return self;
}

fan.fogl.ArrayBuffer.makeDouble$ = function(self, list)
{
  var data = list.m_values
  self.data = new Float64Array(data);
}
fan.fogl.ArrayBuffer.makeDouble = function(list)
{
  var self = new fan.fogl.ArrayBuffer();
  fan.fogl.ArrayBuffer.makeDouble$(self, list);
  return self;
}

fan.fogl.ArrayBuffer.makeInt$ = function(self, list)
{
  var data = list.m_values
  self.data = new Int32Array(data);
}
fan.fogl.ArrayBuffer.makeInt = function(list)
{
  var self = new fan.fogl.ArrayBuffer();
  fan.fogl.ArrayBuffer.makeInt$(self, list);
  return self;
}

fan.fogl.ArrayBuffer.makeShort$ = function(self, list)
{
  var data = list.m_values
  self.data = new Int16Array(data);
}
fan.fogl.ArrayBuffer.makeShort = function(list)
{
  var self = new fan.fogl.ArrayBuffer();
  fan.fogl.ArrayBuffer.makeShort$(self, list);
  return self;
}

fan.fogl.ArrayBuffer.makeByte$ = function(self, list)
{
  var data = list.m_values
  self.data = new Int8Array(data);
}
fan.fogl.ArrayBuffer.makeByte = function(list)
{
  var self = new fan.fogl.ArrayBuffer();
  fan.fogl.ArrayBuffer.makeByte$(self, list);
  return self;
}

//////////////////////////////////////////////////////////////////////////
// methods
//////////////////////////////////////////////////////////////////////////


fan.fogl.ArrayBuffer.prototype.getData = function(){ return this.data; }