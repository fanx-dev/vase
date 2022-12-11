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
class DisplayMetrics
{

  private Float density = 0.0

  internal Bool autoScale = false {
    set {
      changed := &autoScale != it
      if (changed) {
        &autoScale = it
        if (Toolkit.cur.window != null) {
          winSize := Toolkit.cur.window.size
          updateDensity(winSize.w, winSize.h)
        }
      }
    }
  }

  internal Float densityBaseW = 1080f
  internal Float densityBaseH = 1920f

  private static const Unsafe<DisplayMetrics> instance = Unsafe<DisplayMetrics>(make())

  static DisplayMetrics cur() { instance.val }

  internal new make() {
    density = Toolkit.cur.density
  }

  **
  ** a dp pixel size.
  ** scale dp to pixel
  **
  private Float dp() {
    return density
  }

  internal Void updateDensity(Int w, Int h) {
    if (!autoScale) {
      density = Toolkit.cur.density
      return
    }

    m := 1.0
    if (w < h) {
      m1 := w / densityBaseW
      m2 := h / densityBaseH
      m = m1.min(m2)
    }
    else {
      m1 := w / densityBaseH
      m2 := h / densityBaseW
      m = m1.min(m2)
    }
    density = m
  }

  Int dpToPixel(Float d) { (d * dp).toInt }

  Float pixelToDp(Int p) { (p / dp) }

}

