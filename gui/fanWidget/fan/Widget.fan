//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fan2d
using fanWt


@Js
abstract class Widget
{
  Str id := ""
  Str styleClass := ""
  {
    set
    {
      e := StateChangedEvent (&styleClass, it, #styleClass, this )
      onStateChanged.fire(e)
      &styleClass = it
    }
  }

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


  Rect bounds
  {
    get { return Rect.makePosSize(pos, size) }
    set { pos = it.pos; size = it.size }
  }

//////////////////////////////////////////////////////////////////////////
// Widget Tree
//////////////////////////////////////////////////////////////////////////

  Widget? parent { private set }

  internal Void setParent(Widget? p) { parent = p }

  virtual Void touch(InputEvent e) {}

  virtual Void keyPress(InputEvent e) {}

  virtual Void paint(Graphics g, Rect? dirty) { rootView.find(this).paint(this, g) }

  virtual Size prefSize(Size? hints := null) { size }
  virtual This relayout() { this }


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