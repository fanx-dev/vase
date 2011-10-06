//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using gfx
using gfx2
using concurrent

**
** Represent a top level Widget
**
@Js
class View : Widget
{
  **
  ** The reference of nativeView
  **
  protected NativeView nativeView
  
  Gesture gesture := Gesture()
  
  **
  ** current focus widget
  **
  Widget? focusWidget
  
  **
  ** Used to toggle anti-aliasing on and off.
  **
  Bool antialias := true
  
  new make()
  {
    nativeView = NativeView.build(this)
    this.setParent(this)
  }
  
  override Void repaint(Rect? dirty := null) { nativeView.repaint(dirty) }
  override Void repaintLater(Rect? dirty := null) {}
  
  override Void paint(Graphics2 g)
  {
    g.antialias = this.antialias
    super.paint(g)
  }
  
  override Void touch(MotionEvent e)
  {
    gesture.add(e)
    super.touch(e)
  }
  
  override Void keyPress(KeyEvent e) { focusWidget.keyPress(e) }
  
  **
  ** open View
  **
  Void show() { nativeView.show(size) }
  
  **
  ** request focus for widget
  **
  Void focusIt(Widget w) { nativeView.focus; this.focusWidget = w }
  
  **
  ** nativeView position. The value depends on native implements
  **
  Point nativePos() { nativeView.pos }
  
  **
  ** Callback function when View becomes an inactive
  **
  once EventListeners onResume() { EventListeners() }
  
  **
  ** Called when the View will start interacting with the user
  **
  once EventListeners onPause() { EventListeners() }
}