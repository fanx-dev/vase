//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-04  Jed Young  Creation
//

using fgfxGraphics
using fgfxWtk
using concurrent

**
** Represent a top level Widget
**
@Js
class RootView : FrameLayout, View
{
  **
  ** The reference of nativeView
  **
  override NativeView? nativeView

  **
  ** current focus widget
  **
  Widget? focusWidget { private set }
  private Widget? mouseOverWidget

  **
  ** top layer is a overlay of root view
  **
  private WidgetGroup? topLayerGroup

  **
  ** Used to toggle anti-aliasing on and off.
  **
  Bool antialias := true

  **
  ** Style support
  **
  StyleManager styleManager := StyleManager()

  **
  ** find the current style
  **
  Style findStyle(Widget widget) { styleManager.find(widget) }

  **
  ** double buffer
  **
  Bool doubleBuffered := false

  **
  ** animation manager
  **
  AnimManager animManager := AnimManager()

  private Int lastUpdateTime := 0

  **
  ** has modal dialog
  **
  Bool modal := false

  **
  ** root background color
  **
  Brush background := Color.white

  **
  ** marked need do layout
  **
  protected Bool layoutDirty := true

  **
  ** Shared dimension for layout
  **
  private Dimension sharedDimension := Dimension(0, 0)

  new make() {
    id = "root"
    width = 0
    height = 0
  }

  override Void requestLayout() {
    layoutDirty = true
    requestPaint
  }

  protected Void onUpdate() {
    if (lastUpdateTime == 0) {
      lastUpdateTime = Duration.nowTicks
    }
    now := Duration.nowTicks

    elapsedTime := ((now - lastUpdateTime) / 1E6d.toInt)
    if (animManager.update(elapsedTime)) {
      //echo("anim continue")
      requestPaint
    }

    lastUpdateTime = now;
  }

  override Void onPaint(Graphics g) {
    s := nativeView.size
    if (width != s.w || height != s.h) {
      onResize(s.w, s.h)
      layoutDirty = true
    }

    if (layoutDirty) {
      layoutDirty = false
      doLayout(sharedDimension)
    }

    onUpdate

    g.antialias = this.antialias
    g.brush = background
    g.fillRect(0, 0, width, height)
    super.paint(g)
  }

  virtual Void onResize(Int w, Int h) {
    width = w
    height = h
  }

  override Void onMotionEvent(MotionEvent e) {
    touch(e)
  }

  override Void onKeyEvent(KeyEvent e) {
    keyPress(e)
  }

  override Void onDisplayEvent(DisplayEvent e)
  {
    if (e.type == DisplayEvent.opened) onOpened.fire(e)
    else if (e.type == DisplayEvent.activated) onActivated.fire(e)
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
    if (e.type == MotionEvent.released)
    {
      onTouchUp.fire(e)
    }
    else if (e.type == MotionEvent.pressed)
    {
      onTouchDown.fire(e)
    }
    else if (e.type == MotionEvent.moved)
    {
      onTouchMove.fire(e)
    }

    if (!modal)
    {
      if (mouseOverWidget != null) {
        p := Coord(e.x, e.y)
        b := mouseOverWidget.mapToRelative(p)
        if (!b || !mouseOverWidget.bounds.contains(p.x, p.y)) {
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
  override Void requestPaint(Rect? dirty := null)
  {
    if (dirty == null) dirty = this.bounds
    nativeView.repaint(dirty)
  }

  override Size getPrefSize(Int hintsWidth, Int hintsHeight) {
    result := Dimension(0, 0)
    result = super.measureSize(hintsWidth, hintsHeight, result)
    return Size(result.w, result.h)
  }

  **
  ** Show View
  **
  Void show(Window? host := null, Size? size := null)
  {
    if (host == null)
      host = Toolkit.cur.build()
    host.add(this)
    onMounted
    host.show(size)
  }

  **
  ** request focus for widget
  **
  Void focusIt(Widget? w)
  {
    Event e := Event()
    e.data = false
    focusWidget?.onFocusChanged?.fire(e)

    this.focusWidget = w
    nativeView.focus

    e.data = true
    focusWidget?.onFocusChanged?.fire(e)
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
  WidgetGroup topOverLayer()
  {
    if (topLayerGroup == null)
    {
      topLayerGroup = FrameLayout()
    }
    moveToTop(topLayerGroup)
    topLayerGroup.width = this.width
    topLayerGroup.height = this.height
    return topLayerGroup
  }
}