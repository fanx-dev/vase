//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow
using concurrent

@Js
class AnimManager {
  private Animation[] animationList := [,]

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

  Bool hasAnimation() {
    animationList.size > 0
  }

  This add(Animation a) {
    animationList.add(a)
    return this
  }
}