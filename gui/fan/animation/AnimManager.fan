//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using concurrent

@Js
class AnimManager {
  **
  ** last animation update time
  **
  Int lastUpdateTime := 0

  private Animation[] animationList := [,]

  Bool updateFrame() {
    if (lastUpdateTime == 0) {
      lastUpdateTime = TimePoint.nowMillis
    }
    now := TimePoint.nowMillis

    elapsedTime := now - lastUpdateTime

    if (elapsedTime > 0) {
      update(elapsedTime)
    }

    lastUpdateTime = now
    return hasAnimation
  }

  Bool update(Int frameTime) {
    n := animationList.size
    for (i:=0; i<n; ++i) {
      anim := animationList.get(i)
      anim.update(frameTime)
      if (anim.isFinished) {
        animationList.removeAt(i)
        --i
        --n
      }
    }
    return animationList.size > 0
  }

  Void clear() {
    animationList.clear
    lastUpdateTime = 0
  }

  Bool hasAnimation() {
    animationList.size > 0
  }

  This add(Animation a) {
    animationList.add(a)
    return this
  }
}