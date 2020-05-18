//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

@Js
class ScrollAnimChannel : AnimChannel {
  Float acceleration := -0.002f
  Float startV := 1f

  protected Bool backwards := false
  protected Bool inited := false
  ScrollBar? target
  protected Bool allowOverScroll := false

  private Bool isFinished := false
  
  override Bool isFinish() { isFinished }

  protected virtual Void init() {
    backwards = (startV < 0f)
    if (backwards) {
      acceleration = -acceleration
    }
  }

  protected virtual Bool isEnd() {
    Float endV := 0f
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

  override Void update(Int elapsedTime, Int frameTime, Float percent, Float blendWeight) {

    if (!inited) {
      inited = true
      init
    }
    
    if (isFinished) {
      return
    }

    t := frameTime
    s := (startV * t) + (acceleration * t * t / 2)
    startV = startV + (acceleration * t)

    pos := target.curPos - s
    //echo("t:$t, a:$acceleration, vt:$startV, s:$s, pos:$pos, $allowOverScroll")
    target.setCurPos(pos, true, allowOverScroll)
    isFinished = isEnd
    //echo("isFinished:$isFinished")
    target.repaint
  }
}

@Js
class OverScrollAnimChannel : ScrollAnimChannel {

  private Float startPos := 0f

  protected override Void init() {
    //echo(acceleration)
    startV = 0f
    if (target.curPos > 0f) {
      //acceleration = -acceleration
      backwards = true
      startPos = target.max - target.viewport
    }
    
    allowOverScroll = true
  }

  protected override Bool isEnd() {
    //echo("backwards:$backwards, startPos:$startPos, target.curPos:$target.curPos, acc:$acceleration")
    if (backwards) {
      if (target.curPos <= startPos) {
        target.setCurPos(startPos, true)
        return true
      }
    }
    else {
      if (target.curPos >= startPos) {
        target.setCurPos(startPos, true)
        return true
      }
    }
    return false
  }
}

