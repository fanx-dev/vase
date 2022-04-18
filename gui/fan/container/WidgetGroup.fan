//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** WidgetGroup is a Widget Container
**
@Js
@Serializable { collection = true }
abstract class WidgetGroup : Widget
{
  Bool eventPass = false

  new make() {
    useRenderCache = false
    focusable = false
  }

//////////////////////////////////////////////////////////////////////////
// Widget Tree
//////////////////////////////////////////////////////////////////////////

  @NoDoc @Transient
  Widget[] children := Widget[,]


  **
  ** Iterate the children widgets.
  **
  Void each(|Widget w, Int i| f)
  {
    children.each(f)
  }

  **
  ** Remove a child widget
  **
  This remove(Widget? child, Bool doRelayout := true)
  {
    if (child == null) return this

    child.setParent(null)

    root := getRootView
    root?.onRemove(child)

    if (children.removeSame(child) == null) {
      throw ArgErr("not my child: $child, parent$child.parent")
    }

    if (doRelayout && root != null) this.relayout
    return this
  }

  **
  ** Remove all child widgets.  Return this.
  **
  virtual This removeAll()
  {
    root := getRootView
    
    children.each |Widget child| {
      root?.onRemove(child)
      child.setParent(null)
    }
    children.clear
    return this
  }

  **
  ** Add a child widget.
  ** If child is already parented throw ArgErr.  Return this.
  **
  @Operator virtual This add(Widget child)
  {
    if (child.parent != null)
      throw ArgErr("Child already parented: $child")
    child.setParent(this)
    children.add(child)
    return this
  }

  Int indexSame(Widget child)
  {
    return children.indexSame(child)
  }

  **
  ** num of children
  **
  Int childrenSize() { children.size }

  **
  ** get by index
  **
  Widget? getChild(Int i) { children.getSafe(i, null) }

  **
  ** find widget by id in this group
  **
  override Widget? findById(Str id)
  {
    if (id == this.id) return this
    return children.eachWhile
    {
      it.findById(id)
    }
  }

  **
  ** move child to top.
  **
  Void moveToTop(Widget child)
  {
    Int? i := children.indexSame(child)
    if (i == children.size -1) return
    if (i != null)
    {
      children.removeAt(i)
      children.add(child)
    }
    else
    {
      this.add(child)
    }
  }

  override Widget? findAt(Int x, Int y) {
    if (!contains(x, y)) return null
    
    res := children.eachWhile |c| {
      r := c.findAt(x-this.x, y-this.y)
      if (r != null) return r
      return null
    }
    if (res != null) return res
    return this
  }

//////////////////////////////////////////////////////////////////////////
// layout
//////////////////////////////////////////////////////////////////////////

  **
  ** layout the children
  **
  abstract protected override Void layoutChildren(Bool force);

  **
  ** get the prefer content size
  **
  abstract protected override Size prefContentSize(Int hintsWidth := -1, Int hintsHeight := -1);

//////////////////////////////////////////////////////////////////////////
// event
//////////////////////////////////////////////////////////////////////////


  **
  ** process motion event
  **
  protected override Void motionEvent(MotionEvent e) {
    px := e.relativeX
    py := e.relativeY
    for (i:=children.size-1; i>=0 && i<children.size; --i) {
      t := children.get(i)
      if (t.enabled && !e.consumed) {
        e.relativeX = px - this.x
        e.relativeY = py - this.y
        if (t.contains(e.relativeX, e.relativeY)) {
          t.motionEvent(e)
          if (!eventPass) break
        }
      }
    }
    e.relativeX = px
    e.relativeY = py
    
    if (e.consumed) return
    super.motionEvent(e)
  }

  **
  ** process gesture event
  **
  protected override Void gestureEvent(GestureEvent e) {
    px := e.relativeX
    py := e.relativeY
    for (i:=children.size-1; i>=0 && i<children.size; --i) {
      t := children.get(i)
      if (t.enabled && !e.consumed) {
        e.relativeX = px - this.x
        e.relativeY = py - this.y
        if (t.contains(e.relativeX, e.relativeY)) {
          t.gestureEvent(e)
          if (!eventPass) break
        }
      }
    }
    e.relativeX = px
    e.relativeY = py
    
    if (e.consumed) return
    super.gestureEvent(e)
  }

  protected override Void keyEvent(KeyEvent e) {
    
    children.eachr {
      if (it.enabled && !e.consumed) {
        it.keyEvent(e)
      }
    }
    
    if (e.consumed) return
    super.keyEvent(e)
  }

  **
  ** callback on mounted
  **
  protected override Void onMounted()
  {
    children.each { it.onMounted }
  }

//////////////////////////////////////////////////////////////////////////
// Paint
//////////////////////////////////////////////////////////////////////////
  override Void resetStyle() {
    super.resetStyle
    children.each { it.resetStyle }
  }
  
  protected override Void doPaint(Graphics g)
  {
    super.doPaint(g)
    paintChildren(g)
  }

  **
  ** paint children widget
  **
  protected virtual Void paintChildren(Graphics g)
  {
    children.each
    {
      if (it.visible)
      {
        g.push
        g.transform(Transform2D.makeTranslate(it.x.toFloat, it.y.toFloat))
        it.paint(g)
        g.pop
      }
    }
  }

}

