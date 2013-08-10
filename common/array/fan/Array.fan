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
class Array
{
  internal new make(){}

  native Int size()
  native NumType type()

  native static Array allocate(Int size, NumType type := NumType.tInt)

  native Int getInt(Int index)
  native This setInt(Int index, Int v)
  native Float getFloat(Int index)
  native This setFloat(Int index, Float v)

  native static ArrayBuffer fromList(Obj[] list, NumType type)
  native Obj[] toList()

  native Void copyTo(Array dst, Int dstOffset := 0, Int srcOffset := 0, Int size := this.size())
}