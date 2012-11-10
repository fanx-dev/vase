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
  override NativeView? nativeView

  **
  ** current focus widget
  **
  Widget? focusWidget
  private Widget? mouseOverWidget

  **
  ** top layer is a overlay of root view
  **
  WidgetGroup? topLayerGroup

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


  **
  ** Callback for mouse button pressed.
  **
  once EventListeners onTouchDown() { EventListeners() }

  **
  ** Callback for mouse button move.
  **
  once EventListeners onTouchMove() { EventListeners() }

  **
  ** Callback for mouse button released.
  **
  once EventListeners onTouchUp() { EventListeners() }

  **
  ** post key event
  **
  override Void keyPress(KeyEvent e)
  {
    if (focusWidget == null) return
    if (focusWidget.enabled) focusWidget.keyPress(e)
  }

  **
  ** post touch event
  **
  override Void touch(MotionEvent e)
  {
    if (e.id == MotionEvent.released)
    {
      onTouchUp.fire(e)
    }
    else if (e.id == MotionEvent.pressed)
    {
      onTouchDown.fire(e)
    }
    else if (e.id == MotionEvent.moved)
    {
      onTouchMove.fire(e)
    }

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

  **
  ** repaint the dirty region on later
  **
  override Void repaint(Rect? dirty := null)
  {
    if (dirty == null) dirty = this.bounds
    nativeView.repaint(dirty)
  }

  **
  ** Show View
  **
  Void show(Window? host := null)
  {
    if (host == null)
      host = Toolkit.cur.build()
    host.add(this)
    onMounted
    relayout
    host.show(size)
  }

  **
  ** request focus for widget
  **
  Void focusIt(Widget w)
  {
    focusWidget?.focusChanged(false)
    this.focusWidget = w
    nativeView.focus
  }

  **
  ** set for dealwith mouse exit and mouse enter
  **
  Void mouseCapture(Widget w)
  {
    if (mouseOverWidget === w) return
    mouseOverWidget?.mouseExit
    this.mouseOverWidget = w
    w.mouseEnter
  }

  **
  ** return true if host windows has focus
  **
  override Bool hasFocus() { nativeView.hasFocus }

  **
  ** get or make a widget that layout top of root view
  **
  WidgetGroup topLayer()
  {
    if (topLayerGroup == null)
    {
      topLayerGroup = WidgetGroup()
    }
    moveToTop(topLayerGroup)
    topLayerGroup.size = this.size
    return topLayerGroup
  }
}