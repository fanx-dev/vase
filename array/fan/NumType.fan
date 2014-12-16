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
  tInt(4), tShort(2), tLong(8), tDouble(8), tFloat(4), tByte(1)

  private new make(Int size) { this.size = size }
  const Int size;
}

