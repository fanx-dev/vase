#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-5-29  Jed Young  Creation
//

using gfx
using fwt

using gfx2
using gfx2Imp
using fan3dMath
using array

**
** fan D:/code/Hg/fan3d/jsTest/fan/jsfan/Gfx2Caret.fan
**
@Js
class Gfx2Caret : Canvas2
{
  Str str := ""

  new make()
  {
    onKeyUp.add { str += it.key->mask->toChar; this.repaint }
    // js not support keyChar
    //onKeyUp.add { str += it.keyChar.toChar; this.repaint }
  }

  override Void onPaint(Graphics gc)
  {
    setCaret(10, 10, 2, 30)
    gc.drawText(str, 10, 20)
  }

  Void main()
  {
    Window
    {
      content = Gfx2Caret()
      it.size = Size(400, 400)
    }.open
  }
}