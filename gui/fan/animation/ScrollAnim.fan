//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

@Js
class ScrollAnimChannel : AnimChannel {
  protected Float endV := 0f
  Float acceleration := -0.001f
  Float startV := 1f
  private Int lastT := 0

  protected Bool backwards := true
  ScrollBar? target
  protected Bool allowOverScroll := false

  private Bool isFinished := false

  protected virtual Void init() {
    backwards = (startV < 0f)
    if (backwards) {
      acceleration = -acceleration
    }
  }

  protected virtual Bool isEnd() {
    if (backwards) {
      if (startV >= endV) {
        return true
      }
    } else {
       if (startV <= endV) {
        return true
      }
    }
    if (target.isOverScroll) {
      return true
    }
    return false
  }

  override Void update(Int elapsedTime, Float percent, Float blendWeight) {
    if (lastT == 0) {
      lastT = elapsedTime
      init
      target.requestPaint
      return
    }
    if (isFinished) {
      return
    }

    t := (elapsedTime - lastT).toFloat
    s := (startV * t) + (acceleration * t * t / 2)

    startV = startV + (acceleration * t)
    lastT += t.toInt

    pos := target.curPos - s
    //echo("pos$pos, s$s, $allowOverScroll")
    target.setCurPos(pos, true, allowOverScroll)
    target.requestPaint

    isFinished = isEnd
  }
}

@Js
class OverScrollAnimChannel : ScrollAnimChannel {

  private Float startPos := 0f

  protected override Void init() {
    startV = 0f
    if (target.curPos > 0f) {
      acceleration = -acceleration
    }
    startPos = target.curPos
    allowOverScroll = true
  }

  protected override Bool isEnd() {
    if (!target.isOverScroll) {
      target.setCurPos(startPos, true)
      return true
    }
    return false
  }
}

