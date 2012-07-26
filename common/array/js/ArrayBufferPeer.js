//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fgfxArray.ArrayBufferPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxArray.ArrayBufferPeer.prototype.$ctor = function(self) {}
fan.fgfxArray.ArrayBufferPeer.prototype.rawData = null;
fan.fgfxArray.ArrayBufferPeer.prototype.bufferView = null;

//////////////////////////////////////////////////////////////////////////
// native
//////////////////////////////////////////////////////////////////////////

fan.fgfxArray.ArrayBufferPeer.prototype.m_size;
fan.fgfxArray.ArrayBufferPeer.prototype.size = function(self) { return this.m_size; }

fan.fgfxArray.ArrayBufferPeer.prototype.m_offset;

fan.fgfxArray.ArrayBufferPeer.prototype.m_endian = fan.sys.Endian.big;
fan.fgfxArray.ArrayBufferPeer.prototype.endian = function(self) { return this.m_endian; }
fan.fgfxArray.ArrayBufferPeer.prototype.endian$  = function(self, v) { this.m_endian = v; }
fan.fgfxArray.ArrayBufferPeer.prototype.isLittleEndian = function() { return this.m_endian == fan.sys.Endian.little; }

fan.fgfxArray.ArrayBufferPeer.prototype.type = function(self)
{
  var d = this.bufferView;
  if (d == null) return fan.fgfxArray.NumType.m_tByte;
  else if (d instanceof Int8Array) return fan.fgfxArray.NumType.m_tByte;
  else if (d instanceof Uint8Array) return fan.fgfxArray.NumType.m_tByte;
  else if (d instanceof Int16Array) return fan.fgfxArray.NumType.m_tShort;
  else if (d instanceof Uint16Array) return fan.fgfxArray.NumType.m_tShort;
  else if (d instanceof Int32Array) return fan.fgfxArray.NumType.m_tInt;
  else if (d instanceof Uint32Array) return fan.fgfxArray.NumType.m_tInt;
  else if (d instanceof Float32Array) return fan.fgfxArray.NumType.m_tFloat;
  else throw fan.sys.Err.make("unknow type");
}

fan.fgfxArray.ArrayBufferPeer.prototype.reset = function()
{
  this.m_size = this.bufferView.length;
  this.m_offset = this.bufferView.byteOffset;
}

//////////////////////////////////////////////////////////////////////////
// ctor
//////////////////////////////////////////////////////////////////////////

fan.fgfxArray.ArrayBufferPeer.asView = function(rawData, v, offset, size)
{
  var view;
  if (fan.fgfxArray.NumType.m_tByte == v) view = new Int8Array(rawData, offset, size);
  else if (fan.fgfxArray.NumType.m_tShort == v) view = new Int16Array(rawData, offset, size);
  else if (fan.fgfxArray.NumType.m_tInt == v) view = new Int32Array(rawData, offset, size);
  else if (fan.fgfxArray.NumType.m_tFloat == v) view = new Float32Array(rawData, offset, size);
  else throw fan.sys.Err.make("unknow type");
  return view;
}
fan.fgfxArray.ArrayBufferPeer.prototype.createView = function(self, type, offset, size)
{
  if (this.type(self) != fan.fgfxArray.NumType.m_tByte) throw UnsupportedErr.make("only ByteBuffer can create view");

  var view = fan.fgfxArray.ArrayBuffer.make();
  var peer = view.peer;
  peer.rawData = this.rawData;
  if (!offset) offset = this.m_offset;
  if (!size) size = this.m_size / type.m_size;
  peer.bufferView = asView(rawData, type, offset, size);
  peer.reset();
  return view;
}

fan.fgfxArray.ArrayBufferPeer.allocateDirect = function(size, type)
{
  if (!type) type = fan.fgfxArray.NumType.m_tByte;
  var capacity = (size * type.m_size);
  var buf = new ArrayBuffer(capacity);
  var self = fan.fgfxArray.ArrayBuffer.make();
  self.peer.rawData = buf;

  if (type == fan.fgfxArray.NumType.m_tByte)
  {
    self.peer.bufferView = new Int8Array(buf);
    self.peer.reset();
    return self;
  }
  self.peer.bufferView = fan.fgfxArray.ArrayBufferPeer.asView(buf, type, 0, size);
  self.peer.reset();
  return self;
}

//////////////////////////////////////////////////////////////////////////
// random read/write
//////////////////////////////////////////////////////////////////////////

fan.fgfxArray.ArrayBufferPeer.prototype.getInt = function(self, index)
{
  if (this.type(self) != fan.fgfxArray.NumType.m_tInt) throw UnsupportedErr.make("not Int buffer");
  return this.bufferView[index];
}
fan.fgfxArray.ArrayBufferPeer.prototype.setInt = function(self, index, v)
{
  if (this.type(self) != fan.fgfxArray.NumType.m_tInt) throw UnsupportedErr.make("not Int buffer");
  this.bufferView.set[index] = v;
  return self;
}
fan.fgfxArray.ArrayBufferPeer.prototype.getFloat = function(self, index)
{
  if (this.type(self) != fan.fgfxArray.NumType.m_tFloat) throw UnsupportedErr.make("not Float buffer");
  return this.bufferView[index];
}
fan.fgfxArray.ArrayBufferPeer.prototype.setFloat = function(self, index, v)
{
  if (this.type(self) != fan.fgfxArray.NumType.m_tFloat) throw UnsupportedErr.make("not Float buffer");
  this.bufferView.set[index] = v;
  return self;
}

//////////////////////////////////////////////////////////////////////////
// batch read/write
//////////////////////////////////////////////////////////////////////////

fan.fgfxArray.ArrayBufferPeer.prototype.putFloat = function(self, data)
{
  this.bufferView.set(data.m_values);
  return self;
}
fan.fgfxArray.ArrayBufferPeer.prototype.putInt = function(self, data)
{
  this.bufferView.set(data.m_values);
  return self;
}
fan.fgfxArray.ArrayBufferPeer.prototype.putShort = function(self, data)
{
  this.bufferView.set(data.m_values);
  return self;
}

//////////////////////////////////////////////////////////////////////////
// methods
//////////////////////////////////////////////////////////////////////////

fan.fgfxArray.ArrayBufferPeer.prototype.getValue = function()
{
  return this.bufferView;
}