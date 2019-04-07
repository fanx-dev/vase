//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow
using concurrent
using fanvasMath

**
** root view
**
@Js
internal class WinView : View
{
  **
  ** The reference of nativeView
  **
  @Transient
  override Window? host

  private Frame curFrame

  private Frame[] stack := Frame[,]

  private Dimension sharedDimension := Dimension(0, 0)

  **
  ** gesture recognizer
  ** convert motion event to gesture event
  **
  @Transient
  private Gesture gesture := Gesture()

  **
  ** animation manager
  **
  @Transient
  protected AnimManager animManager := AnimManager()

  **
  ** last animation update time
  **
  @Transient
  private Int lastUpdateTime := 0

  private Int width := 0
  private Int height := 0
  protected Int layoutDirty := 1

  ** ctor
  new make(Frame curFrame) {
    this.curFrame = curFrame

    gesture.onGestureEvent.add |GestureEvent e|{
      e.relativeX = e.x
      e.relativeY = e.y
      this.curFrame.gestureEvent(e)
    }
  }

  Void pushFrame(Frame frame) {
    stack.push(curFrame)
    curFrame = frame
    layoutDirty = 2
    host.repaint
  }

  Frame popFrame() {
    frame := stack.pop
    curFrame = frame
    layoutDirty = 2
    host.repaint
    //echo("popFrame $frame")
    return frame
  }

  protected Void onUpdate() {
    if (lastUpdateTime == 0) {
      lastUpdateTime = TimePoint.nowMillis
    }
    now := TimePoint.nowMillis

    elapsedTime := now - lastUpdateTime

    // elapsedTime is millisecond.
    // elapsedTime is 0 cause a bug on updatee animation
    if (elapsedTime == 0) {
      if (animManager.hasAnimation) {
        host.repaint
      }
      return
    }

    if (animManager.update(elapsedTime)) {
//      echo("anim continue")
      host.repaint
    }

    lastUpdateTime = now
  }

  **
  ** do paint at here
  **
  override Void onPaint(Graphics g) {
    s := host.size
    if (width != s.w || height != s.h) {
      this.width = s.w
      this.height = s.h
      //echo("layout $s")
      layoutDirty = 2
    }

    if (layoutDirty > 0) {
      curFrame.layout(0, 0, s.w, s.h, sharedDimension, layoutDirty>1)
      layoutDirty = 0

      //echo("layout $s")

      if (!curFrame.inited) {
        curFrame.inited = true
        curFrame.onMounted
        curFrame.onOpened.fire(null)
      }
    }
    
    onUpdate
    curFrame.paint(g)
  }

  override Void onMotionEvent(MotionEvent e) {
    curFrame.motionEvent(e)
    if (!e.consumed) {
      gesture.onEvent(e)
    }
  }

  override Void onKeyEvent(KeyEvent e) {
    curFrame.keyEvent(e)
  }

  override Void onWindowEvent(WindowEvent e) {
    curFrame.windowEvent(e)
  }

  **
  ** get prefer size
  **
  override Size getPrefSize(Int hintsWidth, Int hintsHeight) {
    result := curFrame.canonicalSize(hintsWidth, hintsHeight, sharedDimension)
    //echo("hintsHeight$hintsHeight, result$result")
    return Size(result.w, result.h)
  }
}