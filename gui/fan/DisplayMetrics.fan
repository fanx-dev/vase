//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow
using fanvasMath


@Js
mixin DisplayMetrics
{
  **
  ** a dp pixel size.
  ** scale dp to pixel
  **
  private static Float dp() {
    Toolkit.cur.density
  }

  static Int dpToPixel(Float d) { (d * dp).toInt }

  static Float pixelToDp(Int p) { (p / dp) }

}

