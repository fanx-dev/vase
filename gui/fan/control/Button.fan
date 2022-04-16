//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** common behaviors for buttons.
**
@Js
class Button : Label
{
//////////////////////////////////////////////////////////////////////////
// state
//////////////////////////////////////////////////////////////////////////
  const static Int mouseOver := 1
  const static Int mouseOut := 0
  const static Int mouseDown := 2
  
  @NoDoc Point? ripplePoint
  @NoDoc Float rippleSize := -1.0
  Bool rippleEnable := true

  ** displays a small popup when the mouse hovers over
  Str? tooltip
  Int tooltipDelay := 750
  private Bool tooltipValid = false
  private Label? tooltipLabel

  @Transient
  Int state := mouseOut
  {
    set
    {
      if (&state == it) return
      e := StateChangedEvent (&state, it, #state, this )
      onStateChanged.fire(e)
      &state = it
      this.repaint
    }
  }
  
  new make() {
    padding = Insets(25)
    textAlign = Align.center
    focusable = true
  }

//////////////////////////////////////////////////////////////////////////
// Event
//////////////////////////////////////////////////////////////////////////

  protected Void startRipple(Int x, Int y) {
    if (!rippleEnable) return
    
    ripplePoint = Point(x, y)
    anim := Animation {
        it.duration = 300
        FloatPropertyAnimChannel(this, #rippleSize) {
          from = 0.0; to = 1.0
        },
    }
    anim.whenDone.add {
        rippleSize = -1.0
        ripplePoint = null
    }
    this.getRootView.animManager.add(anim)
    anim.start
    this.repaint
  }

  protected once EventListeners onAction() { EventListeners() }

  protected override Void gestureEvent(GestureEvent e) {
    //super.gestureEvent(e)
    //if (e.consumed) return
    //echo("e.type $e.type")

    if (e.type == GestureEvent.click) {    
      getRootView.clearFocus
      clicked
      onAction.fire(e)
      e.consume
    }
    else if (e.type == GestureEvent.shortPress) {
      startRipple(e.relativeX-this.x, e.relativeY-this.y)
      e.consume
    }
    else if (onLongPressCallback != null && e.type == GestureEvent.longPress) {
      //this.focus
      onLongPressCallback.call(this)
      e.consume
    }
  }

  protected override Void motionEvent(MotionEvent e)
  {
    //echo("e.type $e.type, $id")
    super.motionEvent(e)

    if (state == mouseOut) {
      getRootView?.mouseHover(this)
    }
      
    if (e.type == MotionEvent.released)
    {
      state = mouseOut
    }
    else if (e.type == MotionEvent.pressed)
    {
      state = mouseDown
    }
  }

  override protected Void clicked() {
    try {
      onClickCallback?.call(this)
    } catch (Err e) {
      e.trace
    }
  }

  override Void mouseExit() {
    state = mouseOut
    tooltipValid = false
    if (tooltipLabel != null) {
      tooltipLabel.detach
      tooltipLabel = null
    }
  }

  override Void mouseEnter() {
    state = mouseOver
    if (tooltip != null && tooltipLabel == null) {
      tooltipValid = true
      Toolkit.cur.callLater(tooltipDelay) {
          if (tooltipValid && tooltipLabel == null) {
              pos := Coord(0.0, 0.0)
              rc := posOnWindow(pos)
              tooltipLabel = Label {
                it.layout.offsetX = this.pixelToDp(pos.x.toInt)
                it.layout.offsetY = this.pixelToDp(pos.y.toInt + this.height)
                it.layout.width = Layout.wrapContent
                it.padding = Insets(10, 30)
                it.text = tooltip
                it.style = "tooltip"
              }
              this.getRootView.topOverlayer.add(tooltipLabel)
              tooltipLabel.relayout
          }
      }
    }
  }

  override Void keyEvent(KeyEvent e)
  {
    if (e.type == KeyEvent.released && e.key == Key.enter)
    {
      onAction.fire(e)
    }
  }
}
