//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fan2d
using fanWt

**
** Widget is the base class for all UI widgets.
**
@Js
abstract class Widget : AbstractView
{
  Style? style := null
  Layout layout := FixedLayout()

//////////////////////////////////////////////////////////////////////////
// Widget Tree
//////////////////////////////////////////////////////////////////////////

  private Widget[] children := Widget[,]
  Widget? parent { private set }
  internal Void setParent(Widget p) { parent = p } // for View.make

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
  This remove(Widget child)
  {
    if (children.removeSame(child) == null)
      throw ArgErr("not my child: $child")
    child.parent = null
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
    child.parent = this
    children.add(child)
    return this
  }

//////////////////////////////////////////////////////////////////////////
// rootView
//////////////////////////////////////////////////////////////////////////

  **
  ** Absolute position.
  **
  Point? absolutePos()
  {
    if (parent == null) return null
    p := parent.absolutePos
    return Point(p.x + pos.x, p.y + pos.y)
  }

  **
  ** Get this widget's parent View or null if not
  ** mounted under a View widget.
  **
  RootView? rootView()
  {
    Widget? x := this
    while (x != null)
    {
      if (x is RootView) return (RootView)x
      x = x.parent
    }
    return null
  }

//////////////////////////////////////////////////////////////////////////
// layout
//////////////////////////////////////////////////////////////////////////

  virtual This relayout() { layout.relayout(this); return this }
  virtual Size prefSize(Size? hints := null) { layout.prefSize(this, hints) }

//////////////////////////////////////////////////////////////////////////
// repaint
//////////////////////////////////////////////////////////////////////////

  virtual Void repaint(Rect? dirty := null)
  {
    if (dirty == null) dirty = this.bounds
    else dirty = Rect(dirty.x + pos.x, dirty.y + pos.y, dirty.h, dirty.w)
    this.parent?.repaint(dirty)
  }

  virtual Void repaintLater(Rect? dirty := null)
  {
    if (dirty == null) dirty = this.bounds
    else dirty = Rect(dirty.x + pos.x, dirty.y + pos.y, dirty.h, dirty.w)
    this.parent?.repaintLater(dirty)
  }

//////////////////////////////////////////////////////////////////////////
// event
//////////////////////////////////////////////////////////////////////////

  virtual Void touch(InputEvent e) { children.each { it.touch(e) } }

  virtual Void keyPress(InputEvent e) { children.each { it.keyPress(e) } }

//////////////////////////////////////////////////////////////////////////
// Paint
//////////////////////////////////////////////////////////////////////////

  virtual Void onPaint(Graphics g)
  {
    if (style != null)
    {
      style.paint(this, g)
    }
    paintChildren(g)
  }

  protected virtual Void paintChildren(Graphics g)
  {
    children.each
    {
      g.push
      g.clip(it.bounds)
      g.transform = g.transform.translate(it.pos.x.toFloat, it.pos.y.toFloat)
      it.onPaint(g)
      g.pop
    }
  }

//////////////////////////////////////////////////////////////////////////
// Focus
//////////////////////////////////////////////////////////////////////////

  **
  ** Return if this widget is the focused widget which
  ** is currently receiving all keyboard input.
  **
  virtual Bool hasFocus()
  {
    v := rootView
    return v.hasFocus && v.focusWidget === this
  }

  **
  ** Attempt for this widget to take the keyboard focus.
  **
  virtual Void focus() { rootView.focusIt(this) }
}