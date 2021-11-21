//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using concurrent

@Js
mixin DisplayMetrics
{
  **
  ** a dp pixel size.
  ** scale dp to pixel
  **
  private static Float dp() {
    Bool? floatDesity := Actor.locals["vaseGui.floatDesity"]
    if (floatDesity == null || floatDesity == false) return Toolkit.cur.density

    Float desityBase := Actor.locals.get("vaseGui.desityBase", 1080f)
    win := Toolkit.cur.window
    if (win != null) {
      desity := (win.size.w / desityBase)
      return desity
    }
    return Toolkit.cur.density
  }

  static Int dpToPixel(Float d) { (d * dp).toInt }

  static Float pixelToDp(Int p) { (p / dp) }

}

