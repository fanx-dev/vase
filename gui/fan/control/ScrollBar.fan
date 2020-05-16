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
** An implementation of a scrollbar.
**
@Js
class ScrollBar : Widget
{
  **
  ** max content length
  **
  Float max := 2000f

  **
  ** view size of content
  **
  Float viewport := 0f

  **
  ** start position at content
  **
  Float curPos := 0f { set { setCurPos(it, false) } }

  Bool isActive() { draging }

  Bool isOverScroll() {
    if (curPos < 0f) {
      return true
    }
    
    if (curPos + viewport > max) return true
    return false
  }
  
  Float overScrollVal() {
    if (curPos < 0f) {
      return curPos
    }
    if (curPos + viewport > max) return curPos + viewport - max
    return 0.0
  }

  Void setCurPos(Float pos, Bool fireEvent, Bool allowOverScroll := false) {
    val := pos

    if (!allowOverScroll) {
      if (pos + viewport > max) {
        val = max - viewport
      }
      else if (pos < 0f) {
        val = 0f
      }
    }

    if (curPos == val) return
    oldPos := curPos
    &curPos = val
    if (fireEvent) {
        //echo("curPos:$curPos")
        e := StateChangedEvent (oldPos, curPos, #curPos, this )
        onStateChanged.fire(e)
        posChangeFunc?.call(curPos)
    }
  }

  Void onPosChanged(|Float| f) { posChangeFunc = f }
  |Float|? posChangeFunc

  **
  ** is vertical
  **
  const Bool vertical := true

  **
  ** touch position
  **
  private Bool draging := false

  Int barSize := 60

  new make(|This|? f := null)
  {
    if (f != null) f(this)

    if (vertical) {
      //layout.widthType = SizeType.fixed
      layout.width = barSize
      layout.height = Layout.matchParent
    }
    else {
      //layout.heightType = SizeType.fixed
      layout.height = barSize
      layout.width = Layout.matchParent
    }
    
    focusable = true
    pressFocus = true
  }

  **
  ** bar length in screen coordinate
  **
  Int barLength() {
    if (vertical) {
      return this.contentHeight
    } else {
      return this.contentWidth
    }
  }

  **
  ** screen thumb size
  **
  Int thumbSize()
  {
    return toScreenCoord(viewport).toInt
  }

  Int screenPos() {
    toScreenCoord(curPos).toInt
  }

  **
  ** maping from world to screen
  **
  protected Float toScreenCoord(Float val)
  {
    return ((val.toFloat / max.toFloat) * barLength.toFloat)
  }

  **
  ** map from screen to world
  **
  protected Float toWorldCoord(Float val)
  {
    return ((val.toFloat /barLength.toFloat )* max)
  }

  /*
  protected override Void doPaint(Graphics g) {
    super.doPaint(g)
  }
  */

  protected override Void gestureEvent(GestureEvent e) {
    if (e.type == GestureEvent.drop || e.type == GestureEvent.fling)
    {
      draging = false
      repaint
    }
    else if (e.type == GestureEvent.drag)
    {
      draging = true
      if (vertical)
      {
        pos := toWorldCoord(e.deltaY.toFloat) + curPos
        setCurPos(pos, true)
      }
      else
      {
        pos := toWorldCoord(e.deltaX.toFloat) + curPos
        setCurPos(pos, true)
      }
      //echo("=====>$curPos")
      e.consume
      repaint
    }
  }
}


**
** An implementation base scroll bar.
**
@Js
class SliderBar : ScrollBar
{
  new make() : super.make(|i|{ i.vertical = false; i.barSize = 120 })
  {
    this.viewport = 0f
    this.max = 100f
    this.padding = Insets(30, 50)
  }
}