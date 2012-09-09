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
  private Widget? mouseOverWidget

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

  Bool modal := false

  Brush bg := Color.white


  override Void onPaint(Graphics g) {
    g.antialias = this.antialias
    g.brush = bg
    g.fillRect(0, 0, size.w, size.h)
    super.paint(g)
  }

  override Void onMotionEvent(MotionEvent e) {
    touch(e)
  }

  override Void onKeyEvent(KeyEvent e) {
    keyPress(e)
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


  override Void keyPress(KeyEvent e)
  {
    if (focusWidget == null) return
    if (focusWidget.enabled) focusWidget.keyPress(e)
  }

  override Void touch(MotionEvent e)
  {
    if (!modal)
    {
      if (mouseOverWidget != null) {
        p := mouseOverWidget.mapToRelative(Point(e.x, e.y))
        if (p == null || !mouseOverWidget.bounds.contains(p.x, p.y)) {
          mouseOverWidget.mouseExit
          mouseOverWidget = null
        }
      }
      super.touch(e)
    }
    else
    {
      focusWidget.touch(e)
    }
  }

  override Void repaint(Rect? dirty := null)
  {
    if (dirty == null) dirty = this.bounds
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

  Void mouseCapture(Widget w)
  {
    if (mouseOverWidget === w) return
    mouseOverWidget?.mouseExit
    this.mouseOverWidget = w
    w.mouseEnter
  }

  override Bool hasFocus() { win.hasFocus }
}