//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using fan2d
using fanWt
using concurrent

**
** Represent a top level Widget
**
@Js
class RootView : Widget, View
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


  override Void onPaint(Graphics g) {
    g.antialias = this.antialias
    super.onPaint(g)
  }

  override Void onEvent(InputEvent e) {
    if (e.id == InputEvent.keyDown || e.id == InputEvent.keyUp) {
      keyPress(e)
    } else {
      touch(e)
    }
  }

  override Void repaint(Rect? dirty := null)
  {
    win.repaint(dirty)
  }

  **
  ** open View
  **
  Void show() { this.relayout; win.show(size) }

  **
  ** request focus for widget
  **
  Void focusIt(Widget w) { win.focus; this.focusWidget = w }
}