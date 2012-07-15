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
abstract class AbstractView
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
}