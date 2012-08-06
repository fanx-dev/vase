//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using fgfx2d
using fgfxWtk
using concurrent

**
** Represent a top level Widget
**
@Js
class RootView : WidgetGroup, View
{
  **
  ** The reference of nativeView
  **
  Window? win

  **
  ** current focus widget
  **
  Widget? focusWidget

  **
  ** Used to toggle anti-aliasing on and off.
  **
  Bool antialias := true

  **
  ** Style support
  **
  StyleManager styleManager := StyleManager()
  Style find(Widget widget) { styleManager.find(widget) }

  **
  ** double buffer
  **
  Bool doubleBuffered := false


  override Void onPaint(Graphics g) {
    g.antialias = this.antialias
    super.paint(g)
  }

  override Void onEvent(InputEvent e) {
    if (e.id == InputEvent.keyDown || e.id == InputEvent.keyUp || e.id == InputEvent.keyTyped) {
      keyPress(e)
    } else {
      touch(e)
    }
  }

  override Void onDisplayEvent(DisplayEvent e)
  {
    if (e.id == DisplayEvent.opened) onOpened.fire(e)
    else if (e.id == DisplayEvent.activated) onActivated.fire(e)
    else onDisplayStateChange.fire(e)
  }

  once EventListeners onDisplayStateChange() { EventListeners() }

  **
  ** Callback function when window is opended.
  **
  once EventListeners onOpened() { EventListeners() }

  **
  ** Callback function when window becomes the active window on the desktop with focus.
  **
  once EventListeners onActivated() { EventListeners() }


  override Void keyPress(InputEvent e)
  {
    if (focusWidget == null) return
    if (focusWidget.enabled) focusWidget.keyPress(e)
  }

  override Void repaint(Rect? dirty := null)
  {
    win.repaint(dirty)
  }

  **
  ** Show View
  **
  Void show(Window? host := null)
  {
    if (host == null)
      win = Toolkit.cur.build(this)
    else
      win = host
    relayout
    win.show(size)
  }

  **
  ** request focus for widget
  **
  Void focusIt(Widget w)
  {
    focusWidget?.focusChanged(false)
    this.focusWidget = w
    win.focus
  }

  override Bool hasFocus() { win.hasFocus }
}