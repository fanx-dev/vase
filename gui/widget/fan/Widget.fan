//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-05  Jed Young  Creation
//

using fgfx2d
using fgfxWtk

**
** Widget is the base class for all UI widgets.
**
@Js
abstract class Widget
{
  **
  ** The unique identifies of widget.
  **
  Str id := ""

  **
  ** A name for style
  **
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

//////////////////////////////////////////////////////////////////////////
// Widget Tree
//////////////////////////////////////////////////////////////////////////

  **
  ** Get this widget's parent or null if not mounted.
  **
  Widget? parent { private set }

  internal Void setParent(Widget? p) { parent = p }

  **
  ** Find widget by id in descendant
  **
  virtual Widget? findById(Str id) { if (this.id == id) return this; else return null }

  **
  ** Post mouse event
  **
  virtual Void touch(MotionEvent e) {}

  **
  ** Post key event
  **
  virtual Void keyPress(KeyEvent e) {}

  **
  ** Paints this component.
  **
  virtual Void paint(Graphics g) { if (!visible) return; rootView.find(this).paint(this, g) }

  **
  ** Detach from parent
  **
  virtual Void detach()
  {
    WidgetGroup? p := this.parent
    if (p == null) return
    p.remove(this)
  }

//////////////////////////////////////////////////////////////////////////
// layout
//////////////////////////////////////////////////////////////////////////

  **
  ** Compute the preferred size of this widget.
  **
  virtual Size prefSize(Int hintsWidth := -1, Int hintsHeight := -1) { size }

  **
  ** Relayout this widget.
  **
  virtual This relayout() { this }

//////////////////////////////////////////////////////////////////////////
// rootView
//////////////////////////////////////////////////////////////////////////

  **
  ** Position and size of this widget relative to its parent.
  ** If this a window, this is the position on the screen.
  **
  Rect bounds
  {
    get { return Rect.makePosSize(pos, size) }
    set { pos = it.pos; size = it.size }
  }

  **
  ** Get the position of this widget relative to the window.
  ** If not on mounted on the screen then return null.
  **
  Point? posOnWindow()
  {
    if (this is RootView) return Point(0, 0)
    if (parent == null) return null
    if (parent.posOnWindow == null) return null

    x := parent.posOnWindow.x + pos.x
    y := parent.posOnWindow.y + pos.y
    return Point(x, y)
  }

  **
  ** Translates absolute coordinates into coordinates in the coordinate space of this component.
  **
  Point? mapToRelative(Point p)
  {
    posOW := parent.posOnWindow
    if (posOW == null) return null

    return Point(p.x - posOW.x, p.y - posOW.y)
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

  **
  ** Repaints the specified rectangle.
  **
  virtual Void repaint(Rect? dirty := null)
  {
    if (dirty == null) dirty = this.bounds
    else dirty = Rect(dirty.x + pos.x, dirty.y + pos.y, dirty.w, dirty.h)
    this.parent?.repaint(dirty)
  }

//////////////////////////////////////////////////////////////////////////
// Focus
//////////////////////////////////////////////////////////////////////////

  Bool isFocusable := true

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
  virtual Void focus() { rootView.focusIt(this); focusChanged(true) }

  **
  ** callback when lost focus or gains focus.
  **
  virtual Void focusChanged(Bool focused) {}

}