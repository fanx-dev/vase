//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fogl.ArrayBuffer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fogl.ArrayBuffer.prototype.$ctor = function(self) {}
fan.fogl.ArrayBuffer.type = null;
fan.fogl.ArrayBuffer.prototype.data = null;

//////////////////////////////////////////////////////////////////////////
// ctor
//////////////////////////////////////////////////////////////////////////

fan.fogl.ArrayBuffer.makeFloat(list)
{
  var self = new fan.fogl.ArrayBuffer();
  makeFloat$(self, list);
  return self;
}
fan.fogl.ArrayBuffer.makeFloat$(self, list)
{
  var data = list.m_values
  self.data = new Float32Array(data);
}

fan.fogl.ArrayBuffer.makeDouble(list)
{
  var self = new fan.fogl.ArrayBuffer();
  makeDouble$(self, list);
  return self;
}
fan.fogl.ArrayBuffer.makeDouble$(self, list)
{
  var data = list.m_values
  self.data = new Float64Array(data);
}

fan.fogl.ArrayBuffer.makeInt(list)
{
  var self = new fan.fogl.ArrayBuffer();
  makeInt$(self, list);
  return self;
}
fan.fogl.ArrayBuffer.makeInt$(self, list)
{
  var data = list.m_values
  self.data = new Int32Array(data);
}

fan.fogl.ArrayBuffer.makeShort(list)
{
  var self = new fan.fogl.ArrayBuffer();
  makeShort$(self, list);
  return self;
}
fan.fogl.ArrayBuffer.makeShort$(self, list)
{
  var data = list.m_values
  self.data = new Int16Array(data);
}

fan.fogl.ArrayBuffer.makeByte(list)
{
  var self = new fan.fogl.ArrayBuffer();
  makeByte$(self, list);
  return self;
}
fan.fogl.ArrayBuffer.makeByte$(self, list)
{
  var data = list.m_values
  self.data = new Int8Array(data);
}

//////////////////////////////////////////////////////////////////////////
// methods
//////////////////////////////////////////////////////////////////////////

fan.fogl.ArrayBuffer.prototype.typeof$()
{
  if (type == null) type = Type.find("fogl::ArrayBuffer");
  return type;
}

fan.fogl.ArrayBuffer.prototype.getData(){ return data; }