//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

**
** Wrapping a native array buffer.
**
@Js
class ArrayBuffer
{
  native Int size()
  native NumType type()

  native static ArrayBuffer allocateDirect(Int size, NumType type := NumType.tByte)

  native This createView(NumType v, Int offset := 0, Int size := this.size / this.type.size)

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
    return buf
  }

  static ArrayBuffer makeInt(Int[] data)
  {
    buf := ArrayBuffer.allocateDirect(data.size, NumType.tInt)
    buf.putInt(data)
    return buf
  }

  static ArrayBuffer makeShort(Int[] data)
  {
    buf := ArrayBuffer.allocateDirect(data.size, NumType.tShort)
    buf.putShort(data)
    return buf
  }
}