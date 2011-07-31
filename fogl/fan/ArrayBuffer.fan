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
  native static ArrayBuffer makeFloat(Float[] data)

  native static ArrayBuffer makeInt(Int[] data)

  native static ArrayBuffer makeShort(Int[] data)
}

