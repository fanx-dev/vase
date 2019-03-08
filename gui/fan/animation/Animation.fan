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
mixin AnimChannel {
  abstract Void update(Int frameTime, Float percent, Float blendWeight)
}

@Js
class Animation
{
  Str name := ""

  Int duration := 1000
  Int elapsedTime := 0
  Float speed := 1f
  Float blendWeight := 1f
  Int repeat := 0
  Int delay := 0

  Bool isRuning := false { private set }
  Bool isFinished := false { private set }

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

  Void update(Int frameTime) {
    Int i := 0
    if (!this.isRuning) {
      return
    }
    this.elapsedTime += (frameTime.toFloat * speed).toInt

    elapsed := this.elapsedTime - delay
    if (elapsed < 0) return

    if (elapsed > this.duration) {
      if (this.repeat > 1) {
        elapsed %= this.duration
        --repeat
      } else {
        updateChannel(frameTime, 1.0f)
        onFinised
        return
      }
    }

    Float percent := elapsed / this.duration.toFloat
    updateChannel(frameTime, percent)
  }

  private Void updateChannel(Int frameTime, Float percent) {
    for (i:=0; i<this.channelList.size; ++i) {
      channel := this.channelList[i]
      channel.update(frameTime, percent, this.blendWeight)
    }
  }
}

