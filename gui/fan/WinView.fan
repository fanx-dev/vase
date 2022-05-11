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

  internal Frame curFrame
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

  private Animation? frameAnimation


  private Int width := 0
  private Int height := 0
  protected Int layoutDirty := 1

  ** ctor
  new make(Frame frame) {
    this.curFrame = frame

    gesture.onGestureEvent.add |GestureEvent e|{
      e.relativeX = e.x
      e.relativeY = e.y
      if (this.oldFrame == null) {
        if (e.type == GestureEvent.drag
            || e.type == GestureEvent.drop || e.type == GestureEvent.multiTouch) {
          this.curFrame.onDrag(e)
          if (e.type != GestureEvent.drop) return
        }
        this.curFrame.postGestureEvent(e)
      }
    }
  }

  Void showFrame(Frame frame, Bool push, Bool animation := true) {
    if (push) stack.push(curFrame)

    //the old animation not finised
    if (frameAnimation != null) {
      frameAnimation.stop
      frameAnimation = null
    }

    oldFrame = curFrame
    curFrame = frame
    frameOut = false

    DisplayMetrics.cur.autoScale = curFrame.autoScale

    //animation for frame
    if (oldFrame != null) {
      oldFrame.onClosing.fire(null)
      if (animation) {
        anim := TweenAnimation {
          it.duration = 200
          TranslateAnimChannel { to = Point.defVal; from = Point(oldFrame.width, 0)},
        }
        frameAnimation = anim
        anim.bind(curFrame)
        anim.whenDone.add {
          //oldFrame.animManager.clear
          oldFrame.detach
          frameAnimation = null
        }
        anim.start
      }
      else {
        oldFrame.detach
      }
    }

    layoutDirty = 2
    host.repaint
  }

  Frame? popFrame(Bool animation := true) {
    frame := stack.pop
    if (frame == null) {
      echo("nomore frame")
      return null
    }

    if (frameAnimation != null) {
      frameAnimation.stop
      frameAnimation = null
    }
    curFrame.clearFocus

    oldFrame = curFrame
    curFrame = frame
    frameOut = true

    DisplayMetrics.cur.autoScale = curFrame.autoScale

    //frame animation
    if (oldFrame != null) {
      oldFrame.onClosing.fire(null)
      if (animation) {
        anim := TweenAnimation {
          it.duration = 200
          TranslateAnimChannel { from = Point.defVal; to = Point(oldFrame.width, 0)},
        }
        frameAnimation = anim
        anim.bind(oldFrame)
        anim.whenDone.add {
          //oldFrame.animManager.clear
          oldFrame.detach
          //echo("oldFrame in done")
          frameAnimation = null
        }
        anim.start
      }
      else {
        oldFrame.detach
      }
    }

    layoutDirty = 2
    host.repaint
    //echo("popFrame $frame")
    return frame
  }
  
  private Void update() {
    if (layoutDirty > 0) {
      force := layoutDirty > 1
      layoutDirty = 0
      curFrame.setLayout(0, 0, width, height, force)
    }

    if (!curFrame.isOpened) {
      curFrame.onOpen
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
      DisplayMetrics.cur.updateDensity(s.w, s.h)
    }
    update
    
    bounds := Rect(0, 0, this.width, this.height)

    oldFrame?.onUpdate
    if (!frameOut && oldFrame != null) {
      DisplayMetrics.cur.autoScale = oldFrame.autoScale
      g.push
      oldFrame.paint(bounds, g)
      g.pop
      DisplayMetrics.cur.autoScale = curFrame.autoScale
    }
    
    curFrame.onUpdate
    curFrame.paint(bounds, g)

    if (frameOut && oldFrame != null) {
      g.push
      oldFrame.paint(bounds, g)
      g.pop
    }
  }

  override Void onMotionEvent(MotionEvent e) {
    e.relativeX = e.x
    e.relativeY = e.y
    update
    if (oldFrame == null) curFrame.postMotionEvent(e)
    //if (!e.consumed) {
    gesture.onEvent(e)
    //}
  }

  override Void onKeyEvent(KeyEvent e) {
    if (oldFrame == null) curFrame.keyEvent(e)
  }

  override Void onWindowEvent(WindowEvent e) {
    if (oldFrame == null) curFrame.windowEvent(e)
  }

  override Bool onBack() {
    return popFrame != null
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