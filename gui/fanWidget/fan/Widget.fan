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
abstract class Widget
{

//////////////////////////////////////////////////////////////////////////
// State
//////////////////////////////////////////////////////////////////////////

  **
  ** Controls whether this widget is visible or hidden.
  **
  Bool visible := true
  {
    set
    {
      e := StateChangedEvent (&visible, it, #visible, this )
      onStateChanged.fire(e)
      &visible = it
    }
  }

  **
  ** Enabled is used to control whether this widget can
  ** accept user input.  Disabled controls are "grayed out".
  **
  Bool enabled := true
  {
    set
    {
      e := StateChangedEvent (&enabled, it, #enabled, this )
      onStateChanged.fire(e)
      &enabled = it
    }
  }

  **
  ** Position of this widget relative to its parent.
  **
  Point pos := Point(0, 0)
  {
    set
    {
      e := StateChangedEvent (&pos, it, #pos, this )
      onStateChanged.fire(e)
      &pos = it
    }
  }

  **
  ** Size of this widget.
  **
  Size size := Size(50, 50)
  {
    set
    {
      e := StateChangedEvent (&size, it, #size, this )
      onStateChanged.fire(e)
      &size = it
    }
  }


  **
  ** Callback function when Widget state changed
  **
  once EventListeners onStateChanged() { EventListeners() }

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

  **
  ** Absolute position. relative to the view
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
  RootView? view()
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

  virtual This relayout() { children.each { it.relayout }; return this }
  virtual Size prefSize(Size? hints := null) { return size }
  virtual Void repaint(Rect? dirty := null)
  {
    if (dirty == null) dirty = this.bounds
    else dirty = Rect(dirty.x + pos.x, dirty.y + pos.y, dirty.h, dirty.w)
    this.parent?.repaint(dirty)
  }
  virtual Void repaintLater(Rect? dirty := null) {}

  Rect bounds
  {
    get { return Rect.makePosSize(pos, size) }
    set { pos = it.pos; size = it.size }
  }

//////////////////////////////////////////////////////////////////////////
// event
//////////////////////////////////////////////////////////////////////////

  virtual Void touch(InputEvent e)
  {
    children.each
    {
      if (it.bounds.contains(e.x, e.y))
      {
        it.touch(e)
      }
    }
  }
  virtual Void keyPress(InputEvent e) { children.each { it.keyPress(e) } }

//////////////////////////////////////////////////////////////////////////
// Paint
//////////////////////////////////////////////////////////////////////////

  BufImage? bufferedImage

  Void doubleBuffer()
  {
    bufferedImage = BufImage(size)
  }

  virtual Void onPaint(Graphics g2)
  {
    if (bufferedImage == null)
    {
      onPaintWidget(g2)
      return
    }
    g := bufferedImage.graphics
    onPaintWidget(g)
    g2.drawImage(bufferedImage, pos.x, pos.y)
    g.dispose
  }

  virtual Void onPaintWidget(Graphics g)
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
    v := view
    return v.hasFocus && v.focusWidget === this
  }

  **
  ** Attempt for this widget to take the keyboard focus.
  **
  virtual Void focus() { view.focusIt(this) }
}