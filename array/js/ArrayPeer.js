//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//


fan.fgfxArray.ArrayPeer = fan.sys.Obj.$extend(fan.sys.Obj);
fan.fgfxArray.ArrayPeer.prototype.$ctor = function(self) {}
fan.fgfxArray.ArrayPeer.prototype.array = null;

//////////////////////////////////////////////////////////////////////////
// native
//////////////////////////////////////////////////////////////////////////

fan.fgfxArray.ArrayPeer.prototype.size = function(self) { return this.array.length; }

fan.fgfxArray.ArrayPeer.prototype.type = function(self) { return this.m_type; };

//////////////////////////////////////////////////////////////////////////
// ctor
//////////////////////////////////////////////////////////////////////////

fan.fgfxArray.ArrayPeer.allocate = function(size, type)
{
  var a = fan.fgfxArray.Array.make();
  if (!type) type = fan.fgfxArray.NumType.m_tInt;
  a.peer.m_type = type;
  a.peer.array = new Array(size);
  return a;
}

//////////////////////////////////////////////////////////////////////////
// random read/write
//////////////////////////////////////////////////////////////////////////

fan.fgfxArray.ArrayPeer.prototype.getInt = function(self, index)
{
  if (this.type(self) != fan.fgfxArray.NumType.m_tInt) throw UnsupportedErr.make("not Int buffer");
  return this.array[index];
}
fan.fgfxArray.ArrayPeer.prototype.setInt = function(self, index, v)
{
  if (this.type(self) != fan.fgfxArray.NumType.m_tInt) throw UnsupportedErr.make("not Int buffer");
  this.array[index] = v;
  return self;
}
fan.fgfxArray.ArrayPeer.prototype.getFloat = function(self, index)
{
  if (this.type(self) != fan.fgfxArray.NumType.m_tFloat) throw UnsupportedErr.make("not Float buffer");
  return this.array[index];
}
fan.fgfxArray.ArrayPeer.prototype.setFloat = function(self, index, v)
{
  if (this.type(self) != fan.fgfxArray.NumType.m_tFloat) throw UnsupportedErr.make("not Float buffer");
  this.array[index] = v;
  return self;
}

//////////////////////////////////////////////////////////////////////////
// batch read/write
//////////////////////////////////////////////////////////////////////////

fan.fgfxArray.ArrayPeer.prototype.fromList = function(self, list)
{
  var size = list.size();
  var array
  if (list.of == fan.sys.Int.$type)
  {
    array = fan.fgfxArray.Array.allocate(size, fan.fgfxArray.NumType.m_tInt);
  }
  else if(list.of == fan.sys.Float.$type)
  {
    array = fan.fgfxArray.Array.allocate(size, fan.fgfxArray.NumType.m_tFloat);
  }
  else
  {
    throw UnsupportedErr.make("Unknow type: " + list.of);
  }

  for (var i = 0; i < size; ++i)
  {
    array.peer.array[0] = list.get(0);
  }
  return array;
}
fan.fgfxArray.ArrayPeer.prototype.toList = function(self)
{
  var size = this.size(self);
  var type = this.type(self);

  if (type == NumType.tByte || type == NumType.tInt || type == NumType.tShort || type == NumType.tLong)
  {
    var list = fan.sys.List.make(fan.sys.Int.$type, size);
    for (var i = 0; i < size; ++i)
    {
      list.add(this.getInt(self, i));
    }
    return list;
  }
  else if (type == NumType.tFloat || type == NumType.tDouble)
  {
    var list = fan.sys.List.make(fan.sys.Float.$type, size);
    for (var i = 0; i < size; ++i)
    {
      list.add(this.getFloat(self, i));
    }
    return list;
  }
  else
  {
    throw UnsupportedErr.make("unsupported type");
  }
}
fan.fgfxArray.ArrayPeer.prototype.copyTo = function(self, dst, dstOffset, srcOffset, size)
{
  if (!dstOffset) dstOffset = 0;
  if (!srcOffset) srcOffset = 0;
  if (!size) size = this.size(self);

  if (self.type() != dst.type()) throw ArgErr.make("Must have same type");
  if (size > self.size()-srcOffset || size > dst.size()-dstOffset) throw IndexErr.make("out of range: "+size);

  for(var i=0; i < size; ++i)
  {
    dst.peer.array[i+dstOffset] = this.array[i+srcOffset];
  }
}

//////////////////////////////////////////////////////////////////////////
// methods
//////////////////////////////////////////////////////////////////////////

fan.fgfxArray.ArrayPeer.prototype.getValue = function()
{
  return this.array;
}