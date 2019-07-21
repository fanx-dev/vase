//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow
using fanvasMath

**
** WidgetGroup is a Widget Container
**
@Js
@Serializable
abstract class WidgetGroup : Widget
{
  new make() {
    useRenderCache = false
  }

//////////////////////////////////////////////////////////////////////////
// Widget Tree
//////////////////////////////////////////////////////////////////////////

  @Transient
  private Widget[] children := Widget[,]


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
  This remove(Widget? child)
  {
    if (child == null) return this

    root := getRootView
    root?.onRemove(child)

    if (children.removeSame(child) == null) {
      throw ArgErr("not my child: $child, parent$child.parent")
    }
    child.setParent(null)

    if (root != null) this.relayout
    return this
  }

  **
  ** Remove all child widgets.  Return this.
  **
  virtual This removeAll()
  {
    children.dup.each |Widget kid| { remove(kid) }
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
  Widget getChild(Int i) { children[i] }

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

//////////////////////////////////////////////////////////////////////////
// layout
//////////////////////////////////////////////////////////////////////////

  **
  ** layout the children
  **
  abstract protected override Void layoutChildren(Dimension result, Bool force);

  **
  ** get the prefer content size
  **
  abstract protected override Dimension prefContentSize(Dimension result);

//////////////////////////////////////////////////////////////////////////
// event
//////////////////////////////////////////////////////////////////////////


  **
  ** process motion event
  **
  protected override Void motionEvent(MotionEvent e) {
    px := e.relativeX
    py := e.relativeY
    children.eachr {
      if (it.enabled && it.visible && !e.consumed) {
        e.relativeX = px - this.x
        e.relativeY = py - this.y
        if (it.contains(e.relativeX, e.relativeY)) {
          it.motionEvent(e)
        }
      }
    }
    e.relativeX = px
    e.relativeY = py
  }

  **
  ** process gesture event
  **
  protected override Void gestureEvent(GestureEvent e) {
    px := e.relativeX
    py := e.relativeY
    for (i:=children.size-1; i>=0 && i<children.size; --i) {
      t := children.get(i)
      if (t.enabled && t.visible && !e.consumed) {
        e.relativeX = px - this.x
        e.relativeY = py - this.y
        if (t.contains(e.relativeX, e.relativeY)) {
          t.gestureEvent(e)
        }
      }
    }
    e.relativeX = px
    e.relativeY = py
  }

  protected override Void keyEvent(KeyEvent e) {
    children.eachr {
      if (it.enabled) {
        it.keyEvent(e)
      }
    }
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

  protected override Void doPaint(Graphics g)
  {
    super.doPaint(g)
    paintChildren(g)

    //debug
    if (debug) {
      //g.brush = Color.black
      //g.drawLine(0, 0, width, height)
      //g.drawLine(width, 0, 0, height)
      g.brush = Color.red
      g.pen = Pen { it.width = 1 }
      g.drawRect(2, 2, width-4, height-4)
    }
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
        g.transform(Transform2D.make.translate(it.x.toFloat, it.y.toFloat))
        it.paint(g)
        g.pop
      }
    }
  }

}

