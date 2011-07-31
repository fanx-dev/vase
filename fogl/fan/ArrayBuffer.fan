//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

**
** primeval number type
**
@Js
enum class NumType
{
  tInt(4), tShort(2), tLong(8), tDouble(8), tFloat(4), tChar(2), tByte(1)

  private new make(Int size) { this.size = size }
  const Int size;
}

**
** Wrapping a native array buffer.
**
@Js
class ArrayBuffer
{
  native Int size
  native Int pos
  native Endian endian
  native NumType type

  native Int capacity()
  native Bool isDirect()

  native static ArrayBuffer allocateDirect(Int size, NumType type := NumType.tByte)
  native static ArrayBuffer allocate(Int size, NumType type := NumType.tByte)

  native This flip()
  native Int remaining()

  native This readTo(Num[] dst, Int offset := 0, Int length := dst.size)
  native This writeFrom(Num[] src, Int offset := 0, Int length := src.size)

  native Int getInt(Int index)
  native This setInt(Int index, Int v)
  native Int getFloat(Int index)
  native This setFloat(Int index, Int v)

  native This putFloat(Float[] data)
  native This putInt(Int[] data)
  native This putShort(Int[] data)

  internal new make() {}

  static ArrayBuffer makeFloat(Float[] data)
  {
    buf := ArrayBuffer.allocateDirect(data.size, NumType.tFloat)
    buf.putFloat(data)
    buf.flip
    return buf
  }

  static ArrayBuffer makeInt(Int[] data)
  {
    buf := ArrayBuffer.allocateDirect(data.size, NumType.tInt)
    buf.putInt(data)
    buf.flip
    return buf
  }

  static ArrayBuffer makeShort(Int[] data)
  {
    buf := ArrayBuffer.allocateDirect(data.size, NumType.tShort)
    buf.putShort(data)
    buf.flip
    return buf
  }
}