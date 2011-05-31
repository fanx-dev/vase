//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-31  Jed Young  Creation
//

package fan.fogl;

import fan.sys.*;

class PointerPeer
{
  long pointer;

  public static PointerPeer make(Pointer self)
  {
    return new PointerPeer();
  }

  long val(Pointer self)
  {
    return pointer;
  }

  void val(Pointer self, long i)
  {
    pointer = i;
  }
}