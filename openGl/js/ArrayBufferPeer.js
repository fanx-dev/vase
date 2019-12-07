//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.vaseOpenGl.ArrayBufferPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.vaseOpenGl.ArrayBufferPeer.prototype.$ctor = function(self) {}
fan.vaseOpenGl.ArrayBufferPeer.prototype.rawData = null;
fan.vaseOpenGl.ArrayBufferPeer.prototype.bufferView = null;

//////////////////////////////////////////////////////////////////////////
// native
//////////////////////////////////////////////////////////////////////////

fan.vaseOpenGl.ArrayBufferPeer.prototype.m_size;
fan.vaseOpenGl.ArrayBufferPeer.prototype.size = function(self) { return this.m_size; }

fan.vaseOpenGl.ArrayBufferPeer.prototype.m_offset;

fan.vaseOpenGl.ArrayBufferPeer.prototype.m_endian = fan.std.Endian.big;
fan.vaseOpenGl.ArrayBufferPeer.prototype.endian = function(self) { return this.m_endian; }
fan.vaseOpenGl.ArrayBufferPeer.prototype.endian$  = function(self, v) { this.m_endian = v; }
fan.vaseOpenGl.ArrayBufferPeer.prototype.isLittleEndian = function() { return this.m_endian == fan.std.Endian.little; }

fan.vaseOpenGl.ArrayBufferPeer.prototype.type = function(self)
{
  var d = this.bufferView;
  if (d == null) return fan.vaseOpenGl.NumType.m_tByte;
  else if (d instanceof Int8Array) return fan.vaseOpenGl.NumType.m_tByte;
  else if (d instanceof Uint8Array) return fan.vaseOpenGl.NumType.m_tByte;
  else if (d instanceof Int16Array) return fan.vaseOpenGl.NumType.m_tShort;
  else if (d instanceof Uint16Array) return fan.vaseOpenGl.NumType.m_tShort;
  else if (d instanceof Int32Array) return fan.vaseOpenGl.NumType.m_tInt;
  else if (d instanceof Uint32Array) return fan.vaseOpenGl.NumType.m_tInt;
  else if (d instanceof Float32Array) return fan.vaseOpenGl.NumType.m_tFloat;
  else throw fan.sys.Err.make("unknow type");
}

fan.vaseOpenGl.ArrayBufferPeer.prototype.reset = function()
{
  this.m_size = this.bufferView.length;
  this.m_offset = this.bufferView.byteOffset;
}

//////////////////////////////////////////////////////////////////////////
// ctor
//////////////////////////////////////////////////////////////////////////

fan.vaseOpenGl.ArrayBufferPeer.asView = function(rawData, v, offset, size)
{
  var view;
  if (fan.vaseOpenGl.NumType.m_tByte == v) view = new Int8Array(rawData, offset, size);
  else if (fan.vaseOpenGl.NumType.m_tShort == v) view = new Int16Array(rawData, offset, size);
  else if (fan.vaseOpenGl.NumType.m_tInt == v) view = new Int32Array(rawData, offset, size);
  else if (fan.vaseOpenGl.NumType.m_tFloat == v) view = new Float32Array(rawData, offset, size);
  else throw fan.sys.Err.make("unknow type");
  return view;
}
fan.vaseOpenGl.ArrayBufferPeer.prototype.createView = function(self, type, offset, size)
{
  if (this.type(self) != fan.vaseOpenGl.NumType.m_tByte) throw UnsupportedErr.make("only ByteBuffer can create view");

  var view = fan.vaseOpenGl.ArrayBuffer.make();
  var peer = view.peer;
  peer.rawData = this.rawData;
  if (!offset) offset = this.m_offset;
  if (!size) size = this.m_size / type.m_size;
  peer.bufferView = asView(rawData, type, offset, size);
  peer.reset();
  return view;
}

fan.vaseOpenGl.ArrayBufferPeer.allocateDirect = function(size, type)
{
  if (!type) type = fan.vaseOpenGl.NumType.m_tByte;
  var capacity = (size * type.m_size);
  var buf = new ArrayBuffer(capacity);
  var self = fan.vaseOpenGl.ArrayBuffer.make();
  self.peer.rawData = buf;

  if (type == fan.vaseOpenGl.NumType.m_tByte)
  {
    self.peer.bufferView = new Int8Array(buf);
    self.peer.reset();
    return self;
  }
  self.peer.bufferView = fan.vaseOpenGl.ArrayBufferPeer.asView(buf, type, 0, size);
  self.peer.reset();
  return self;
}

//////////////////////////////////////////////////////////////////////////
// random read/write
//////////////////////////////////////////////////////////////////////////

fan.vaseOpenGl.ArrayBufferPeer.prototype.getInt = function(self, index)
{
  if (this.type(self) != fan.vaseOpenGl.NumType.m_tInt) throw UnsupportedErr.make("not Int buffer");
  return this.bufferView[index];
}
fan.vaseOpenGl.ArrayBufferPeer.prototype.setInt = function(self, index, v)
{
  if (this.type(self) != fan.vaseOpenGl.NumType.m_tInt) throw UnsupportedErr.make("not Int buffer");
  this.bufferView.set[index] = v;
  return self;
}
fan.vaseOpenGl.ArrayBufferPeer.prototype.getFloat = function(self, index)
{
  if (this.type(self) != fan.vaseOpenGl.NumType.m_tFloat) throw UnsupportedErr.make("not Float buffer");
  return this.bufferView[index];
}
fan.vaseOpenGl.ArrayBufferPeer.prototype.setFloat = function(self, index, v)
{
  if (this.type(self) != fan.vaseOpenGl.NumType.m_tFloat) throw UnsupportedErr.make("not Float buffer");
  this.bufferView.set[index] = v;
  return self;
}

//////////////////////////////////////////////////////////////////////////
// batch read/write
//////////////////////////////////////////////////////////////////////////

fan.vaseOpenGl.ArrayBufferPeer.prototype.putFloat = function(self, data)
{
  var a = data.toJs();
  if (a.length != this.bufferView.length) {
    a = a.slice(0, this.bufferView.length);
  }
  this.bufferView.set(a);
  return self;
}
fan.vaseOpenGl.ArrayBufferPeer.prototype.putInt = function(self, data)
{
  var a = data.toJs();
  if (a.length != this.bufferView.length) {
    a = a.slice(0, this.bufferView.length);
  }
  this.bufferView.set(a);
  return self;
}
fan.vaseOpenGl.ArrayBufferPeer.prototype.putShort = function(self, data)
{
  var a = data.toJs();
  if (a.length != this.bufferView.length) {
    a = a.slice(0, this.bufferView.length);
  }
  this.bufferView.set(a);
  return self;
}

fan.vaseOpenGl.ArrayBufferPeer.prototype.setFloatArray = function(self, data)
{
  var a = data.m_array;
  if (a.length != this.bufferView.length) {
    a = a.slice(0, this.bufferView.length);
  }
  this.bufferView.set(a);
  return self;
}
fan.vaseOpenGl.ArrayBufferPeer.prototype.setIntArray = function(self, data)
{
  var a = data.m_array;
  if (a.length != this.bufferView.length) {
    a = a.slice(0, this.bufferView.length);
  }
  this.bufferView.set(a);
  return self;
}

//////////////////////////////////////////////////////////////////////////
// methods
//////////////////////////////////////////////////////////////////////////

fan.vaseOpenGl.ArrayBufferPeer.prototype.getValue = function()
{
  return this.bufferView;
}