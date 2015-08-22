//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk
using fgfxMath


@Js
mixin DisplayMetrics
{
  **
  ** a dp pixel size.
  ** scale dp to pixel
  **
  static Float dp() {
    Toolkit.cur.density
  }

  static Int dpToPixel(Int d) { (d * dp).toInt }

  static Int pixelToDp(Int p) { (p / dp).toInt }

}

