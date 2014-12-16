//
// Copyright (c) 2014, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk
using concurrent

@Js
mixin AnimChannel {
  abstract Void update(Int elapsedTime, Float percent, Float blendWeight)
}

@Js
class Animation
{
  Str name := ""

  Int duration := 1000
  Int elapsedTime := 0
  Float speed := 1f
  Float blendWeight := 1f
  Bool repeat := false
  Bool isRuning := false { private set }
  Bool isFinished := false

  protected AnimChannel[] channelList := [,]

  once EventListeners whenDone() { EventListeners() }

  @Operator virtual This add(AnimChannel child) {
    channelList.add(child)
    return this
  }

  Void start() {
    this.elapsedTime = 0
    this.isRuning = true
    onStart
  }

  Void stop() {
    this.isRuning = false
    onStop
  }

  protected virtual Void onStart() {
  }

  protected virtual Void onStop() {
    onFinised
  }

  protected virtual Void onFinised() {
    this.isRuning = false
    whenDone.fire(null)
    isFinished = true
  }

  Void update(Int elapsedTime) {
    Int i := 0
    if (!this.isRuning) {
      return
    }
    this.elapsedTime += (elapsedTime.toFloat * speed).toInt

    if (this.elapsedTime > this.duration) {
      if (this.repeat) {
        this.elapsedTime %= this.duration
      } else {
        onFinised
        return
      }
    }

    Float percent := this.elapsedTime / this.duration.toFloat
    for (i=0; i<this.channelList.size; ++i) {
      this.channelList[i]->update(this.elapsedTime, percent, this.blendWeight)
    }
  }
}

