//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using vaseGraphics
using vaseWindow
using concurrent
using vaseMath

**
** root view
**
@Js
internal class WinView : View
{
  **
  ** The reference of nativeView
  **
  override Window? host

  private Frame curFrame
  internal Frame? oldFrame
  private Bool frameOut := false

  private Frame[] stack := Frame[,]

  //private Dimension sharedDimension := Dimension(0, 0)

  **
  ** gesture recognizer
  ** convert motion event to gesture event
  **
  @Transient
  private Gesture gesture := Gesture()


  private Int width := 0
  private Int height := 0
  protected Int layoutDirty := 1

  ** ctor
  new make(Frame frame) {
    this.curFrame = frame

    gesture.onGestureEvent.add |GestureEvent e|{
      e.relativeX = e.x
      e.relativeY = e.y
      if (this.oldFrame == null) this.curFrame.gestureEvent(e)
    }
  }

  Void pushFrame(Frame frame) {
    stack.push(curFrame)
    oldFrame = curFrame
    curFrame = frame
    frameOut = false

    //animation for frame
    if (oldFrame != null) {
      curFrame.animManager.clear
      anim := TweenAnimation {
        it.duration = 300
        TranslateAnimChannel { to = Point.defVal; from = Point(oldFrame.width, 0)},
      }
      anim.bind(curFrame)
      anim.whenDone.add {
        oldFrame.detach
        //echo("curFrame in done")
      }
      anim.start
    }

    layoutDirty = 2
    host.repaint
  }

  Frame? popFrame() {
    frame := stack.pop
    if (frame == null) {
      echo("nomore frame")
      return null
    }

    oldFrame = curFrame
    curFrame = frame
    frameOut = true

    //frame animation
    if (oldFrame != null) {
      oldFrame.animManager.clear
      anim := TweenAnimation {
        it.duration = 300
        TranslateAnimChannel { from = Point.defVal; to = Point(oldFrame.width, 0)},
      }
      anim.bind(oldFrame)
      anim.whenDone.add {
        oldFrame.detach
        //echo("oldFrame in done")
      }
      anim.start
    }

    layoutDirty = 2
    host.repaint
    //echo("popFrame $frame")
    return frame
  }
  
  private Void update() {
    if (layoutDirty > 0) {
      curFrame.setLayout(0, 0, width, height, layoutDirty>1)
      layoutDirty = 0

      //echo("layout $s")

      if (!curFrame.inited) {
        curFrame.inited = true
        curFrame.onMounted
        curFrame.onOpened.fire(null)
      }
    }
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
    update

    oldFrame?.onUpdate
    if (!frameOut && oldFrame != null) {
      g.push
      oldFrame.paint(g)
      g.pop
    }
    
    curFrame.onUpdate
    curFrame.paint(g)

    if (frameOut && oldFrame != null) {
      g.push
      oldFrame.paint(g)
      g.pop
    }
  }

  override Void onMotionEvent(MotionEvent e) {
    update
    if (oldFrame == null) curFrame.motionEvent(e)
    if (!e.consumed) {
      gesture.onEvent(e)
    }
  }

  override Void onKeyEvent(KeyEvent e) {
    if (oldFrame == null) curFrame.keyEvent(e)
  }

  override Void onWindowEvent(WindowEvent e) {
    if (oldFrame == null) curFrame.windowEvent(e)
  }

  override Bool onBack() {
    f := popFrame 
    if (f == null) return false
    f.focusIt(null)
    return true
  }

  **
  ** get prefer size
  **
  override Size getPrefSize(Int hintsWidth, Int hintsHeight) {
    result := curFrame.prefSize(hintsWidth, hintsHeight)
    //echo("hintsHeight$hintsHeight, result$result")
    return Size(result.w, result.h)
  }
}